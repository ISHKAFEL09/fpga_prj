module RgmiiTransfer(
  input        clock,
  input        reset,
  input        io_rgmii_rxClock,
  input  [3:0] io_rgmii_rxData,
  input        io_rgmii_rxCtrl,
  output       io_rgmii_ereset,
  output       io_rx_valid,
  output [7:0] io_rx_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] rxReg; // @[MacReceive.scala 20:18]
  reg [3:0] sReg; // @[MacReceive.scala 22:21]
  wire  _T = 4'h0 == sReg; // @[Conditional.scala 37:30]
  wire  _T_2 = 4'h1 == sReg; // @[Conditional.scala 37:30]
  assign io_rgmii_ereset = ~reset; // @[MacReceive.scala 18:22]
  assign io_rx_valid = _T ? 1'h0 : _T_2; // @[Conditional.scala 40:58 MacReceive.scala 17:15]
  assign io_rx_bits = {rxReg,io_rgmii_rxData}; // @[Cat.scala 30:58]
  always @(posedge clock) begin
    if (_T) begin // @[Conditional.scala 40:58]
      if (io_rgmii_rxClock & io_rgmii_rxCtrl) begin // @[MacReceive.scala 25:50]
        rxReg <= io_rgmii_rxData; // @[MacReceive.scala 26:15]
      end
    end
    if (reset) begin // @[MacReceive.scala 22:21]
      sReg <= 4'h0; // @[MacReceive.scala 22:21]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_rgmii_rxClock & io_rgmii_rxCtrl) begin // @[MacReceive.scala 25:50]
        sReg <= 4'h1; // @[MacReceive.scala 27:14]
      end
    end else if (_T_2) begin // @[Conditional.scala 39:67]
      sReg <= 4'h0; // @[MacReceive.scala 33:12]
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
  rxReg = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  sReg = _RAND_1[3:0];
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
  input        reset,
  output       rgmii_txClock,
  output [3:0] rgmii_txData,
  output       rgmii_txCtrl,
  input        rgmii_rxClock,
  input  [3:0] rgmii_rxData,
  input        rgmii_rxCtrl,
  output       rgmii_ereset
);
  wire  rgmiiTransfer_clock; // @[NetStack.scala 16:31]
  wire  rgmiiTransfer_reset; // @[NetStack.scala 16:31]
  wire  rgmiiTransfer_io_rgmii_rxClock; // @[NetStack.scala 16:31]
  wire [3:0] rgmiiTransfer_io_rgmii_rxData; // @[NetStack.scala 16:31]
  wire  rgmiiTransfer_io_rgmii_rxCtrl; // @[NetStack.scala 16:31]
  wire  rgmiiTransfer_io_rgmii_ereset; // @[NetStack.scala 16:31]
  wire  rgmiiTransfer_io_rx_valid; // @[NetStack.scala 16:31]
  wire [7:0] rgmiiTransfer_io_rx_bits; // @[NetStack.scala 16:31]
  (* mark_debug = "true" *)
  wire  rxMac_valid = rgmiiTransfer_io_rx_valid; // @[NetStack.scala 14:21 NetStack.scala 20:25]
  (* mark_debug = "true" *)
  wire [7:0] rxMac_bits = rgmiiTransfer_io_rx_bits; // @[NetStack.scala 14:21 NetStack.scala 20:25]
  RgmiiTransfer rgmiiTransfer ( // @[NetStack.scala 16:31]
    .clock(rgmiiTransfer_clock),
    .reset(rgmiiTransfer_reset),
    .io_rgmii_rxClock(rgmiiTransfer_io_rgmii_rxClock),
    .io_rgmii_rxData(rgmiiTransfer_io_rgmii_rxData),
    .io_rgmii_rxCtrl(rgmiiTransfer_io_rgmii_rxCtrl),
    .io_rgmii_ereset(rgmiiTransfer_io_rgmii_ereset),
    .io_rx_valid(rgmiiTransfer_io_rx_valid),
    .io_rx_bits(rgmiiTransfer_io_rx_bits)
  );
  assign rgmii_txClock = 1'h0; // @[NetStack.scala 19:28]
  assign rgmii_txData = 4'h0; // @[NetStack.scala 19:28]
  assign rgmii_txCtrl = 1'h0; // @[NetStack.scala 19:28]
  assign rgmii_ereset = rgmiiTransfer_io_rgmii_ereset; // @[NetStack.scala 19:28]
  assign rgmiiTransfer_clock = clock;
  assign rgmiiTransfer_reset = ~reset; // @[package.scala 12:19]
  assign rgmiiTransfer_io_rgmii_rxClock = rgmii_rxClock; // @[NetStack.scala 19:28]
  assign rgmiiTransfer_io_rgmii_rxData = rgmii_rxData; // @[NetStack.scala 19:28]
  assign rgmiiTransfer_io_rgmii_rxCtrl = rgmii_rxCtrl; // @[NetStack.scala 19:28]
endmodule
