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
}
