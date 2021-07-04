import chisel3._
import chisel3.experimental._
import chisel3.util._
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
      val rst = Input(Reset())
      val wr_clk = Input(Clock())
      val rd_clk = Input(Clock())
      val din = Input(UInt(width.W))
      val wr_en = Input(Bool())
      val rd_en = Input(Bool())
      val dout = Output(UInt(width.W))
      val full = Output(Bool())
//      val almost_full = Output(Bool())
      val empty = Output(Bool())
//      val almost_empty = Output(Bool())
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

  class FpgaPhasePll extends BlackBox {
    val io = IO(new Bundle() {
      val clk_in = Input(Clock())
      val reset = Input(Reset())
      val clk_p45 = Output(Clock())
      val clk_p90 = Output(Clock())
      val clk_p180 = Output(Clock())
      val clk_p225 = Output(Clock())
      val clk_p270 = Output(Clock())
    })
  }

  trait SendStream {
    val sCnt: Counter
    val sPort: DecoupledIO[UInt]
    val sState: UInt

    def sendData(d: Vec[UInt], nextState: UInt) = {
      sPort.bits := d(sCnt.value)
      sCnt.inc()
      when (sCnt.value === (d.length - 1).U) {
        sCnt.reset()
        sState := nextState
      }
    }
  }

  trait ReceiveStream {
    val cnt: Counter
    val vd: ValidIO[UInt]
    val st: UInt
    val idle: UInt
    val ss: Bool

    def parser(pattern: Array[Vec[UInt]], nextState: UInt) = {
      val len = pattern(0).length
      pattern.foreach(i => assert(i.length == len))
      when (vd.valid && pattern.map(i => vd.bits === i(cnt.value)).reduce(_ || _)) {
        cnt.inc()
      } otherwise {
        cnt.reset()
        st := idle
      }
      when (cnt.value === (len - 1).U) {
        cnt.reset()
        ss := true.B
        st := nextState
      }
    }

    def getData(d: Vec[UInt], nextState: UInt) = {
      for (i <- 0 until d.length) {
        when(vd.valid && i.U === cnt.value) {
          d((d.length - i - 1).U) := vd.bits
        }
      }
      when (vd.valid) {
        cnt.inc()
        when(cnt.value === (d.length - 1).U) {
          cnt.reset()
          ss := true.B
          st := nextState
        }
      } otherwise {
        cnt.reset()
        st := idle
      }
    }

    def idleReceive(i: Int, nextSate: UInt): Unit = {
      if (i != 0) {
        when(vd.valid) {
          cnt.inc()
          when(cnt.value === (i - 1).U) {
            cnt.reset()
            ss := true.B
            st := nextSate
          }
        } otherwise {
          cnt.reset()
          st := idle
        }
      } else {
        when (!vd.valid) {
          ss := true.B
          st := nextSate
        }
      }
    }

  }

  implicit def Uint2Vec(u: UInt): Vec[UInt] = {
    val bytes = u.getWidth / 8
    val v = Wire(Vec(bytes, UInt(8.W)))
    for (i <- 0 until bytes) {
      v(i) := u((bytes - i) * 8 - 1, (bytes - i - 1) * 8)
    }
    v
  }

  implicit def Array2Vec(a: Array[String]): Vec[UInt] = {
    VecInit.tabulate(a.length)(a(_).U(8.W))
  }

  val MaxBytesPerPkg = 1500
  val MinBytesPerPkg = 46
  val MacPreamble = "h55555555555555d5".U(64.W)//Array.fill(7)("h55") ++ Array("hd5")
  val MacBroadcast = Array.fill(6)("hFF")
  val MacAddress = Array("h12", "h34", "h55", "hAA", "hFF", "h00")
  val MacTypeArp = "h0806".U(32.W)
  val MacTypeIp = "h0800".U(32.W)

  val ArpOpReq = "h1".U(16.W)
  val ArpOpResp = "h2".U(16.W)
  val ArpPreamble = Array("h00", "h01", "h08", "h00", "h06", "h04")

  val IpAddress = Array("hAA", "hBB", "hCC", "hDD")
}
