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

  withClockAndReset(pll.io.clk_125, reset.asAsyncReset()) {
    val rgmiiTransfer = Module(RgmiiTransfer())
    val macReceive = Module(MacReceive())
    val arp = Module(Arp())

    rgmiiTransfer.io := DontCare
    macReceive.io := DontCare
    arp.io := DontCare

    rgmiiTransfer.io.rgmii <> rgmii
    rgmiiTransfer.io.rx <> macReceive.io.rx
    macReceive.io.mac2IpIf.arpData <> arp.io.mac2Arp
    //    rgmiiTransfer.io.tx <> txMac

//    debug(rgmiiTransfer.io.debugPort)
    debug(macReceive.io.debugPort)
    arp.io.arp2Mac.ready := true.B
    debug(arp.io.debugPort)
  }

  rgmii.ereset := reset_n
  withClockAndReset(pll.io.clk_100, reset.asAsyncReset()) {
    val ledReg = RegInit(false.B)
    val (_, done) = Counter(true.B, 50 * 1000 * 1000)
    when (done) { ledReg := !ledReg }
    led := Cat(0.U, ledReg)
  }
}

object NetStack extends App {
  new ChiselStage emitVerilog(NetStack(), Array("--target-dir", "rtl/netstack"))
}