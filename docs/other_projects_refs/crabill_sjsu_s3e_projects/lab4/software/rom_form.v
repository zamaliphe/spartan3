{begin template}
// File: {name}.v
// This is the PicoBlaze executable for EE178 Lab #4.
// This is derived from the Xilinx "rom_form.v" with
// integrated JTAG load capability.
 
// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator timestep should be (1 ps here).
 
`timescale 1 ns / 1 ps
 
// Declare the module and its ports. This is
// using Verilog-2001 syntax.
 
module {name} 
  (
  input  wire  [9:0] address,
  output wire [17:0] instruction,
  output wire        reset,
  input  wire        rst,
  input  wire        clk
  );
 
  // Declare signals internal to this module.
 
  wire        [10:0] jaddr;
  wire         [7:0] jdata;
  wire               jparity;
  wire               tdo1;
  wire               update;
  wire               tdi;
  wire               sel1;
  wire               drck1;
  wire               drck1_buf;
  wire               tap5;
  wire               tap11;
  wire               tap17;
  wire               temp;
  wire               sync;
 
  RAMB16_S9_S18 #(
    .INIT_00(256'h{INIT_00}),
    .INIT_01(256'h{INIT_01}),
    .INIT_02(256'h{INIT_02}),
    .INIT_03(256'h{INIT_03}),
    .INIT_04(256'h{INIT_04}),
    .INIT_05(256'h{INIT_05}),
    .INIT_06(256'h{INIT_06}),
    .INIT_07(256'h{INIT_07}),
    .INIT_08(256'h{INIT_08}),
    .INIT_09(256'h{INIT_09}),
    .INIT_0A(256'h{INIT_0A}),
    .INIT_0B(256'h{INIT_0B}),
    .INIT_0C(256'h{INIT_0C}),
    .INIT_0D(256'h{INIT_0D}),
    .INIT_0E(256'h{INIT_0E}),
    .INIT_0F(256'h{INIT_0F}),
    .INIT_10(256'h{INIT_10}),
    .INIT_11(256'h{INIT_11}),
    .INIT_12(256'h{INIT_12}),
    .INIT_13(256'h{INIT_13}),
    .INIT_14(256'h{INIT_14}),
    .INIT_15(256'h{INIT_15}),
    .INIT_16(256'h{INIT_16}),
    .INIT_17(256'h{INIT_17}),
    .INIT_18(256'h{INIT_18}),
    .INIT_19(256'h{INIT_19}),
    .INIT_1A(256'h{INIT_1A}),
    .INIT_1B(256'h{INIT_1B}),
    .INIT_1C(256'h{INIT_1C}),
    .INIT_1D(256'h{INIT_1D}),
    .INIT_1E(256'h{INIT_1E}),
    .INIT_1F(256'h{INIT_1F}),
    .INIT_20(256'h{INIT_20}),
    .INIT_21(256'h{INIT_21}),
    .INIT_22(256'h{INIT_22}),
    .INIT_23(256'h{INIT_23}),
    .INIT_24(256'h{INIT_24}),
    .INIT_25(256'h{INIT_25}),
    .INIT_26(256'h{INIT_26}),
    .INIT_27(256'h{INIT_27}),
    .INIT_28(256'h{INIT_28}),
    .INIT_29(256'h{INIT_29}),
    .INIT_2A(256'h{INIT_2A}),
    .INIT_2B(256'h{INIT_2B}),
    .INIT_2C(256'h{INIT_2C}),
    .INIT_2D(256'h{INIT_2D}),
    .INIT_2E(256'h{INIT_2E}),
    .INIT_2F(256'h{INIT_2F}),
    .INIT_30(256'h{INIT_30}),
    .INIT_31(256'h{INIT_31}),
    .INIT_32(256'h{INIT_32}),
    .INIT_33(256'h{INIT_33}),
    .INIT_34(256'h{INIT_34}),
    .INIT_35(256'h{INIT_35}),
    .INIT_36(256'h{INIT_36}),
    .INIT_37(256'h{INIT_37}),
    .INIT_38(256'h{INIT_38}),
    .INIT_39(256'h{INIT_39}),
    .INIT_3A(256'h{INIT_3A}),
    .INIT_3B(256'h{INIT_3B}),
    .INIT_3C(256'h{INIT_3C}),
    .INIT_3D(256'h{INIT_3D}),
    .INIT_3E(256'h{INIT_3E}),
    .INIT_3F(256'h{INIT_3F}),
    .INITP_00(256'h{INITP_00}),
    .INITP_01(256'h{INITP_01}),
    .INITP_02(256'h{INITP_02}),
    .INITP_03(256'h{INITP_03}),
    .INITP_04(256'h{INITP_04}),
    .INITP_05(256'h{INITP_05}),
    .INITP_06(256'h{INITP_06}),
    .INITP_07(256'h{INITP_07}))
  ram_1024_x_18 (
    .DIB(16'h0000),
    .DIPB(2'b00),
    .ENB(1'b1),
    .WEB(1'b0),
    .SSRB(1'b0),
    .CLKB(clk),
    .ADDRB(address),
    .DOB(instruction[15:0]),
    .DOPB(instruction[17:16]),
    .DIA(jdata),
    .DIPA(jparity),
    .ENA(sel1),
    .WEA(1'b1),
    .SSRA(1'b0),
    .CLKA(update),
    .ADDRA(jaddr),
    .DOA(),
    .DOPA());
 
  BSCAN_SPARTAN3 s3_bscan (
    .TDO1(tdo1),
    .TDO2(1'b0),
    .UPDATE(update),
    .SHIFT(),
    .RESET(),
    .TDI(tdi),
    .SEL1(sel1),
    .DRCK1(drck1),
    .SEL2(),
    .DRCK2(),
    .CAPTURE());
 
  BUFG upload_clock (.I(drck1),.O(drck1_buf));
 
  // Assign the reset to be active whenever
  // the uploading subsystem is active or
  // whenever the async rst is asserted.
 
  assign temp = rst || sel1;
  FDP fda (.Q(sync),.D(temp),.C(clk),.PRE(temp));
  FDP fdb (.Q(reset),.D(sync),.C(clk),.PRE(temp));
 
  // synthesis attribute ASYNC_REG of fda is "TRUE";
  // synthesis attribute ASYNC_REG of fdb is "TRUE";
  // synthesis attribute HU_SET of fda is "SYNC";
  // synthesis attribute HU_SET of fdb is "SYNC";
  // synthesis attribute RLOC of fda is "X0Y0";
  // synthesis attribute RLOC of fdb is "X0Y0";
 
  SRLC16E #(.INIT(16'h0000)) srlC1 (
    .D(tdi),
    .CE(1'b1),
    .CLK(drck1_buf),
    .A0(1'b1),
    .A1(1'b0),
    .A2(1'b1),
    .A3(1'b1),
    .Q(jaddr[10]),
    .Q15(jaddr[8]));
 
  FD flop1 (
    .D(jaddr[10]),
    .Q(jaddr[9]),
    .C(drck1_buf));
 
  SRLC16E #(.INIT(16'h0000)) srlC2 (
    .D(jaddr[8]),
    .CE(1'b1),
    .CLK(drck1_buf),
    .A0(1'b1),
    .A1(1'b0),
    .A2(1'b1),
    .A3(1'b1),
    .Q(jaddr[7]),
    .Q15(tap5));
 
  FD flop2 (
    .D(jaddr[7]),
    .Q(jaddr[6]),
    .C(drck1_buf));
 
  SRLC16E #(.INIT(16'h0000)) srlC3 (
    .D(tap5),
    .CE(1'b1),
    .CLK(drck1_buf),
    .A0(1'b1),
    .A1(1'b0),
    .A2(1'b1),
    .A3(1'b1),
    .Q(jaddr[5]),
    .Q15(jaddr[3]));
 
  FD flop3 (
    .D(jaddr[5]),
    .Q(jaddr[4]),
    .C(drck1_buf));
 
  SRLC16E #(.INIT(16'h0000)) srlC4 (
    .D(jaddr[3]),
    .CE(1'b1),
    .CLK(drck1_buf),
    .A0(1'b1),
    .A1(1'b0),
    .A2(1'b1),
    .A3(1'b1),
    .Q(jaddr[2]),
    .Q15(tap11));
 
  FD flop4 (
    .D(jaddr[2]),
    .Q(jaddr[1]),
    .C(drck1_buf));
 
  SRLC16E #(.INIT(16'h0000)) srlC5 (
    .D(tap11),
    .CE(1'b1),
    .CLK(drck1_buf),
    .A0(1'b1),
    .A1(1'b0),
    .A2(1'b1),
    .A3(1'b1),
    .Q(jaddr[0]),
    .Q15(jdata[7]));
 
  FD flop5 (
    .D(jaddr[0]),
    .Q(jparity),
    .C(drck1_buf));
 
  SRLC16E #(.INIT(16'h0000)) srlC6 (
    .D(jdata[7]),
    .CE(1'b1),
    .CLK(drck1_buf),
    .A0(1'b1),
    .A1(1'b0),
    .A2(1'b1),
    .A3(1'b1),
    .Q(jdata[6]),
    .Q15(tap17));
 
  FD flop6 (
    .D(jdata[6]),
    .Q(jdata[5]),
    .C(drck1_buf));
 
  SRLC16E #(.INIT(16'h0000)) srlC7 (
    .D(tap17),
    .CE(1'b1),
    .CLK(drck1_buf),
    .A0(1'b1),
    .A1(1'b0),
    .A2(1'b1),
    .A3(1'b1),
    .Q(jdata[4]),
    .Q15(jdata[2]));
 
  FD flop7 (
    .D(jdata[4]),
    .Q(jdata[3]),
    .C(drck1_buf));
 
  SRLC16E #(.INIT(16'h0000)) srlC8 (
    .D(jdata[2]),
    .CE(1'b1),
    .CLK(drck1_buf),
    .A0(1'b1),
    .A1(1'b0),
    .A2(1'b1),
    .A3(1'b1),
    .Q(jdata[1]),
    .Q15(tdo1));
 
  FD flop8 (
    .D(jdata[1]),
    .Q(jdata[0]),
    .C(drck1_buf));
 
endmodule