package netstack

import chisel3._
import chisel3.util._
import Interface._
import chisel3.stage.ChiselStage

case class NetStack() extends FpgaBasic {
  val rgmii = IO(Rgmii())

  rgmii := DontCare

  withClockAndReset(clock, reset_n) {
    val rxMac = Wire(ValidIO(UInt(8.W)))
    //  val txMac = Wire(Flipped(ValidIO(UInt(8.W))))
    val rgmiiTransfer = Module(RgmiiTransfer())
    rgmiiTransfer.io := DontCare

    rgmiiTransfer.io.rgmii <> rgmii
    rgmiiTransfer.io.rx <> rxMac
    //    rgmiiTransfer.io.tx <> txMac

    debug(rxMac.valid)
    debug(rxMac.bits)
  }
}

object NetStack extends App {
  new ChiselStage emitVerilog(NetStack(), Array("--target-dir", "rtl/netstack"))
}