package netstack

import chisel3._
import chisel3.util._
import Interface._
import chisel3.stage.ChiselStage

case class NetStack() extends FpgaBasic {
  val rgmii = IO(Rgmii())
  val led = IO(Output(UInt(4.W)))

  val pll = Module(new FpgaPll)
  pll.io.clk_in <> clock
  pll.io.reset <> reset

  rgmii := DontCare

  withClockAndReset(pll.io.clk_125, reset) {
    val rgmiiTransfer = Module(RgmiiTransfer())
    val macReceive = Module(MacReceive())

    rgmiiTransfer.io := DontCare
    macReceive.io := DontCare

    rgmiiTransfer.io.rgmii <> rgmii
    rgmiiTransfer.io.rx <> macReceive.io.rx
    //    rgmiiTransfer.io.tx <> txMac

    debug(rgmii.rxClock)
    debug(rgmii.rxCtrl)
    debug(rgmii.rxData)
//    debug(rgmii.rxClock)
//    debug(rgmii.rxCtrl)
//    debug(rgmii.rxData)
  }

  rgmii.ereset := reset_n
  withClockAndReset(pll.io.clk_100, reset) {
    val ledReg = RegInit(false.B)
    val (_, done) = Counter(true.B, 50 * 1000 * 1000)
    when (done) { ledReg := !ledReg }
    led := Cat(0.U, ledReg)
  }
}

object NetStack extends App {
  new ChiselStage emitVerilog(NetStack(), Array("--target-dir", "rtl/netstack"))
}