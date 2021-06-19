package netstack

import chisel3._
import chisel3.util._
import Interface._

case class MacReceive() extends Module {
  val io = IO(new Bundle() {
    val rx = Flipped(ValidIO(UInt(8.W)))
    val mac2IpIf = Mac2IpIf()
    val mac2CrcIf = Mac2CrcIf()
  })

  io := DontCare

  final val preamble = Cat(Fill(7, "h55".U(8.W)), "hd5".U(8.W)).asTypeOf(Vec(8, UInt(8.W)))
  final val macAddress = MacAddress.asTypeOf(Vec(6, UInt(8.W)))
  final val broadMacAddress = "hFFFF_FFFF_FFFF".U.asTypeOf(Vec(6, UInt(8.W)))

  val macType = Wire(Vec(2, UInt(8.W)))
  macType.foreach(_ := 0.U)
  val rxData = io.rx.bits
  val rxValid = io.rx.valid
  val cnt = Counter(MaxBytesPerPkg)
  val sIdle :: sPreamble :: sDestMac :: sSrcMac :: sType :: sData :: sDone :: _ = Enum(10)
  val stateReg = RegInit(sIdle)

  def parser(pattern: Array[Vec[UInt]], nextState: UInt) = {
    when (rxValid && pattern.map(i => rxData === i(cnt.value)).reduce(_ || _)) {
      cnt.inc()
    } otherwise {
      cnt.reset()
      stateReg := sIdle
    }
    when (cnt.value === pattern(0).length.U) {
      cnt.reset()
      stateReg := nextState
    }
  }

  def getData(d: Vec[UInt], nextState: UInt) = {
    when (rxValid) {
      d(cnt.value) := rxData
      cnt.inc()
      when(cnt.value === d.length.U) {
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
        when(cnt.value === i.U) {
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
}
