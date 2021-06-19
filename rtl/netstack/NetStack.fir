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
    node _io_rx_valid_T = eq(topHalfFifo.empty, UInt<1>("h00")) @[RgmiiTransfer.scala 36:26]
    node _io_rx_valid_T_1 = eq(bottomHalfFifo.empty, UInt<1>("h00")) @[RgmiiTransfer.scala 36:51]
    node _io_rx_valid_T_2 = and(_io_rx_valid_T, _io_rx_valid_T_1) @[RgmiiTransfer.scala 36:48]
    reg io_rx_valid_REG : UInt<1>, clock @[RgmiiTransfer.scala 36:25]
    io_rx_valid_REG <= _io_rx_valid_T_2 @[RgmiiTransfer.scala 36:25]
    io.rx.valid <= io_rx_valid_REG @[RgmiiTransfer.scala 36:15]
    node _io_rx_bits_T = cat(topHalfFifo.dout, bottomHalfFifo.dout) @[Cat.scala 30:58]
    io.rx.bits <= _io_rx_bits_T @[RgmiiTransfer.scala 37:14]
    
  module MacReceive : 
    input clock : Clock
    input reset : Reset
    output io : {flip rx : {valid : UInt<1>, bits : UInt<8>}, mac2IpIf : {arpData : {valid : UInt<1>, bits : UInt<8>}, ipData : {valid : UInt<1>, bits : UInt<8>}}, mac2CrcIf : {crcData : {valid : UInt<1>, bits : UInt<8>}, flip crcDone : UInt<1>, flip crcErr : UInt<1>}}
    
    io.mac2CrcIf.crcErr is invalid @[MacReceive.scala 14:6]
    io.mac2CrcIf.crcDone is invalid @[MacReceive.scala 14:6]
    io.mac2CrcIf.crcData.bits is invalid @[MacReceive.scala 14:6]
    io.mac2CrcIf.crcData.valid is invalid @[MacReceive.scala 14:6]
    io.mac2IpIf.ipData.bits is invalid @[MacReceive.scala 14:6]
    io.mac2IpIf.ipData.valid is invalid @[MacReceive.scala 14:6]
    io.mac2IpIf.arpData.bits is invalid @[MacReceive.scala 14:6]
    io.mac2IpIf.arpData.valid is invalid @[MacReceive.scala 14:6]
    io.rx.bits is invalid @[MacReceive.scala 14:6]
    io.rx.valid is invalid @[MacReceive.scala 14:6]
    node preamble_hi_lo = cat(UInt<8>("h055"), UInt<8>("h055")) @[Cat.scala 30:58]
    node preamble_lo = cat(preamble_hi_lo, preamble_hi_lo) @[Cat.scala 30:58]
    node preamble_hi = cat(UInt<8>("h055"), preamble_hi_lo) @[Cat.scala 30:58]
    node preamble_hi_1 = cat(preamble_hi, preamble_lo) @[Cat.scala 30:58]
    node _preamble_T = cat(preamble_hi_1, UInt<8>("h0d5")) @[Cat.scala 30:58]
    wire preamble : UInt<8>[8] @[MacReceive.scala 16:73]
    wire _preamble_WIRE : UInt<64>
    _preamble_WIRE <= _preamble_T
    node _preamble_T_1 = bits(_preamble_WIRE, 7, 0) @[MacReceive.scala 16:73]
    preamble[0] <= _preamble_T_1 @[MacReceive.scala 16:73]
    node _preamble_T_2 = bits(_preamble_WIRE, 15, 8) @[MacReceive.scala 16:73]
    preamble[1] <= _preamble_T_2 @[MacReceive.scala 16:73]
    node _preamble_T_3 = bits(_preamble_WIRE, 23, 16) @[MacReceive.scala 16:73]
    preamble[2] <= _preamble_T_3 @[MacReceive.scala 16:73]
    node _preamble_T_4 = bits(_preamble_WIRE, 31, 24) @[MacReceive.scala 16:73]
    preamble[3] <= _preamble_T_4 @[MacReceive.scala 16:73]
    node _preamble_T_5 = bits(_preamble_WIRE, 39, 32) @[MacReceive.scala 16:73]
    preamble[4] <= _preamble_T_5 @[MacReceive.scala 16:73]
    node _preamble_T_6 = bits(_preamble_WIRE, 47, 40) @[MacReceive.scala 16:73]
    preamble[5] <= _preamble_T_6 @[MacReceive.scala 16:73]
    node _preamble_T_7 = bits(_preamble_WIRE, 55, 48) @[MacReceive.scala 16:73]
    preamble[6] <= _preamble_T_7 @[MacReceive.scala 16:73]
    node _preamble_T_8 = bits(_preamble_WIRE, 63, 56) @[MacReceive.scala 16:73]
    preamble[7] <= _preamble_T_8 @[MacReceive.scala 16:73]
    wire macAddress : UInt<8>[6] @[MacReceive.scala 17:45]
    macAddress[0] <= UInt<8>("h0aa") @[MacReceive.scala 17:45]
    macAddress[1] <= UInt<8>("h055") @[MacReceive.scala 17:45]
    macAddress[2] <= UInt<8>("h034") @[MacReceive.scala 17:45]
    macAddress[3] <= UInt<8>("h012") @[MacReceive.scala 17:45]
    macAddress[4] <= UInt<8>("h00") @[MacReceive.scala 17:45]
    macAddress[5] <= UInt<8>("h0ff") @[MacReceive.scala 17:45]
    wire broadMacAddress : UInt<8>[6] @[MacReceive.scala 18:59]
    broadMacAddress[0] <= UInt<8>("h0ff") @[MacReceive.scala 18:59]
    broadMacAddress[1] <= UInt<8>("h0ff") @[MacReceive.scala 18:59]
    broadMacAddress[2] <= UInt<8>("h0ff") @[MacReceive.scala 18:59]
    broadMacAddress[3] <= UInt<8>("h0ff") @[MacReceive.scala 18:59]
    broadMacAddress[4] <= UInt<8>("h0ff") @[MacReceive.scala 18:59]
    broadMacAddress[5] <= UInt<8>("h0ff") @[MacReceive.scala 18:59]
    wire macType : UInt<8>[2] @[MacReceive.scala 20:21]
    macType[0] <= UInt<1>("h00") @[MacReceive.scala 21:21]
    macType[1] <= UInt<1>("h00") @[MacReceive.scala 21:21]
    reg value : UInt<11>, clock with : (reset => (reset, UInt<11>("h00"))) @[Counter.scala 60:40]
    reg stateReg : UInt<4>, clock with : (reset => (reset, UInt<4>("h00"))) @[MacReceive.scala 26:25]
    node _T = eq(UInt<4>("h00"), stateReg) @[Conditional.scala 37:30]
    when _T : @[Conditional.scala 40:58]
      node _T_1 = eq(io.rx.bits, preamble[0]) @[MacReceive.scala 74:31]
      node _T_2 = and(io.rx.valid, _T_1) @[MacReceive.scala 74:21]
      when _T_2 : @[MacReceive.scala 74:48]
        node wrap = eq(value, UInt<11>("h05db")) @[Counter.scala 72:24]
        node _value_T = add(value, UInt<1>("h01")) @[Counter.scala 76:24]
        node _value_T_1 = tail(_value_T, 1) @[Counter.scala 76:24]
        value <= _value_T_1 @[Counter.scala 76:15]
        when wrap : @[Counter.scala 86:20]
          value <= UInt<1>("h00") @[Counter.scala 86:28]
          skip @[Counter.scala 86:20]
        stateReg <= UInt<4>("h01") @[MacReceive.scala 76:18]
        skip @[MacReceive.scala 74:48]
      skip @[Conditional.scala 40:58]
    else : @[Conditional.scala 39:67]
      node _T_3 = eq(UInt<4>("h01"), stateReg) @[Conditional.scala 37:30]
      when _T_3 : @[Conditional.scala 39:67]
        node _T_4 = bits(value, 2, 0)
        node _T_5 = eq(io.rx.bits, preamble[_T_4]) @[MacReceive.scala 29:46]
        node _T_6 = and(io.rx.valid, _T_5) @[MacReceive.scala 29:19]
        when _T_6 : @[MacReceive.scala 29:80]
          node wrap_1 = eq(value, UInt<11>("h05db")) @[Counter.scala 72:24]
          node _value_T_2 = add(value, UInt<1>("h01")) @[Counter.scala 76:24]
          node _value_T_3 = tail(_value_T_2, 1) @[Counter.scala 76:24]
          value <= _value_T_3 @[Counter.scala 76:15]
          when wrap_1 : @[Counter.scala 86:20]
            value <= UInt<1>("h00") @[Counter.scala 86:28]
            skip @[Counter.scala 86:20]
          skip @[MacReceive.scala 29:80]
        else : @[MacReceive.scala 31:7]
          value <= UInt<1>("h00") @[Counter.scala 97:11]
          stateReg <= UInt<4>("h00") @[MacReceive.scala 33:16]
          skip @[MacReceive.scala 31:7]
        node _T_7 = eq(value, UInt<4>("h08")) @[MacReceive.scala 35:21]
        when _T_7 : @[MacReceive.scala 35:46]
          value <= UInt<1>("h00") @[Counter.scala 97:11]
          stateReg <= UInt<4>("h02") @[MacReceive.scala 37:16]
          skip @[MacReceive.scala 35:46]
        skip @[Conditional.scala 39:67]
      else : @[Conditional.scala 39:67]
        node _T_8 = eq(UInt<4>("h02"), stateReg) @[Conditional.scala 37:30]
        when _T_8 : @[Conditional.scala 39:67]
          node _T_9 = bits(value, 2, 0)
          node _T_10 = eq(io.rx.bits, macAddress[_T_9]) @[MacReceive.scala 29:46]
          node _T_11 = bits(value, 2, 0)
          node _T_12 = eq(io.rx.bits, broadMacAddress[_T_11]) @[MacReceive.scala 29:46]
          node _T_13 = or(_T_10, _T_12) @[MacReceive.scala 29:73]
          node _T_14 = and(io.rx.valid, _T_13) @[MacReceive.scala 29:19]
          when _T_14 : @[MacReceive.scala 29:80]
            node wrap_2 = eq(value, UInt<11>("h05db")) @[Counter.scala 72:24]
            node _value_T_4 = add(value, UInt<1>("h01")) @[Counter.scala 76:24]
            node _value_T_5 = tail(_value_T_4, 1) @[Counter.scala 76:24]
            value <= _value_T_5 @[Counter.scala 76:15]
            when wrap_2 : @[Counter.scala 86:20]
              value <= UInt<1>("h00") @[Counter.scala 86:28]
              skip @[Counter.scala 86:20]
            skip @[MacReceive.scala 29:80]
          else : @[MacReceive.scala 31:7]
            value <= UInt<1>("h00") @[Counter.scala 97:11]
            stateReg <= UInt<4>("h00") @[MacReceive.scala 33:16]
            skip @[MacReceive.scala 31:7]
          node _T_15 = eq(value, UInt<3>("h06")) @[MacReceive.scala 35:21]
          when _T_15 : @[MacReceive.scala 35:46]
            value <= UInt<1>("h00") @[Counter.scala 97:11]
            stateReg <= UInt<4>("h03") @[MacReceive.scala 37:16]
            skip @[MacReceive.scala 35:46]
          skip @[Conditional.scala 39:67]
        else : @[Conditional.scala 39:67]
          node _T_16 = eq(UInt<4>("h03"), stateReg) @[Conditional.scala 37:30]
          when _T_16 : @[Conditional.scala 39:67]
            when io.rx.valid : @[MacReceive.scala 57:21]
              node wrap_3 = eq(value, UInt<11>("h05db")) @[Counter.scala 72:24]
              node _value_T_6 = add(value, UInt<1>("h01")) @[Counter.scala 76:24]
              node _value_T_7 = tail(_value_T_6, 1) @[Counter.scala 76:24]
              value <= _value_T_7 @[Counter.scala 76:15]
              when wrap_3 : @[Counter.scala 86:20]
                value <= UInt<1>("h00") @[Counter.scala 86:28]
                skip @[Counter.scala 86:20]
              node _T_17 = eq(value, UInt<3>("h06")) @[MacReceive.scala 59:24]
              when _T_17 : @[MacReceive.scala 59:33]
                value <= UInt<1>("h00") @[Counter.scala 97:11]
                stateReg <= UInt<4>("h04") @[MacReceive.scala 61:20]
                skip @[MacReceive.scala 59:33]
              skip @[MacReceive.scala 57:21]
            else : @[MacReceive.scala 63:9]
              value <= UInt<1>("h00") @[Counter.scala 97:11]
              stateReg <= UInt<4>("h00") @[MacReceive.scala 65:18]
              skip @[MacReceive.scala 63:9]
            skip @[Conditional.scala 39:67]
          else : @[Conditional.scala 39:67]
            node _T_18 = eq(UInt<4>("h04"), stateReg) @[Conditional.scala 37:30]
            when _T_18 : @[Conditional.scala 39:67]
              when io.rx.valid : @[MacReceive.scala 42:20]
                node _T_19 = bits(value, 0, 0)
                macType[_T_19] <= io.rx.bits @[MacReceive.scala 43:20]
                node wrap_4 = eq(value, UInt<11>("h05db")) @[Counter.scala 72:24]
                node _value_T_8 = add(value, UInt<1>("h01")) @[Counter.scala 76:24]
                node _value_T_9 = tail(_value_T_8, 1) @[Counter.scala 76:24]
                value <= _value_T_9 @[Counter.scala 76:15]
                when wrap_4 : @[Counter.scala 86:20]
                  value <= UInt<1>("h00") @[Counter.scala 86:28]
                  skip @[Counter.scala 86:20]
                node _T_20 = eq(value, UInt<2>("h02")) @[MacReceive.scala 45:22]
                when _T_20 : @[MacReceive.scala 45:38]
                  value <= UInt<1>("h00") @[Counter.scala 97:11]
                  stateReg <= UInt<4>("h05") @[MacReceive.scala 47:18]
                  skip @[MacReceive.scala 45:38]
                skip @[MacReceive.scala 42:20]
              else : @[MacReceive.scala 49:7]
                value <= UInt<1>("h00") @[Counter.scala 97:11]
                stateReg <= UInt<4>("h00") @[MacReceive.scala 51:16]
                skip @[MacReceive.scala 49:7]
              skip @[Conditional.scala 39:67]
            else : @[Conditional.scala 39:67]
              node _T_21 = eq(UInt<4>("h05"), stateReg) @[Conditional.scala 37:30]
              when _T_21 : @[Conditional.scala 39:67]
                node _T_22 = eq(io.rx.valid, UInt<1>("h00")) @[MacReceive.scala 68:13]
                when _T_22 : @[MacReceive.scala 68:23]
                  stateReg <= UInt<4>("h06") @[MacReceive.scala 68:34]
                  skip @[MacReceive.scala 68:23]
                skip @[Conditional.scala 39:67]
              else : @[Conditional.scala 39:67]
                node _T_23 = eq(UInt<4>("h06"), stateReg) @[Conditional.scala 37:30]
                when _T_23 : @[Conditional.scala 39:67]
                  stateReg <= UInt<4>("h00") @[MacReceive.scala 95:16]
                  skip @[Conditional.scala 39:67]
    
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
    rgmii.ereset <= reset_n @[NetStack.scala 37:16]
    reg led_lo : UInt<1>, pll.clk_100 with : (reset => (reset, UInt<1>("h00"))) @[NetStack.scala 39:25]
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
    when done : @[NetStack.scala 41:17]
      node _ledReg_T = eq(led_lo, UInt<1>("h00")) @[NetStack.scala 41:29]
      led_lo <= _ledReg_T @[NetStack.scala 41:26]
      skip @[NetStack.scala 41:17]
    node _led_T = cat(UInt<1>("h00"), led_lo) @[Cat.scala 30:58]
    led <= _led_T @[NetStack.scala 42:9]
    
