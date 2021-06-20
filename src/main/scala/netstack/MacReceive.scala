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
          stateReg := nextSate
        }
      } otherwise {
        cnt.reset()
        stateReg := sIdle
      }
    } else {
      when (!rxValid) { stateReg := nextSate }
    }
  }

  switch (stateReg) {
    is (sIdle) {
      when (rxValid && rxData === preamble(0)) {
        cnt.inc()
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

  io.debugPort.state := stateReg
  io.debugPort.cnt := cnt.value
  io.debugPort.rxValid := io.rx.valid
  io.debugPort.rxData := io.rx.bits
  io.debugPort.macType := macType.asTypeOf(UInt(16.W))
}
