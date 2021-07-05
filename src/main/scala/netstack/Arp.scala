package netstack

import chisel3._
import chisel3.util._
import netstack.Interface.Ip2ArpIf

case class ArpDebugPort() extends Bundle {
  val op = UInt(16.W)
  val macSrc = UInt(48.W)
  val ipSrc = UInt(32.W)
  val macDest = UInt(48.W)
  val ipDest = UInt(32.W)
  val ramWriteEnable = Bool()
  val ramWriteAddr = UInt(8.W)
  val ramWriteIp = UInt(32.W)
  val ramWriteMac = UInt(48.W)
  val arpOutValid = Bool()
  val arpOutData = UInt(8.W)
  val state = UInt(4.W)
}

case class ArpType() extends Bundle {
  val ip = UInt(32.W)
  val mac = UInt(48.W)
}

case class Arp() extends Module with ReceiveStream with SendStream {
  val io = IO(new Bundle() {
    val mac2Arp = Flipped(ValidIO(UInt(8.W)))
    val arp2Mac = DecoupledIO(UInt(8.W))
    val ip2Arp = Flipped(Ip2ArpIf())
    val debugPort = Output(ArpDebugPort())
  })

  io := DontCare

  val arpRam = SyncReadMem(1 << 8, ArpType())
  val arpRamWriteEnable = Wire(Bool())
  val arpRamWriteAddress = Reg(UInt(8.W))
  val arpRamWriteData = Reg(ArpType())
  val arpRamReadEnable = Wire(Bool())
  val arpRamReadAddress = Wire(UInt(8.W))
  val arpRamReadData = Wire(ArpType())
  when (arpRamWriteEnable) { arpRam.write(arpRamWriteAddress, arpRamWriteData) }
  arpRamReadData := arpRam.read(arpRamReadAddress, arpRamReadEnable)

  val cnt = Counter(8)
  val op = Reg(Vec(2, UInt(8.W)))
  val macSrc = Reg(Vec(6, UInt(8.W)))
  val ipSrc = Reg(Vec(4, UInt(8.W)))
  val macDest = Reg(Vec(6, UInt(8.W)))
  val ipDest = Reg(Vec(4, UInt(8.W)))

  val sIdle :: sData0 :: sOp :: sMacSrc :: sIpSrc :: sMacDest :: sIpDest :: sDone :: _ = Enum(10)
  val stateReg = RegInit(sIdle)

  val shiftState = Wire(Bool())
  override val vd: ValidIO[UInt] = io.mac2Arp
  override val st: UInt = stateReg
  override val idle: UInt = sIdle
  override val ss: Bool = shiftState

  shiftState := false.B
  switch (stateReg) {
    is (sIdle) {
      when (io.mac2Arp.valid) {
        stateReg := sData0
        cnt.reset()
      }
    }
    is (sData0) {
      idleReceive(5, sOp)
    }
    is (sOp) {
      getData(op, sMacSrc)
    }
    is (sMacSrc) {
      getData(macSrc, sIpSrc)
    }
    is (sIpSrc) {
      getData(ipSrc, sMacDest)
    }
    is (sMacDest) {
      getData(macDest, sIpDest)
    }
    is (sIpDest) {
      getData(ipDest, sDone)
    }
    is (sDone) {
      stateReg := sIdle
    }
  }

  arpRamWriteEnable := stateReg === sDone
  arpRamWriteAddress := macSrc(0)
  arpRamWriteData.ip := ipSrc.asTypeOf(UInt(32.W))
  arpRamWriteData.mac := macSrc.asTypeOf(UInt(48.W))

  arpRamReadEnable := false.B
  arpRamReadAddress := 0.U

  val arpReqIn = Wire(Flipped(DecoupledIO(UInt(81.W))))
  arpReqIn.bits := Cat(true.B, ipSrc.asTypeOf(UInt(32.W)), macSrc.asTypeOf(UInt(48.W))) // arp response
  arpReqIn.valid := op.asTypeOf(UInt()) === ArpOpReq && RegNext(stateReg === sDone)
  val arpReqOut = Queue(arpReqIn, 16)

  val ipReqIn = Wire(Flipped(DecoupledIO(UInt(81.W))))
  ipReqIn.bits := Cat(false.B, io.ip2Arp.sendReq.bits, "hFFFFFFFFFFFF".U(48.W)) // arp request
  ipReqIn.valid := io.ip2Arp.sendReq.valid
  val ipReqOut = Queue(ipReqIn, 16)

  val arpSend = Wire(DecoupledIO(UInt(81.W)))
  val arb = Module(new Arbiter(UInt(), 2))
  arb.io.in(0) <> ipReqOut
  arb.io.in(1) <> arpReqOut
  arpSend <> arb.io.out
  arpSend.ready := false.B

  val sendIdle :: sendPre :: sendOp :: sendSrcMac :: sendSrcIp :: sendDestMac :: sendDestIp :: sendDone :: _ = Enum(10)
  val sendStateReg = RegInit(sendIdle)
  override val sCnt: Counter = Counter(8)
  override val sState: UInt = sendStateReg
  override val sPort = io.arp2Mac

  val arpSendReg = RegEnable(arpSend.bits, arpSend.fire())
  val arpSendOp = Wire(Bool())
  val arpSendIp = Wire(UInt(32.W))
  val arpSendMac = Wire(UInt(48.W))
  arpSendOp := arpSendReg(80)
  arpSendIp := arpSendReg(79, 48)
  arpSendMac := arpSendReg(47, 0)

  switch (sendStateReg) {
    is (sendIdle) {
      when (io.arp2Mac.ready && arpSend.valid) {
        arpSend.ready := true.B
        sendStateReg := sendPre
      }
    }
    is (sendPre) {
      sendData("h000108000604".U(48.W), sendOp)
    }
    is (sendOp) {
      when (arpSendOp) {
        sendData(ArpOpResp, sendSrcMac)
      } otherwise {
        sendData(ArpOpReq, sendSrcMac)
      }
    }
    is (sendSrcMac) {
      sendData(MacAddress, sendSrcIp)
    }
    is (sendSrcIp) {
      sendData(IpAddress, sendDestMac)
    }
    is (sendDestMac) {
      sendData(arpSendMac, sendDestIp)
    }
    is (sendDestIp) {
      sendData(arpSendIp, sendIdle)
    }
  }

  arpSend.ready := sendStateReg === sendIdle
  io.arp2Mac.valid := sendStateReg =/= sendIdle

  io.debugPort.op := op.asTypeOf(UInt())
  io.debugPort.macSrc := macSrc.asTypeOf(UInt())
  io.debugPort.macDest := macDest.asTypeOf(UInt())
  io.debugPort.ipSrc := ipSrc.asTypeOf(UInt())
  io.debugPort.ipDest := ipDest.asTypeOf(UInt())
  io.debugPort.ramWriteEnable := arpRamWriteEnable
  io.debugPort.ramWriteAddr := arpRamWriteAddress
  io.debugPort.ramWriteIp := arpRamWriteData.ip
  io.debugPort.ramWriteMac := arpRamWriteData.mac
  io.debugPort.arpOutValid := io.arp2Mac.valid
  io.debugPort.arpOutData := io.arp2Mac.bits
  io.debugPort.state := sendStateReg
}
