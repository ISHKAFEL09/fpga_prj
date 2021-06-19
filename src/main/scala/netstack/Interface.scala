package netstack

import chisel3._
import chisel3.util._

object Interface {
  case class Rgmii() extends Bundle {
    val txClock = Output(Bool())
    val txData = Output(UInt(4.W))
    val txCtrl = Output(Bool())
    val rxClock = Input(Bool())
    val rxData = Input(UInt(4.W))
    val rxCtrl = Input(Bool())
    //  val mdc = Output(Bool())
    //  val mdi = Input(Bool())
    //  val mdo = Output(Bool())
    //  val mdoEn = Output(Bool())
    val ereset = Output(Bool())
  }

  case class Mac2IpIf() extends Bundle {
    val arpData = ValidIO(UInt(8.W))
    val ipData = ValidIO(UInt(8.W))
  }

  case class Mac2CrcIf() extends Bundle {
    val crcData = ValidIO(UInt(8.W))
    val crcDone = Input(Bool())
    val crcErr = Input(Bool())
  }
}
