module RgmiiTransfer(
  input        clock,
  input        io_rgmii_rxClock,
  input  [3:0] io_rgmii_rxData,
  input        io_rgmii_rxCtrl,
  output       io_rx_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  topHalfFifo_wr_clk; // @[RgmiiTransfer.scala 19:27]
  wire  topHalfFifo_rd_clk; // @[RgmiiTransfer.scala 19:27]
  wire [3:0] topHalfFifo_din; // @[RgmiiTransfer.scala 19:27]
  wire  topHalfFifo_wr_en; // @[RgmiiTransfer.scala 19:27]
  wire  topHalfFifo_rd_en; // @[RgmiiTransfer.scala 19:27]
  wire [3:0] topHalfFifo_dout; // @[RgmiiTransfer.scala 19:27]
  wire  topHalfFifo_full; // @[RgmiiTransfer.scala 19:27]
  wire  topHalfFifo_almost_full; // @[RgmiiTransfer.scala 19:27]
  wire  topHalfFifo_empty; // @[RgmiiTransfer.scala 19:27]
  wire  topHalfFifo_almost_empty; // @[RgmiiTransfer.scala 19:27]
  wire  bottomHalfFifo_wr_clk; // @[RgmiiTransfer.scala 20:30]
  wire  bottomHalfFifo_rd_clk; // @[RgmiiTransfer.scala 20:30]
  wire [3:0] bottomHalfFifo_din; // @[RgmiiTransfer.scala 20:30]
  wire  bottomHalfFifo_wr_en; // @[RgmiiTransfer.scala 20:30]
  wire  bottomHalfFifo_rd_en; // @[RgmiiTransfer.scala 20:30]
  wire [3:0] bottomHalfFifo_dout; // @[RgmiiTransfer.scala 20:30]
  wire  bottomHalfFifo_full; // @[RgmiiTransfer.scala 20:30]
  wire  bottomHalfFifo_almost_full; // @[RgmiiTransfer.scala 20:30]
  wire  bottomHalfFifo_empty; // @[RgmiiTransfer.scala 20:30]
  wire  bottomHalfFifo_almost_empty; // @[RgmiiTransfer.scala 20:30]
  reg  topHalfFifo_io_wr_en_REG; // @[RgmiiTransfer.scala 24:36]
  reg  io_rx_valid_REG; // @[RgmiiTransfer.scala 36:25]
  FpgaFifo topHalfFifo ( // @[RgmiiTransfer.scala 19:27]
    .wr_clk(topHalfFifo_wr_clk),
    .rd_clk(topHalfFifo_rd_clk),
    .din(topHalfFifo_din),
    .wr_en(topHalfFifo_wr_en),
    .rd_en(topHalfFifo_rd_en),
    .dout(topHalfFifo_dout),
    .full(topHalfFifo_full),
    .almost_full(topHalfFifo_almost_full),
    .empty(topHalfFifo_empty),
    .almost_empty(topHalfFifo_almost_empty)
  );
  FpgaFifo bottomHalfFifo ( // @[RgmiiTransfer.scala 20:30]
    .wr_clk(bottomHalfFifo_wr_clk),
    .rd_clk(bottomHalfFifo_rd_clk),
    .din(bottomHalfFifo_din),
    .wr_en(bottomHalfFifo_wr_en),
    .rd_en(bottomHalfFifo_rd_en),
    .dout(bottomHalfFifo_dout),
    .full(bottomHalfFifo_full),
    .almost_full(bottomHalfFifo_almost_full),
    .empty(bottomHalfFifo_empty),
    .almost_empty(bottomHalfFifo_almost_empty)
  );
  assign io_rx_valid = io_rx_valid_REG; // @[RgmiiTransfer.scala 36:15]
  assign topHalfFifo_wr_clk = ~io_rgmii_rxClock; // @[RgmiiTransfer.scala 22:44]
  assign topHalfFifo_rd_clk = clock; // @[RgmiiTransfer.scala 27:25]
  assign topHalfFifo_din = io_rgmii_rxData; // @[RgmiiTransfer.scala 26:22]
  assign topHalfFifo_wr_en = topHalfFifo_io_wr_en_REG; // @[RgmiiTransfer.scala 24:26]
  assign topHalfFifo_rd_en = io_rx_valid; // @[RgmiiTransfer.scala 28:24]
  assign bottomHalfFifo_wr_clk = io_rgmii_rxClock; // @[RgmiiTransfer.scala 30:55]
  assign bottomHalfFifo_rd_clk = clock; // @[RgmiiTransfer.scala 33:28]
  assign bottomHalfFifo_din = io_rgmii_rxData; // @[RgmiiTransfer.scala 32:25]
  assign bottomHalfFifo_wr_en = io_rgmii_rxCtrl; // @[RgmiiTransfer.scala 31:27]
  assign bottomHalfFifo_rd_en = io_rx_valid; // @[RgmiiTransfer.scala 34:27]
  always @(posedge io_rgmii_rxClock) begin
    topHalfFifo_io_wr_en_REG <= io_rgmii_rxCtrl; // @[RgmiiTransfer.scala 24:36]
  end
  always @(posedge clock) begin
    io_rx_valid_REG <= ~topHalfFifo_empty & ~bottomHalfFifo_empty; // @[RgmiiTransfer.scala 36:48]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  topHalfFifo_io_wr_en_REG = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  io_rx_valid_REG = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module NetStack(
  input        clock,
  input        reset_n,
  output       rgmii_txClock,
  output [3:0] rgmii_txData,
  output       rgmii_txCtrl,

  (* mark_debug = "true" *)
  input        rgmii_rxClock,

  (* mark_debug = "true" *)
  input  [3:0] rgmii_rxData,

  (* mark_debug = "true" *)
  input        rgmii_rxCtrl,
  output       rgmii_ereset,
  output [3:0] led
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  pll_clk_in; // @[NetStack.scala 12:19]
  wire  pll_reset; // @[NetStack.scala 12:19]
  wire  pll_clk_100; // @[NetStack.scala 12:19]
  wire  pll_clk_125; // @[NetStack.scala 12:19]
  wire  pll_clk_200; // @[NetStack.scala 12:19]
  wire  pll_clk_250; // @[NetStack.scala 12:19]
  wire  pll_locked; // @[NetStack.scala 12:19]
  wire  rgmiiTransfer_clock; // @[NetStack.scala 19:31]
  wire  rgmiiTransfer_io_rgmii_rxClock; // @[NetStack.scala 19:31]
  wire [3:0] rgmiiTransfer_io_rgmii_rxData; // @[NetStack.scala 19:31]
  wire  rgmiiTransfer_io_rgmii_rxCtrl; // @[NetStack.scala 19:31]
  wire  rgmiiTransfer_io_rx_valid; // @[NetStack.scala 19:31]
  wire  reset = ~reset_n; // @[package.scala 12:17]
  reg  led_lo; // @[NetStack.scala 39:25]
  reg [25:0] done_value; // @[Counter.scala 60:40]
  wire  done_wrap_wrap = done_value == 26'h2faf07f; // @[Counter.scala 72:24]
  wire [25:0] _done_wrap_value_T_1 = done_value + 26'h1; // @[Counter.scala 76:24]
  wire [1:0] _led_T = {1'h0,led_lo}; // @[Cat.scala 30:58]
  FpgaPll pll ( // @[NetStack.scala 12:19]
    .clk_in(pll_clk_in),
    .reset(pll_reset),
    .clk_100(pll_clk_100),
    .clk_125(pll_clk_125),
    .clk_200(pll_clk_200),
    .clk_250(pll_clk_250),
    .locked(pll_locked)
  );
  RgmiiTransfer rgmiiTransfer ( // @[NetStack.scala 19:31]
    .clock(rgmiiTransfer_clock),
    .io_rgmii_rxClock(rgmiiTransfer_io_rgmii_rxClock),
    .io_rgmii_rxData(rgmiiTransfer_io_rgmii_rxData),
    .io_rgmii_rxCtrl(rgmiiTransfer_io_rgmii_rxCtrl),
    .io_rx_valid(rgmiiTransfer_io_rx_valid)
  );
  assign rgmii_txClock = 1'h0; // @[NetStack.scala 25:28]
  assign rgmii_txData = 4'h0; // @[NetStack.scala 25:28]
  assign rgmii_txCtrl = 1'h0; // @[NetStack.scala 25:28]
  assign rgmii_ereset = reset_n; // @[NetStack.scala 37:16]
  assign led = {{2'd0}, _led_T}; // @[Cat.scala 30:58]
  assign pll_clk_in = clock; // @[NetStack.scala 13:17]
  assign pll_reset = ~reset_n; // @[package.scala 12:17]
  assign rgmiiTransfer_clock = pll_clk_125;
  assign rgmiiTransfer_io_rgmii_rxClock = rgmii_rxClock; // @[NetStack.scala 25:28]
  assign rgmiiTransfer_io_rgmii_rxData = rgmii_rxData; // @[NetStack.scala 25:28]
  assign rgmiiTransfer_io_rgmii_rxCtrl = rgmii_rxCtrl; // @[NetStack.scala 25:28]
  always @(posedge pll_clk_100) begin
    if (reset) begin // @[NetStack.scala 39:25]
      led_lo <= 1'h0; // @[NetStack.scala 39:25]
    end else if (done_wrap_wrap) begin // @[NetStack.scala 41:17]
      led_lo <= ~led_lo; // @[NetStack.scala 41:26]
    end
    if (reset) begin // @[Counter.scala 60:40]
      done_value <= 26'h0; // @[Counter.scala 60:40]
    end else if (done_wrap_wrap) begin // @[Counter.scala 86:20]
      done_value <= 26'h0; // @[Counter.scala 86:28]
    end else begin
      done_value <= _done_wrap_value_T_1; // @[Counter.scala 76:15]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  led_lo = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  done_value = _RAND_1[25:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
