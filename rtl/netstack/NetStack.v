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
  reg [7:0] macData [0:4095]; // @[MacReceive.scala 56:28]
  wire [7:0] macData_macDataReadData_MPORT_data; // @[MacReceive.scala 56:28]
  wire [11:0] macData_macDataReadData_MPORT_addr; // @[MacReceive.scala 56:28]
  wire [7:0] macData_MPORT_data; // @[MacReceive.scala 56:28]
  wire [11:0] macData_MPORT_addr; // @[MacReceive.scala 56:28]
  wire  macData_MPORT_mask; // @[MacReceive.scala 56:28]
  wire  macData_MPORT_en; // @[MacReceive.scala 56:28]
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
  reg [7:0] macType_0; // @[MacReceive.scala 47:20]
  reg [7:0] macType_1; // @[MacReceive.scala 47:20]
  reg [10:0] cnt_value; // @[Counter.scala 60:40]
  reg [3:0] inStateReg; // @[MacReceive.scala 52:27]
  reg [11:0] macDataWriteAddress; // @[MacReceive.scala 57:32]
  reg [11:0] macDataReadAddress; // @[MacReceive.scala 61:31]
  wire  _macDataWriteEnable_T = inStateReg == 4'h5; // @[MacReceive.scala 184:36]
  reg [2:0] outStateReg; // @[MacReceive.scala 187:28]
  wire  macDataReadEnable = outStateReg == 3'h1; // @[MacReceive.scala 207:36]
  reg [11:0] inStartAddress; // @[MacReceive.scala 77:31]
  reg [11:0] inEndAddress; // @[MacReceive.scala 78:29]
  wire [24:0] _inMetaFifoIf_bits_T = {1'h0,inStartAddress,inEndAddress}; // @[Cat.scala 30:58]
  wire [31:0] _inMetaFifoIf_bits_WIRE_1 = {{7'd0}, _inMetaFifoIf_bits_T};
  wire [31:0] _metaInfo_T = {metaFifo_io_deq_bits_info,metaFifo_io_deq_bits_startAddress,metaFifo_io_deq_bits_endAddress
    }; // @[MacReceive.scala 81:40]
  wire [11:0] metaInfo_endAddress = _metaInfo_T[11:0]; // @[MacReceive.scala 81:40]
  wire [11:0] metaInfo_startAddress = _metaInfo_T[23:12]; // @[MacReceive.scala 81:40]
  wire  _outStartAddress_T = metaFifo_io_deq_ready & metaFifo_io_deq_valid; // @[Decoupled.scala 40:37]
  reg [11:0] outEndAddress; // @[Reg.scala 15:16]
  wire  _T = 4'h0 == inStateReg; // @[Conditional.scala 37:30]
  wire  _T_2 = io_rx_valid & io_rx_bits == 8'h55; // @[MacReceive.scala 143:21]
  wire  wrap = cnt_value == 11'h5db; // @[Counter.scala 72:24]
  wire [10:0] _value_T_1 = cnt_value + 11'h1; // @[Counter.scala 76:24]
  wire [10:0] _GEN_11 = wrap ? 11'h0 : _value_T_1; // @[Counter.scala 86:20 Counter.scala 86:28 Counter.scala 76:15]
  wire  _T_3 = 4'h1 == inStateReg; // @[Conditional.scala 37:30]
  wire [7:0] _GEN_22 = 3'h7 == cnt_value[2:0] ? 8'hd5 : 8'h55; // @[MacReceive.scala 88:46 MacReceive.scala 88:46]
  wire  _T_7 = cnt_value == 11'h7; // @[MacReceive.scala 94:21]
  wire  _T_8 = 4'h2 == inStateReg; // @[Conditional.scala 37:30]
  wire [7:0] _GEN_30 = 3'h1 == cnt_value[2:0] ? 8'h34 : 8'h12; // @[MacReceive.scala 88:46 MacReceive.scala 88:46]
  wire [7:0] _GEN_31 = 3'h2 == cnt_value[2:0] ? 8'h55 : _GEN_30; // @[MacReceive.scala 88:46 MacReceive.scala 88:46]
  wire [7:0] _GEN_32 = 3'h3 == cnt_value[2:0] ? 8'haa : _GEN_31; // @[MacReceive.scala 88:46 MacReceive.scala 88:46]
  wire [7:0] _GEN_33 = 3'h4 == cnt_value[2:0] ? 8'hff : _GEN_32; // @[MacReceive.scala 88:46 MacReceive.scala 88:46]
  wire [7:0] _GEN_34 = 3'h5 == cnt_value[2:0] ? 8'h0 : _GEN_33; // @[MacReceive.scala 88:46 MacReceive.scala 88:46]
  wire [10:0] _GEN_42 = io_rx_valid & (io_rx_bits == _GEN_34 | io_rx_bits == 8'hff) ? _GEN_11 : 11'h0; // @[MacReceive.scala 88:80 Counter.scala 97:11]
  wire [3:0] _GEN_43 = io_rx_valid & (io_rx_bits == _GEN_34 | io_rx_bits == 8'hff) ? inStateReg : 4'h0; // @[MacReceive.scala 88:80 MacReceive.scala 52:27 MacReceive.scala 92:18]
  wire  _T_15 = cnt_value == 11'h5; // @[MacReceive.scala 94:21]
  wire  _T_16 = 4'h3 == inStateReg; // @[Conditional.scala 37:30]
  wire [10:0] _GEN_48 = _T_15 ? 11'h0 : _GEN_11; // @[MacReceive.scala 124:39 Counter.scala 97:11]
  wire [3:0] _GEN_50 = _T_15 ? 4'h4 : inStateReg; // @[MacReceive.scala 124:39 MacReceive.scala 127:22 MacReceive.scala 52:27]
  wire [10:0] _GEN_51 = io_rx_valid ? _GEN_48 : 11'h0; // @[MacReceive.scala 122:21 Counter.scala 97:11]
  wire  _GEN_52 = io_rx_valid & _T_15; // @[MacReceive.scala 122:21 MacReceive.scala 54:14]
  wire [3:0] _GEN_53 = io_rx_valid ? _GEN_50 : 4'h0; // @[MacReceive.scala 122:21 MacReceive.scala 131:20]
  wire  _T_18 = 4'h4 == inStateReg; // @[Conditional.scala 37:30]
  wire [7:0] _GEN_54 = io_rx_valid & 11'h0 == cnt_value ? io_rx_bits : macType_1; // @[MacReceive.scala 103:42 MacReceive.scala 104:33 MacReceive.scala 47:20]
  wire [7:0] _GEN_55 = io_rx_valid & 11'h1 == cnt_value ? io_rx_bits : macType_0; // @[MacReceive.scala 103:42 MacReceive.scala 104:33 MacReceive.scala 47:20]
  wire  _T_23 = cnt_value == 11'h1; // @[MacReceive.scala 109:22]
  wire [10:0] _GEN_57 = cnt_value == 11'h1 ? 11'h0 : _GEN_11; // @[MacReceive.scala 109:44 Counter.scala 97:11]
  wire [3:0] _GEN_59 = cnt_value == 11'h1 ? 4'h5 : inStateReg; // @[MacReceive.scala 109:44 MacReceive.scala 112:20 MacReceive.scala 52:27]
  wire [10:0] _GEN_60 = io_rx_valid ? _GEN_57 : 11'h0; // @[MacReceive.scala 107:20 Counter.scala 97:11]
  wire  _GEN_61 = io_rx_valid & _T_23; // @[MacReceive.scala 107:20 MacReceive.scala 54:14]
  wire [3:0] _GEN_62 = io_rx_valid ? _GEN_59 : 4'h0; // @[MacReceive.scala 107:20 MacReceive.scala 116:18]
  wire  _T_24 = 4'h5 == inStateReg; // @[Conditional.scala 37:30]
  wire  _T_25 = ~io_rx_valid; // @[MacReceive.scala 134:13]
  wire [3:0] _GEN_64 = ~io_rx_valid ? 4'h6 : inStateReg; // @[MacReceive.scala 134:23 MacReceive.scala 136:20 MacReceive.scala 52:27]
  wire  _T_26 = 4'h6 == inStateReg; // @[Conditional.scala 37:30]
  wire [3:0] _GEN_65 = _T_26 ? 4'h0 : inStateReg; // @[Conditional.scala 39:67 MacReceive.scala 165:18 MacReceive.scala 52:27]
  wire  _GEN_66 = _T_24 & _T_25; // @[Conditional.scala 39:67 MacReceive.scala 54:14]
  wire [3:0] _GEN_67 = _T_24 ? _GEN_64 : _GEN_65; // @[Conditional.scala 39:67]
  wire [7:0] _GEN_68 = _T_18 ? _GEN_54 : macType_1; // @[Conditional.scala 39:67 MacReceive.scala 47:20]
  wire [7:0] _GEN_69 = _T_18 ? _GEN_55 : macType_0; // @[Conditional.scala 39:67 MacReceive.scala 47:20]
  wire [10:0] _GEN_70 = _T_18 ? _GEN_60 : cnt_value; // @[Conditional.scala 39:67 Counter.scala 60:40]
  wire  _GEN_71 = _T_18 ? _GEN_61 : _GEN_66; // @[Conditional.scala 39:67]
  wire [3:0] _GEN_72 = _T_18 ? _GEN_62 : _GEN_67; // @[Conditional.scala 39:67]
  wire  _GEN_74 = _T_16 ? _GEN_52 : _GEN_71; // @[Conditional.scala 39:67]
  wire  _GEN_80 = _T_8 ? _T_15 : _GEN_74; // @[Conditional.scala 39:67]
  wire  _GEN_85 = _T_3 ? _T_7 : _GEN_80; // @[Conditional.scala 39:67]
  wire  stateShift = _T ? _T_2 : _GEN_85; // @[Conditional.scala 40:58]
  wire [11:0] _macDataWriteAddress_T_1 = inEndAddress + 12'h1; // @[MacReceive.scala 170:41]
  wire [11:0] _macDataWriteAddress_T_3 = macDataWriteAddress + 12'h1; // @[MacReceive.scala 174:48]
  wire [11:0] _lo_T_3 = macDataWriteAddress - 12'h1; // @[MacReceive.scala 175:61]
  wire  _T_30 = inStateReg == 4'h6; // @[MacReceive.scala 177:20]
  wire [15:0] _T_31 = {macType_1,macType_0}; // @[MacReceive.scala 182:23]
  wire  _T_32 = _T_31 == 16'h800; // @[MacReceive.scala 182:26]
  wire  _T_33 = 3'h0 == outStateReg; // @[Conditional.scala 37:30]
  wire  _T_35 = 3'h1 == outStateReg; // @[Conditional.scala 37:30]
  wire [11:0] _macDataReadAddress_T_1 = macDataReadAddress + 12'h1; // @[MacReceive.scala 196:48]
  wire  _T_37 = 3'h2 == outStateReg; // @[Conditional.scala 37:30]
  reg  io_mac2IpIf_arpData_valid_REG; // @[MacReceive.scala 210:39]
  reg  io_mac2IpIf_ipData_valid_REG; // @[MacReceive.scala 212:38]
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
  assign macData_macDataReadData_MPORT_data = macData[macData_macDataReadData_MPORT_addr]; // @[MacReceive.scala 56:28]
  assign macData_MPORT_data = io_rx_bits;
  assign macData_MPORT_addr = macDataWriteAddress;
  assign macData_MPORT_mask = 1'h1;
  assign macData_MPORT_en = _macDataWriteEnable_T & io_rx_valid;
  assign io_mac2IpIf_arpData_valid = io_mac2IpIf_arpData_valid_REG; // @[MacReceive.scala 210:29]
  assign io_mac2IpIf_arpData_bits = macData_macDataReadData_MPORT_data; // @[MacReceive.scala 62:29 MacReceive.scala 66:19]
  assign io_mac2IpIf_ipData_valid = io_mac2IpIf_ipData_valid_REG; // @[MacReceive.scala 212:28]
  assign io_mac2IpIf_ipData_bits = macData_macDataReadData_MPORT_data; // @[MacReceive.scala 62:29 MacReceive.scala 66:19]
  assign io_debugPort_rxValid = io_rx_valid; // @[MacReceive.scala 216:24]
  assign io_debugPort_rxData = io_rx_bits; // @[MacReceive.scala 217:23]
  assign io_debugPort_state = {{4'd0}, inStateReg}; // @[MacReceive.scala 214:22]
  assign io_debugPort_cnt = cnt_value[7:0]; // @[MacReceive.scala 215:20]
  assign io_debugPort_macType = {macType_1,macType_0}; // @[MacReceive.scala 218:43]
  assign io_debugPort_macWriteEnable = inStateReg == 4'h5 & io_rx_valid; // @[MacReceive.scala 184:46]
  assign io_debugPort_macWriteAddress = macDataWriteAddress; // @[MacReceive.scala 220:32]
  assign io_debugPort_macWriteData = io_rx_bits; // @[MacReceive.scala 59:30 MacReceive.scala 67:20]
  assign io_debugPort_macReadEnable = outStateReg == 3'h1; // @[MacReceive.scala 207:36]
  assign io_debugPort_macReadAddress = macDataReadAddress; // @[MacReceive.scala 226:31]
  assign io_debugPort_macReadData = macData_macDataReadData_MPORT_data; // @[MacReceive.scala 62:29 MacReceive.scala 66:19]
  assign io_debugPort_arpTxValid = io_mac2IpIf_arpData_valid; // @[MacReceive.scala 231:27]
  assign io_debugPort_arpTxData = io_mac2IpIf_arpData_bits; // @[MacReceive.scala 232:26]
  assign io_debugPort_ipTxValid = io_mac2IpIf_ipData_valid; // @[MacReceive.scala 233:26]
  assign io_debugPort_ipTxData = io_mac2IpIf_ipData_bits; // @[MacReceive.scala 234:25]
  assign io_debugPort_fifoInValid = _T_31 == 16'h800 ? 1'h0 : _T_30; // @[MacReceive.scala 182:41 MacReceive.scala 182:62]
  assign io_debugPort_fifoInStart = inStartAddress; // @[MacReceive.scala 223:28]
  assign io_debugPort_fifoInEnd = inEndAddress; // @[MacReceive.scala 224:26]
  assign io_debugPort_fifoOutFire = metaFifo_io_deq_ready & metaFifo_io_deq_valid; // @[Decoupled.scala 40:37]
  assign io_debugPort_fifoOutStart = _metaInfo_T[23:12]; // @[MacReceive.scala 81:40]
  assign io_debugPort_fifoOutEnd = _metaInfo_T[11:0]; // @[MacReceive.scala 81:40]
  assign metaFifo_clock = clock;
  assign metaFifo_reset = reset;
  assign metaFifo_io_enq_valid = _T_31 == 16'h800 ? 1'h0 : _T_30; // @[MacReceive.scala 182:41 MacReceive.scala 182:62]
  assign metaFifo_io_enq_bits_info = _inMetaFifoIf_bits_WIRE_1[31:24]; // @[MacReceive.scala 80:71]
  assign metaFifo_io_enq_bits_startAddress = _inMetaFifoIf_bits_WIRE_1[23:12]; // @[MacReceive.scala 80:71]
  assign metaFifo_io_enq_bits_endAddress = _inMetaFifoIf_bits_WIRE_1[11:0]; // @[MacReceive.scala 80:71]
  assign metaFifo_io_deq_ready = outStateReg == 3'h0; // @[MacReceive.scala 206:33]
  always @(posedge clock) begin
    if(macData_MPORT_en & macData_MPORT_mask) begin
      macData[macData_MPORT_addr] <= macData_MPORT_data; // @[MacReceive.scala 56:28]
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
    if (_macDataWriteEnable_T) begin // @[MacReceive.scala 173:31]
      macDataWriteAddress <= _macDataWriteAddress_T_3; // @[MacReceive.scala 174:25]
    end else if (inStateReg == 4'h4 & stateShift) begin // @[MacReceive.scala 169:45]
      macDataWriteAddress <= _macDataWriteAddress_T_1; // @[MacReceive.scala 170:25]
    end
    if (_T_33) begin // @[Conditional.scala 40:58]
      if (_outStartAddress_T) begin // @[MacReceive.scala 190:30]
        macDataReadAddress <= metaInfo_startAddress; // @[MacReceive.scala 192:28]
      end
    end else if (_T_35) begin // @[Conditional.scala 39:67]
      macDataReadAddress <= _macDataReadAddress_T_1; // @[MacReceive.scala 196:26]
    end
    if (_outStartAddress_T) begin // @[Reg.scala 16:19]
      outEndAddress <= metaInfo_endAddress; // @[Reg.scala 16:23]
    end
    io_mac2IpIf_arpData_valid_REG <= macDataReadEnable & _T_31 == 16'h806; // @[MacReceive.scala 210:62]
    io_mac2IpIf_ipData_valid_REG <= macDataReadEnable & _T_32; // @[MacReceive.scala 212:61]
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
  assign macReceive_clock = pll_clk_125;
  assign macReceive_reset = ~reset_n; // @[NetStack.scala 18:55]
  assign macReceive_io_rx_valid = rgmiiTransfer_io_rx_valid; // @[NetStack.scala 26:25]
  assign macReceive_io_rx_bits = rgmiiTransfer_io_rx_bits; // @[NetStack.scala 26:25]
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
