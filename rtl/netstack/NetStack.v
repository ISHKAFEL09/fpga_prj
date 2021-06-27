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
  output [7:0] io_debugPort_rxData
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  topHalfFifo_rst; // @[RgmiiTransfer.scala 28:27]
  wire  topHalfFifo_wr_clk; // @[RgmiiTransfer.scala 28:27]
  wire  topHalfFifo_rd_clk; // @[RgmiiTransfer.scala 28:27]
  wire [3:0] topHalfFifo_din; // @[RgmiiTransfer.scala 28:27]
  wire  topHalfFifo_wr_en; // @[RgmiiTransfer.scala 28:27]
  wire  topHalfFifo_rd_en; // @[RgmiiTransfer.scala 28:27]
  wire [3:0] topHalfFifo_dout; // @[RgmiiTransfer.scala 28:27]
  wire  topHalfFifo_full; // @[RgmiiTransfer.scala 28:27]
  wire  topHalfFifo_empty; // @[RgmiiTransfer.scala 28:27]
  wire  bottomHalfFifo_rst; // @[RgmiiTransfer.scala 29:30]
  wire  bottomHalfFifo_wr_clk; // @[RgmiiTransfer.scala 29:30]
  wire  bottomHalfFifo_rd_clk; // @[RgmiiTransfer.scala 29:30]
  wire [3:0] bottomHalfFifo_din; // @[RgmiiTransfer.scala 29:30]
  wire  bottomHalfFifo_wr_en; // @[RgmiiTransfer.scala 29:30]
  wire  bottomHalfFifo_rd_en; // @[RgmiiTransfer.scala 29:30]
  wire [3:0] bottomHalfFifo_dout; // @[RgmiiTransfer.scala 29:30]
  wire  bottomHalfFifo_full; // @[RgmiiTransfer.scala 29:30]
  wire  bottomHalfFifo_empty; // @[RgmiiTransfer.scala 29:30]
  reg  topHalfFifo_io_wr_en_REG; // @[RgmiiTransfer.scala 36:36]
  wire  notEmpty = ~topHalfFifo_empty & ~bottomHalfFifo_empty; // @[RgmiiTransfer.scala 48:40]
  reg  io_rx_valid_REG; // @[RgmiiTransfer.scala 49:25]
  FpgaFifo topHalfFifo ( // @[RgmiiTransfer.scala 28:27]
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
  FpgaFifo bottomHalfFifo ( // @[RgmiiTransfer.scala 29:30]
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
  assign io_rx_valid = io_rx_valid_REG & notEmpty; // @[RgmiiTransfer.scala 49:36]
  assign io_rx_bits = {topHalfFifo_dout,bottomHalfFifo_dout}; // @[Cat.scala 30:58]
  assign io_debugPort_rgmiiRxClock = io_rgmii_rxClock; // @[RgmiiTransfer.scala 52:29]
  assign io_debugPort_rgmiiRxCtrl = io_rgmii_rxCtrl; // @[RgmiiTransfer.scala 53:28]
  assign io_debugPort_rgmiiRxData = io_rgmii_rxData; // @[RgmiiTransfer.scala 54:28]
  assign io_debugPort_rxValid = io_rx_valid; // @[RgmiiTransfer.scala 55:24]
  assign io_debugPort_rxData = io_rx_bits; // @[RgmiiTransfer.scala 56:23]
  assign topHalfFifo_rst = reset; // @[RgmiiTransfer.scala 31:22]
  assign topHalfFifo_wr_clk = ~io_rgmii_rxClock; // @[RgmiiTransfer.scala 34:44]
  assign topHalfFifo_rd_clk = clock; // @[RgmiiTransfer.scala 39:25]
  assign topHalfFifo_din = io_rgmii_rxData; // @[RgmiiTransfer.scala 38:22]
  assign topHalfFifo_wr_en = topHalfFifo_io_wr_en_REG; // @[RgmiiTransfer.scala 36:26]
  assign topHalfFifo_rd_en = io_rx_valid; // @[RgmiiTransfer.scala 40:24]
  assign bottomHalfFifo_rst = reset; // @[RgmiiTransfer.scala 32:25]
  assign bottomHalfFifo_wr_clk = io_rgmii_rxClock; // @[RgmiiTransfer.scala 42:55]
  assign bottomHalfFifo_rd_clk = clock; // @[RgmiiTransfer.scala 45:28]
  assign bottomHalfFifo_din = io_rgmii_rxData; // @[RgmiiTransfer.scala 44:25]
  assign bottomHalfFifo_wr_en = io_rgmii_rxCtrl; // @[RgmiiTransfer.scala 43:27]
  assign bottomHalfFifo_rd_en = io_rx_valid; // @[RgmiiTransfer.scala 46:27]
  always @(posedge io_rgmii_rxClock) begin
    topHalfFifo_io_wr_en_REG <= io_rgmii_rxCtrl; // @[RgmiiTransfer.scala 36:36]
  end
  always @(posedge clock) begin
    io_rx_valid_REG <= ~topHalfFifo_empty & ~bottomHalfFifo_empty; // @[RgmiiTransfer.scala 48:40]
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
module MacReceive(
  input         clock,
  input         reset,
  input         io_rx_valid,
  input  [7:0]  io_rx_bits,

  (* mark_debug = "true" *)
  output        io_debugPort_rxValid,

  (* mark_debug = "true" *)
  output [7:0]  io_debugPort_rxData,

  (* mark_debug = "true" *)
  output [7:0]  io_debugPort_state,

  (* mark_debug = "true" *)
  output [7:0]  io_debugPort_cnt,

  (* mark_debug = "true" *)
  output [15:0] io_debugPort_macType,

  (* mark_debug = "true" *)
  output        io_debugPort_macWriteEnable,

  (* mark_debug = "true" *)
  output [11:0] io_debugPort_macWriteAddress,

  (* mark_debug = "true" *)
  output [7:0]  io_debugPort_macWriteData,

  (* mark_debug = "true" *)
  output        io_debugPort_fifoValid,

  (* mark_debug = "true" *)
  output [11:0] io_debugPort_fifoStart,

  (* mark_debug = "true" *)
  output [11:0] io_debugPort_fifoEnd
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] macType_0; // @[MacReceive.scala 37:20]
  reg [7:0] macType_1; // @[MacReceive.scala 37:20]
  reg [10:0] cnt_value; // @[Counter.scala 60:40]
  reg [3:0] stateReg; // @[MacReceive.scala 42:25]
  reg [11:0] macDataWriteAddress; // @[MacReceive.scala 47:32]
  wire  macDataWriteEnable = stateReg == 4'h5; // @[MacReceive.scala 161:18]
  reg [11:0] inStartAddress; // @[MacReceive.scala 67:31]
  reg [11:0] inEndAddress; // @[MacReceive.scala 68:29]
  wire  _T = 4'h0 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_2 = io_rx_valid & io_rx_bits == 8'h55; // @[MacReceive.scala 131:21]
  wire  wrap = cnt_value == 11'h5db; // @[Counter.scala 72:24]
  wire [10:0] _value_T_1 = cnt_value + 11'h1; // @[Counter.scala 76:24]
  wire [10:0] _GEN_9 = wrap ? 11'h0 : _value_T_1; // @[Counter.scala 86:20 Counter.scala 86:28 Counter.scala 76:15]
  wire  _T_3 = 4'h1 == stateReg; // @[Conditional.scala 37:30]
  wire [7:0] _GEN_20 = 3'h7 == cnt_value[2:0] ? 8'hd5 : 8'h55; // @[MacReceive.scala 76:46 MacReceive.scala 76:46]
  wire [10:0] _GEN_22 = io_rx_valid & io_rx_bits == _GEN_20 ? _GEN_9 : 11'h0; // @[MacReceive.scala 76:80 Counter.scala 97:11]
  wire [3:0] _GEN_23 = io_rx_valid & io_rx_bits == _GEN_20 ? stateReg : 4'h0; // @[MacReceive.scala 76:80 MacReceive.scala 42:25 MacReceive.scala 80:16]
  wire  _T_7 = cnt_value == 11'h7; // @[MacReceive.scala 82:21]
  wire  _T_8 = 4'h2 == stateReg; // @[Conditional.scala 37:30]
  wire [7:0] _GEN_28 = 3'h1 == cnt_value[2:0] ? 8'h34 : 8'h12; // @[MacReceive.scala 76:46 MacReceive.scala 76:46]
  wire [7:0] _GEN_29 = 3'h2 == cnt_value[2:0] ? 8'h55 : _GEN_28; // @[MacReceive.scala 76:46 MacReceive.scala 76:46]
  wire [7:0] _GEN_30 = 3'h3 == cnt_value[2:0] ? 8'haa : _GEN_29; // @[MacReceive.scala 76:46 MacReceive.scala 76:46]
  wire [7:0] _GEN_31 = 3'h4 == cnt_value[2:0] ? 8'hff : _GEN_30; // @[MacReceive.scala 76:46 MacReceive.scala 76:46]
  wire [7:0] _GEN_32 = 3'h5 == cnt_value[2:0] ? 8'h0 : _GEN_31; // @[MacReceive.scala 76:46 MacReceive.scala 76:46]
  wire [10:0] _GEN_40 = io_rx_valid & (io_rx_bits == _GEN_32 | io_rx_bits == 8'hff) ? _GEN_9 : 11'h0; // @[MacReceive.scala 76:80 Counter.scala 97:11]
  wire [3:0] _GEN_41 = io_rx_valid & (io_rx_bits == _GEN_32 | io_rx_bits == 8'hff) ? stateReg : 4'h0; // @[MacReceive.scala 76:80 MacReceive.scala 42:25 MacReceive.scala 80:16]
  wire  _T_15 = cnt_value == 11'h5; // @[MacReceive.scala 82:21]
  wire [10:0] _GEN_42 = cnt_value == 11'h5 ? 11'h0 : _GEN_40; // @[MacReceive.scala 82:38 Counter.scala 97:11]
  wire [3:0] _GEN_44 = cnt_value == 11'h5 ? 4'h3 : _GEN_41; // @[MacReceive.scala 82:38 MacReceive.scala 85:16]
  wire  _T_16 = 4'h3 == stateReg; // @[Conditional.scala 37:30]
  wire [10:0] _GEN_46 = _T_15 ? 11'h0 : _GEN_9; // @[MacReceive.scala 112:39 Counter.scala 97:11]
  wire [3:0] _GEN_48 = _T_15 ? 4'h4 : stateReg; // @[MacReceive.scala 112:39 MacReceive.scala 115:20 MacReceive.scala 42:25]
  wire [10:0] _GEN_49 = io_rx_valid ? _GEN_46 : 11'h0; // @[MacReceive.scala 110:21 Counter.scala 97:11]
  wire  _GEN_50 = io_rx_valid & _T_15; // @[MacReceive.scala 110:21 MacReceive.scala 44:14]
  wire [3:0] _GEN_51 = io_rx_valid ? _GEN_48 : 4'h0; // @[MacReceive.scala 110:21 MacReceive.scala 119:18]
  wire  _T_18 = 4'h4 == stateReg; // @[Conditional.scala 37:30]
  wire [7:0] _GEN_52 = io_rx_valid & 11'h0 == cnt_value ? io_rx_bits : macType_1; // @[MacReceive.scala 91:42 MacReceive.scala 92:33 MacReceive.scala 37:20]
  wire [7:0] _GEN_53 = io_rx_valid & 11'h1 == cnt_value ? io_rx_bits : macType_0; // @[MacReceive.scala 91:42 MacReceive.scala 92:33 MacReceive.scala 37:20]
  wire  _T_23 = cnt_value == 11'h1; // @[MacReceive.scala 97:22]
  wire [10:0] _GEN_55 = cnt_value == 11'h1 ? 11'h0 : _GEN_9; // @[MacReceive.scala 97:44 Counter.scala 97:11]
  wire [3:0] _GEN_57 = cnt_value == 11'h1 ? 4'h5 : stateReg; // @[MacReceive.scala 97:44 MacReceive.scala 100:18 MacReceive.scala 42:25]
  wire [10:0] _GEN_58 = io_rx_valid ? _GEN_55 : 11'h0; // @[MacReceive.scala 95:20 Counter.scala 97:11]
  wire  _GEN_59 = io_rx_valid & _T_23; // @[MacReceive.scala 95:20 MacReceive.scala 44:14]
  wire [3:0] _GEN_60 = io_rx_valid ? _GEN_57 : 4'h0; // @[MacReceive.scala 95:20 MacReceive.scala 104:16]
  wire  _T_24 = 4'h5 == stateReg; // @[Conditional.scala 37:30]
  wire  _T_25 = ~io_rx_valid; // @[MacReceive.scala 122:13]
  wire [3:0] _GEN_62 = ~io_rx_valid ? 4'h6 : stateReg; // @[MacReceive.scala 122:23 MacReceive.scala 124:18 MacReceive.scala 42:25]
  wire  _T_26 = 4'h6 == stateReg; // @[Conditional.scala 37:30]
  wire [3:0] _GEN_63 = _T_26 ? 4'h0 : stateReg; // @[Conditional.scala 39:67 MacReceive.scala 153:16 MacReceive.scala 42:25]
  wire  _GEN_64 = _T_24 & _T_25; // @[Conditional.scala 39:67 MacReceive.scala 44:14]
  wire [3:0] _GEN_65 = _T_24 ? _GEN_62 : _GEN_63; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_66 = _T_18 ? _GEN_52 : macType_1; // @[Conditional.scala 39:67 MacReceive.scala 37:20]
  wire [7:0] _GEN_67 = _T_18 ? _GEN_53 : macType_0; // @[Conditional.scala 39:67 MacReceive.scala 37:20]
  wire [10:0] _GEN_68 = _T_18 ? _GEN_58 : cnt_value; // @[Conditional.scala 39:67 Counter.scala 60:40]
  wire  _GEN_69 = _T_18 ? _GEN_59 : _GEN_64; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_70 = _T_18 ? _GEN_60 : _GEN_65; // @[Conditional.scala 39:67]
  wire [10:0] _GEN_71 = _T_16 ? _GEN_49 : _GEN_68; // @[Conditional.scala 39:67]
  wire  _GEN_72 = _T_16 ? _GEN_50 : _GEN_69; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_73 = _T_16 ? _GEN_51 : _GEN_70; // @[Conditional.scala 39:67]
  wire  _GEN_78 = _T_8 ? _T_15 : _GEN_72; // @[Conditional.scala 39:67]
  wire  _GEN_83 = _T_3 ? _T_7 : _GEN_78; // @[Conditional.scala 39:67]
  wire  stateShift = _T ? _T_2 : _GEN_83; // @[Conditional.scala 40:58]
  wire [11:0] _macDataWriteAddress_T_1 = macDataWriteAddress + 12'h1; // @[MacReceive.scala 163:48]
  assign io_debugPort_rxValid = io_rx_valid; // @[MacReceive.scala 172:24]
  assign io_debugPort_rxData = io_rx_bits; // @[MacReceive.scala 173:23]
  assign io_debugPort_state = {{4'd0}, stateReg}; // @[MacReceive.scala 170:22]
  assign io_debugPort_cnt = cnt_value[7:0]; // @[MacReceive.scala 171:20]
  assign io_debugPort_macType = {macType_1,macType_0}; // @[MacReceive.scala 174:43]
  assign io_debugPort_macWriteEnable = stateReg == 4'h5; // @[MacReceive.scala 161:18]
  assign io_debugPort_macWriteAddress = macDataWriteAddress; // @[MacReceive.scala 176:32]
  assign io_debugPort_macWriteData = io_rx_bits; // @[MacReceive.scala 49:30 MacReceive.scala 57:20]
  assign io_debugPort_fifoValid = stateReg == 4'h6; // @[MacReceive.scala 166:18]
  assign io_debugPort_fifoStart = inStartAddress; // @[MacReceive.scala 179:26]
  assign io_debugPort_fifoEnd = inEndAddress; // @[MacReceive.scala 180:24]
  always @(posedge clock) begin
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_3)) begin // @[Conditional.scala 39:67]
        if (!(_T_8)) begin // @[Conditional.scala 39:67]
          if (!(_T_16)) begin // @[Conditional.scala 39:67]
            macType_0 <= _GEN_67;
          end
        end
      end
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_3)) begin // @[Conditional.scala 39:67]
        if (!(_T_8)) begin // @[Conditional.scala 39:67]
          if (!(_T_16)) begin // @[Conditional.scala 39:67]
            macType_1 <= _GEN_66;
          end
        end
      end
    end
    if (reset) begin // @[Counter.scala 60:40]
      cnt_value <= 11'h0; // @[Counter.scala 60:40]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_rx_valid & io_rx_bits == 8'h55) begin // @[MacReceive.scala 131:48]
        if (wrap) begin // @[Counter.scala 86:20]
          cnt_value <= 11'h0; // @[Counter.scala 86:28]
        end else begin
          cnt_value <= _value_T_1; // @[Counter.scala 76:15]
        end
      end
    end else if (_T_3) begin // @[Conditional.scala 39:67]
      if (cnt_value == 11'h7) begin // @[MacReceive.scala 82:38]
        cnt_value <= 11'h0; // @[Counter.scala 97:11]
      end else begin
        cnt_value <= _GEN_22;
      end
    end else if (_T_8) begin // @[Conditional.scala 39:67]
      cnt_value <= _GEN_42;
    end else begin
      cnt_value <= _GEN_71;
    end
    if (reset) begin // @[MacReceive.scala 42:25]
      stateReg <= 4'h0; // @[MacReceive.scala 42:25]
    end else if (_T) begin // @[Conditional.scala 40:58]
      if (io_rx_valid & io_rx_bits == 8'h55) begin // @[MacReceive.scala 131:48]
        stateReg <= 4'h1; // @[MacReceive.scala 134:18]
      end
    end else if (_T_3) begin // @[Conditional.scala 39:67]
      if (cnt_value == 11'h7) begin // @[MacReceive.scala 82:38]
        stateReg <= 4'h2; // @[MacReceive.scala 85:16]
      end else begin
        stateReg <= _GEN_23;
      end
    end else if (_T_8) begin // @[Conditional.scala 39:67]
      stateReg <= _GEN_44;
    end else begin
      stateReg <= _GEN_73;
    end
    if (macDataWriteEnable) begin // @[MacReceive.scala 161:29]
      macDataWriteAddress <= _macDataWriteAddress_T_1; // @[MacReceive.scala 163:25]
    end else if (stateReg == 4'h4 & stateShift) begin // @[MacReceive.scala 157:43]
      macDataWriteAddress <= inEndAddress; // @[MacReceive.scala 158:25]
    end
    if (reset) begin // @[MacReceive.scala 67:31]
      inStartAddress <= 12'h0; // @[MacReceive.scala 67:31]
    end else if (stateReg == 4'h4 & stateShift) begin // @[MacReceive.scala 157:43]
      inStartAddress <= inEndAddress; // @[MacReceive.scala 159:20]
    end
    if (reset) begin // @[MacReceive.scala 68:29]
      inEndAddress <= 12'h0; // @[MacReceive.scala 68:29]
    end else if (macDataWriteEnable) begin // @[MacReceive.scala 161:29]
      if (stateShift) begin // @[MacReceive.scala 164:23]
        inEndAddress <= macDataWriteAddress; // @[MacReceive.scala 164:38]
      end
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
  macType_0 = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  macType_1 = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  cnt_value = _RAND_2[10:0];
  _RAND_3 = {1{`RANDOM}};
  stateReg = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  macDataWriteAddress = _RAND_4[11:0];
  _RAND_5 = {1{`RANDOM}};
  inStartAddress = _RAND_5[11:0];
  _RAND_6 = {1{`RANDOM}};
  inEndAddress = _RAND_6[11:0];
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
  wire  macReceive_clock; // @[NetStack.scala 20:28]
  wire  macReceive_reset; // @[NetStack.scala 20:28]
  wire  macReceive_io_rx_valid; // @[NetStack.scala 20:28]
  wire [7:0] macReceive_io_rx_bits; // @[NetStack.scala 20:28]
  wire  macReceive_io_debugPort_rxValid; // @[NetStack.scala 20:28]
  wire [7:0] macReceive_io_debugPort_rxData; // @[NetStack.scala 20:28]
  wire [7:0] macReceive_io_debugPort_state; // @[NetStack.scala 20:28]
  wire [7:0] macReceive_io_debugPort_cnt; // @[NetStack.scala 20:28]
  wire [15:0] macReceive_io_debugPort_macType; // @[NetStack.scala 20:28]
  wire  macReceive_io_debugPort_macWriteEnable; // @[NetStack.scala 20:28]
  wire [11:0] macReceive_io_debugPort_macWriteAddress; // @[NetStack.scala 20:28]
  wire [7:0] macReceive_io_debugPort_macWriteData; // @[NetStack.scala 20:28]
  wire  macReceive_io_debugPort_fifoValid; // @[NetStack.scala 20:28]
  wire [11:0] macReceive_io_debugPort_fifoStart; // @[NetStack.scala 20:28]
  wire [11:0] macReceive_io_debugPort_fifoEnd; // @[NetStack.scala 20:28]
  wire  reset = ~reset_n; // @[package.scala 12:17]
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
    .io_debugPort_rxData(rgmiiTransfer_io_debugPort_rxData)
  );
  MacReceive macReceive ( // @[NetStack.scala 20:28]
    .clock(macReceive_clock),
    .reset(macReceive_reset),
    .io_rx_valid(macReceive_io_rx_valid),
    .io_rx_bits(macReceive_io_rx_bits),
    .io_debugPort_rxValid(macReceive_io_debugPort_rxValid),
    .io_debugPort_rxData(macReceive_io_debugPort_rxData),
    .io_debugPort_state(macReceive_io_debugPort_state),
    .io_debugPort_cnt(macReceive_io_debugPort_cnt),
    .io_debugPort_macType(macReceive_io_debugPort_macType),
    .io_debugPort_macWriteEnable(macReceive_io_debugPort_macWriteEnable),
    .io_debugPort_macWriteAddress(macReceive_io_debugPort_macWriteAddress),
    .io_debugPort_macWriteData(macReceive_io_debugPort_macWriteData),
    .io_debugPort_fifoValid(macReceive_io_debugPort_fifoValid),
    .io_debugPort_fifoStart(macReceive_io_debugPort_fifoStart),
    .io_debugPort_fifoEnd(macReceive_io_debugPort_fifoEnd)
  );
  assign rgmii_txClock = 1'h0; // @[NetStack.scala 25:28]
  assign rgmii_txData = 4'h0; // @[NetStack.scala 25:28]
  assign rgmii_txCtrl = 1'h0; // @[NetStack.scala 25:28]
  assign rgmii_ereset = reset_n; // @[NetStack.scala 33:16]
  assign led = {{2'd0}, _led_T}; // @[Cat.scala 30:58]
  assign pll_clk_in = clock; // @[NetStack.scala 13:17]
  assign pll_reset = ~reset_n; // @[package.scala 12:17]
  assign rgmiiTransfer_clock = pll_clk_125;
  assign rgmiiTransfer_reset = ~reset_n; // @[package.scala 12:17]
  assign rgmiiTransfer_io_rgmii_rxClock = rgmii_rxClock; // @[NetStack.scala 25:28]
  assign rgmiiTransfer_io_rgmii_rxData = rgmii_rxData; // @[NetStack.scala 25:28]
  assign rgmiiTransfer_io_rgmii_rxCtrl = rgmii_rxCtrl; // @[NetStack.scala 25:28]
  assign macReceive_clock = pll_clk_125;
  assign macReceive_reset = ~reset_n; // @[package.scala 12:17]
  assign macReceive_io_rx_valid = rgmiiTransfer_io_rx_valid; // @[NetStack.scala 26:25]
  assign macReceive_io_rx_bits = rgmiiTransfer_io_rx_bits; // @[NetStack.scala 26:25]
  always @(posedge pll_clk_100) begin
    if (reset) begin // @[NetStack.scala 35:25]
      led_lo <= 1'h0; // @[NetStack.scala 35:25]
    end else if (done_wrap_wrap) begin // @[NetStack.scala 37:17]
      led_lo <= ~led_lo; // @[NetStack.scala 37:26]
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
