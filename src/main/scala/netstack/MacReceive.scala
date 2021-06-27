package netstack

import chisel3._
import chisel3.util._
import Interface._
import chisel3.experimental.chiselName

case class MacDebugPort() extends Bundle {
  val rxValid = Bool()
  val rxData = UInt(8.W)
  val state = UInt(8.W)
  val cnt = UInt(8.W)
  val macType = UInt(16.W)
  val macWriteEnable = Bool()
  val macWriteAddress = UInt(12.W)
  val macWriteData = UInt(8.W)
  val fifoValid = Bool()
  val fifoStart = UInt(12.W)
  val fifoEnd = UInt(12.W)
}

@chiselName
case class MacReceive() extends Module {
  val io = IO(new Bundle() {
    val rx = Flipped(ValidIO(UInt(8.W)))
    val mac2IpIf = Mac2IpIf()
    val mac2CrcIf = Mac2CrcIf()
    val debugPort = Output(MacDebugPort())
  })

  io := DontCare

  final val preamble = VecInit.tabulate(MacPreamble.length)(MacPreamble(_).U)
  final val macAddress = VecInit.tabulate(MacAddress.length)(MacAddress(_).U)
  final val broadMacAddress = VecInit.tabulate(MacBroadcast.length)(MacBroadcast(_).U)

  val macType = Reg(Vec(2, UInt(8.W)))
  val rxData = io.rx.bits
  val rxValid = io.rx.valid
  val cnt = Counter(MaxBytesPerPkg)
  val sIdle :: sPreamble :: sDestMac :: sSrcMac :: sType :: sData :: sDone :: _ = Enum(10)
  val stateReg = RegInit(sIdle)
  val stateShift = Wire(Bool())
  stateShift := false.B

  val macData = SyncReadMem(1 << 12, UInt(8.W))
  val macDataWriteAddress = Reg(UInt(12.W))
  val macDataWriteEnable = Wire(Bool())
  val macDataWriteData = Wire(UInt(8.W))
  val macDataReadEnable = Wire(Bool())
  val macDataReadAddress = Reg(UInt(12.W))
  val macDataReadData = Wire(UInt(8.W))
  macDataWriteEnable := false.B
  macDataReadEnable := false.B
  when (macDataWriteEnable) { macData.write(macDataWriteAddress, macDataWriteData) }
  macDataReadData := macData.read(macDataReadAddress, macDataReadEnable)
  macDataWriteData := io.rx.bits

  case class MetaFifoIf() extends Bundle {
    val startAddress = UInt(12.W)
    val endAddress = UInt(12.W)
    val info = UInt(8.W)
  }

  val inMetaFifoIf = Wire(Flipped(DecoupledIO(MetaFifoIf())))
  val metaFifo = Queue(inMetaFifoIf, 32)
  val inStartAddress = RegInit(0.U(12.W))
  val inEndAddress = RegInit(0.U(12.W))
  inMetaFifoIf.valid := false.B
  inMetaFifoIf.bits := Cat(0.U, inStartAddress, inEndAddress).asTypeOf(MetaFifoIf())
  metaFifo.ready := true.B

  def parser(pattern: Array[Vec[UInt]], nextState: UInt) = {
    val len = pattern(0).length
    pattern.foreach(i => assert(i.length == len))
    when (rxValid && pattern.map(i => rxData === i(cnt.value)).reduce(_ || _)) {
      cnt.inc()
    } otherwise {
      cnt.reset()
      stateReg := sIdle
    }
    when (cnt.value === (len - 1).U) {
      cnt.reset()
      stateShift := true.B
      stateReg := nextState
    }
  }

  def getData(d: Vec[UInt], nextState: UInt) = {
    for (i <- 0 until d.length) {
      when(rxValid && i.U === cnt.value) {
        d((d.length - i - 1).U) := rxData
      }
    }
    when (rxValid) {
      cnt.inc()
      when(cnt.value === (d.length - 1).U) {
        cnt.reset()
        stateShift := true.B
        stateReg := nextState
      }
    } otherwise {
      cnt.reset()
      stateReg := sIdle
    }
  }

  def idleReceive(i: Int, nextSate: UInt): Unit = {
    if (i != 0) {
      when(rxValid) {
        cnt.inc()
        when(cnt.value === (i - 1).U) {
          cnt.reset()
          stateShift := true.B
          stateReg := nextSate
        }
      } otherwise {
        cnt.reset()
        stateReg := sIdle
      }
    } else {
      when (!rxValid) {
        stateShift := true.B
        stateReg := nextSate
      }
    }
  }

  switch (stateReg) {
    is (sIdle) {
      when (rxValid && rxData === preamble(0)) {
        cnt.inc()
        stateShift := true.B
        stateReg := sPreamble
      }
    }
    is (sPreamble) {
      parser(Array(preamble), sDestMac)
    }
    is (sDestMac) {
      parser(Array(macAddress, broadMacAddress), sSrcMac)
    }
    is (sSrcMac) {
      idleReceive(6, sType)
    }
    is (sType) {
      getData(macType, sData)
    }
    is (sData) {
      idleReceive(0, sDone)
    }
    is (sDone) {
      stateReg := sIdle
    }
  }

  when (stateReg === sType && stateShift) {
    macDataWriteAddress := inEndAddress
    inStartAddress := inEndAddress
  }
  when (stateReg === sData) {
    macDataWriteEnable := true.B
    macDataWriteAddress := macDataWriteAddress + 1.U
    when (stateShift) { inEndAddress := macDataWriteAddress }
  }
  when (stateReg === sDone) {
    inMetaFifoIf.valid := true.B
  }

  io.debugPort.state := stateReg
  io.debugPort.cnt := cnt.value
  io.debugPort.rxValid := io.rx.valid
  io.debugPort.rxData := io.rx.bits
  io.debugPort.macType := macType.asTypeOf(UInt(16.W))
  io.debugPort.macWriteEnable := macDataWriteEnable
  io.debugPort.macWriteAddress := macDataWriteAddress
  io.debugPort.macWriteData := macDataWriteData
  io.debugPort.fifoValid := inMetaFifoIf.valid
  io.debugPort.fifoStart := inStartAddress
  io.debugPort.fifoEnd := inEndAddress
}
