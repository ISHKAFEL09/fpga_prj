package netstack

import chisel3._
import chisel3.util._

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
}

case class ArpType() extends Bundle {
  val ip = UInt(32.W)
  val mac = UInt(48.W)
}

case class Arp() extends Module with NetStream {
  val io = IO(new Bundle() {
    val mac2Arp = Flipped(ValidIO(UInt(8.W)))
    val arp2Mac = ValidIO(UInt(8.W))
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

  io.debugPort.op := op.asTypeOf(UInt())
  io.debugPort.macSrc := macSrc.asTypeOf(UInt())
  io.debugPort.macDest := macDest.asTypeOf(UInt())
  io.debugPort.ipSrc := ipSrc.asTypeOf(UInt())
  io.debugPort.ipDest := ipDest.asTypeOf(UInt())
  io.debugPort.ramWriteEnable := arpRamWriteEnable
  io.debugPort.ramWriteAddr := arpRamWriteAddress
  io.debugPort.ramWriteIp := arpRamWriteData.ip
  io.debugPort.ramWriteMac := arpRamWriteData.mac
}
