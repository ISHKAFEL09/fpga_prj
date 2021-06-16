package netstack

import chisel3._
import chisel3.util._
import Interface._

// 250M
case class RgmiiTransfer() extends Module {
  val io = IO(new Bundle() {
    val rgmii = Rgmii()
    val rx = ValidIO(UInt(8.W))
    val tx = Flipped(ValidIO(UInt(8.W)))
  })

  io := DontCare

  io.rx.valid := false.B
  io.rgmii.ereset := ~reset.asBool()

  val rxReg = Reg(UInt(4.W))
  val idle :: s0 :: s1 :: _ = Enum(10)
  val sReg = RegInit(idle)
  switch (sReg) {
    is (idle) {
      when (io.rgmii.rxClock && io.rgmii.rxCtrl) {
        rxReg := io.rgmii.rxData
        sReg := s0
      }
    }
    is (s0) {
      io.rx.valid := true.B
      io.rx.bits := Cat(rxReg, io.rgmii.rxData)
      sReg := idle
    }
  }
}

class MacReceive {

}
