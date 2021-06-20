import chisel3._
import chisel3.experimental._
import firrtl.AttributeAnnotation
import firrtl.annotations.Annotation
import firrtl.transforms.DontTouchAnnotation

package object netstack {
  @chiselName
  class FpgaBasic extends RawModule {
    val clock = IO(Input(Clock()))
    val reset_n = IO(Input(Bool()))
    val reset = !reset_n

    def debug(data: Data) = {
      annotate(new ChiselAnnotation {
        override def toFirrtl: Annotation = DontTouchAnnotation(data.toTarget)
      })

      annotate(new ChiselAnnotation {
        override def toFirrtl: Annotation = AttributeAnnotation(data.toTarget, """mark_debug = "true"""")
      })
    }
  }

  class FpgaFifo(width: Int) extends BlackBox {
    val io = IO(new Bundle() {
//      val rst = Input(Reset())
      val wr_clk = Input(Clock())
      val rd_clk = Input(Clock())
      val din = Input(UInt(width.W))
      val wr_en = Input(Bool())
      val rd_en = Input(Bool())
      val dout = Output(UInt(width.W))
      val full = Output(Bool())
      val almost_full = Output(Bool())
      val empty = Output(Bool())
      val almost_empty = Output(Bool())
//      val wr_rst_busy = Output(Bool())
//      val rd_rst_busy = Output(Bool())
    })
  }

  class FpgaPll extends BlackBox {
    val io = IO(new Bundle() {
      val clk_in = Input(Clock())
      val reset = Input(Reset())
      val clk_100 = Output(Clock())
      val clk_125 = Output(Clock())
      val clk_200 = Output(Clock())
      val clk_250 = Output(Clock())
      val locked = Output(Bool())
    })
  }

  val MaxBytesPerPkg = 1500
  val MinBytesPerPkg = 46
  val MacPreamble = Array.fill(7)("h55") ++ Array("hd5")
  val MacBroadcast = Array.fill(6)("hFF")
  val MacAddress = Array("h12", "h34", "h55", "hAA", "hFF", "h00")
}
