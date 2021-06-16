;buildInfoPackage: chisel3, version: 3.4.2, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit NetStack : 
  module RgmiiTransfer : 
    input clock : Clock
    input reset : Reset
    output io : {rgmii : {txClock : UInt<1>, txData : UInt<4>, txCtrl : UInt<1>, flip rxClock : UInt<1>, flip rxData : UInt<4>, flip rxCtrl : UInt<1>, ereset : UInt<1>}, rx : {valid : UInt<1>, bits : UInt<8>}, flip tx : {valid : UInt<1>, bits : UInt<8>}}
    
    io.tx.bits is invalid @[MacReceive.scala 15:6]
    io.tx.valid is invalid @[MacReceive.scala 15:6]
    io.rx.bits is invalid @[MacReceive.scala 15:6]
    io.rx.valid is invalid @[MacReceive.scala 15:6]
    io.rgmii.ereset is invalid @[MacReceive.scala 15:6]
    io.rgmii.rxCtrl is invalid @[MacReceive.scala 15:6]
    io.rgmii.rxData is invalid @[MacReceive.scala 15:6]
    io.rgmii.rxClock is invalid @[MacReceive.scala 15:6]
    io.rgmii.txCtrl is invalid @[MacReceive.scala 15:6]
    io.rgmii.txData is invalid @[MacReceive.scala 15:6]
    io.rgmii.txClock is invalid @[MacReceive.scala 15:6]
    io.rx.valid <= UInt<1>("h00") @[MacReceive.scala 17:15]
    node _io_rgmii_ereset_T = asUInt(reset) @[MacReceive.scala 18:35]
    node _io_rgmii_ereset_T_1 = not(_io_rgmii_ereset_T) @[MacReceive.scala 18:22]
    io.rgmii.ereset <= _io_rgmii_ereset_T_1 @[MacReceive.scala 18:19]
    reg rxReg : UInt<4>, clock @[MacReceive.scala 20:18]
    reg sReg : UInt<4>, clock with : (reset => (reset, UInt<4>("h00"))) @[MacReceive.scala 22:21]
    node _T = eq(UInt<4>("h00"), sReg) @[Conditional.scala 37:30]
    when _T : @[Conditional.scala 40:58]
      node _T_1 = and(io.rgmii.rxClock, io.rgmii.rxCtrl) @[MacReceive.scala 25:30]
      when _T_1 : @[MacReceive.scala 25:50]
        rxReg <= io.rgmii.rxData @[MacReceive.scala 26:15]
        sReg <= UInt<4>("h01") @[MacReceive.scala 27:14]
        skip @[MacReceive.scala 25:50]
      skip @[Conditional.scala 40:58]
    else : @[Conditional.scala 39:67]
      node _T_2 = eq(UInt<4>("h01"), sReg) @[Conditional.scala 37:30]
      when _T_2 : @[Conditional.scala 39:67]
        io.rx.valid <= UInt<1>("h01") @[MacReceive.scala 31:19]
        node _io_rx_bits_T = cat(rxReg, io.rgmii.rxData) @[Cat.scala 30:58]
        io.rx.bits <= _io_rx_bits_T @[MacReceive.scala 32:18]
        sReg <= UInt<4>("h00") @[MacReceive.scala 33:12]
        skip @[Conditional.scala 39:67]
    
  module NetStack : 
    input clock : Clock
    input reset : UInt<1>
    output rgmii : {txClock : UInt<1>, txData : UInt<4>, txCtrl : UInt<1>, flip rxClock : UInt<1>, flip rxData : UInt<4>, flip rxCtrl : UInt<1>, ereset : UInt<1>}
    
    node reset_n = eq(reset, UInt<1>("h00")) @[package.scala 12:19]
    rgmii.ereset is invalid @[NetStack.scala 11:9]
    rgmii.rxCtrl is invalid @[NetStack.scala 11:9]
    rgmii.rxData is invalid @[NetStack.scala 11:9]
    rgmii.rxClock is invalid @[NetStack.scala 11:9]
    rgmii.txCtrl is invalid @[NetStack.scala 11:9]
    rgmii.txData is invalid @[NetStack.scala 11:9]
    rgmii.txClock is invalid @[NetStack.scala 11:9]
    wire rxMac : {valid : UInt<1>, bits : UInt<8>} @[NetStack.scala 14:21]
    inst rgmiiTransfer of RgmiiTransfer @[NetStack.scala 16:31]
    rgmiiTransfer.clock <= clock
    rgmiiTransfer.reset <= reset_n
    rgmiiTransfer.io.tx.bits is invalid @[NetStack.scala 17:22]
    rgmiiTransfer.io.tx.valid is invalid @[NetStack.scala 17:22]
    rgmiiTransfer.io.rx.bits is invalid @[NetStack.scala 17:22]
    rgmiiTransfer.io.rx.valid is invalid @[NetStack.scala 17:22]
    rgmiiTransfer.io.rgmii.ereset is invalid @[NetStack.scala 17:22]
    rgmiiTransfer.io.rgmii.rxCtrl is invalid @[NetStack.scala 17:22]
    rgmiiTransfer.io.rgmii.rxData is invalid @[NetStack.scala 17:22]
    rgmiiTransfer.io.rgmii.rxClock is invalid @[NetStack.scala 17:22]
    rgmiiTransfer.io.rgmii.txCtrl is invalid @[NetStack.scala 17:22]
    rgmiiTransfer.io.rgmii.txData is invalid @[NetStack.scala 17:22]
    rgmiiTransfer.io.rgmii.txClock is invalid @[NetStack.scala 17:22]
    rgmii.ereset <= rgmiiTransfer.io.rgmii.ereset @[NetStack.scala 19:28]
    rgmiiTransfer.io.rgmii.rxCtrl <= rgmii.rxCtrl @[NetStack.scala 19:28]
    rgmiiTransfer.io.rgmii.rxData <= rgmii.rxData @[NetStack.scala 19:28]
    rgmiiTransfer.io.rgmii.rxClock <= rgmii.rxClock @[NetStack.scala 19:28]
    rgmii.txCtrl <= rgmiiTransfer.io.rgmii.txCtrl @[NetStack.scala 19:28]
    rgmii.txData <= rgmiiTransfer.io.rgmii.txData @[NetStack.scala 19:28]
    rgmii.txClock <= rgmiiTransfer.io.rgmii.txClock @[NetStack.scala 19:28]
    rxMac.bits <= rgmiiTransfer.io.rx.bits @[NetStack.scala 20:25]
    rxMac.valid <= rgmiiTransfer.io.rx.valid @[NetStack.scala 20:25]
    
