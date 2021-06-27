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

  val rxClockN = !io.rgmii.rxClock
  val topHalfFifo = Module(new FpgaFifo(4))
  val bottomHalfFifo = Module(new FpgaFifo(4))

  topHalfFifo.io.rst <> reset
  bottomHalfFifo.io.rst <> reset

  topHalfFifo.io.wr_clk <> rxClockN.asClock()
  withClock(io.rgmii.rxClock.asClock()) {
    topHalfFifo.io.wr_en <> RegNext(io.rgmii.rxCtrl)
  }
  topHalfFifo.io.din <> io.rgmii.rxData
  topHalfFifo.io.rd_clk <> clock
  topHalfFifo.io.rd_en := io.rx.valid

  bottomHalfFifo.io.wr_clk <> io.rgmii.rxClock.asClock()
  bottomHalfFifo.io.wr_en <> io.rgmii.rxCtrl
  bottomHalfFifo.io.din <> io.rgmii.rxData
  bottomHalfFifo.io.rd_clk <> clock
  bottomHalfFifo.io.rd_en := io.rx.valid

  val notEmpty = !topHalfFifo.io.empty && !bottomHalfFifo.io.empty
  io.rx.valid := RegNext(notEmpty) && notEmpty
  io.rx.bits := Cat(topHalfFifo.io.dout, bottomHalfFifo.io.dout)

  io.debugPort.rgmiiRxClock := io.rgmii.rxClock
  io.debugPort.rgmiiRxCtrl := io.rgmii.rxCtrl
  io.debugPort.rgmiiRxData := io.rgmii.rxData
  io.debugPort.rxValid := io.rx.valid
  io.debugPort.rxData := io.rx.bits
}
