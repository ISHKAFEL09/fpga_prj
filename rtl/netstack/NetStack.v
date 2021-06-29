module RgmiiTransfer(
  input        clock,
  input        reset,
  input        io_rgmii_rxClock,
  input  [3:0] io_rgmii_rxData,
  input        io_rgmii_rxCtrl,
  output       io_rx_valid,
  output [7:0] io_rx_bits,

  (* mark_debug = "true" *)
  output       io_debugPort_rgmiiRxClock,

  (* mark_debug = "true" *)
  output       io_debugPort_rgmiiRxCtrl,

  (* mark_debug = "true" *)
  output [3:0] io_debugPort_rgmiiRxData,

  (* mark_debug = "true" *)
  output       io_debugPort_rxValid,

  (* mark_debug = "true" *)
  output [7:0] io_debugPort_rxData,

  (* mark_debug = "true" *)
  output [3:0] io_debugPort_riseFifo,

  (* mark_debug = "true" *)
  output [3:0] io_debugPort_fallFifo
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  phasePll_clk_in; // @[RgmiiTransfer.scala 29:24]
  wire  phasePll_reset; // @[RgmiiTransfer.scala 29:24]
  wire  phasePll_clk_p45; // @[RgmiiTransfer.scala 29:24]
  wire  phasePll_clk_p90; // @[RgmiiTransfer.scala 29:24]
  wire  phasePll_clk_p180; // @[RgmiiTransfer.scala 29:24]
  wire  phasePll_clk_p225; // @[RgmiiTransfer.scala 29:24]
  wire  phasePll_clk_p270; // @[RgmiiTransfer.scala 29:24]
  wire  topHalfFifo_rst; // @[RgmiiTransfer.scala 30:27]
  wire  topHalfFifo_wr_clk; // @[RgmiiTransfer.scala 30:27]
  wire  topHalfFifo_rd_clk; // @[RgmiiTransfer.scala 30:27]
  wire [3:0] topHalfFifo_din; // @[RgmiiTransfer.scala 30:27]
  wire  topHalfFifo_wr_en; // @[RgmiiTransfer.scala 30:27]
  wire  topHalfFifo_rd_en; // @[RgmiiTransfer.scala 30:27]
  wire [3:0] topHalfFifo_dout; // @[RgmiiTransfer.scala 30:27]
  wire  topHalfFifo_full; // @[RgmiiTransfer.scala 30:27]
  wire  topHalfFifo_empty; // @[RgmiiTransfer.scala 30:27]
  wire  bottomHalfFifo_rst; // @[RgmiiTransfer.scala 31:30]
  wire  bottomHalfFifo_wr_clk; // @[RgmiiTransfer.scala 31:30]
  wire  bottomHalfFifo_rd_clk; // @[RgmiiTransfer.scala 31:30]
  wire [3:0] bottomHalfFifo_din; // @[RgmiiTransfer.scala 31:30]
  wire  bottomHalfFifo_wr_en; // @[RgmiiTransfer.scala 31:30]
  wire  bottomHalfFifo_rd_en; // @[RgmiiTransfer.scala 31:30]
  wire [3:0] bottomHalfFifo_dout; // @[RgmiiTransfer.scala 31:30]
  wire  bottomHalfFifo_full; // @[RgmiiTransfer.scala 31:30]
  wire  bottomHalfFifo_empty; // @[RgmiiTransfer.scala 31:30]
  wire  notEmpty = ~topHalfFifo_empty & ~bottomHalfFifo_empty; // @[RgmiiTransfer.scala 50:40]
  reg  io_rx_valid_REG; // @[RgmiiTransfer.scala 51:41]
  reg  io_rx_valid_REG_1; // @[RgmiiTransfer.scala 51:33]
  reg  io_rx_valid_REG_2; // @[RgmiiTransfer.scala 51:25]
  FpgaPhasePll phasePll ( // @[RgmiiTransfer.scala 29:24]
    .clk_in(phasePll_clk_in),
    .reset(phasePll_reset),
    .clk_p45(phasePll_clk_p45),
    .clk_p90(phasePll_clk_p90),
    .clk_p180(phasePll_clk_p180),
    .clk_p225(phasePll_clk_p225),
    .clk_p270(phasePll_clk_p270)
  );
  FpgaFifo topHalfFifo ( // @[RgmiiTransfer.scala 30:27]
    .rst(topHalfFifo_rst),
    .wr_clk(topHalfFifo_wr_clk),
    .rd_clk(topHalfFifo_rd_clk),
    .din(topHalfFifo_din),
    .wr_en(topHalfFifo_wr_en),
    .rd_en(topHalfFifo_rd_en),
    .dout(topHalfFifo_dout),
    .full(topHalfFifo_full),
    .empty(topHalfFifo_empty)
  );
  FpgaFifo bottomHalfFifo ( // @[RgmiiTransfer.scala 31:30]
    .rst(bottomHalfFifo_rst),
    .wr_clk(bottomHalfFifo_wr_clk),
    .rd_clk(bottomHalfFifo_rd_clk),
    .din(bottomHalfFifo_din),
    .wr_en(bottomHalfFifo_wr_en),
    .rd_en(bottomHalfFifo_rd_en),
    .dout(bottomHalfFifo_dout),
    .full(bottomHalfFifo_full),
    .empty(bottomHalfFifo_empty)
  );
  assign io_rx_valid = io_rx_valid_REG_2 & notEmpty; // @[RgmiiTransfer.scala 51:54]
  assign io_rx_bits = {topHalfFifo_dout,bottomHalfFifo_dout}; // @[Cat.scala 30:58]
  assign io_debugPort_rgmiiRxClock = 1'h0;
  assign io_debugPort_rgmiiRxCtrl = io_rgmii_rxCtrl; // @[RgmiiTransfer.scala 55:28]
  assign io_debugPort_rgmiiRxData = io_rgmii_rxData; // @[RgmiiTransfer.scala 56:28]
  assign io_debugPort_rxValid = io_rx_valid; // @[RgmiiTransfer.scala 57:24]
  assign io_debugPort_rxData = io_rx_bits; // @[RgmiiTransfer.scala 58:23]
  assign io_debugPort_riseFifo = bottomHalfFifo_dout; // @[RgmiiTransfer.scala 59:25]
  assign io_debugPort_fallFifo = topHalfFifo_dout; // @[RgmiiTransfer.scala 60:25]
  assign phasePll_clk_in = io_rgmii_rxClock; // @[RgmiiTransfer.scala 33:49]
  assign phasePll_reset = 1'h0;
  assign topHalfFifo_rst = reset; // @[RgmiiTransfer.scala 35:22]
  assign topHalfFifo_wr_clk = phasePll_clk_p45; // @[RgmiiTransfer.scala 38:25]
  assign topHalfFifo_rd_clk = clock; // @[RgmiiTransfer.scala 41:25]
  assign topHalfFifo_din = io_rgmii_rxData; // @[RgmiiTransfer.scala 40:22]
  assign topHalfFifo_wr_en = io_rgmii_rxCtrl; // @[RgmiiTransfer.scala 39:24]
  assign topHalfFifo_rd_en = io_rx_valid; // @[RgmiiTransfer.scala 42:24]
  assign bottomHalfFifo_rst = reset; // @[RgmiiTransfer.scala 36:25]
  assign bottomHalfFifo_wr_clk = phasePll_clk_p225; // @[RgmiiTransfer.scala 44:28]
  assign bottomHalfFifo_rd_clk = clock; // @[RgmiiTransfer.scala 47:28]
  assign bottomHalfFifo_din = io_rgmii_rxData; // @[RgmiiTransfer.scala 46:25]
  assign bottomHalfFifo_wr_en = io_rgmii_rxCtrl; // @[RgmiiTransfer.scala 45:27]
  assign bottomHalfFifo_rd_en = io_rx_valid; // @[RgmiiTransfer.scala 48:27]
  always @(posedge clock) begin
    io_rx_valid_REG <= ~topHalfFifo_empty & ~bottomHalfFifo_empty; // @[RgmiiTransfer.scala 50:40]
    io_rx_valid_REG_1 <= io_rx_valid_REG; // @[RgmiiTransfer.scala 51:33]
    io_rx_valid_REG_2 <= io_rx_valid_REG_1; // @[RgmiiTransfer.scala 51:25]
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
  io_rx_valid_REG = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  io_rx_valid_REG_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  io_rx_valid_REG_2 = _RAND_2[0:0];
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
  input        rgmii_rxClock,
  input  [3:0] rgmii_rxData,
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
  wire  rgmiiTransfer_reset; // @[NetStack.scala 19:31]
  wire  rgmiiTransfer_io_rgmii_rxClock; // @[NetStack.scala 19:31]
  wire [3:0] rgmiiTransfer_io_rgmii_rxData; // @[NetStack.scala 19:31]
  wire  rgmiiTransfer_io_rgmii_rxCtrl; // @[NetStack.scala 19:31]
  wire  rgmiiTransfer_io_rx_valid; // @[NetStack.scala 19:31]
  wire [7:0] rgmiiTransfer_io_rx_bits; // @[NetStack.scala 19:31]
  wire  rgmiiTransfer_io_debugPort_rgmiiRxClock; // @[NetStack.scala 19:31]
  wire  rgmiiTransfer_io_debugPort_rgmiiRxCtrl; // @[NetStack.scala 19:31]
  wire [3:0] rgmiiTransfer_io_debugPort_rgmiiRxData; // @[NetStack.scala 19:31]
  wire  rgmiiTransfer_io_debugPort_rxValid; // @[NetStack.scala 19:31]
  wire [7:0] rgmiiTransfer_io_debugPort_rxData; // @[NetStack.scala 19:31]
  wire [3:0] rgmiiTransfer_io_debugPort_riseFifo; // @[NetStack.scala 19:31]
  wire [3:0] rgmiiTransfer_io_debugPort_fallFifo; // @[NetStack.scala 19:31]
  wire  _T = ~reset_n; // @[NetStack.scala 18:55]
  reg  led_lo; // @[NetStack.scala 35:25]
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
    .reset(rgmiiTransfer_reset),
    .io_rgmii_rxClock(rgmiiTransfer_io_rgmii_rxClock),
    .io_rgmii_rxData(rgmiiTransfer_io_rgmii_rxData),
    .io_rgmii_rxCtrl(rgmiiTransfer_io_rgmii_rxCtrl),
    .io_rx_valid(rgmiiTransfer_io_rx_valid),
    .io_rx_bits(rgmiiTransfer_io_rx_bits),
    .io_debugPort_rgmiiRxClock(rgmiiTransfer_io_debugPort_rgmiiRxClock),
    .io_debugPort_rgmiiRxCtrl(rgmiiTransfer_io_debugPort_rgmiiRxCtrl),
    .io_debugPort_rgmiiRxData(rgmiiTransfer_io_debugPort_rgmiiRxData),
    .io_debugPort_rxValid(rgmiiTransfer_io_debugPort_rxValid),
    .io_debugPort_rxData(rgmiiTransfer_io_debugPort_rxData),
    .io_debugPort_riseFifo(rgmiiTransfer_io_debugPort_riseFifo),
    .io_debugPort_fallFifo(rgmiiTransfer_io_debugPort_fallFifo)
  );
  assign rgmii_txClock = 1'h0; // @[NetStack.scala 25:28]
  assign rgmii_txData = 4'h0; // @[NetStack.scala 25:28]
  assign rgmii_txCtrl = 1'h0; // @[NetStack.scala 25:28]
  assign rgmii_ereset = reset_n; // @[NetStack.scala 33:16]
  assign led = {{2'd0}, _led_T}; // @[Cat.scala 30:58]
  assign pll_clk_in = clock; // @[NetStack.scala 13:17]
  assign pll_reset = ~reset_n; // @[package.scala 12:17]
  assign rgmiiTransfer_clock = pll_clk_125;
  assign rgmiiTransfer_reset = ~reset_n; // @[NetStack.scala 18:55]
  assign rgmiiTransfer_io_rgmii_rxClock = rgmii_rxClock; // @[NetStack.scala 25:28]
  assign rgmiiTransfer_io_rgmii_rxData = rgmii_rxData; // @[NetStack.scala 25:28]
  assign rgmiiTransfer_io_rgmii_rxCtrl = rgmii_rxCtrl; // @[NetStack.scala 25:28]
  always @(posedge pll_clk_100 or posedge _T) begin
    if (_T) begin
      led_lo <= 1'h0;
    end else if (done_wrap_wrap) begin
      led_lo <= ~led_lo;
    end
  end
  always @(posedge pll_clk_100 or posedge _T) begin
    if (_T) begin
      done_value <= 26'h0;
    end else if (done_wrap_wrap) begin
      done_value <= 26'h0;
    end else begin
      done_value <= _done_wrap_value_T_1;
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
  if (_T) begin
    led_lo = 1'h0;
  end
  if (_T) begin
    done_value = 26'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
