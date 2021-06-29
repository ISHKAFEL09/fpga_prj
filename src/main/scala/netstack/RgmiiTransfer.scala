package netstack

import chisel3._
import chisel3.util._
import Interface._
import chisel3.experimental.chiselName

case class RgmiiDebugPort() extends Bundle {
  val rgmiiRxClock = Bool()
  val rgmiiRxCtrl = Bool()
  val rgmiiRxData = UInt(4.W)
  val rxValid = Bool()
  val rxData = UInt(8.W)
  val riseFifo = UInt(4.W)
  val fallFifo = UInt(4.W)
}

@chiselName
case class RgmiiTransfer() extends Module {
  val io = IO(new Bundle() {
    val rgmii = Rgmii()
    val rx = ValidIO(UInt(8.W))
    val tx = Flipped(ValidIO(UInt(8.W)))
    val debugPort = Output(RgmiiDebugPort())
  })

  io := DontCare

  val phasePll = Module(new FpgaPhasePll)
  val topHalfFifo = Module(new FpgaFifo(4))
  val bottomHalfFifo = Module(new FpgaFifo(4))

  phasePll.io.clk_in := io.rgmii.rxClock.asClock()

  topHalfFifo.io.rst <> reset
  bottomHalfFifo.io.rst <> reset

  topHalfFifo.io.wr_clk <> phasePll.io.clk_p45
  topHalfFifo.io.wr_en <> io.rgmii.rxCtrl
  topHalfFifo.io.din <> io.rgmii.rxData
  topHalfFifo.io.rd_clk <> clock
  topHalfFifo.io.rd_en := io.rx.valid

  bottomHalfFifo.io.wr_clk <> phasePll.io.clk_p225
  bottomHalfFifo.io.wr_en <> io.rgmii.rxCtrl
  bottomHalfFifo.io.din <> io.rgmii.rxData
  bottomHalfFifo.io.rd_clk <> clock
  bottomHalfFifo.io.rd_en := io.rx.valid

  val notEmpty = !topHalfFifo.io.empty && !bottomHalfFifo.io.empty
  io.rx.valid := RegNext(RegNext(RegNext(notEmpty))) && notEmpty
  io.rx.bits := Cat(topHalfFifo.io.dout, bottomHalfFifo.io.dout)

//  io.debugPort.rgmiiRxClock := io.rgmii.rxClock
  io.debugPort.rgmiiRxCtrl := io.rgmii.rxCtrl
  io.debugPort.rgmiiRxData := io.rgmii.rxData
  io.debugPort.rxValid := io.rx.valid
  io.debugPort.rxData := io.rx.bits
  io.debugPort.riseFifo := bottomHalfFifo.io.dout
  io.debugPort.fallFifo := topHalfFifo.io.dout
}
