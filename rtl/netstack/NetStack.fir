;buildInfoPackage: chisel3, version: 3.4.2, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit NetStack : 
  extmodule FpgaPll : 
    input clk_in : Clock
    input reset : Reset
    output clk_100 : Clock
    output clk_125 : Clock
    output clk_200 : Clock
    output clk_250 : Clock
    output locked : UInt<1>
    
    defname = FpgaPll
    
    
  extmodule FpgaFifo : 
    input wr_clk : Clock
    input rd_clk : Clock
    input din : UInt<4>
    input wr_en : UInt<1>
    input rd_en : UInt<1>
    output dout : UInt<4>
    output full : UInt<1>
    output almost_full : UInt<1>
    output empty : UInt<1>
    output almost_empty : UInt<1>
    
    defname = FpgaFifo
    
    
  extmodule FpgaFifo_1 : 
    input wr_clk : Clock
    input rd_clk : Clock
    input din : UInt<4>
    input wr_en : UInt<1>
    input rd_en : UInt<1>
    output dout : UInt<4>
    output full : UInt<1>
    output almost_full : UInt<1>
    output empty : UInt<1>
    output almost_empty : UInt<1>
    
    defname = FpgaFifo
    
    
  module RgmiiTransfer : 
    input clock : Clock
    input reset : Reset
    output io : {rgmii : {txClock : UInt<1>, txData : UInt<4>, txCtrl : UInt<1>, flip rxClock : UInt<1>, flip rxData : UInt<4>, flip rxCtrl : UInt<1>, ereset : UInt<1>}, rx : {valid : UInt<1>, bits : UInt<8>}, flip tx : {valid : UInt<1>, bits : UInt<8>}}
    
    io.tx.bits is invalid @[RgmiiTransfer.scala 16:6]
    io.tx.valid is invalid @[RgmiiTransfer.scala 16:6]
    io.rx.bits is invalid @[RgmiiTransfer.scala 16:6]
    io.rx.valid is invalid @[RgmiiTransfer.scala 16:6]
    io.rgmii.ereset is invalid @[RgmiiTransfer.scala 16:6]
    io.rgmii.rxCtrl is invalid @[RgmiiTransfer.scala 16:6]
    io.rgmii.rxData is invalid @[RgmiiTransfer.scala 16:6]
    io.rgmii.rxClock is invalid @[RgmiiTransfer.scala 16:6]
    io.rgmii.txCtrl is invalid @[RgmiiTransfer.scala 16:6]
    io.rgmii.txData is invalid @[RgmiiTransfer.scala 16:6]
    io.rgmii.txClock is invalid @[RgmiiTransfer.scala 16:6]
    node rxClockN = eq(io.rgmii.rxClock, UInt<1>("h00")) @[RgmiiTransfer.scala 18:18]
    inst topHalfFifo of FpgaFifo @[RgmiiTransfer.scala 19:27]
    topHalfFifo.almost_empty is invalid
    topHalfFifo.empty is invalid
    topHalfFifo.almost_full is invalid
    topHalfFifo.full is invalid
    topHalfFifo.dout is invalid
    topHalfFifo.rd_en is invalid
    topHalfFifo.wr_en is invalid
    topHalfFifo.din is invalid
    topHalfFifo.rd_clk is invalid
    topHalfFifo.wr_clk is invalid
    inst bottomHalfFifo of FpgaFifo_1 @[RgmiiTransfer.scala 20:30]
    bottomHalfFifo.almost_empty is invalid
    bottomHalfFifo.empty is invalid
    bottomHalfFifo.almost_full is invalid
    bottomHalfFifo.full is invalid
    bottomHalfFifo.dout is invalid
    bottomHalfFifo.rd_en is invalid
    bottomHalfFifo.wr_en is invalid
    bottomHalfFifo.din is invalid
    bottomHalfFifo.rd_clk is invalid
    bottomHalfFifo.wr_clk is invalid
    node _topHalfFifo_io_wr_clk_T = asClock(rxClockN) @[RgmiiTransfer.scala 22:44]
    topHalfFifo.wr_clk <= _topHalfFifo_io_wr_clk_T @[RgmiiTransfer.scala 22:25]
    node _T = asClock(io.rgmii.rxClock) @[RgmiiTransfer.scala 23:37]
    reg topHalfFifo_io_wr_en_REG : UInt<1>, _T @[RgmiiTransfer.scala 24:36]
    topHalfFifo_io_wr_en_REG <= io.rgmii.rxCtrl @[RgmiiTransfer.scala 24:36]
    topHalfFifo.wr_en <= topHalfFifo_io_wr_en_REG @[RgmiiTransfer.scala 24:26]
    topHalfFifo.din <= io.rgmii.rxData @[RgmiiTransfer.scala 26:22]
    topHalfFifo.rd_clk <= clock @[RgmiiTransfer.scala 27:25]
    topHalfFifo.rd_en <= io.rx.valid @[RgmiiTransfer.scala 28:24]
    node _bottomHalfFifo_io_wr_clk_T = asClock(io.rgmii.rxClock) @[RgmiiTransfer.scala 30:55]
    bottomHalfFifo.wr_clk <= _bottomHalfFifo_io_wr_clk_T @[RgmiiTransfer.scala 30:28]
    bottomHalfFifo.wr_en <= io.rgmii.rxCtrl @[RgmiiTransfer.scala 31:27]
    bottomHalfFifo.din <= io.rgmii.rxData @[RgmiiTransfer.scala 32:25]
    bottomHalfFifo.rd_clk <= clock @[RgmiiTransfer.scala 33:28]
    bottomHalfFifo.rd_en <= io.rx.valid @[RgmiiTransfer.scala 34:27]
    node _notEmpty_T = eq(topHalfFifo.empty, UInt<1>("h00")) @[RgmiiTransfer.scala 36:18]
    node _notEmpty_T_1 = eq(bottomHalfFifo.empty, UInt<1>("h00")) @[RgmiiTransfer.scala 36:43]
    node notEmpty = and(_notEmpty_T, _notEmpty_T_1) @[RgmiiTransfer.scala 36:40]
    reg io_rx_valid_REG : UInt<1>, clock @[RgmiiTransfer.scala 37:25]
    io_rx_valid_REG <= notEmpty @[RgmiiTransfer.scala 37:25]
    node _io_rx_valid_T = and(io_rx_valid_REG, notEmpty) @[RgmiiTransfer.scala 37:36]
    io.rx.valid <= _io_rx_valid_T @[RgmiiTransfer.scala 37:15]
    node _io_rx_bits_T = cat(topHalfFifo.dout, bottomHalfFifo.dout) @[Cat.scala 30:58]
    io.rx.bits <= _io_rx_bits_T @[RgmiiTransfer.scala 38:14]
    
  module Queue : 
    input clock : Clock
    input reset : Reset
    output io : {flip enq : {flip ready : UInt<1>, valid : UInt<1>, bits : {startAddress : UInt<12>, endAddress : UInt<12>, info : UInt<8>}}, deq : {flip ready : UInt<1>, valid : UInt<1>, bits : {startAddress : UInt<12>, endAddress : UInt<12>, info : UInt<8>}}, count : UInt<6>}
    
    cmem ram : {startAddress : UInt<12>, endAddress : UInt<12>, info : UInt<8>}[32] @[Decoupled.scala 218:16]
    reg value : UInt<5>, clock with : (reset => (reset, UInt<5>("h00"))) @[Counter.scala 60:40]
    reg value_1 : UInt<5>, clock with : (reset => (reset, UInt<5>("h00"))) @[Counter.scala 60:40]
    reg maybe_full : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[Decoupled.scala 221:27]
    node ptr_match = eq(value, value_1) @[Decoupled.scala 223:33]
    node _empty_T = eq(maybe_full, UInt<1>("h00")) @[Decoupled.scala 224:28]
    node empty = and(ptr_match, _empty_T) @[Decoupled.scala 224:25]
    node full = and(ptr_match, maybe_full) @[Decoupled.scala 225:24]
    node _do_enq_T = and(io.enq.ready, io.enq.valid) @[Decoupled.scala 40:37]
    wire do_enq : UInt<1>
    do_enq <= _do_enq_T
    node _do_deq_T = and(io.deq.ready, io.deq.valid) @[Decoupled.scala 40:37]
    wire do_deq : UInt<1>
    do_deq <= _do_deq_T
    when do_enq : @[Decoupled.scala 229:17]
      infer mport MPORT = ram[value], clock @[Decoupled.scala 230:8]
      MPORT.info <= io.enq.bits.info @[Decoupled.scala 230:24]
      MPORT.endAddress <= io.enq.bits.endAddress @[Decoupled.scala 230:24]
      MPORT.startAddress <= io.enq.bits.startAddress @[Decoupled.scala 230:24]
      node wrap = eq(value, UInt<5>("h01f")) @[Counter.scala 72:24]
      node _value_T = add(value, UInt<1>("h01")) @[Counter.scala 76:24]
      node _value_T_1 = tail(_value_T, 1) @[Counter.scala 76:24]
      value <= _value_T_1 @[Counter.scala 76:15]
      skip @[Decoupled.scala 229:17]
    when do_deq : @[Decoupled.scala 233:17]
      node wrap_1 = eq(value_1, UInt<5>("h01f")) @[Counter.scala 72:24]
      node _value_T_2 = add(value_1, UInt<1>("h01")) @[Counter.scala 76:24]
      node _value_T_3 = tail(_value_T_2, 1) @[Counter.scala 76:24]
      value_1 <= _value_T_3 @[Counter.scala 76:15]
      skip @[Decoupled.scala 233:17]
    node _T = neq(do_enq, do_deq) @[Decoupled.scala 236:16]
    when _T : @[Decoupled.scala 236:28]
      maybe_full <= do_enq @[Decoupled.scala 237:16]
      skip @[Decoupled.scala 236:28]
    node _io_deq_valid_T = eq(empty, UInt<1>("h00")) @[Decoupled.scala 240:19]
    io.deq.valid <= _io_deq_valid_T @[Decoupled.scala 240:16]
    node _io_enq_ready_T = eq(full, UInt<1>("h00")) @[Decoupled.scala 241:19]
    io.enq.ready <= _io_enq_ready_T @[Decoupled.scala 241:16]
    infer mport io_deq_bits_MPORT = ram[value_1], clock @[Decoupled.scala 242:21]
    io.deq.bits.info <= io_deq_bits_MPORT.info @[Decoupled.scala 242:15]
    io.deq.bits.endAddress <= io_deq_bits_MPORT.endAddress @[Decoupled.scala 242:15]
    io.deq.bits.startAddress <= io_deq_bits_MPORT.startAddress @[Decoupled.scala 242:15]
    node _ptr_diff_T = sub(value, value_1) @[Decoupled.scala 257:32]
    node ptr_diff = tail(_ptr_diff_T, 1) @[Decoupled.scala 257:32]
    node _io_count_T = and(maybe_full, ptr_match) @[Decoupled.scala 259:32]
    node _io_count_T_1 = mux(_io_count_T, UInt<6>("h020"), UInt<1>("h00")) @[Decoupled.scala 259:20]
    node _io_count_T_2 = or(_io_count_T_1, ptr_diff) @[Decoupled.scala 259:62]
    io.count <= _io_count_T_2 @[Decoupled.scala 259:14]
    
  module MacReceive : 
    input clock : Clock
    input reset : Reset
    output io : {flip rx : {valid : UInt<1>, bits : UInt<8>}, mac2IpIf : {arpData : {valid : UInt<1>, bits : UInt<8>}, ipData : {valid : UInt<1>, bits : UInt<8>}}, mac2CrcIf : {crcData : {valid : UInt<1>, bits : UInt<8>}, flip crcDone : UInt<1>, flip crcErr : UInt<1>}, debugPort : {rxValid : UInt<1>, rxData : UInt<8>, state : UInt<8>, cnt : UInt<8>, macType : UInt<16>}}
    
    io.debugPort.macType is invalid @[MacReceive.scala 25:6]
    io.debugPort.cnt is invalid @[MacReceive.scala 25:6]
    io.debugPort.state is invalid @[MacReceive.scala 25:6]
    io.debugPort.rxData is invalid @[MacReceive.scala 25:6]
    io.debugPort.rxValid is invalid @[MacReceive.scala 25:6]
    io.mac2CrcIf.crcErr is invalid @[MacReceive.scala 25:6]
    io.mac2CrcIf.crcDone is invalid @[MacReceive.scala 25:6]
    io.mac2CrcIf.crcData.bits is invalid @[MacReceive.scala 25:6]
    io.mac2CrcIf.crcData.valid is invalid @[MacReceive.scala 25:6]
    io.mac2IpIf.ipData.bits is invalid @[MacReceive.scala 25:6]
    io.mac2IpIf.ipData.valid is invalid @[MacReceive.scala 25:6]
    io.mac2IpIf.arpData.bits is invalid @[MacReceive.scala 25:6]
    io.mac2IpIf.arpData.valid is invalid @[MacReceive.scala 25:6]
    io.rx.bits is invalid @[MacReceive.scala 25:6]
    io.rx.valid is invalid @[MacReceive.scala 25:6]
    wire preamble : UInt<8>[8] @[MacReceive.scala 27:60]
    preamble[0] <= UInt<7>("h055") @[MacReceive.scala 27:60]
    preamble[1] <= UInt<7>("h055") @[MacReceive.scala 27:60]
    preamble[2] <= UInt<7>("h055") @[MacReceive.scala 27:60]
    preamble[3] <= UInt<7>("h055") @[MacReceive.scala 27:60]
    preamble[4] <= UInt<7>("h055") @[MacReceive.scala 27:60]
    preamble[5] <= UInt<7>("h055") @[MacReceive.scala 27:60]
    preamble[6] <= UInt<7>("h055") @[MacReceive.scala 27:60]
    preamble[7] <= UInt<8>("h0d5") @[MacReceive.scala 27:60]
    wire macAddress : UInt<8>[6] @[MacReceive.scala 28:61]
    macAddress[0] <= UInt<5>("h012") @[MacReceive.scala 28:61]
    macAddress[1] <= UInt<6>("h034") @[MacReceive.scala 28:61]
    macAddress[2] <= UInt<7>("h055") @[MacReceive.scala 28:61]
    macAddress[3] <= UInt<8>("h0aa") @[MacReceive.scala 28:61]
    macAddress[4] <= UInt<8>("h0ff") @[MacReceive.scala 28:61]
    macAddress[5] <= UInt<1>("h00") @[MacReceive.scala 28:61]
    wire broadMacAddress : UInt<8>[6] @[MacReceive.scala 29:68]
    broadMacAddress[0] <= UInt<8>("h0ff") @[MacReceive.scala 29:68]
    broadMacAddress[1] <= UInt<8>("h0ff") @[MacReceive.scala 29:68]
    broadMacAddress[2] <= UInt<8>("h0ff") @[MacReceive.scala 29:68]
    broadMacAddress[3] <= UInt<8>("h0ff") @[MacReceive.scala 29:68]
    broadMacAddress[4] <= UInt<8>("h0ff") @[MacReceive.scala 29:68]
    broadMacAddress[5] <= UInt<8>("h0ff") @[MacReceive.scala 29:68]
    reg macType : UInt<8>[2], clock @[MacReceive.scala 31:20]
    reg cnt_value : UInt<11>, clock with : (reset => (reset, UInt<11>("h00"))) @[Counter.scala 60:40]
    reg stateReg : UInt<4>, clock with : (reset => (reset, UInt<4>("h00"))) @[MacReceive.scala 36:25]
    wire stateShift : UInt<1> @[MacReceive.scala 37:24]
    stateShift <= UInt<1>("h00") @[MacReceive.scala 38:14]
    smem macData : UInt<8>[4096], undefined @[MacReceive.scala 40:28]
    reg macDataWriteAddress : UInt<12>, clock @[MacReceive.scala 41:32]
    wire macDataWriteEnable : UInt<1> @[MacReceive.scala 42:32]
    wire macDataWriteData : UInt<8> @[MacReceive.scala 43:30]
    wire macDataReadEnable : UInt<1> @[MacReceive.scala 44:31]
    reg macDataReadAddress : UInt<12>, clock @[MacReceive.scala 45:31]
    wire macDataReadData : UInt<8> @[MacReceive.scala 46:29]
    macDataWriteEnable <= UInt<1>("h00") @[MacReceive.scala 47:22]
    macDataReadEnable <= UInt<1>("h00") @[MacReceive.scala 48:21]
    when macDataWriteEnable : @[MacReceive.scala 49:29]
      write mport MPORT = macData[macDataWriteAddress], clock
      MPORT <= macDataWriteData
      skip @[MacReceive.scala 49:29]
    wire _macDataReadData_WIRE : UInt @[MacReceive.scala 50:34]
    _macDataReadData_WIRE is invalid @[MacReceive.scala 50:34]
    when macDataReadEnable : @[MacReceive.scala 50:34]
      _macDataReadData_WIRE <= macDataReadAddress @[MacReceive.scala 50:34]
      node _macDataReadData_T = or(_macDataReadData_WIRE, UInt<12>("h00")) @[MacReceive.scala 50:34]
      node _macDataReadData_T_1 = bits(_macDataReadData_T, 11, 0) @[MacReceive.scala 50:34]
      read mport macDataReadData_MPORT = macData[_macDataReadData_T_1], clock @[MacReceive.scala 50:34]
      skip @[MacReceive.scala 50:34]
    macDataReadData <= macDataReadData_MPORT @[MacReceive.scala 50:19]
    macDataWriteData <= io.rx.bits @[MacReceive.scala 51:20]
    wire inMetaFifoIf : {flip ready : UInt<1>, valid : UInt<1>, bits : {startAddress : UInt<12>, endAddress : UInt<12>, info : UInt<8>}} @[MacReceive.scala 59:26]
    inst metaFifo of Queue @[Decoupled.scala 296:21]
    metaFifo.clock <= clock
    metaFifo.reset <= reset
    metaFifo.io.enq.valid <= inMetaFifoIf.valid @[Decoupled.scala 297:22]
    metaFifo.io.enq.bits.info <= inMetaFifoIf.bits.info @[Decoupled.scala 298:21]
    metaFifo.io.enq.bits.endAddress <= inMetaFifoIf.bits.endAddress @[Decoupled.scala 298:21]
    metaFifo.io.enq.bits.startAddress <= inMetaFifoIf.bits.startAddress @[Decoupled.scala 298:21]
    inMetaFifoIf.ready <= metaFifo.io.enq.ready @[Decoupled.scala 299:17]
    reg inStartAddress : UInt<12>, clock with : (reset => (reset, UInt<12>("h00"))) @[MacReceive.scala 61:31]
    reg inEndAddress : UInt<12>, clock with : (reset => (reset, UInt<12>("h00"))) @[MacReceive.scala 62:29]
    inMetaFifoIf.valid <= UInt<1>("h00") @[MacReceive.scala 63:22]
    node inMetaFifoIf_bits_hi = cat(UInt<1>("h00"), inStartAddress) @[Cat.scala 30:58]
    node _inMetaFifoIf_bits_T = cat(inMetaFifoIf_bits_hi, inEndAddress) @[Cat.scala 30:58]
    wire _inMetaFifoIf_bits_WIRE : {startAddress : UInt<12>, endAddress : UInt<12>, info : UInt<8>} @[MacReceive.scala 64:71]
    wire _inMetaFifoIf_bits_WIRE_1 : UInt<32>
    _inMetaFifoIf_bits_WIRE_1 <= _inMetaFifoIf_bits_T
    node _inMetaFifoIf_bits_T_1 = bits(_inMetaFifoIf_bits_WIRE_1, 7, 0) @[MacReceive.scala 64:71]
    _inMetaFifoIf_bits_WIRE.info <= _inMetaFifoIf_bits_T_1 @[MacReceive.scala 64:71]
    node _inMetaFifoIf_bits_T_2 = bits(_inMetaFifoIf_bits_WIRE_1, 19, 8) @[MacReceive.scala 64:71]
    _inMetaFifoIf_bits_WIRE.endAddress <= _inMetaFifoIf_bits_T_2 @[MacReceive.scala 64:71]
    node _inMetaFifoIf_bits_T_3 = bits(_inMetaFifoIf_bits_WIRE_1, 31, 20) @[MacReceive.scala 64:71]
    _inMetaFifoIf_bits_WIRE.startAddress <= _inMetaFifoIf_bits_T_3 @[MacReceive.scala 64:71]
    inMetaFifoIf.bits.info <= _inMetaFifoIf_bits_WIRE.info @[MacReceive.scala 64:21]
    inMetaFifoIf.bits.endAddress <= _inMetaFifoIf_bits_WIRE.endAddress @[MacReceive.scala 64:21]
    inMetaFifoIf.bits.startAddress <= _inMetaFifoIf_bits_WIRE.startAddress @[MacReceive.scala 64:21]
    metaFifo.io.deq.ready <= UInt<1>("h01") @[MacReceive.scala 65:18]
    node _T = eq(UInt<4>("h00"), stateReg) @[Conditional.scala 37:30]
    when _T : @[Conditional.scala 40:58]
      node _T_1 = eq(io.rx.bits, preamble[0]) @[MacReceive.scala 125:31]
      node _T_2 = and(io.rx.valid, _T_1) @[MacReceive.scala 125:21]
      when _T_2 : @[MacReceive.scala 125:48]
        node wrap = eq(cnt_value, UInt<11>("h05db")) @[Counter.scala 72:24]
        node _value_T = add(cnt_value, UInt<1>("h01")) @[Counter.scala 76:24]
        node _value_T_1 = tail(_value_T, 1) @[Counter.scala 76:24]
        cnt_value <= _value_T_1 @[Counter.scala 76:15]
        when wrap : @[Counter.scala 86:20]
          cnt_value <= UInt<1>("h00") @[Counter.scala 86:28]
          skip @[Counter.scala 86:20]
        stateShift <= UInt<1>("h01") @[MacReceive.scala 127:20]
        stateReg <= UInt<4>("h01") @[MacReceive.scala 128:18]
        skip @[MacReceive.scala 125:48]
      skip @[Conditional.scala 40:58]
    else : @[Conditional.scala 39:67]
      node _T_3 = eq(UInt<4>("h01"), stateReg) @[Conditional.scala 37:30]
      when _T_3 : @[Conditional.scala 39:67]
        node _T_4 = bits(cnt_value, 2, 0)
        node _T_5 = eq(io.rx.bits, preamble[_T_4]) @[MacReceive.scala 70:46]
        node _T_6 = and(io.rx.valid, _T_5) @[MacReceive.scala 70:19]
        when _T_6 : @[MacReceive.scala 70:80]
          node wrap_1 = eq(cnt_value, UInt<11>("h05db")) @[Counter.scala 72:24]
          node _value_T_2 = add(cnt_value, UInt<1>("h01")) @[Counter.scala 76:24]
          node _value_T_3 = tail(_value_T_2, 1) @[Counter.scala 76:24]
          cnt_value <= _value_T_3 @[Counter.scala 76:15]
          when wrap_1 : @[Counter.scala 86:20]
            cnt_value <= UInt<1>("h00") @[Counter.scala 86:28]
            skip @[Counter.scala 86:20]
          skip @[MacReceive.scala 70:80]
        else : @[MacReceive.scala 72:7]
          cnt_value <= UInt<1>("h00") @[Counter.scala 97:11]
          stateReg <= UInt<4>("h00") @[MacReceive.scala 74:16]
          skip @[MacReceive.scala 72:7]
        node _T_7 = eq(cnt_value, UInt<3>("h07")) @[MacReceive.scala 76:21]
        when _T_7 : @[MacReceive.scala 76:38]
          cnt_value <= UInt<1>("h00") @[Counter.scala 97:11]
          stateShift <= UInt<1>("h01") @[MacReceive.scala 78:18]
          stateReg <= UInt<4>("h02") @[MacReceive.scala 79:16]
          skip @[MacReceive.scala 76:38]
        skip @[Conditional.scala 39:67]
      else : @[Conditional.scala 39:67]
        node _T_8 = eq(UInt<4>("h02"), stateReg) @[Conditional.scala 37:30]
        when _T_8 : @[Conditional.scala 39:67]
          node _T_9 = bits(cnt_value, 2, 0)
          node _T_10 = eq(io.rx.bits, macAddress[_T_9]) @[MacReceive.scala 70:46]
          node _T_11 = bits(cnt_value, 2, 0)
          node _T_12 = eq(io.rx.bits, broadMacAddress[_T_11]) @[MacReceive.scala 70:46]
          node _T_13 = or(_T_10, _T_12) @[MacReceive.scala 70:73]
          node _T_14 = and(io.rx.valid, _T_13) @[MacReceive.scala 70:19]
          when _T_14 : @[MacReceive.scala 70:80]
            node wrap_2 = eq(cnt_value, UInt<11>("h05db")) @[Counter.scala 72:24]
            node _value_T_4 = add(cnt_value, UInt<1>("h01")) @[Counter.scala 76:24]
            node _value_T_5 = tail(_value_T_4, 1) @[Counter.scala 76:24]
            cnt_value <= _value_T_5 @[Counter.scala 76:15]
            when wrap_2 : @[Counter.scala 86:20]
              cnt_value <= UInt<1>("h00") @[Counter.scala 86:28]
              skip @[Counter.scala 86:20]
            skip @[MacReceive.scala 70:80]
          else : @[MacReceive.scala 72:7]
            cnt_value <= UInt<1>("h00") @[Counter.scala 97:11]
            stateReg <= UInt<4>("h00") @[MacReceive.scala 74:16]
            skip @[MacReceive.scala 72:7]
          node _T_15 = eq(cnt_value, UInt<3>("h05")) @[MacReceive.scala 76:21]
          when _T_15 : @[MacReceive.scala 76:38]
            cnt_value <= UInt<1>("h00") @[Counter.scala 97:11]
            stateShift <= UInt<1>("h01") @[MacReceive.scala 78:18]
            stateReg <= UInt<4>("h03") @[MacReceive.scala 79:16]
            skip @[MacReceive.scala 76:38]
          skip @[Conditional.scala 39:67]
        else : @[Conditional.scala 39:67]
          node _T_16 = eq(UInt<4>("h03"), stateReg) @[Conditional.scala 37:30]
          when _T_16 : @[Conditional.scala 39:67]
            when io.rx.valid : @[MacReceive.scala 104:21]
              node wrap_3 = eq(cnt_value, UInt<11>("h05db")) @[Counter.scala 72:24]
              node _value_T_6 = add(cnt_value, UInt<1>("h01")) @[Counter.scala 76:24]
              node _value_T_7 = tail(_value_T_6, 1) @[Counter.scala 76:24]
              cnt_value <= _value_T_7 @[Counter.scala 76:15]
              when wrap_3 : @[Counter.scala 86:20]
                cnt_value <= UInt<1>("h00") @[Counter.scala 86:28]
                skip @[Counter.scala 86:20]
              node _T_17 = eq(cnt_value, UInt<3>("h05")) @[MacReceive.scala 106:24]
              when _T_17 : @[MacReceive.scala 106:39]
                cnt_value <= UInt<1>("h00") @[Counter.scala 97:11]
                stateShift <= UInt<1>("h01") @[MacReceive.scala 108:22]
                stateReg <= UInt<4>("h04") @[MacReceive.scala 109:20]
                skip @[MacReceive.scala 106:39]
              skip @[MacReceive.scala 104:21]
            else : @[MacReceive.scala 111:9]
              cnt_value <= UInt<1>("h00") @[Counter.scala 97:11]
              stateReg <= UInt<4>("h00") @[MacReceive.scala 113:18]
              skip @[MacReceive.scala 111:9]
            skip @[Conditional.scala 39:67]
          else : @[Conditional.scala 39:67]
            node _T_18 = eq(UInt<4>("h04"), stateReg) @[Conditional.scala 37:30]
            when _T_18 : @[Conditional.scala 39:67]
              node _T_19 = eq(UInt<1>("h00"), cnt_value) @[MacReceive.scala 85:27]
              node _T_20 = and(io.rx.valid, _T_19) @[MacReceive.scala 85:20]
              when _T_20 : @[MacReceive.scala 85:42]
                macType[UInt<1>("h01")] <= io.rx.bits @[MacReceive.scala 86:33]
                skip @[MacReceive.scala 85:42]
              node _T_21 = eq(UInt<1>("h01"), cnt_value) @[MacReceive.scala 85:27]
              node _T_22 = and(io.rx.valid, _T_21) @[MacReceive.scala 85:20]
              when _T_22 : @[MacReceive.scala 85:42]
                macType[UInt<1>("h00")] <= io.rx.bits @[MacReceive.scala 86:33]
                skip @[MacReceive.scala 85:42]
              when io.rx.valid : @[MacReceive.scala 89:20]
                node wrap_4 = eq(cnt_value, UInt<11>("h05db")) @[Counter.scala 72:24]
                node _value_T_8 = add(cnt_value, UInt<1>("h01")) @[Counter.scala 76:24]
                node _value_T_9 = tail(_value_T_8, 1) @[Counter.scala 76:24]
                cnt_value <= _value_T_9 @[Counter.scala 76:15]
                when wrap_4 : @[Counter.scala 86:20]
                  cnt_value <= UInt<1>("h00") @[Counter.scala 86:28]
                  skip @[Counter.scala 86:20]
                node _T_23 = eq(cnt_value, UInt<1>("h01")) @[MacReceive.scala 91:22]
                when _T_23 : @[MacReceive.scala 91:44]
                  cnt_value <= UInt<1>("h00") @[Counter.scala 97:11]
                  stateShift <= UInt<1>("h01") @[MacReceive.scala 93:20]
                  stateReg <= UInt<4>("h05") @[MacReceive.scala 94:18]
                  skip @[MacReceive.scala 91:44]
                skip @[MacReceive.scala 89:20]
              else : @[MacReceive.scala 96:7]
                cnt_value <= UInt<1>("h00") @[Counter.scala 97:11]
                stateReg <= UInt<4>("h00") @[MacReceive.scala 98:16]
                skip @[MacReceive.scala 96:7]
              skip @[Conditional.scala 39:67]
            else : @[Conditional.scala 39:67]
              node _T_24 = eq(UInt<4>("h05"), stateReg) @[Conditional.scala 37:30]
              when _T_24 : @[Conditional.scala 39:67]
                node _T_25 = eq(io.rx.valid, UInt<1>("h00")) @[MacReceive.scala 116:13]
                when _T_25 : @[MacReceive.scala 116:23]
                  stateShift <= UInt<1>("h01") @[MacReceive.scala 117:20]
                  stateReg <= UInt<4>("h06") @[MacReceive.scala 118:18]
                  skip @[MacReceive.scala 116:23]
                skip @[Conditional.scala 39:67]
              else : @[Conditional.scala 39:67]
                node _T_26 = eq(UInt<4>("h06"), stateReg) @[Conditional.scala 37:30]
                when _T_26 : @[Conditional.scala 39:67]
                  stateReg <= UInt<4>("h00") @[MacReceive.scala 147:16]
                  skip @[Conditional.scala 39:67]
    node _T_27 = eq(stateReg, UInt<4>("h04")) @[MacReceive.scala 151:18]
    node _T_28 = and(_T_27, stateShift) @[MacReceive.scala 151:28]
    when _T_28 : @[MacReceive.scala 151:43]
      macDataWriteAddress <= inEndAddress @[MacReceive.scala 152:25]
      inStartAddress <= inEndAddress @[MacReceive.scala 153:20]
      skip @[MacReceive.scala 151:43]
    node _T_29 = eq(stateReg, UInt<4>("h05")) @[MacReceive.scala 155:18]
    when _T_29 : @[MacReceive.scala 155:29]
      macDataWriteEnable <= UInt<1>("h01") @[MacReceive.scala 156:24]
      node _macDataWriteAddress_T = add(macDataWriteAddress, UInt<1>("h01")) @[MacReceive.scala 157:48]
      node _macDataWriteAddress_T_1 = tail(_macDataWriteAddress_T, 1) @[MacReceive.scala 157:48]
      macDataWriteAddress <= _macDataWriteAddress_T_1 @[MacReceive.scala 157:25]
      when stateShift : @[MacReceive.scala 158:23]
        inEndAddress <= macDataWriteAddress @[MacReceive.scala 158:38]
        skip @[MacReceive.scala 158:23]
      skip @[MacReceive.scala 155:29]
    node _T_30 = eq(stateReg, UInt<4>("h06")) @[MacReceive.scala 160:18]
    when _T_30 : @[MacReceive.scala 160:29]
      inMetaFifoIf.valid <= UInt<1>("h01") @[MacReceive.scala 161:24]
      skip @[MacReceive.scala 160:29]
    io.debugPort.state <= stateReg @[MacReceive.scala 164:22]
    io.debugPort.cnt <= cnt_value @[MacReceive.scala 165:20]
    io.debugPort.rxValid <= io.rx.valid @[MacReceive.scala 166:24]
    io.debugPort.rxData <= io.rx.bits @[MacReceive.scala 167:23]
    wire _io_debugPort_macType_WIRE : UInt<16> @[MacReceive.scala 168:43]
    node _io_debugPort_macType_T = cat(macType[1], macType[0]) @[MacReceive.scala 168:43]
    _io_debugPort_macType_WIRE <= _io_debugPort_macType_T @[MacReceive.scala 168:43]
    io.debugPort.macType <= _io_debugPort_macType_WIRE @[MacReceive.scala 168:24]
    
  module NetStack : 
    input clock : Clock
    input reset_n : UInt<1>
    output rgmii : {txClock : UInt<1>, txData : UInt<4>, txCtrl : UInt<1>, flip rxClock : UInt<1>, flip rxData : UInt<4>, flip rxCtrl : UInt<1>, ereset : UInt<1>}
    output led : UInt<4>
    
    node reset = eq(reset_n, UInt<1>("h00")) @[package.scala 12:17]
    inst pll of FpgaPll @[NetStack.scala 12:19]
    pll.locked is invalid
    pll.clk_250 is invalid
    pll.clk_200 is invalid
    pll.clk_125 is invalid
    pll.clk_100 is invalid
    pll.reset is invalid
    pll.clk_in is invalid
    pll.clk_in <= clock @[NetStack.scala 13:17]
    pll.reset <= reset @[NetStack.scala 14:16]
    rgmii.ereset is invalid @[NetStack.scala 16:9]
    rgmii.rxCtrl is invalid @[NetStack.scala 16:9]
    rgmii.rxData is invalid @[NetStack.scala 16:9]
    rgmii.rxClock is invalid @[NetStack.scala 16:9]
    rgmii.txCtrl is invalid @[NetStack.scala 16:9]
    rgmii.txData is invalid @[NetStack.scala 16:9]
    rgmii.txClock is invalid @[NetStack.scala 16:9]
    inst rgmiiTransfer of RgmiiTransfer @[NetStack.scala 19:31]
    rgmiiTransfer.clock <= pll.clk_125
    rgmiiTransfer.reset <= reset
    inst macReceive of MacReceive @[NetStack.scala 20:28]
    macReceive.clock <= pll.clk_125
    macReceive.reset <= reset
    rgmiiTransfer.io.tx.bits is invalid @[NetStack.scala 22:22]
    rgmiiTransfer.io.tx.valid is invalid @[NetStack.scala 22:22]
    rgmiiTransfer.io.rx.bits is invalid @[NetStack.scala 22:22]
    rgmiiTransfer.io.rx.valid is invalid @[NetStack.scala 22:22]
    rgmiiTransfer.io.rgmii.ereset is invalid @[NetStack.scala 22:22]
    rgmiiTransfer.io.rgmii.rxCtrl is invalid @[NetStack.scala 22:22]
    rgmiiTransfer.io.rgmii.rxData is invalid @[NetStack.scala 22:22]
    rgmiiTransfer.io.rgmii.rxClock is invalid @[NetStack.scala 22:22]
    rgmiiTransfer.io.rgmii.txCtrl is invalid @[NetStack.scala 22:22]
    rgmiiTransfer.io.rgmii.txData is invalid @[NetStack.scala 22:22]
    rgmiiTransfer.io.rgmii.txClock is invalid @[NetStack.scala 22:22]
    macReceive.io.debugPort.macType is invalid @[NetStack.scala 23:19]
    macReceive.io.debugPort.cnt is invalid @[NetStack.scala 23:19]
    macReceive.io.debugPort.state is invalid @[NetStack.scala 23:19]
    macReceive.io.debugPort.rxData is invalid @[NetStack.scala 23:19]
    macReceive.io.debugPort.rxValid is invalid @[NetStack.scala 23:19]
    macReceive.io.mac2CrcIf.crcErr is invalid @[NetStack.scala 23:19]
    macReceive.io.mac2CrcIf.crcDone is invalid @[NetStack.scala 23:19]
    macReceive.io.mac2CrcIf.crcData.bits is invalid @[NetStack.scala 23:19]
    macReceive.io.mac2CrcIf.crcData.valid is invalid @[NetStack.scala 23:19]
    macReceive.io.mac2IpIf.ipData.bits is invalid @[NetStack.scala 23:19]
    macReceive.io.mac2IpIf.ipData.valid is invalid @[NetStack.scala 23:19]
    macReceive.io.mac2IpIf.arpData.bits is invalid @[NetStack.scala 23:19]
    macReceive.io.mac2IpIf.arpData.valid is invalid @[NetStack.scala 23:19]
    macReceive.io.rx.bits is invalid @[NetStack.scala 23:19]
    macReceive.io.rx.valid is invalid @[NetStack.scala 23:19]
    rgmii.ereset <= rgmiiTransfer.io.rgmii.ereset @[NetStack.scala 25:28]
    rgmiiTransfer.io.rgmii.rxCtrl <= rgmii.rxCtrl @[NetStack.scala 25:28]
    rgmiiTransfer.io.rgmii.rxData <= rgmii.rxData @[NetStack.scala 25:28]
    rgmiiTransfer.io.rgmii.rxClock <= rgmii.rxClock @[NetStack.scala 25:28]
    rgmii.txCtrl <= rgmiiTransfer.io.rgmii.txCtrl @[NetStack.scala 25:28]
    rgmii.txData <= rgmiiTransfer.io.rgmii.txData @[NetStack.scala 25:28]
    rgmii.txClock <= rgmiiTransfer.io.rgmii.txClock @[NetStack.scala 25:28]
    macReceive.io.rx.bits <= rgmiiTransfer.io.rx.bits @[NetStack.scala 26:25]
    macReceive.io.rx.valid <= rgmiiTransfer.io.rx.valid @[NetStack.scala 26:25]
    rgmii.ereset <= reset_n @[NetStack.scala 32:16]
    reg led_lo : UInt<1>, pll.clk_100 with : (reset => (reset, UInt<1>("h00"))) @[NetStack.scala 34:25]
    reg done_value : UInt<26>, pll.clk_100 with : (reset => (reset, UInt<26>("h00"))) @[Counter.scala 60:40]
    wire done : UInt<1>
    done <= UInt<1>("h00")
    when UInt<1>("h01") : @[Counter.scala 118:17]
      node done_wrap_wrap = eq(done_value, UInt<26>("h02faf07f")) @[Counter.scala 72:24]
      node _done_wrap_value_T = add(done_value, UInt<1>("h01")) @[Counter.scala 76:24]
      node _done_wrap_value_T_1 = tail(_done_wrap_value_T, 1) @[Counter.scala 76:24]
      done_value <= _done_wrap_value_T_1 @[Counter.scala 76:15]
      when done_wrap_wrap : @[Counter.scala 86:20]
        done_value <= UInt<1>("h00") @[Counter.scala 86:28]
        skip @[Counter.scala 86:20]
      done <= done_wrap_wrap @[Counter.scala 118:24]
      skip @[Counter.scala 118:17]
    when done : @[NetStack.scala 36:17]
      node _ledReg_T = eq(led_lo, UInt<1>("h00")) @[NetStack.scala 36:29]
      led_lo <= _ledReg_T @[NetStack.scala 36:26]
      skip @[NetStack.scala 36:17]
    node _led_T = cat(UInt<1>("h00"), led_lo) @[Cat.scala 30:58]
    led <= _led_T @[NetStack.scala 37:9]
    
