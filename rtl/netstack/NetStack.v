module RgmiiTransfer(
  input        clock,
  input        reset,
  input        io_rgmii_rxClock,
  input  [3:0] io_rgmii_rxData,
  input        io_rgmii_rxCtrl,
  output       io_rx_valid,
  output [7:0] io_rx_bits
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
module Queue(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [7:0]  io_enq_bits_info,
  input  [11:0] io_enq_bits_startAddress,
  input  [11:0] io_enq_bits_endAddress,
  input         io_deq_ready,
  output        io_deq_valid,
  output [7:0]  io_deq_bits_info,
  output [11:0] io_deq_bits_startAddress,
  output [11:0] io_deq_bits_endAddress
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] ram_info [0:31]; // @[Decoupled.scala 218:16]
  wire [7:0] ram_info_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [4:0] ram_info_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [7:0] ram_info_MPORT_data; // @[Decoupled.scala 218:16]
  wire [4:0] ram_info_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_info_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_info_MPORT_en; // @[Decoupled.scala 218:16]
  reg [11:0] ram_startAddress [0:31]; // @[Decoupled.scala 218:16]
  wire [11:0] ram_startAddress_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [4:0] ram_startAddress_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [11:0] ram_startAddress_MPORT_data; // @[Decoupled.scala 218:16]
  wire [4:0] ram_startAddress_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_startAddress_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_startAddress_MPORT_en; // @[Decoupled.scala 218:16]
  reg [11:0] ram_endAddress [0:31]; // @[Decoupled.scala 218:16]
  wire [11:0] ram_endAddress_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [4:0] ram_endAddress_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [11:0] ram_endAddress_MPORT_data; // @[Decoupled.scala 218:16]
  wire [4:0] ram_endAddress_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_endAddress_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_endAddress_MPORT_en; // @[Decoupled.scala 218:16]
  reg [4:0] value; // @[Counter.scala 60:40]
  reg [4:0] value_1; // @[Counter.scala 60:40]
  reg  maybe_full; // @[Decoupled.scala 221:27]
  wire  ptr_match = value == value_1; // @[Decoupled.scala 223:33]
  wire  empty = ptr_match & ~maybe_full; // @[Decoupled.scala 224:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 225:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 40:37]
  wire [4:0] _value_T_1 = value + 5'h1; // @[Counter.scala 76:24]
  wire [4:0] _value_T_3 = value_1 + 5'h1; // @[Counter.scala 76:24]
  assign ram_info_io_deq_bits_MPORT_addr = value_1;
  assign ram_info_io_deq_bits_MPORT_data = ram_info[ram_info_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_info_MPORT_data = io_enq_bits_info;
  assign ram_info_MPORT_addr = value;
  assign ram_info_MPORT_mask = 1'h1;
  assign ram_info_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_startAddress_io_deq_bits_MPORT_addr = value_1;
  assign ram_startAddress_io_deq_bits_MPORT_data = ram_startAddress[ram_startAddress_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_startAddress_MPORT_data = io_enq_bits_startAddress;
  assign ram_startAddress_MPORT_addr = value;
  assign ram_startAddress_MPORT_mask = 1'h1;
  assign ram_startAddress_MPORT_en = io_enq_ready & io_enq_valid;
  assign ram_endAddress_io_deq_bits_MPORT_addr = value_1;
  assign ram_endAddress_io_deq_bits_MPORT_data = ram_endAddress[ram_endAddress_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_endAddress_MPORT_data = io_enq_bits_endAddress;
  assign ram_endAddress_MPORT_addr = value;
  assign ram_endAddress_MPORT_mask = 1'h1;
  assign ram_endAddress_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[Decoupled.scala 241:19]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 240:19]
  assign io_deq_bits_info = ram_info_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_startAddress = ram_startAddress_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  assign io_deq_bits_endAddress = ram_endAddress_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  always @(posedge clock) begin
    if(ram_info_MPORT_en & ram_info_MPORT_mask) begin
      ram_info[ram_info_MPORT_addr] <= ram_info_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_startAddress_MPORT_en & ram_startAddress_MPORT_mask) begin
      ram_startAddress[ram_startAddress_MPORT_addr] <= ram_startAddress_MPORT_data; // @[Decoupled.scala 218:16]
    end
    if(ram_endAddress_MPORT_en & ram_endAddress_MPORT_mask) begin
      ram_endAddress[ram_endAddress_MPORT_addr] <= ram_endAddress_MPORT_data; // @[Decoupled.scala 218:16]
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      value <= 5'h0;
    end else if (do_enq) begin
      value <= _value_T_1;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      value_1 <= 5'h0;
    end else if (do_deq) begin
      value_1 <= _value_T_3;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      maybe_full <= 1'h0;
    end else if (do_enq != do_deq) begin
      maybe_full <= do_enq;
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    ram_info[initvar] = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    ram_startAddress[initvar] = _RAND_1[11:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    ram_endAddress[initvar] = _RAND_2[11:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  value = _RAND_3[4:0];
  _RAND_4 = {1{`RANDOM}};
  value_1 = _RAND_4[4:0];
  _RAND_5 = {1{`RANDOM}};
  maybe_full = _RAND_5[0:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    value = 5'h0;
  end
  if (reset) begin
    value_1 = 5'h0;
  end
  if (reset) begin
    maybe_full = 1'h0;
  end
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
  output        io_mac2IpIf_arpData_valid,
  output [7:0]  io_mac2IpIf_arpData_bits,
  output        io_mac2IpIf_ipData_valid,
  output [7:0]  io_mac2IpIf_ipData_bits,

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
  output        io_debugPort_macReadEnable,

  (* mark_debug = "true" *)
  output [11:0] io_debugPort_macReadAddress,

  (* mark_debug = "true" *)
  output [7:0]  io_debugPort_macReadData,

  (* mark_debug = "true" *)
  output        io_debugPort_arpTxValid,

  (* mark_debug = "true" *)
  output [7:0]  io_debugPort_arpTxData,

  (* mark_debug = "true" *)
  output        io_debugPort_ipTxValid,

  (* mark_debug = "true" *)
  output [7:0]  io_debugPort_ipTxData,

  (* mark_debug = "true" *)
  output        io_debugPort_fifoInValid,

  (* mark_debug = "true" *)
  output [11:0] io_debugPort_fifoInStart,

  (* mark_debug = "true" *)
  output [11:0] io_debugPort_fifoInEnd,

  (* mark_debug = "true" *)
  output        io_debugPort_fifoOutFire,

  (* mark_debug = "true" *)
  output [11:0] io_debugPort_fifoOutStart,

  (* mark_debug = "true" *)
  output [11:0] io_debugPort_fifoOutEnd
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] macData [0:4095]; // @[MacReceive.scala 52:28]
  wire [7:0] macData_macDataReadData_MPORT_data; // @[MacReceive.scala 52:28]
  wire [11:0] macData_macDataReadData_MPORT_addr; // @[MacReceive.scala 52:28]
  wire [7:0] macData_MPORT_data; // @[MacReceive.scala 52:28]
  wire [11:0] macData_MPORT_addr; // @[MacReceive.scala 52:28]
  wire  macData_MPORT_mask; // @[MacReceive.scala 52:28]
  wire  macData_MPORT_en; // @[MacReceive.scala 52:28]
  reg  macData_macDataReadData_MPORT_en_pipe_0;
  reg [11:0] macData_macDataReadData_MPORT_addr_pipe_0;
  wire  metaFifo_clock; // @[Decoupled.scala 296:21]
  wire  metaFifo_reset; // @[Decoupled.scala 296:21]
  wire  metaFifo_io_enq_ready; // @[Decoupled.scala 296:21]
  wire  metaFifo_io_enq_valid; // @[Decoupled.scala 296:21]
  wire [7:0] metaFifo_io_enq_bits_info; // @[Decoupled.scala 296:21]
  wire [11:0] metaFifo_io_enq_bits_startAddress; // @[Decoupled.scala 296:21]
  wire [11:0] metaFifo_io_enq_bits_endAddress; // @[Decoupled.scala 296:21]
  wire  metaFifo_io_deq_ready; // @[Decoupled.scala 296:21]
  wire  metaFifo_io_deq_valid; // @[Decoupled.scala 296:21]
  wire [7:0] metaFifo_io_deq_bits_info; // @[Decoupled.scala 296:21]
  wire [11:0] metaFifo_io_deq_bits_startAddress; // @[Decoupled.scala 296:21]
  wire [11:0] metaFifo_io_deq_bits_endAddress; // @[Decoupled.scala 296:21]
  reg [7:0] macType_0; // @[MacReceive.scala 43:20]
  reg [7:0] macType_1; // @[MacReceive.scala 43:20]
  reg [10:0] cnt_value; // @[Counter.scala 60:40]
  reg [3:0] inStateReg; // @[MacReceive.scala 48:27]
  reg [11:0] macDataWriteAddress; // @[MacReceive.scala 53:32]
  reg [11:0] macDataReadAddress; // @[MacReceive.scala 57:31]
  wire  _macDataWriteEnable_T = inStateReg == 4'h5; // @[MacReceive.scala 130:36]
  reg [2:0] outStateReg; // @[MacReceive.scala 133:28]
  wire  macDataReadEnable = outStateReg == 3'h1; // @[MacReceive.scala 153:36]
  reg [11:0] inStartAddress; // @[MacReceive.scala 73:31]
  reg [11:0] inEndAddress; // @[MacReceive.scala 74:29]
  wire [24:0] _inMetaFifoIf_bits_T = {1'h0,inStartAddress,inEndAddress}; // @[Cat.scala 30:58]
  wire [31:0] _inMetaFifoIf_bits_WIRE_1 = {{7'd0}, _inMetaFifoIf_bits_T};
  wire [31:0] _metaInfo_T = {metaFifo_io_deq_bits_info,metaFifo_io_deq_bits_startAddress,metaFifo_io_deq_bits_endAddress
    }; // @[MacReceive.scala 77:40]
  wire [11:0] metaInfo_endAddress = _metaInfo_T[11:0]; // @[MacReceive.scala 77:40]
  wire [11:0] metaInfo_startAddress = _metaInfo_T[23:12]; // @[MacReceive.scala 77:40]
  wire  _outStartAddress_T = metaFifo_io_deq_ready & metaFifo_io_deq_valid; // @[Decoupled.scala 40:37]
  reg [11:0] outEndAddress; // @[Reg.scala 15:16]
  wire  _T = 4'h0 == inStateReg; // @[Conditional.scala 37:30]
  wire  _T_2 = io_rx_valid & io_rx_bits == 8'h55; // @[MacReceive.scala 89:21]
  wire  wrap = cnt_value == 11'h5db; // @[Counter.scala 72:24]
  wire [10:0] _value_T_1 = cnt_value + 11'h1; // @[Counter.scala 76:24]
  wire [10:0] _GEN_11 = wrap ? 11'h0 : _value_T_1; // @[Counter.scala 86:20 Counter.scala 86:28 Counter.scala 76:15]
  wire  _T_3 = 4'h1 == inStateReg; // @[Conditional.scala 37:30]
  wire [7:0] _GEN_22 = 3'h7 == cnt_value[2:0] ? 8'hd5 : 8'h55; // @[package.scala 93:50 package.scala 93:50]
  wire  _T_7 = cnt_value == 11'h7; // @[package.scala 99:23]
  wire  _T_8 = 4'h2 == inStateReg; // @[Conditional.scala 37:30]
  wire [7:0] _GEN_30 = 3'h1 == cnt_value[2:0] ? 8'h34 : 8'h12; // @[package.scala 93:50 package.scala 93:50]
  wire [7:0] _GEN_31 = 3'h2 == cnt_value[2:0] ? 8'h55 : _GEN_30; // @[package.scala 93:50 package.scala 93:50]
  wire [7:0] _GEN_32 = 3'h3 == cnt_value[2:0] ? 8'haa : _GEN_31; // @[package.scala 93:50 package.scala 93:50]
  wire [7:0] _GEN_33 = 3'h4 == cnt_value[2:0] ? 8'hff : _GEN_32; // @[package.scala 93:50 package.scala 93:50]
  wire [7:0] _GEN_34 = 3'h5 == cnt_value[2:0] ? 8'h0 : _GEN_33; // @[package.scala 93:50 package.scala 93:50]
  wire [10:0] _GEN_42 = io_rx_valid & (io_rx_bits == _GEN_34 | io_rx_bits == 8'hff) ? _GEN_11 : 11'h0; // @[package.scala 93:84 Counter.scala 97:11]
  wire [3:0] _GEN_43 = io_rx_valid & (io_rx_bits == _GEN_34 | io_rx_bits == 8'hff) ? inStateReg : 4'h0; // @[package.scala 93:84 MacReceive.scala 48:27 package.scala 97:12]
  wire  _T_15 = cnt_value == 11'h5; // @[package.scala 99:23]
  wire  _T_16 = 4'h3 == inStateReg; // @[Conditional.scala 37:30]
  wire [10:0] _GEN_48 = _T_15 ? 11'h0 : _GEN_11; // @[package.scala 129:41 Counter.scala 97:11]
  wire [3:0] _GEN_50 = _T_15 ? 4'h4 : inStateReg; // @[package.scala 129:41 package.scala 132:16 MacReceive.scala 48:27]
  wire [10:0] _GEN_51 = io_rx_valid ? _GEN_48 : 11'h0; // @[package.scala 127:24 Counter.scala 97:11]
  wire  _GEN_52 = io_rx_valid & _T_15; // @[package.scala 127:24 MacReceive.scala 86:14]
  wire [3:0] _GEN_53 = io_rx_valid ? _GEN_50 : 4'h0; // @[package.scala 127:24 package.scala 136:14]
  wire  _T_18 = 4'h4 == inStateReg; // @[Conditional.scala 37:30]
  wire [7:0] _GEN_54 = io_rx_valid & 11'h0 == cnt_value ? io_rx_bits : macType_1; // @[package.scala 108:45 package.scala 109:35 MacReceive.scala 43:20]
  wire [7:0] _GEN_55 = io_rx_valid & 11'h1 == cnt_value ? io_rx_bits : macType_0; // @[package.scala 108:45 package.scala 109:35 MacReceive.scala 43:20]
  wire  _T_23 = cnt_value == 11'h1; // @[package.scala 114:24]
  wire [10:0] _GEN_57 = cnt_value == 11'h1 ? 11'h0 : _GEN_11; // @[package.scala 114:46 Counter.scala 97:11]
  wire [3:0] _GEN_59 = cnt_value == 11'h1 ? 4'h5 : inStateReg; // @[package.scala 114:46 package.scala 117:14 MacReceive.scala 48:27]
  wire [10:0] _GEN_60 = io_rx_valid ? _GEN_57 : 11'h0; // @[package.scala 112:23 Counter.scala 97:11]
  wire  _GEN_61 = io_rx_valid & _T_23; // @[package.scala 112:23 MacReceive.scala 86:14]
  wire [3:0] _GEN_62 = io_rx_valid ? _GEN_59 : 4'h0; // @[package.scala 112:23 package.scala 121:12]
  wire  _T_24 = 4'h5 == inStateReg; // @[Conditional.scala 37:30]
  wire  _T_25 = ~io_rx_valid; // @[package.scala 139:15]
  wire [3:0] _GEN_64 = ~io_rx_valid ? 4'h6 : inStateReg; // @[package.scala 139:26 package.scala 141:14 MacReceive.scala 48:27]
  wire  _T_26 = 4'h6 == inStateReg; // @[Conditional.scala 37:30]
  wire [3:0] _GEN_65 = _T_26 ? 4'h0 : inStateReg; // @[Conditional.scala 39:67 MacReceive.scala 111:18 MacReceive.scala 48:27]
  wire  _GEN_66 = _T_24 & _T_25; // @[Conditional.scala 39:67 MacReceive.scala 86:14]
  wire [3:0] _GEN_67 = _T_24 ? _GEN_64 : _GEN_65; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_68 = _T_18 ? _GEN_54 : macType_1; // @[Conditional.scala 39:67 MacReceive.scala 43:20]
  wire [7:0] _GEN_69 = _T_18 ? _GEN_55 : macType_0; // @[Conditional.scala 39:67 MacReceive.scala 43:20]
  wire [10:0] _GEN_70 = _T_18 ? _GEN_60 : cnt_value; // @[Conditional.scala 39:67 Counter.scala 60:40]
  wire  _GEN_71 = _T_18 ? _GEN_61 : _GEN_66; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_72 = _T_18 ? _GEN_62 : _GEN_67; // @[Conditional.scala 39:67]
  wire  _GEN_74 = _T_16 ? _GEN_52 : _GEN_71; // @[Conditional.scala 39:67]
  wire  _GEN_80 = _T_8 ? _T_15 : _GEN_74; // @[Conditional.scala 39:67]
  wire  _GEN_85 = _T_3 ? _T_7 : _GEN_80; // @[Conditional.scala 39:67]
  wire  stateShift = _T ? _T_2 : _GEN_85; // @[Conditional.scala 40:58]
  wire [11:0] _macDataWriteAddress_T_1 = inEndAddress + 12'h1; // @[MacReceive.scala 116:41]
  wire [11:0] _macDataWriteAddress_T_3 = macDataWriteAddress + 12'h1; // @[MacReceive.scala 120:48]
  wire [11:0] _lo_T_3 = macDataWriteAddress - 12'h1; // @[MacReceive.scala 121:61]
  wire  _T_30 = inStateReg == 4'h6; // @[MacReceive.scala 123:20]
  wire [15:0] _T_31 = {macType_1,macType_0}; // @[MacReceive.scala 128:23]
  wire [31:0] _GEN_108 = {{16'd0}, _T_31}; // @[MacReceive.scala 128:26]
  wire  _T_32 = _GEN_108 == 32'h800; // @[MacReceive.scala 128:26]
  wire  _T_33 = 3'h0 == outStateReg; // @[Conditional.scala 37:30]
  wire  _T_35 = 3'h1 == outStateReg; // @[Conditional.scala 37:30]
  wire [11:0] _macDataReadAddress_T_1 = macDataReadAddress + 12'h1; // @[MacReceive.scala 142:48]
  wire  _T_37 = 3'h2 == outStateReg; // @[Conditional.scala 37:30]
  reg  io_mac2IpIf_arpData_valid_REG; // @[MacReceive.scala 156:39]
  reg  io_mac2IpIf_ipData_valid_REG; // @[MacReceive.scala 158:38]
  Queue metaFifo ( // @[Decoupled.scala 296:21]
    .clock(metaFifo_clock),
    .reset(metaFifo_reset),
    .io_enq_ready(metaFifo_io_enq_ready),
    .io_enq_valid(metaFifo_io_enq_valid),
    .io_enq_bits_info(metaFifo_io_enq_bits_info),
    .io_enq_bits_startAddress(metaFifo_io_enq_bits_startAddress),
    .io_enq_bits_endAddress(metaFifo_io_enq_bits_endAddress),
    .io_deq_ready(metaFifo_io_deq_ready),
    .io_deq_valid(metaFifo_io_deq_valid),
    .io_deq_bits_info(metaFifo_io_deq_bits_info),
    .io_deq_bits_startAddress(metaFifo_io_deq_bits_startAddress),
    .io_deq_bits_endAddress(metaFifo_io_deq_bits_endAddress)
  );
  assign macData_macDataReadData_MPORT_addr = macData_macDataReadData_MPORT_addr_pipe_0;
  assign macData_macDataReadData_MPORT_data = macData[macData_macDataReadData_MPORT_addr]; // @[MacReceive.scala 52:28]
  assign macData_MPORT_data = io_rx_bits;
  assign macData_MPORT_addr = macDataWriteAddress;
  assign macData_MPORT_mask = 1'h1;
  assign macData_MPORT_en = _macDataWriteEnable_T & io_rx_valid;
  assign io_mac2IpIf_arpData_valid = io_mac2IpIf_arpData_valid_REG; // @[MacReceive.scala 156:29]
  assign io_mac2IpIf_arpData_bits = macData_macDataReadData_MPORT_data; // @[MacReceive.scala 58:29 MacReceive.scala 62:19]
  assign io_mac2IpIf_ipData_valid = io_mac2IpIf_ipData_valid_REG; // @[MacReceive.scala 158:28]
  assign io_mac2IpIf_ipData_bits = macData_macDataReadData_MPORT_data; // @[MacReceive.scala 58:29 MacReceive.scala 62:19]
  assign io_debugPort_rxValid = io_rx_valid; // @[MacReceive.scala 162:24]
  assign io_debugPort_rxData = io_rx_bits; // @[MacReceive.scala 163:23]
  assign io_debugPort_state = {{4'd0}, inStateReg}; // @[MacReceive.scala 160:22]
  assign io_debugPort_cnt = cnt_value[7:0]; // @[MacReceive.scala 161:20]
  assign io_debugPort_macType = {macType_1,macType_0}; // @[MacReceive.scala 164:43]
  assign io_debugPort_macWriteEnable = inStateReg == 4'h5 & io_rx_valid; // @[MacReceive.scala 130:46]
  assign io_debugPort_macWriteAddress = macDataWriteAddress; // @[MacReceive.scala 166:32]
  assign io_debugPort_macWriteData = io_rx_bits; // @[MacReceive.scala 55:30 MacReceive.scala 63:20]
  assign io_debugPort_macReadEnable = outStateReg == 3'h1; // @[MacReceive.scala 153:36]
  assign io_debugPort_macReadAddress = macDataReadAddress; // @[MacReceive.scala 172:31]
  assign io_debugPort_macReadData = macData_macDataReadData_MPORT_data; // @[MacReceive.scala 58:29 MacReceive.scala 62:19]
  assign io_debugPort_arpTxValid = io_mac2IpIf_arpData_valid; // @[MacReceive.scala 177:27]
  assign io_debugPort_arpTxData = io_mac2IpIf_arpData_bits; // @[MacReceive.scala 178:26]
  assign io_debugPort_ipTxValid = io_mac2IpIf_ipData_valid; // @[MacReceive.scala 179:26]
  assign io_debugPort_ipTxData = io_mac2IpIf_ipData_bits; // @[MacReceive.scala 180:25]
  assign io_debugPort_fifoInValid = _GEN_108 == 32'h800 ? 1'h0 : _T_30; // @[MacReceive.scala 128:41 MacReceive.scala 128:62]
  assign io_debugPort_fifoInStart = inStartAddress; // @[MacReceive.scala 169:28]
  assign io_debugPort_fifoInEnd = inEndAddress; // @[MacReceive.scala 170:26]
  assign io_debugPort_fifoOutFire = metaFifo_io_deq_ready & metaFifo_io_deq_valid; // @[Decoupled.scala 40:37]
  assign io_debugPort_fifoOutStart = _metaInfo_T[23:12]; // @[MacReceive.scala 77:40]
  assign io_debugPort_fifoOutEnd = _metaInfo_T[11:0]; // @[MacReceive.scala 77:40]
  assign metaFifo_clock = clock;
  assign metaFifo_reset = reset;
  assign metaFifo_io_enq_valid = _GEN_108 == 32'h800 ? 1'h0 : _T_30; // @[MacReceive.scala 128:41 MacReceive.scala 128:62]
  assign metaFifo_io_enq_bits_info = _inMetaFifoIf_bits_WIRE_1[31:24]; // @[MacReceive.scala 76:71]
  assign metaFifo_io_enq_bits_startAddress = _inMetaFifoIf_bits_WIRE_1[23:12]; // @[MacReceive.scala 76:71]
  assign metaFifo_io_enq_bits_endAddress = _inMetaFifoIf_bits_WIRE_1[11:0]; // @[MacReceive.scala 76:71]
  assign metaFifo_io_deq_ready = outStateReg == 3'h0; // @[MacReceive.scala 152:33]
  always @(posedge clock) begin
    if(macData_MPORT_en & macData_MPORT_mask) begin
      macData[macData_MPORT_addr] <= macData_MPORT_data; // @[MacReceive.scala 52:28]
    end
    macData_macDataReadData_MPORT_en_pipe_0 <= outStateReg == 3'h1;
    if (outStateReg == 3'h1) begin
      macData_macDataReadData_MPORT_addr_pipe_0 <= macDataReadAddress;
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_3)) begin // @[Conditional.scala 39:67]
        if (!(_T_8)) begin // @[Conditional.scala 39:67]
          if (!(_T_16)) begin // @[Conditional.scala 39:67]
            macType_0 <= _GEN_69;
          end
        end
      end
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_3)) begin // @[Conditional.scala 39:67]
        if (!(_T_8)) begin // @[Conditional.scala 39:67]
          if (!(_T_16)) begin // @[Conditional.scala 39:67]
            macType_1 <= _GEN_68;
          end
        end
      end
    end
    if (_macDataWriteEnable_T) begin // @[MacReceive.scala 119:31]
      macDataWriteAddress <= _macDataWriteAddress_T_3; // @[MacReceive.scala 120:25]
    end else if (inStateReg == 4'h4 & stateShift) begin // @[MacReceive.scala 115:45]
      macDataWriteAddress <= _macDataWriteAddress_T_1; // @[MacReceive.scala 116:25]
    end
    if (_T_33) begin // @[Conditional.scala 40:58]
      if (_outStartAddress_T) begin // @[MacReceive.scala 136:30]
        macDataReadAddress <= metaInfo_startAddress; // @[MacReceive.scala 138:28]
      end
    end else if (_T_35) begin // @[Conditional.scala 39:67]
      macDataReadAddress <= _macDataReadAddress_T_1; // @[MacReceive.scala 142:26]
    end
    if (_outStartAddress_T) begin // @[Reg.scala 16:19]
      outEndAddress <= metaInfo_endAddress; // @[Reg.scala 16:23]
    end
    io_mac2IpIf_arpData_valid_REG <= macDataReadEnable & _GEN_108 == 32'h806; // @[MacReceive.scala 156:62]
    io_mac2IpIf_ipData_valid_REG <= macDataReadEnable & _T_32; // @[MacReceive.scala 158:61]
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      cnt_value <= 11'h0;
    end else if (_T) begin
      if (io_rx_valid & io_rx_bits == 8'h55) begin
        cnt_value <= _GEN_11;
      end
    end else if (_T_3) begin
      if (cnt_value == 11'h7) begin
        cnt_value <= 11'h0;
      end else if (io_rx_valid & io_rx_bits == _GEN_22) begin
        cnt_value <= _GEN_11;
      end else begin
        cnt_value <= 11'h0;
      end
    end else if (_T_8) begin
      if (cnt_value == 11'h5) begin
        cnt_value <= 11'h0;
      end else begin
        cnt_value <= _GEN_42;
      end
    end else if (_T_16) begin
      cnt_value <= _GEN_51;
    end else begin
      cnt_value <= _GEN_70;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      inStateReg <= 4'h0;
    end else if (_T) begin
      if (io_rx_valid & io_rx_bits == 8'h55) begin
        inStateReg <= 4'h1;
      end
    end else if (_T_3) begin
      if (cnt_value == 11'h7) begin
        inStateReg <= 4'h2;
      end else if (!(io_rx_valid & io_rx_bits == _GEN_22)) begin
        inStateReg <= 4'h0;
      end
    end else if (_T_8) begin
      if (cnt_value == 11'h5) begin
        inStateReg <= 4'h3;
      end else begin
        inStateReg <= _GEN_43;
      end
    end else if (_T_16) begin
      inStateReg <= _GEN_53;
    end else begin
      inStateReg <= _GEN_72;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      outStateReg <= 3'h0;
    end else if (_T_33) begin
      if (_outStartAddress_T) begin
        outStateReg <= 3'h1;
      end
    end else if (_T_35) begin
      if (macDataReadAddress == outEndAddress) begin
        outStateReg <= 3'h2;
      end
    end else if (_T_37) begin
      outStateReg <= 3'h0;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      inStartAddress <= 12'h0;
    end else if (inStateReg == 4'h4 & stateShift) begin
      inStartAddress <= _macDataWriteAddress_T_1;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      inEndAddress <= 12'h0;
    end else if (_macDataWriteEnable_T) begin
      if (stateShift) begin
        inEndAddress <= _lo_T_3;
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 4096; initvar = initvar+1)
    macData[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  macData_macDataReadData_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  macData_macDataReadData_MPORT_addr_pipe_0 = _RAND_2[11:0];
  _RAND_3 = {1{`RANDOM}};
  macType_0 = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  macType_1 = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  cnt_value = _RAND_5[10:0];
  _RAND_6 = {1{`RANDOM}};
  inStateReg = _RAND_6[3:0];
  _RAND_7 = {1{`RANDOM}};
  macDataWriteAddress = _RAND_7[11:0];
  _RAND_8 = {1{`RANDOM}};
  macDataReadAddress = _RAND_8[11:0];
  _RAND_9 = {1{`RANDOM}};
  outStateReg = _RAND_9[2:0];
  _RAND_10 = {1{`RANDOM}};
  inStartAddress = _RAND_10[11:0];
  _RAND_11 = {1{`RANDOM}};
  inEndAddress = _RAND_11[11:0];
  _RAND_12 = {1{`RANDOM}};
  outEndAddress = _RAND_12[11:0];
  _RAND_13 = {1{`RANDOM}};
  io_mac2IpIf_arpData_valid_REG = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  io_mac2IpIf_ipData_valid_REG = _RAND_14[0:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    cnt_value = 11'h0;
  end
  if (reset) begin
    inStateReg = 4'h0;
  end
  if (reset) begin
    outStateReg = 3'h0;
  end
  if (reset) begin
    inStartAddress = 12'h0;
  end
  if (reset) begin
    inEndAddress = 12'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Queue_1(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [80:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [80:0] io_deq_bits
);
`ifdef RANDOMIZE_MEM_INIT
  reg [95:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [80:0] ram [0:15]; // @[Decoupled.scala 218:16]
  wire [80:0] ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 218:16]
  wire [3:0] ram_io_deq_bits_MPORT_addr; // @[Decoupled.scala 218:16]
  wire [80:0] ram_MPORT_data; // @[Decoupled.scala 218:16]
  wire [3:0] ram_MPORT_addr; // @[Decoupled.scala 218:16]
  wire  ram_MPORT_mask; // @[Decoupled.scala 218:16]
  wire  ram_MPORT_en; // @[Decoupled.scala 218:16]
  reg [3:0] value; // @[Counter.scala 60:40]
  reg [3:0] value_1; // @[Counter.scala 60:40]
  reg  maybe_full; // @[Decoupled.scala 221:27]
  wire  ptr_match = value == value_1; // @[Decoupled.scala 223:33]
  wire  empty = ptr_match & ~maybe_full; // @[Decoupled.scala 224:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 225:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 40:37]
  wire [3:0] _value_T_1 = value + 4'h1; // @[Counter.scala 76:24]
  wire [3:0] _value_T_3 = value_1 + 4'h1; // @[Counter.scala 76:24]
  assign ram_io_deq_bits_MPORT_addr = value_1;
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 218:16]
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = value;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[Decoupled.scala 241:19]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 240:19]
  assign io_deq_bits = ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 242:15]
  always @(posedge clock) begin
    if(ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[Decoupled.scala 218:16]
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      value <= 4'h0;
    end else if (do_enq) begin
      value <= _value_T_1;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      value_1 <= 4'h0;
    end else if (do_deq) begin
      value_1 <= _value_T_3;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      maybe_full <= 1'h0;
    end else if (do_enq != do_deq) begin
      maybe_full <= do_enq;
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {3{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    ram[initvar] = _RAND_0[80:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  value = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  value_1 = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  maybe_full = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    value = 4'h0;
  end
  if (reset) begin
    value_1 = 4'h0;
  end
  if (reset) begin
    maybe_full = 1'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Arbiter(
  output        io_in_0_ready,
  input         io_in_0_valid,
  input  [80:0] io_in_0_bits,
  output        io_in_1_ready,
  input         io_in_1_valid,
  input  [80:0] io_in_1_bits,
  input         io_out_ready,
  output        io_out_valid,
  output [80:0] io_out_bits
);
  wire  grant_1 = ~io_in_0_valid; // @[Arbiter.scala 31:78]
  assign io_in_0_ready = io_out_ready; // @[Arbiter.scala 134:19]
  assign io_in_1_ready = grant_1 & io_out_ready; // @[Arbiter.scala 134:19]
  assign io_out_valid = ~grant_1 | io_in_1_valid; // @[Arbiter.scala 135:31]
  assign io_out_bits = io_in_0_valid ? io_in_0_bits : io_in_1_bits; // @[Arbiter.scala 126:27 Arbiter.scala 128:19 Arbiter.scala 124:15]
endmodule
module Arp(
  input         clock,
  input         reset,
  input         io_mac2Arp_valid,
  input  [7:0]  io_mac2Arp_bits,
  output        io_arp2Mac_valid,
  output [7:0]  io_arp2Mac_bits,

  (* mark_debug = "true" *)
  output [15:0] io_debugPort_op,

  (* mark_debug = "true" *)
  output [47:0] io_debugPort_macSrc,

  (* mark_debug = "true" *)
  output [31:0] io_debugPort_ipSrc,

  (* mark_debug = "true" *)
  output [47:0] io_debugPort_macDest,

  (* mark_debug = "true" *)
  output [31:0] io_debugPort_ipDest,

  (* mark_debug = "true" *)
  output        io_debugPort_ramWriteEnable,

  (* mark_debug = "true" *)
  output [7:0]  io_debugPort_ramWriteAddr,

  (* mark_debug = "true" *)
  output [31:0] io_debugPort_ramWriteIp,

  (* mark_debug = "true" *)
  output [47:0] io_debugPort_ramWriteMac,

  (* mark_debug = "true" *)
  output        io_debugPort_arpOutValid,

  (* mark_debug = "true" *)
  output [7:0]  io_debugPort_arpOutData
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [95:0] _RAND_30;
`endif // RANDOMIZE_REG_INIT
  wire  arpReqOut_clock; // @[Decoupled.scala 296:21]
  wire  arpReqOut_reset; // @[Decoupled.scala 296:21]
  wire  arpReqOut_io_enq_ready; // @[Decoupled.scala 296:21]
  wire  arpReqOut_io_enq_valid; // @[Decoupled.scala 296:21]
  wire [80:0] arpReqOut_io_enq_bits; // @[Decoupled.scala 296:21]
  wire  arpReqOut_io_deq_ready; // @[Decoupled.scala 296:21]
  wire  arpReqOut_io_deq_valid; // @[Decoupled.scala 296:21]
  wire [80:0] arpReqOut_io_deq_bits; // @[Decoupled.scala 296:21]
  wire  ipReqOut_clock; // @[Decoupled.scala 296:21]
  wire  ipReqOut_reset; // @[Decoupled.scala 296:21]
  wire  ipReqOut_io_enq_ready; // @[Decoupled.scala 296:21]
  wire  ipReqOut_io_enq_valid; // @[Decoupled.scala 296:21]
  wire [80:0] ipReqOut_io_enq_bits; // @[Decoupled.scala 296:21]
  wire  ipReqOut_io_deq_ready; // @[Decoupled.scala 296:21]
  wire  ipReqOut_io_deq_valid; // @[Decoupled.scala 296:21]
  wire [80:0] ipReqOut_io_deq_bits; // @[Decoupled.scala 296:21]
  wire  arb_io_in_0_ready; // @[Arp.scala 112:19]
  wire  arb_io_in_0_valid; // @[Arp.scala 112:19]
  wire [80:0] arb_io_in_0_bits; // @[Arp.scala 112:19]
  wire  arb_io_in_1_ready; // @[Arp.scala 112:19]
  wire  arb_io_in_1_valid; // @[Arp.scala 112:19]
  wire [80:0] arb_io_in_1_bits; // @[Arp.scala 112:19]
  wire  arb_io_out_ready; // @[Arp.scala 112:19]
  wire  arb_io_out_valid; // @[Arp.scala 112:19]
  wire [80:0] arb_io_out_bits; // @[Arp.scala 112:19]
  reg [7:0] arpRamWriteAddress; // @[Arp.scala 38:31]
  reg [31:0] arpRamWriteData_ip; // @[Arp.scala 39:28]
  reg [47:0] arpRamWriteData_mac; // @[Arp.scala 39:28]
  reg [3:0] st; // @[Arp.scala 54:25]
  reg [2:0] value; // @[Counter.scala 60:40]
  reg [7:0] op_0; // @[Arp.scala 47:15]
  reg [7:0] op_1; // @[Arp.scala 47:15]
  reg [7:0] macSrc_0; // @[Arp.scala 48:19]
  reg [7:0] macSrc_1; // @[Arp.scala 48:19]
  reg [7:0] macSrc_2; // @[Arp.scala 48:19]
  reg [7:0] macSrc_3; // @[Arp.scala 48:19]
  reg [7:0] macSrc_4; // @[Arp.scala 48:19]
  reg [7:0] macSrc_5; // @[Arp.scala 48:19]
  reg [7:0] ipSrc_0; // @[Arp.scala 49:18]
  reg [7:0] ipSrc_1; // @[Arp.scala 49:18]
  reg [7:0] ipSrc_2; // @[Arp.scala 49:18]
  reg [7:0] ipSrc_3; // @[Arp.scala 49:18]
  reg [7:0] macDest_0; // @[Arp.scala 50:20]
  reg [7:0] macDest_1; // @[Arp.scala 50:20]
  reg [7:0] macDest_2; // @[Arp.scala 50:20]
  reg [7:0] macDest_3; // @[Arp.scala 50:20]
  reg [7:0] macDest_4; // @[Arp.scala 50:20]
  reg [7:0] macDest_5; // @[Arp.scala 50:20]
  reg [7:0] ipDest_0; // @[Arp.scala 51:19]
  reg [7:0] ipDest_1; // @[Arp.scala 51:19]
  reg [7:0] ipDest_2; // @[Arp.scala 51:19]
  reg [7:0] ipDest_3; // @[Arp.scala 51:19]
  wire  _T = 4'h0 == st; // @[Conditional.scala 37:30]
  wire  _T_1 = 4'h1 == st; // @[Conditional.scala 37:30]
  wire [2:0] _value_T_1 = value + 3'h1; // @[Counter.scala 76:24]
  wire  _T_3 = 4'h2 == st; // @[Conditional.scala 37:30]
  wire [2:0] _GEN_20 = value == 3'h1 ? 3'h0 : _value_T_1; // @[package.scala 114:46 Counter.scala 97:11 Counter.scala 76:15]
  wire [3:0] _GEN_22 = value == 3'h1 ? 4'h3 : st; // @[package.scala 114:46 package.scala 117:14 Arp.scala 54:25]
  wire  _T_9 = 4'h3 == st; // @[Conditional.scala 37:30]
  wire [7:0] _GEN_26 = io_mac2Arp_valid & 3'h0 == value ? io_mac2Arp_bits : macSrc_5; // @[package.scala 108:45 package.scala 109:35 Arp.scala 48:19]
  wire [7:0] _GEN_27 = io_mac2Arp_valid & 3'h1 == value ? io_mac2Arp_bits : macSrc_4; // @[package.scala 108:45 package.scala 109:35 Arp.scala 48:19]
  wire [7:0] _GEN_28 = io_mac2Arp_valid & 3'h2 == value ? io_mac2Arp_bits : macSrc_3; // @[package.scala 108:45 package.scala 109:35 Arp.scala 48:19]
  wire [7:0] _GEN_29 = io_mac2Arp_valid & 3'h3 == value ? io_mac2Arp_bits : macSrc_2; // @[package.scala 108:45 package.scala 109:35 Arp.scala 48:19]
  wire [7:0] _GEN_30 = io_mac2Arp_valid & 3'h4 == value ? io_mac2Arp_bits : macSrc_1; // @[package.scala 108:45 package.scala 109:35 Arp.scala 48:19]
  wire [7:0] _GEN_31 = io_mac2Arp_valid & 3'h5 == value ? io_mac2Arp_bits : macSrc_0; // @[package.scala 108:45 package.scala 109:35 Arp.scala 48:19]
  wire [2:0] _GEN_32 = value == 3'h5 ? 3'h0 : _value_T_1; // @[package.scala 114:46 Counter.scala 97:11 Counter.scala 76:15]
  wire [3:0] _GEN_34 = value == 3'h5 ? 4'h4 : st; // @[package.scala 114:46 package.scala 117:14 Arp.scala 54:25]
  wire [2:0] _GEN_35 = io_mac2Arp_valid ? _GEN_32 : 3'h0; // @[package.scala 112:23 Counter.scala 97:11]
  wire [3:0] _GEN_37 = io_mac2Arp_valid ? _GEN_34 : 4'h0; // @[package.scala 112:23 package.scala 121:12]
  wire  _T_23 = 4'h4 == st; // @[Conditional.scala 37:30]
  wire [7:0] _GEN_38 = io_mac2Arp_valid & 3'h0 == value ? io_mac2Arp_bits : ipSrc_3; // @[package.scala 108:45 package.scala 109:35 Arp.scala 49:18]
  wire [7:0] _GEN_39 = io_mac2Arp_valid & 3'h1 == value ? io_mac2Arp_bits : ipSrc_2; // @[package.scala 108:45 package.scala 109:35 Arp.scala 49:18]
  wire [7:0] _GEN_40 = io_mac2Arp_valid & 3'h2 == value ? io_mac2Arp_bits : ipSrc_1; // @[package.scala 108:45 package.scala 109:35 Arp.scala 49:18]
  wire [7:0] _GEN_41 = io_mac2Arp_valid & 3'h3 == value ? io_mac2Arp_bits : ipSrc_0; // @[package.scala 108:45 package.scala 109:35 Arp.scala 49:18]
  wire [2:0] _GEN_42 = value == 3'h3 ? 3'h0 : _value_T_1; // @[package.scala 114:46 Counter.scala 97:11 Counter.scala 76:15]
  wire [3:0] _GEN_44 = value == 3'h3 ? 4'h5 : st; // @[package.scala 114:46 package.scala 117:14 Arp.scala 54:25]
  wire [2:0] _GEN_45 = io_mac2Arp_valid ? _GEN_42 : 3'h0; // @[package.scala 112:23 Counter.scala 97:11]
  wire [3:0] _GEN_47 = io_mac2Arp_valid ? _GEN_44 : 4'h0; // @[package.scala 112:23 package.scala 121:12]
  wire  _T_33 = 4'h5 == st; // @[Conditional.scala 37:30]
  wire [7:0] _GEN_48 = io_mac2Arp_valid & 3'h0 == value ? io_mac2Arp_bits : macDest_5; // @[package.scala 108:45 package.scala 109:35 Arp.scala 50:20]
  wire [7:0] _GEN_49 = io_mac2Arp_valid & 3'h1 == value ? io_mac2Arp_bits : macDest_4; // @[package.scala 108:45 package.scala 109:35 Arp.scala 50:20]
  wire [7:0] _GEN_50 = io_mac2Arp_valid & 3'h2 == value ? io_mac2Arp_bits : macDest_3; // @[package.scala 108:45 package.scala 109:35 Arp.scala 50:20]
  wire [7:0] _GEN_51 = io_mac2Arp_valid & 3'h3 == value ? io_mac2Arp_bits : macDest_2; // @[package.scala 108:45 package.scala 109:35 Arp.scala 50:20]
  wire [7:0] _GEN_52 = io_mac2Arp_valid & 3'h4 == value ? io_mac2Arp_bits : macDest_1; // @[package.scala 108:45 package.scala 109:35 Arp.scala 50:20]
  wire [7:0] _GEN_53 = io_mac2Arp_valid & 3'h5 == value ? io_mac2Arp_bits : macDest_0; // @[package.scala 108:45 package.scala 109:35 Arp.scala 50:20]
  wire [3:0] _GEN_56 = value == 3'h5 ? 4'h6 : st; // @[package.scala 114:46 package.scala 117:14 Arp.scala 54:25]
  wire [3:0] _GEN_59 = io_mac2Arp_valid ? _GEN_56 : 4'h0; // @[package.scala 112:23 package.scala 121:12]
  wire  _T_47 = 4'h6 == st; // @[Conditional.scala 37:30]
  wire [7:0] _GEN_60 = io_mac2Arp_valid & 3'h0 == value ? io_mac2Arp_bits : ipDest_3; // @[package.scala 108:45 package.scala 109:35 Arp.scala 51:19]
  wire [7:0] _GEN_61 = io_mac2Arp_valid & 3'h1 == value ? io_mac2Arp_bits : ipDest_2; // @[package.scala 108:45 package.scala 109:35 Arp.scala 51:19]
  wire [7:0] _GEN_62 = io_mac2Arp_valid & 3'h2 == value ? io_mac2Arp_bits : ipDest_1; // @[package.scala 108:45 package.scala 109:35 Arp.scala 51:19]
  wire [7:0] _GEN_63 = io_mac2Arp_valid & 3'h3 == value ? io_mac2Arp_bits : ipDest_0; // @[package.scala 108:45 package.scala 109:35 Arp.scala 51:19]
  wire [3:0] _GEN_66 = value == 3'h3 ? 4'h7 : st; // @[package.scala 114:46 package.scala 117:14 Arp.scala 54:25]
  wire [3:0] _GEN_69 = io_mac2Arp_valid ? _GEN_66 : 4'h0; // @[package.scala 112:23 package.scala 121:12]
  wire  _T_57 = 4'h7 == st; // @[Conditional.scala 37:30]
  wire [3:0] _GEN_70 = _T_57 ? 4'h0 : st; // @[Conditional.scala 39:67 Arp.scala 89:16 Arp.scala 54:25]
  wire [7:0] _GEN_71 = _T_47 ? _GEN_60 : ipDest_3; // @[Conditional.scala 39:67 Arp.scala 51:19]
  wire [7:0] _GEN_72 = _T_47 ? _GEN_61 : ipDest_2; // @[Conditional.scala 39:67 Arp.scala 51:19]
  wire [7:0] _GEN_73 = _T_47 ? _GEN_62 : ipDest_1; // @[Conditional.scala 39:67 Arp.scala 51:19]
  wire [7:0] _GEN_74 = _T_47 ? _GEN_63 : ipDest_0; // @[Conditional.scala 39:67 Arp.scala 51:19]
  wire [2:0] _GEN_75 = _T_47 ? _GEN_45 : value; // @[Conditional.scala 39:67 Counter.scala 60:40]
  wire [3:0] _GEN_77 = _T_47 ? _GEN_69 : _GEN_70; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_78 = _T_33 ? _GEN_48 : macDest_5; // @[Conditional.scala 39:67 Arp.scala 50:20]
  wire [7:0] _GEN_79 = _T_33 ? _GEN_49 : macDest_4; // @[Conditional.scala 39:67 Arp.scala 50:20]
  wire [7:0] _GEN_80 = _T_33 ? _GEN_50 : macDest_3; // @[Conditional.scala 39:67 Arp.scala 50:20]
  wire [7:0] _GEN_81 = _T_33 ? _GEN_51 : macDest_2; // @[Conditional.scala 39:67 Arp.scala 50:20]
  wire [7:0] _GEN_82 = _T_33 ? _GEN_52 : macDest_1; // @[Conditional.scala 39:67 Arp.scala 50:20]
  wire [7:0] _GEN_83 = _T_33 ? _GEN_53 : macDest_0; // @[Conditional.scala 39:67 Arp.scala 50:20]
  wire [2:0] _GEN_84 = _T_33 ? _GEN_35 : _GEN_75; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_86 = _T_33 ? _GEN_59 : _GEN_77; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_87 = _T_33 ? ipDest_3 : _GEN_71; // @[Conditional.scala 39:67 Arp.scala 51:19]
  wire [7:0] _GEN_88 = _T_33 ? ipDest_2 : _GEN_72; // @[Conditional.scala 39:67 Arp.scala 51:19]
  wire [7:0] _GEN_89 = _T_33 ? ipDest_1 : _GEN_73; // @[Conditional.scala 39:67 Arp.scala 51:19]
  wire [7:0] _GEN_90 = _T_33 ? ipDest_0 : _GEN_74; // @[Conditional.scala 39:67 Arp.scala 51:19]
  wire [7:0] _GEN_91 = _T_23 ? _GEN_38 : ipSrc_3; // @[Conditional.scala 39:67 Arp.scala 49:18]
  wire [7:0] _GEN_92 = _T_23 ? _GEN_39 : ipSrc_2; // @[Conditional.scala 39:67 Arp.scala 49:18]
  wire [7:0] _GEN_93 = _T_23 ? _GEN_40 : ipSrc_1; // @[Conditional.scala 39:67 Arp.scala 49:18]
  wire [7:0] _GEN_94 = _T_23 ? _GEN_41 : ipSrc_0; // @[Conditional.scala 39:67 Arp.scala 49:18]
  wire [2:0] _GEN_95 = _T_23 ? _GEN_45 : _GEN_84; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_97 = _T_23 ? _GEN_47 : _GEN_86; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_98 = _T_23 ? macDest_5 : _GEN_78; // @[Conditional.scala 39:67 Arp.scala 50:20]
  wire [7:0] _GEN_99 = _T_23 ? macDest_4 : _GEN_79; // @[Conditional.scala 39:67 Arp.scala 50:20]
  wire [7:0] _GEN_100 = _T_23 ? macDest_3 : _GEN_80; // @[Conditional.scala 39:67 Arp.scala 50:20]
  wire [7:0] _GEN_101 = _T_23 ? macDest_2 : _GEN_81; // @[Conditional.scala 39:67 Arp.scala 50:20]
  wire [7:0] _GEN_102 = _T_23 ? macDest_1 : _GEN_82; // @[Conditional.scala 39:67 Arp.scala 50:20]
  wire [7:0] _GEN_103 = _T_23 ? macDest_0 : _GEN_83; // @[Conditional.scala 39:67 Arp.scala 50:20]
  wire [7:0] _GEN_104 = _T_23 ? ipDest_3 : _GEN_87; // @[Conditional.scala 39:67 Arp.scala 51:19]
  wire [7:0] _GEN_105 = _T_23 ? ipDest_2 : _GEN_88; // @[Conditional.scala 39:67 Arp.scala 51:19]
  wire [7:0] _GEN_106 = _T_23 ? ipDest_1 : _GEN_89; // @[Conditional.scala 39:67 Arp.scala 51:19]
  wire [7:0] _GEN_107 = _T_23 ? ipDest_0 : _GEN_90; // @[Conditional.scala 39:67 Arp.scala 51:19]
  wire [15:0] arpRamWriteData_ip_lo = {ipSrc_1,ipSrc_0}; // @[Arp.scala 95:39]
  wire [15:0] arpRamWriteData_ip_hi = {ipSrc_3,ipSrc_2}; // @[Arp.scala 95:39]
  wire [23:0] arpRamWriteData_mac_lo = {macSrc_2,macSrc_1,macSrc_0}; // @[Arp.scala 96:41]
  wire [23:0] arpRamWriteData_mac_hi = {macSrc_5,macSrc_4,macSrc_3}; // @[Arp.scala 96:41]
  wire [47:0] _arpRamWriteData_mac_T = {macSrc_5,macSrc_4,macSrc_3,macSrc_2,macSrc_1,macSrc_0}; // @[Arp.scala 96:41]
  wire [32:0] arpReqIn_bits_hi_2 = {1'h1,ipSrc_3,ipSrc_2,ipSrc_1,ipSrc_0}; // @[Cat.scala 30:58]
  wire [15:0] _arpReqIn_valid_T = {op_1,op_0}; // @[Arp.scala 103:32]
  reg  arpReqIn_valid_REG; // @[Arp.scala 103:64]
  reg [3:0] sState; // @[Arp.scala 119:29]
  reg [2:0] value_1; // @[Counter.scala 60:40]
  wire  arpSend_ready = sState == 4'h0; // @[Arp.scala 163:33]
  wire  arpSend_valid = arb_io_out_valid; // @[Arp.scala 111:21 Arp.scala 115:11]
  wire  _arpSendReg_T = arpSend_ready & arpSend_valid; // @[Decoupled.scala 40:37]
  reg [80:0] arpSendReg; // @[Reg.scala 15:16]
  wire [80:0] arpSend_bits = arb_io_out_bits; // @[Arp.scala 111:21 Arp.scala 115:11]
  wire  arpSendOp = arpSendReg[80]; // @[Arp.scala 128:26]
  wire [31:0] arpSendIp = arpSendReg[79:48]; // @[Arp.scala 129:26]
  wire [47:0] arpSendMac = arpSendReg[47:0]; // @[Arp.scala 130:27]
  wire  _T_58 = 4'h0 == sState; // @[Conditional.scala 37:30]
  wire  _T_60 = 4'h1 == sState; // @[Conditional.scala 37:30]
  wire [7:0] _GEN_210 = 3'h1 == value_1 ? 8'h1 : 8'h0; // @[package.scala 74:18 package.scala 74:18]
  wire [7:0] _GEN_211 = 3'h2 == value_1 ? 8'h8 : _GEN_210; // @[package.scala 74:18 package.scala 74:18]
  wire [7:0] _GEN_212 = 3'h3 == value_1 ? 8'h0 : _GEN_211; // @[package.scala 74:18 package.scala 74:18]
  wire [7:0] _GEN_213 = 3'h4 == value_1 ? 8'h6 : _GEN_212; // @[package.scala 74:18 package.scala 74:18]
  wire [7:0] _GEN_214 = 3'h5 == value_1 ? 8'h4 : _GEN_213; // @[package.scala 74:18 package.scala 74:18]
  wire [2:0] _value_T_13 = value_1 + 3'h1; // @[Counter.scala 76:24]
  wire [2:0] _GEN_215 = value_1 == 3'h5 ? 3'h0 : _value_T_13; // @[package.scala 76:46 Counter.scala 97:11 Counter.scala 76:15]
  wire  _T_62 = 4'h2 == sState; // @[Conditional.scala 37:30]
  wire [7:0] _GEN_218 = value_1[0] ? 8'h2 : 8'h0; // @[package.scala 74:18 package.scala 74:18]
  wire [2:0] _GEN_219 = value_1 == 3'h1 ? 3'h0 : _value_T_13; // @[package.scala 76:46 Counter.scala 97:11 Counter.scala 76:15]
  wire [3:0] _GEN_220 = value_1 == 3'h1 ? 4'h3 : sState; // @[package.scala 76:46 package.scala 78:16 Arp.scala 119:29]
  wire [7:0] _GEN_222 = value_1[0] ? 8'h1 : 8'h0; // @[package.scala 74:18 package.scala 74:18]
  wire [7:0] _GEN_225 = arpSendOp ? _GEN_218 : _GEN_222; // @[Arp.scala 143:24 package.scala 74:18 package.scala 74:18]
  wire  _T_65 = 4'h3 == sState; // @[Conditional.scala 37:30]
  wire [7:0] _GEN_229 = 3'h1 == value_1 ? 8'h34 : 8'h12; // @[package.scala 74:18 package.scala 74:18]
  wire [7:0] _GEN_230 = 3'h2 == value_1 ? 8'h55 : _GEN_229; // @[package.scala 74:18 package.scala 74:18]
  wire [7:0] _GEN_231 = 3'h3 == value_1 ? 8'haa : _GEN_230; // @[package.scala 74:18 package.scala 74:18]
  wire [7:0] _GEN_232 = 3'h4 == value_1 ? 8'hff : _GEN_231; // @[package.scala 74:18 package.scala 74:18]
  wire [7:0] _GEN_233 = 3'h5 == value_1 ? 8'h0 : _GEN_232; // @[package.scala 74:18 package.scala 74:18]
  wire [3:0] _GEN_235 = value_1 == 3'h5 ? 4'h4 : sState; // @[package.scala 76:46 package.scala 78:16 Arp.scala 119:29]
  wire  _T_67 = 4'h4 == sState; // @[Conditional.scala 37:30]
  wire [7:0] _GEN_237 = 2'h1 == value_1[1:0] ? 8'hbb : 8'haa; // @[package.scala 74:18 package.scala 74:18]
  wire [7:0] _GEN_238 = 2'h2 == value_1[1:0] ? 8'hcc : _GEN_237; // @[package.scala 74:18 package.scala 74:18]
  wire [7:0] _GEN_239 = 2'h3 == value_1[1:0] ? 8'hdd : _GEN_238; // @[package.scala 74:18 package.scala 74:18]
  wire [2:0] _GEN_240 = value_1 == 3'h3 ? 3'h0 : _value_T_13; // @[package.scala 76:46 Counter.scala 97:11 Counter.scala 76:15]
  wire [3:0] _GEN_241 = value_1 == 3'h3 ? 4'h5 : sState; // @[package.scala 76:46 package.scala 78:16 Arp.scala 119:29]
  wire  _T_69 = 4'h5 == sState; // @[Conditional.scala 37:30]
  wire [7:0] v_3_0 = arpSendMac[47:40]; // @[package.scala 152:16]
  wire [7:0] v_3_1 = arpSendMac[39:32]; // @[package.scala 152:16]
  wire [7:0] v_3_2 = arpSendMac[31:24]; // @[package.scala 152:16]
  wire [7:0] v_3_3 = arpSendMac[23:16]; // @[package.scala 152:16]
  wire [7:0] v_3_4 = arpSendMac[15:8]; // @[package.scala 152:16]
  wire [7:0] v_3_5 = arpSendMac[7:0]; // @[package.scala 152:16]
  wire [7:0] _GEN_243 = 3'h1 == value_1 ? v_3_1 : v_3_0; // @[package.scala 74:18 package.scala 74:18]
  wire [7:0] _GEN_244 = 3'h2 == value_1 ? v_3_2 : _GEN_243; // @[package.scala 74:18 package.scala 74:18]
  wire [7:0] _GEN_245 = 3'h3 == value_1 ? v_3_3 : _GEN_244; // @[package.scala 74:18 package.scala 74:18]
  wire [7:0] _GEN_246 = 3'h4 == value_1 ? v_3_4 : _GEN_245; // @[package.scala 74:18 package.scala 74:18]
  wire [7:0] _GEN_247 = 3'h5 == value_1 ? v_3_5 : _GEN_246; // @[package.scala 74:18 package.scala 74:18]
  wire [3:0] _GEN_249 = value_1 == 3'h5 ? 4'h6 : sState; // @[package.scala 76:46 package.scala 78:16 Arp.scala 119:29]
  wire  _T_71 = 4'h6 == sState; // @[Conditional.scala 37:30]
  wire [7:0] v_4_0 = arpSendIp[31:24]; // @[package.scala 152:16]
  wire [7:0] v_4_1 = arpSendIp[23:16]; // @[package.scala 152:16]
  wire [7:0] v_4_2 = arpSendIp[15:8]; // @[package.scala 152:16]
  wire [7:0] v_4_3 = arpSendIp[7:0]; // @[package.scala 152:16]
  wire [7:0] _GEN_251 = 2'h1 == value_1[1:0] ? v_4_1 : v_4_0; // @[package.scala 74:18 package.scala 74:18]
  wire [7:0] _GEN_252 = 2'h2 == value_1[1:0] ? v_4_2 : _GEN_251; // @[package.scala 74:18 package.scala 74:18]
  wire [7:0] _GEN_253 = 2'h3 == value_1[1:0] ? v_4_3 : _GEN_252; // @[package.scala 74:18 package.scala 74:18]
  wire [3:0] _GEN_255 = value_1 == 3'h3 ? 4'h0 : sState; // @[package.scala 76:46 package.scala 78:16 Arp.scala 119:29]
  wire [2:0] _GEN_257 = _T_71 ? _GEN_240 : value_1; // @[Conditional.scala 39:67 Counter.scala 60:40]
  wire [3:0] _GEN_258 = _T_71 ? _GEN_255 : sState; // @[Conditional.scala 39:67 Arp.scala 119:29]
  wire [7:0] _GEN_259 = _T_69 ? _GEN_247 : _GEN_253; // @[Conditional.scala 39:67 package.scala 74:18]
  wire [2:0] _GEN_260 = _T_69 ? _GEN_215 : _GEN_257; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_261 = _T_69 ? _GEN_249 : _GEN_258; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_262 = _T_67 ? _GEN_239 : _GEN_259; // @[Conditional.scala 39:67 package.scala 74:18]
  wire [2:0] _GEN_263 = _T_67 ? _GEN_240 : _GEN_260; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_264 = _T_67 ? _GEN_241 : _GEN_261; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_265 = _T_65 ? _GEN_233 : _GEN_262; // @[Conditional.scala 39:67 package.scala 74:18]
  wire [7:0] _GEN_268 = _T_62 ? _GEN_225 : _GEN_265; // @[Conditional.scala 39:67]
  wire [23:0] io_debugPort_macDest_lo = {macDest_2,macDest_1,macDest_0}; // @[Arp.scala 168:43]
  wire [23:0] io_debugPort_macDest_hi = {macDest_5,macDest_4,macDest_3}; // @[Arp.scala 168:43]
  wire [15:0] io_debugPort_ipDest_lo = {ipDest_1,ipDest_0}; // @[Arp.scala 170:41]
  wire [15:0] io_debugPort_ipDest_hi = {ipDest_3,ipDest_2}; // @[Arp.scala 170:41]
  Queue_1 arpReqOut ( // @[Decoupled.scala 296:21]
    .clock(arpReqOut_clock),
    .reset(arpReqOut_reset),
    .io_enq_ready(arpReqOut_io_enq_ready),
    .io_enq_valid(arpReqOut_io_enq_valid),
    .io_enq_bits(arpReqOut_io_enq_bits),
    .io_deq_ready(arpReqOut_io_deq_ready),
    .io_deq_valid(arpReqOut_io_deq_valid),
    .io_deq_bits(arpReqOut_io_deq_bits)
  );
  Queue_1 ipReqOut ( // @[Decoupled.scala 296:21]
    .clock(ipReqOut_clock),
    .reset(ipReqOut_reset),
    .io_enq_ready(ipReqOut_io_enq_ready),
    .io_enq_valid(ipReqOut_io_enq_valid),
    .io_enq_bits(ipReqOut_io_enq_bits),
    .io_deq_ready(ipReqOut_io_deq_ready),
    .io_deq_valid(ipReqOut_io_deq_valid),
    .io_deq_bits(ipReqOut_io_deq_bits)
  );
  Arbiter arb ( // @[Arp.scala 112:19]
    .io_in_0_ready(arb_io_in_0_ready),
    .io_in_0_valid(arb_io_in_0_valid),
    .io_in_0_bits(arb_io_in_0_bits),
    .io_in_1_ready(arb_io_in_1_ready),
    .io_in_1_valid(arb_io_in_1_valid),
    .io_in_1_bits(arb_io_in_1_bits),
    .io_out_ready(arb_io_out_ready),
    .io_out_valid(arb_io_out_valid),
    .io_out_bits(arb_io_out_bits)
  );
  assign io_arp2Mac_valid = sState != 4'h0; // @[Arp.scala 164:36]
  assign io_arp2Mac_bits = _T_60 ? _GEN_214 : _GEN_268; // @[Conditional.scala 39:67 package.scala 74:18]
  assign io_debugPort_op = {op_1,op_0}; // @[Arp.scala 166:33]
  assign io_debugPort_macSrc = {arpRamWriteData_mac_hi,arpRamWriteData_mac_lo}; // @[Arp.scala 167:41]
  assign io_debugPort_ipSrc = {arpRamWriteData_ip_hi,arpRamWriteData_ip_lo}; // @[Arp.scala 169:39]
  assign io_debugPort_macDest = {io_debugPort_macDest_hi,io_debugPort_macDest_lo}; // @[Arp.scala 168:43]
  assign io_debugPort_ipDest = {io_debugPort_ipDest_hi,io_debugPort_ipDest_lo}; // @[Arp.scala 170:41]
  assign io_debugPort_ramWriteEnable = st == 4'h7; // @[Arp.scala 93:33]
  assign io_debugPort_ramWriteAddr = arpRamWriteAddress; // @[Arp.scala 172:29]
  assign io_debugPort_ramWriteIp = arpRamWriteData_ip; // @[Arp.scala 173:27]
  assign io_debugPort_ramWriteMac = arpRamWriteData_mac; // @[Arp.scala 174:28]
  assign io_debugPort_arpOutValid = io_arp2Mac_valid; // @[Arp.scala 175:28]
  assign io_debugPort_arpOutData = io_arp2Mac_bits; // @[Arp.scala 176:27]
  assign arpReqOut_clock = clock;
  assign arpReqOut_reset = reset;
  assign arpReqOut_io_enq_valid = _arpReqIn_valid_T == 16'h1 & arpReqIn_valid_REG; // @[Arp.scala 103:54]
  assign arpReqOut_io_enq_bits = {arpReqIn_bits_hi_2,_arpRamWriteData_mac_T}; // @[Cat.scala 30:58]
  assign arpReqOut_io_deq_ready = arb_io_in_1_ready; // @[Arp.scala 114:16]
  assign ipReqOut_clock = clock;
  assign ipReqOut_reset = reset;
  assign ipReqOut_io_enq_valid = 1'h0; // @[Arp.scala 106:21 Arp.scala 108:17]
  assign ipReqOut_io_enq_bits = 81'hffffffffffff; // @[Cat.scala 30:58]
  assign ipReqOut_io_deq_ready = arb_io_in_0_ready; // @[Arp.scala 113:16]
  assign arb_io_in_0_valid = ipReqOut_io_deq_valid; // @[Arp.scala 113:16]
  assign arb_io_in_0_bits = ipReqOut_io_deq_bits; // @[Arp.scala 113:16]
  assign arb_io_in_1_valid = arpReqOut_io_deq_valid; // @[Arp.scala 114:16]
  assign arb_io_in_1_bits = arpReqOut_io_deq_bits; // @[Arp.scala 114:16]
  assign arb_io_out_ready = sState == 4'h0; // @[Arp.scala 163:33]
  always @(posedge clock) begin
    arpRamWriteAddress <= macSrc_0; // @[Arp.scala 94:22]
    arpRamWriteData_ip <= {arpRamWriteData_ip_hi,arpRamWriteData_ip_lo}; // @[Arp.scala 95:39]
    arpRamWriteData_mac <= {arpRamWriteData_mac_hi,arpRamWriteData_mac_lo}; // @[Arp.scala 96:41]
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_1)) begin // @[Conditional.scala 39:67]
        if (_T_3) begin // @[Conditional.scala 39:67]
          if (io_mac2Arp_valid & 3'h1 == value) begin // @[package.scala 108:45]
            op_0 <= io_mac2Arp_bits; // @[package.scala 109:35]
          end
        end
      end
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_1)) begin // @[Conditional.scala 39:67]
        if (_T_3) begin // @[Conditional.scala 39:67]
          if (io_mac2Arp_valid & 3'h0 == value) begin // @[package.scala 108:45]
            op_1 <= io_mac2Arp_bits; // @[package.scala 109:35]
          end
        end
      end
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_1)) begin // @[Conditional.scala 39:67]
        if (!(_T_3)) begin // @[Conditional.scala 39:67]
          if (_T_9) begin // @[Conditional.scala 39:67]
            macSrc_0 <= _GEN_31;
          end
        end
      end
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_1)) begin // @[Conditional.scala 39:67]
        if (!(_T_3)) begin // @[Conditional.scala 39:67]
          if (_T_9) begin // @[Conditional.scala 39:67]
            macSrc_1 <= _GEN_30;
          end
        end
      end
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_1)) begin // @[Conditional.scala 39:67]
        if (!(_T_3)) begin // @[Conditional.scala 39:67]
          if (_T_9) begin // @[Conditional.scala 39:67]
            macSrc_2 <= _GEN_29;
          end
        end
      end
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_1)) begin // @[Conditional.scala 39:67]
        if (!(_T_3)) begin // @[Conditional.scala 39:67]
          if (_T_9) begin // @[Conditional.scala 39:67]
            macSrc_3 <= _GEN_28;
          end
        end
      end
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_1)) begin // @[Conditional.scala 39:67]
        if (!(_T_3)) begin // @[Conditional.scala 39:67]
          if (_T_9) begin // @[Conditional.scala 39:67]
            macSrc_4 <= _GEN_27;
          end
        end
      end
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_1)) begin // @[Conditional.scala 39:67]
        if (!(_T_3)) begin // @[Conditional.scala 39:67]
          if (_T_9) begin // @[Conditional.scala 39:67]
            macSrc_5 <= _GEN_26;
          end
        end
      end
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_1)) begin // @[Conditional.scala 39:67]
        if (!(_T_3)) begin // @[Conditional.scala 39:67]
          if (!(_T_9)) begin // @[Conditional.scala 39:67]
            ipSrc_0 <= _GEN_94;
          end
        end
      end
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_1)) begin // @[Conditional.scala 39:67]
        if (!(_T_3)) begin // @[Conditional.scala 39:67]
          if (!(_T_9)) begin // @[Conditional.scala 39:67]
            ipSrc_1 <= _GEN_93;
          end
        end
      end
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_1)) begin // @[Conditional.scala 39:67]
        if (!(_T_3)) begin // @[Conditional.scala 39:67]
          if (!(_T_9)) begin // @[Conditional.scala 39:67]
            ipSrc_2 <= _GEN_92;
          end
        end
      end
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_1)) begin // @[Conditional.scala 39:67]
        if (!(_T_3)) begin // @[Conditional.scala 39:67]
          if (!(_T_9)) begin // @[Conditional.scala 39:67]
            ipSrc_3 <= _GEN_91;
          end
        end
      end
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_1)) begin // @[Conditional.scala 39:67]
        if (!(_T_3)) begin // @[Conditional.scala 39:67]
          if (!(_T_9)) begin // @[Conditional.scala 39:67]
            macDest_0 <= _GEN_103;
          end
        end
      end
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_1)) begin // @[Conditional.scala 39:67]
        if (!(_T_3)) begin // @[Conditional.scala 39:67]
          if (!(_T_9)) begin // @[Conditional.scala 39:67]
            macDest_1 <= _GEN_102;
          end
        end
      end
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_1)) begin // @[Conditional.scala 39:67]
        if (!(_T_3)) begin // @[Conditional.scala 39:67]
          if (!(_T_9)) begin // @[Conditional.scala 39:67]
            macDest_2 <= _GEN_101;
          end
        end
      end
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_1)) begin // @[Conditional.scala 39:67]
        if (!(_T_3)) begin // @[Conditional.scala 39:67]
          if (!(_T_9)) begin // @[Conditional.scala 39:67]
            macDest_3 <= _GEN_100;
          end
        end
      end
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_1)) begin // @[Conditional.scala 39:67]
        if (!(_T_3)) begin // @[Conditional.scala 39:67]
          if (!(_T_9)) begin // @[Conditional.scala 39:67]
            macDest_4 <= _GEN_99;
          end
        end
      end
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_1)) begin // @[Conditional.scala 39:67]
        if (!(_T_3)) begin // @[Conditional.scala 39:67]
          if (!(_T_9)) begin // @[Conditional.scala 39:67]
            macDest_5 <= _GEN_98;
          end
        end
      end
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_1)) begin // @[Conditional.scala 39:67]
        if (!(_T_3)) begin // @[Conditional.scala 39:67]
          if (!(_T_9)) begin // @[Conditional.scala 39:67]
            ipDest_0 <= _GEN_107;
          end
        end
      end
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_1)) begin // @[Conditional.scala 39:67]
        if (!(_T_3)) begin // @[Conditional.scala 39:67]
          if (!(_T_9)) begin // @[Conditional.scala 39:67]
            ipDest_1 <= _GEN_106;
          end
        end
      end
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_1)) begin // @[Conditional.scala 39:67]
        if (!(_T_3)) begin // @[Conditional.scala 39:67]
          if (!(_T_9)) begin // @[Conditional.scala 39:67]
            ipDest_2 <= _GEN_105;
          end
        end
      end
    end
    if (!(_T)) begin // @[Conditional.scala 40:58]
      if (!(_T_1)) begin // @[Conditional.scala 39:67]
        if (!(_T_3)) begin // @[Conditional.scala 39:67]
          if (!(_T_9)) begin // @[Conditional.scala 39:67]
            ipDest_3 <= _GEN_104;
          end
        end
      end
    end
    arpReqIn_valid_REG <= st == 4'h7; // @[Arp.scala 103:74]
    if (_arpSendReg_T) begin // @[Reg.scala 16:19]
      arpSendReg <= arpSend_bits; // @[Reg.scala 16:23]
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      st <= 4'h0;
    end else if (_T) begin
      if (io_mac2Arp_valid) begin
        st <= 4'h1;
      end
    end else if (_T_1) begin
      if (io_mac2Arp_valid) begin
        if (value == 3'h4) begin
          st <= 4'h2;
        end
      end else begin
        st <= 4'h0;
      end
    end else if (_T_3) begin
      if (io_mac2Arp_valid) begin
        st <= _GEN_22;
      end else begin
        st <= 4'h0;
      end
    end else if (_T_9) begin
      st <= _GEN_37;
    end else begin
      st <= _GEN_97;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      value <= 3'h0;
    end else if (_T) begin
      if (io_mac2Arp_valid) begin
        value <= 3'h0;
      end
    end else if (_T_1) begin
      if (io_mac2Arp_valid) begin
        if (value == 3'h4) begin
          value <= 3'h0;
        end else begin
          value <= _value_T_1;
        end
      end else begin
        value <= 3'h0;
      end
    end else if (_T_3) begin
      if (io_mac2Arp_valid) begin
        value <= _GEN_20;
      end else begin
        value <= 3'h0;
      end
    end else if (_T_9) begin
      value <= _GEN_35;
    end else begin
      value <= _GEN_95;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      sState <= 4'h0;
    end else if (_T_58) begin
      if (arpSend_valid) begin
        sState <= 4'h1;
      end
    end else if (_T_60) begin
      if (value_1 == 3'h5) begin
        sState <= 4'h2;
      end
    end else if (_T_62) begin
      if (arpSendOp) begin
        sState <= _GEN_220;
      end else begin
        sState <= _GEN_220;
      end
    end else if (_T_65) begin
      sState <= _GEN_235;
    end else begin
      sState <= _GEN_264;
    end
  end
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      value_1 <= 3'h0;
    end else if (!(_T_58)) begin
      if (_T_60) begin
        value_1 <= _GEN_215;
      end else if (_T_62) begin
        if (arpSendOp) begin
          value_1 <= _GEN_219;
        end else begin
          value_1 <= _GEN_219;
        end
      end else if (_T_65) begin
        value_1 <= _GEN_215;
      end else begin
        value_1 <= _GEN_263;
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
  arpRamWriteAddress = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  arpRamWriteData_ip = _RAND_1[31:0];
  _RAND_2 = {2{`RANDOM}};
  arpRamWriteData_mac = _RAND_2[47:0];
  _RAND_3 = {1{`RANDOM}};
  st = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  value = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  op_0 = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  op_1 = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  macSrc_0 = _RAND_7[7:0];
  _RAND_8 = {1{`RANDOM}};
  macSrc_1 = _RAND_8[7:0];
  _RAND_9 = {1{`RANDOM}};
  macSrc_2 = _RAND_9[7:0];
  _RAND_10 = {1{`RANDOM}};
  macSrc_3 = _RAND_10[7:0];
  _RAND_11 = {1{`RANDOM}};
  macSrc_4 = _RAND_11[7:0];
  _RAND_12 = {1{`RANDOM}};
  macSrc_5 = _RAND_12[7:0];
  _RAND_13 = {1{`RANDOM}};
  ipSrc_0 = _RAND_13[7:0];
  _RAND_14 = {1{`RANDOM}};
  ipSrc_1 = _RAND_14[7:0];
  _RAND_15 = {1{`RANDOM}};
  ipSrc_2 = _RAND_15[7:0];
  _RAND_16 = {1{`RANDOM}};
  ipSrc_3 = _RAND_16[7:0];
  _RAND_17 = {1{`RANDOM}};
  macDest_0 = _RAND_17[7:0];
  _RAND_18 = {1{`RANDOM}};
  macDest_1 = _RAND_18[7:0];
  _RAND_19 = {1{`RANDOM}};
  macDest_2 = _RAND_19[7:0];
  _RAND_20 = {1{`RANDOM}};
  macDest_3 = _RAND_20[7:0];
  _RAND_21 = {1{`RANDOM}};
  macDest_4 = _RAND_21[7:0];
  _RAND_22 = {1{`RANDOM}};
  macDest_5 = _RAND_22[7:0];
  _RAND_23 = {1{`RANDOM}};
  ipDest_0 = _RAND_23[7:0];
  _RAND_24 = {1{`RANDOM}};
  ipDest_1 = _RAND_24[7:0];
  _RAND_25 = {1{`RANDOM}};
  ipDest_2 = _RAND_25[7:0];
  _RAND_26 = {1{`RANDOM}};
  ipDest_3 = _RAND_26[7:0];
  _RAND_27 = {1{`RANDOM}};
  arpReqIn_valid_REG = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  sState = _RAND_28[3:0];
  _RAND_29 = {1{`RANDOM}};
  value_1 = _RAND_29[2:0];
  _RAND_30 = {3{`RANDOM}};
  arpSendReg = _RAND_30[80:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    st = 4'h0;
  end
  if (reset) begin
    value = 3'h0;
  end
  if (reset) begin
    sState = 4'h0;
  end
  if (reset) begin
    value_1 = 3'h0;
  end
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
  wire  macReceive_clock; // @[NetStack.scala 20:28]
  wire  macReceive_reset; // @[NetStack.scala 20:28]
  wire  macReceive_io_rx_valid; // @[NetStack.scala 20:28]
  wire [7:0] macReceive_io_rx_bits; // @[NetStack.scala 20:28]
  wire  macReceive_io_mac2IpIf_arpData_valid; // @[NetStack.scala 20:28]
  wire [7:0] macReceive_io_mac2IpIf_arpData_bits; // @[NetStack.scala 20:28]
  wire  macReceive_io_mac2IpIf_ipData_valid; // @[NetStack.scala 20:28]
  wire [7:0] macReceive_io_mac2IpIf_ipData_bits; // @[NetStack.scala 20:28]
  wire  macReceive_io_debugPort_rxValid; // @[NetStack.scala 20:28]
  wire [7:0] macReceive_io_debugPort_rxData; // @[NetStack.scala 20:28]
  wire [7:0] macReceive_io_debugPort_state; // @[NetStack.scala 20:28]
  wire [7:0] macReceive_io_debugPort_cnt; // @[NetStack.scala 20:28]
  wire [15:0] macReceive_io_debugPort_macType; // @[NetStack.scala 20:28]
  wire  macReceive_io_debugPort_macWriteEnable; // @[NetStack.scala 20:28]
  wire [11:0] macReceive_io_debugPort_macWriteAddress; // @[NetStack.scala 20:28]
  wire [7:0] macReceive_io_debugPort_macWriteData; // @[NetStack.scala 20:28]
  wire  macReceive_io_debugPort_macReadEnable; // @[NetStack.scala 20:28]
  wire [11:0] macReceive_io_debugPort_macReadAddress; // @[NetStack.scala 20:28]
  wire [7:0] macReceive_io_debugPort_macReadData; // @[NetStack.scala 20:28]
  wire  macReceive_io_debugPort_arpTxValid; // @[NetStack.scala 20:28]
  wire [7:0] macReceive_io_debugPort_arpTxData; // @[NetStack.scala 20:28]
  wire  macReceive_io_debugPort_ipTxValid; // @[NetStack.scala 20:28]
  wire [7:0] macReceive_io_debugPort_ipTxData; // @[NetStack.scala 20:28]
  wire  macReceive_io_debugPort_fifoInValid; // @[NetStack.scala 20:28]
  wire [11:0] macReceive_io_debugPort_fifoInStart; // @[NetStack.scala 20:28]
  wire [11:0] macReceive_io_debugPort_fifoInEnd; // @[NetStack.scala 20:28]
  wire  macReceive_io_debugPort_fifoOutFire; // @[NetStack.scala 20:28]
  wire [11:0] macReceive_io_debugPort_fifoOutStart; // @[NetStack.scala 20:28]
  wire [11:0] macReceive_io_debugPort_fifoOutEnd; // @[NetStack.scala 20:28]
  wire  arp_clock; // @[NetStack.scala 21:21]
  wire  arp_reset; // @[NetStack.scala 21:21]
  wire  arp_io_mac2Arp_valid; // @[NetStack.scala 21:21]
  wire [7:0] arp_io_mac2Arp_bits; // @[NetStack.scala 21:21]
  wire  arp_io_arp2Mac_valid; // @[NetStack.scala 21:21]
  wire [7:0] arp_io_arp2Mac_bits; // @[NetStack.scala 21:21]
  wire [15:0] arp_io_debugPort_op; // @[NetStack.scala 21:21]
  wire [47:0] arp_io_debugPort_macSrc; // @[NetStack.scala 21:21]
  wire [31:0] arp_io_debugPort_ipSrc; // @[NetStack.scala 21:21]
  wire [47:0] arp_io_debugPort_macDest; // @[NetStack.scala 21:21]
  wire [31:0] arp_io_debugPort_ipDest; // @[NetStack.scala 21:21]
  wire  arp_io_debugPort_ramWriteEnable; // @[NetStack.scala 21:21]
  wire [7:0] arp_io_debugPort_ramWriteAddr; // @[NetStack.scala 21:21]
  wire [31:0] arp_io_debugPort_ramWriteIp; // @[NetStack.scala 21:21]
  wire [47:0] arp_io_debugPort_ramWriteMac; // @[NetStack.scala 21:21]
  wire  arp_io_debugPort_arpOutValid; // @[NetStack.scala 21:21]
  wire [7:0] arp_io_debugPort_arpOutData; // @[NetStack.scala 21:21]
  wire  _T = ~reset_n; // @[NetStack.scala 18:55]
  reg  led_lo; // @[NetStack.scala 40:25]
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
    .io_rx_bits(rgmiiTransfer_io_rx_bits)
  );
  MacReceive macReceive ( // @[NetStack.scala 20:28]
    .clock(macReceive_clock),
    .reset(macReceive_reset),
    .io_rx_valid(macReceive_io_rx_valid),
    .io_rx_bits(macReceive_io_rx_bits),
    .io_mac2IpIf_arpData_valid(macReceive_io_mac2IpIf_arpData_valid),
    .io_mac2IpIf_arpData_bits(macReceive_io_mac2IpIf_arpData_bits),
    .io_mac2IpIf_ipData_valid(macReceive_io_mac2IpIf_ipData_valid),
    .io_mac2IpIf_ipData_bits(macReceive_io_mac2IpIf_ipData_bits),
    .io_debugPort_rxValid(macReceive_io_debugPort_rxValid),
    .io_debugPort_rxData(macReceive_io_debugPort_rxData),
    .io_debugPort_state(macReceive_io_debugPort_state),
    .io_debugPort_cnt(macReceive_io_debugPort_cnt),
    .io_debugPort_macType(macReceive_io_debugPort_macType),
    .io_debugPort_macWriteEnable(macReceive_io_debugPort_macWriteEnable),
    .io_debugPort_macWriteAddress(macReceive_io_debugPort_macWriteAddress),
    .io_debugPort_macWriteData(macReceive_io_debugPort_macWriteData),
    .io_debugPort_macReadEnable(macReceive_io_debugPort_macReadEnable),
    .io_debugPort_macReadAddress(macReceive_io_debugPort_macReadAddress),
    .io_debugPort_macReadData(macReceive_io_debugPort_macReadData),
    .io_debugPort_arpTxValid(macReceive_io_debugPort_arpTxValid),
    .io_debugPort_arpTxData(macReceive_io_debugPort_arpTxData),
    .io_debugPort_ipTxValid(macReceive_io_debugPort_ipTxValid),
    .io_debugPort_ipTxData(macReceive_io_debugPort_ipTxData),
    .io_debugPort_fifoInValid(macReceive_io_debugPort_fifoInValid),
    .io_debugPort_fifoInStart(macReceive_io_debugPort_fifoInStart),
    .io_debugPort_fifoInEnd(macReceive_io_debugPort_fifoInEnd),
    .io_debugPort_fifoOutFire(macReceive_io_debugPort_fifoOutFire),
    .io_debugPort_fifoOutStart(macReceive_io_debugPort_fifoOutStart),
    .io_debugPort_fifoOutEnd(macReceive_io_debugPort_fifoOutEnd)
  );
  Arp arp ( // @[NetStack.scala 21:21]
    .clock(arp_clock),
    .reset(arp_reset),
    .io_mac2Arp_valid(arp_io_mac2Arp_valid),
    .io_mac2Arp_bits(arp_io_mac2Arp_bits),
    .io_arp2Mac_valid(arp_io_arp2Mac_valid),
    .io_arp2Mac_bits(arp_io_arp2Mac_bits),
    .io_debugPort_op(arp_io_debugPort_op),
    .io_debugPort_macSrc(arp_io_debugPort_macSrc),
    .io_debugPort_ipSrc(arp_io_debugPort_ipSrc),
    .io_debugPort_macDest(arp_io_debugPort_macDest),
    .io_debugPort_ipDest(arp_io_debugPort_ipDest),
    .io_debugPort_ramWriteEnable(arp_io_debugPort_ramWriteEnable),
    .io_debugPort_ramWriteAddr(arp_io_debugPort_ramWriteAddr),
    .io_debugPort_ramWriteIp(arp_io_debugPort_ramWriteIp),
    .io_debugPort_ramWriteMac(arp_io_debugPort_ramWriteMac),
    .io_debugPort_arpOutValid(arp_io_debugPort_arpOutValid),
    .io_debugPort_arpOutData(arp_io_debugPort_arpOutData)
  );
  assign rgmii_txClock = 1'h0; // @[NetStack.scala 27:28]
  assign rgmii_txData = 4'h0; // @[NetStack.scala 27:28]
  assign rgmii_txCtrl = 1'h0; // @[NetStack.scala 27:28]
  assign rgmii_ereset = reset_n; // @[NetStack.scala 38:16]
  assign led = {{2'd0}, _led_T}; // @[Cat.scala 30:58]
  assign pll_clk_in = clock; // @[NetStack.scala 13:17]
  assign pll_reset = ~reset_n; // @[package.scala 13:17]
  assign rgmiiTransfer_clock = pll_clk_125;
  assign rgmiiTransfer_reset = ~reset_n; // @[NetStack.scala 18:55]
  assign rgmiiTransfer_io_rgmii_rxClock = rgmii_rxClock; // @[NetStack.scala 27:28]
  assign rgmiiTransfer_io_rgmii_rxData = rgmii_rxData; // @[NetStack.scala 27:28]
  assign rgmiiTransfer_io_rgmii_rxCtrl = rgmii_rxCtrl; // @[NetStack.scala 27:28]
  assign macReceive_clock = pll_clk_125;
  assign macReceive_reset = ~reset_n; // @[NetStack.scala 18:55]
  assign macReceive_io_rx_valid = rgmiiTransfer_io_rx_valid; // @[NetStack.scala 28:25]
  assign macReceive_io_rx_bits = rgmiiTransfer_io_rx_bits; // @[NetStack.scala 28:25]
  assign arp_clock = pll_clk_125;
  assign arp_reset = ~reset_n; // @[NetStack.scala 18:55]
  assign arp_io_mac2Arp_valid = macReceive_io_mac2IpIf_arpData_valid; // @[NetStack.scala 29:36]
  assign arp_io_mac2Arp_bits = macReceive_io_mac2IpIf_arpData_bits; // @[NetStack.scala 29:36]
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
