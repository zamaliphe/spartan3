`include "00defines.v"

module Transposer(
transposer_clk	,
transposer_reset,
do_transpose	,	//start signal as well as the tri-stater
do_bitreversing	,	//Input asking it to do bitreversing too
done_transpose	,	//status flag indicating operation finish
ram00_port0_add	,
ram00_port0_bus	,
ram00_port1_add	,
ram00_port1_bus	,
ram00_cs_we_oe_0,
ram00_cs_we_oe_1,	//Have to repeat this for all rams
ram01_port0_add	,
ram01_port0_bus	,
ram01_port1_add	,
ram01_port1_bus	,
ram01_cs_we_oe_0,
ram01_cs_we_oe_1,
ram02_port0_add	,
ram02_port0_bus	,
ram02_port1_add	,
ram02_port1_bus	,
ram02_cs_we_oe_0,
ram02_cs_we_oe_1,
ram03_port0_add	,
ram03_port0_bus	,
ram03_port1_add	,
ram03_port1_bus	,
ram03_cs_we_oe_0,
ram03_cs_we_oe_1,
ram04_port0_add	,
ram04_port0_bus	,
ram04_port1_add	,
ram04_port1_bus	,
ram04_cs_we_oe_0,
ram04_cs_we_oe_1,
ram05_port0_add	,
ram05_port0_bus	,
ram05_port1_add	,
ram05_port1_bus	,
ram05_cs_we_oe_0,
ram05_cs_we_oe_1,
ram06_port0_add	,
ram06_port0_bus	,
ram06_port1_add	,
ram06_port1_bus	,
ram06_cs_we_oe_0,
ram06_cs_we_oe_1,
ram07_port0_add	,
ram07_port0_bus	,
ram07_port1_add	,
ram07_port1_bus	,
ram07_cs_we_oe_0,
ram07_cs_we_oe_1,
ram08_port0_add	,
ram08_port0_bus	,
ram08_port1_add	,
ram08_port1_bus	,
ram08_cs_we_oe_0,
ram08_cs_we_oe_1,
ram09_port0_add	,
ram09_port0_bus	,
ram09_port1_add	,
ram09_port1_bus	,
ram09_cs_we_oe_0,
ram09_cs_we_oe_1,
ram10_port0_add	,
ram10_port0_bus	,
ram10_port1_add	,
ram10_port1_bus	,
ram10_cs_we_oe_0,
ram10_cs_we_oe_1,
ram11_port0_add	,
ram11_port0_bus	,
ram11_port1_add	,
ram11_port1_bus	,
ram11_cs_we_oe_0,
ram11_cs_we_oe_1,
ram12_port0_add	,
ram12_port0_bus	,
ram12_port1_add	,
ram12_port1_bus	,
ram12_cs_we_oe_0,
ram12_cs_we_oe_1,
ram13_port0_add	,
ram13_port0_bus	,
ram13_port1_add	,
ram13_port1_bus	,
ram13_cs_we_oe_0,
ram13_cs_we_oe_1,
ram14_port0_add	,
ram14_port0_bus	,
ram14_port1_add	,
ram14_port1_bus	,
ram14_cs_we_oe_0,
ram14_cs_we_oe_1,
ram15_port0_add	,
ram15_port0_bus	,
ram15_port1_add	,
ram15_port1_bus	,
ram15_cs_we_oe_0,
ram15_cs_we_oe_1,
ram16_port0_add	,
ram16_port0_bus	,
ram16_port1_add	,
ram16_port1_bus	,
ram16_cs_we_oe_0,
ram16_cs_we_oe_1,
ram17_port0_add	,
ram17_port0_bus	,
ram17_port1_add	,
ram17_port1_bus	,
ram17_cs_we_oe_0,
ram17_cs_we_oe_1,
ram18_port0_add	,
ram18_port0_bus	,
ram18_port1_add	,
ram18_port1_bus	,
ram18_cs_we_oe_0,
ram18_cs_we_oe_1,
ram19_port0_add	,
ram19_port0_bus	,
ram19_port1_add	,
ram19_port1_bus	,
ram19_cs_we_oe_0,
ram19_cs_we_oe_1,
ram20_port0_add	,
ram20_port0_bus	,
ram20_port1_add	,
ram20_port1_bus	,
ram20_cs_we_oe_0,
ram20_cs_we_oe_1,
ram21_port0_add	,
ram21_port0_bus	,
ram21_port1_add	,
ram21_port1_bus	,
ram21_cs_we_oe_0,
ram21_cs_we_oe_1,
ram22_port0_add	,
ram22_port0_bus	,
ram22_port1_add	,
ram22_port1_bus	,
ram22_cs_we_oe_0,
ram22_cs_we_oe_1,
ram23_port0_add	,
ram23_port0_bus	,
ram23_port1_add	,
ram23_port1_bus	,
ram23_cs_we_oe_0,
ram23_cs_we_oe_1,
ram24_port0_add	,
ram24_port0_bus	,
ram24_port1_add	,
ram24_port1_bus	,
ram24_cs_we_oe_0,
ram24_cs_we_oe_1,
ram25_port0_add	,
ram25_port0_bus	,
ram25_port1_add	,
ram25_port1_bus	,
ram25_cs_we_oe_0,
ram25_cs_we_oe_1,
ram26_port0_add	,
ram26_port0_bus	,
ram26_port1_add	,
ram26_port1_bus	,
ram26_cs_we_oe_0,
ram26_cs_we_oe_1,
ram27_port0_add	,
ram27_port0_bus	,
ram27_port1_add	,
ram27_port1_bus	,
ram27_cs_we_oe_0,
ram27_cs_we_oe_1,
ram28_port0_add	,
ram28_port0_bus	,
ram28_port1_add	,
ram28_port1_bus	,
ram28_cs_we_oe_0,
ram28_cs_we_oe_1,
ram29_port0_add	,
ram29_port0_bus	,
ram29_port1_add	,
ram29_port1_bus	,
ram29_cs_we_oe_0,
ram29_cs_we_oe_1,
ram30_port0_add	,
ram30_port0_bus	,
ram30_port1_add	,
ram30_port1_bus	,
ram30_cs_we_oe_0,
ram30_cs_we_oe_1,
ram31_port0_add	,
ram31_port0_bus	,
ram31_port1_add	,
ram31_port1_bus	,
ram31_cs_we_oe_0,
ram31_cs_we_oe_1
);


//parameters
parameter STEP_WIDTH = 3;


//IO declarations
input  transposer_clk	;
input  transposer_reset	;
input  do_transpose	;
input  do_bitreversing	;
output done_transpose	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram00_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram00_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram00_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram00_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram00_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram00_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram01_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram01_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram01_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram01_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram01_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram01_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram02_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram02_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram02_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram02_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram02_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram02_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram03_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram03_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram03_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram03_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram03_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram03_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram04_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram04_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram04_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram04_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram04_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram04_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram05_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram05_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram05_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram05_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram05_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram05_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram06_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram06_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram06_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram06_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram06_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram06_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram07_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram07_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram07_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram07_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram07_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram07_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram08_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram08_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram08_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram08_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram08_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram08_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram09_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram09_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram09_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram09_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram09_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram09_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram10_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram10_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram10_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram10_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram10_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram10_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram11_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram11_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram11_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram11_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram11_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram11_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram12_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram12_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram12_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram12_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram12_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram12_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram13_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram13_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram13_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram13_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram13_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram13_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram14_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram14_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram14_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram14_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram14_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram14_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram15_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram15_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram15_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram15_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram15_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram15_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram16_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram16_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram16_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram16_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram16_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram16_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram17_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram17_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram17_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram17_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram17_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram17_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram18_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram18_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram18_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram18_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram18_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram18_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram19_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram19_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram19_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram19_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram19_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram19_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram20_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram20_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram20_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram20_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram20_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram20_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram21_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram21_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram21_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram21_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram21_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram21_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram22_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram22_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram22_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram22_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram22_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram22_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram23_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram23_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram23_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram23_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram23_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram23_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram24_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram24_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram24_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram24_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram24_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram24_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram25_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram25_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram25_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram25_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram25_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram25_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram26_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram26_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram26_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram26_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram26_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram26_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram27_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram27_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram27_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram27_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram27_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram27_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram28_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram28_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram28_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram28_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram28_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram28_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram29_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram29_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram29_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram29_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram29_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram29_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram30_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram30_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram30_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram30_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram30_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram30_cs_we_oe_1	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram31_port0_add;
inout  [`FFT_DATA_WIDTH-1:0]ram31_port0_bus	;
output [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram31_port1_add;
inout  [`FFT_DATA_WIDTH-1:0]ram31_port1_bus	;
output [`RAM_COMMAND_WIDTH-1:0]ram31_cs_we_oe_0	;
output [`RAM_COMMAND_WIDTH-1:0]ram31_cs_we_oe_1	;

wire transposer_clk	;
wire transposer_reset	;
wire do_transpose	;
wire do_bitreversing	;
reg  done_transpose	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram00_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram00_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram00_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram00_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram00_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram00_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram01_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram01_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram01_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram01_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram01_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram01_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram02_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram02_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram02_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram02_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram02_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram02_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram03_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram03_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram03_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram03_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram03_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram03_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram04_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram04_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram04_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram04_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram04_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram04_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram05_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram05_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram05_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram05_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram05_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram05_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram06_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram06_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram06_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram06_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram06_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram06_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram07_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram07_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram07_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram07_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram07_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram07_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram08_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram08_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram08_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram08_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram08_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram08_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram09_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram09_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram09_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram09_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram09_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram09_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram10_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram10_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram10_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram10_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram10_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram10_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram11_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram11_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram11_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram11_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram11_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram11_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram12_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram12_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram12_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram12_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram12_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram12_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram13_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram13_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram13_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram13_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram13_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram13_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram14_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram14_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram14_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram14_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram14_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram14_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram15_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram15_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram15_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram15_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram15_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram15_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram16_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram16_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram16_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram16_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram16_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram16_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram17_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram17_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram17_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram17_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram17_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram17_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram18_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram18_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram18_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram18_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram18_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram18_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram19_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram19_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram19_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram19_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram19_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram19_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram20_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram20_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram20_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram20_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram20_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram20_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram21_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram21_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram21_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram21_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram21_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram21_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram22_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram22_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram22_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram22_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram22_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram22_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram23_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram23_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram23_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram23_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram23_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram23_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram24_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram24_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram24_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram24_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram24_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram24_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram25_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram25_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram25_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram25_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram25_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram25_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram26_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram26_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram26_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram26_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram26_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram26_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram27_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram27_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram27_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram27_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram27_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram27_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram28_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram28_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram28_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram28_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram28_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram28_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram29_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram29_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram29_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram29_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram29_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram29_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram30_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram30_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram30_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram30_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram30_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram30_cs_we_oe_1	;
reg  [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram31_port0_add;
wire [`FFT_DATA_WIDTH-1:0]ram31_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]ram31_port1_add;
wire [`FFT_DATA_WIDTH-1:0]ram31_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]ram31_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]ram31_cs_we_oe_1	;


//Local regs and wires
reg [`FFT_DATA_WIDTH-1:0] temp_reg1[0:`NO_OF_UNITS-1];				//needed as temp storage of guy1
reg [`FFT_DATA_WIDTH-1:0] temp_reg2[0:`NO_OF_UNITS-1];				//needed as temp storage of guy2
reg [`LOG_M_R_R-1:0]    i;							//counters for loop1 of each ram:1,...,max_ram_rows-1
reg [`LOG_N-1:0] 	j;							//counters for loop2 of each ram:1,...,NO_OF_POINTS-1
reg [`LOG_N-1:0]delayed_j;							//counters for loop2 of each ram:1,...,NO_OF_POINTS-1
reg [`RAM_COMMAND_WIDTH-1:0] ram_command;					//should be selectively wired to ramRAMINDEX_cs_we_oe_1
reg [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add[0:`NO_OF_UNITS-1];	//Should be selectively wired to ramRAMINDEX_port1_add
reg [STEP_WIDTH-1:0] step;
reg [`NO_OF_UNITS-1:0] on;
wire [`NO_OF_UNITS*`FFT_DATA_WIDTH-1:0] ram_exchange_bus;
reg add_first_bit;								//for debugging convenience :).. remove with care

//for bitreversing part
reg done_transpose_local;
reg [`LOG_N+1-1:0] counter0	;
reg [`LOG_N+1-1:0] counter1	;
reg [`LOG_N+1-1:0] counter2	;
reg [1:0]	bitstep		;
wire [`LOG_N+1-1:0] counter5	;
wire [`LOG_N+1-1:0] counter6	;


//-----------temporary variables for debugging-------------------------------
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add00;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add01;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add02;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add03;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add04;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add05;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add06;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add07;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add08;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add09;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add10;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add11;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add12;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add13;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add14;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add15;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add16;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add17;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add18;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add19;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add20;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add21;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add22;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add23;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add24;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add25;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add26;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add27;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add28;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add29;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add30;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram_exchange_add31;

wire [`FFT_DATA_WIDTH-1:0] temp_reg1_00;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_01;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_02;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_03;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_04;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_05;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_06;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_07;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_08;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_09;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_10;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_11;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_12;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_13;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_14;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_15;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_16;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_17;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_18;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_19;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_20;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_21;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_22;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_23;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_24;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_25;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_26;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_27;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_28;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_29;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_30;
wire [`FFT_DATA_WIDTH-1:0] temp_reg1_31;

wire [`FFT_DATA_WIDTH-1:0] temp_reg2_00;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_01;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_02;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_03;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_04;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_05;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_06;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_07;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_08;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_09;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_10;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_11;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_12;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_13;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_14;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_15;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_16;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_17;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_18;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_19;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_20;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_21;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_22;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_23;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_24;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_25;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_26;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_27;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_28;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_29;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_30;
wire [`FFT_DATA_WIDTH-1:0] temp_reg2_31;

assign temp_reg1_00 = temp_reg1[00];
assign temp_reg1_01 = temp_reg1[01];
assign temp_reg1_02 = temp_reg1[02];
assign temp_reg1_03 = temp_reg1[03];
assign temp_reg1_04 = temp_reg1[04];
assign temp_reg1_05 = temp_reg1[05];
assign temp_reg1_06 = temp_reg1[06];
assign temp_reg1_07 = temp_reg1[07];
assign temp_reg1_08 = temp_reg1[08];
assign temp_reg1_09 = temp_reg1[09];
assign temp_reg1_10 = temp_reg1[10];
assign temp_reg1_11 = temp_reg1[11];
assign temp_reg1_12 = temp_reg1[12];
assign temp_reg1_13 = temp_reg1[13];
assign temp_reg1_14 = temp_reg1[14];
assign temp_reg1_15 = temp_reg1[15];
assign temp_reg1_16 = temp_reg1[16];
assign temp_reg1_17 = temp_reg1[17];
assign temp_reg1_18 = temp_reg1[18];
assign temp_reg1_19 = temp_reg1[19];
assign temp_reg1_20 = temp_reg1[20];
assign temp_reg1_21 = temp_reg1[21];
assign temp_reg1_22 = temp_reg1[22];
assign temp_reg1_23 = temp_reg1[23];
assign temp_reg1_24 = temp_reg1[24];
assign temp_reg1_25 = temp_reg1[25];
assign temp_reg1_26 = temp_reg1[26];
assign temp_reg1_27 = temp_reg1[27];
assign temp_reg1_28 = temp_reg1[28];
assign temp_reg1_29 = temp_reg1[29];
assign temp_reg1_30 = temp_reg1[30];
assign temp_reg1_31 = temp_reg1[31];
assign temp_reg2_00 = temp_reg2[00];
assign temp_reg2_01 = temp_reg2[01];
assign temp_reg2_02 = temp_reg2[02];
assign temp_reg2_03 = temp_reg2[03];
assign temp_reg2_04 = temp_reg2[04];
assign temp_reg2_05 = temp_reg2[05];
assign temp_reg2_06 = temp_reg2[06];
assign temp_reg2_07 = temp_reg2[07];
assign temp_reg2_08 = temp_reg2[08];
assign temp_reg2_09 = temp_reg2[09];
assign temp_reg2_10 = temp_reg2[10];
assign temp_reg2_11 = temp_reg2[11];
assign temp_reg2_12 = temp_reg2[12];
assign temp_reg2_13 = temp_reg2[13];
assign temp_reg2_14 = temp_reg2[14];
assign temp_reg2_15 = temp_reg2[15];
assign temp_reg2_16 = temp_reg2[16];
assign temp_reg2_17 = temp_reg2[17];
assign temp_reg2_18 = temp_reg2[18];
assign temp_reg2_19 = temp_reg2[19];
assign temp_reg2_20 = temp_reg2[20];
assign temp_reg2_21 = temp_reg2[21];
assign temp_reg2_22 = temp_reg2[22];
assign temp_reg2_23 = temp_reg2[23];
assign temp_reg2_24 = temp_reg2[24];
assign temp_reg2_25 = temp_reg2[25];
assign temp_reg2_26 = temp_reg2[26];
assign temp_reg2_27 = temp_reg2[27];
assign temp_reg2_28 = temp_reg2[28];
assign temp_reg2_29 = temp_reg2[29];
assign temp_reg2_30 = temp_reg2[30];
assign temp_reg2_31 = temp_reg2[31];


assign ram_exchange_add00 = ram_exchange_add[00];
assign ram_exchange_add01 = ram_exchange_add[01];
assign ram_exchange_add02 = ram_exchange_add[02];
assign ram_exchange_add03 = ram_exchange_add[03];
assign ram_exchange_add04 = ram_exchange_add[04];
assign ram_exchange_add05 = ram_exchange_add[05];
assign ram_exchange_add06 = ram_exchange_add[06];
assign ram_exchange_add07 = ram_exchange_add[07];
assign ram_exchange_add08 = ram_exchange_add[08];
assign ram_exchange_add09 = ram_exchange_add[09];
assign ram_exchange_add10 = ram_exchange_add[10];
assign ram_exchange_add11 = ram_exchange_add[11];
assign ram_exchange_add12 = ram_exchange_add[12];
assign ram_exchange_add13 = ram_exchange_add[13];
assign ram_exchange_add14 = ram_exchange_add[14];
assign ram_exchange_add15 = ram_exchange_add[15];
assign ram_exchange_add16 = ram_exchange_add[16];
assign ram_exchange_add17 = ram_exchange_add[17];
assign ram_exchange_add18 = ram_exchange_add[18];
assign ram_exchange_add19 = ram_exchange_add[19];
assign ram_exchange_add20 = ram_exchange_add[20];
assign ram_exchange_add21 = ram_exchange_add[21];
assign ram_exchange_add22 = ram_exchange_add[22];
assign ram_exchange_add23 = ram_exchange_add[23];
assign ram_exchange_add24 = ram_exchange_add[24];
assign ram_exchange_add25 = ram_exchange_add[25];
assign ram_exchange_add26 = ram_exchange_add[26];
assign ram_exchange_add27 = ram_exchange_add[27];
assign ram_exchange_add28 = ram_exchange_add[28];
assign ram_exchange_add29 = ram_exchange_add[29];
assign ram_exchange_add30 = ram_exchange_add[30];
assign ram_exchange_add31 = ram_exchange_add[31];

//-----------temporary variables for debugging------over---------------------

//---------------------------------------------------------------------------
//STATUS
//Inference drawn on 18thJan; To read data, one needs to clock cs,oe and then in keep them high through till the next clock.this is not required for writing
//19th jan:  Scaling this block is not too easy
//on is defined by: ON if transfer is taking place at port0, else OFF
//---------------------------------------------------------------------------


//------------_Added March 08 For Bitreversing part_-------------------------
assign counter5 = counter0 - 1;
assign counter6 = counter1 - 1; 


//------------_Added March 08 For Bitreversing part_-------------------------



assign ram00_cs_we_oe_0=  (on[00])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram01_cs_we_oe_0=  (on[01])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram02_cs_we_oe_0=  (on[02])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram03_cs_we_oe_0=  (on[03])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram04_cs_we_oe_0=  (on[04])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram05_cs_we_oe_0=  (on[05])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram06_cs_we_oe_0=  (on[06])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram07_cs_we_oe_0=  (on[07])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram08_cs_we_oe_0=  (on[08])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram09_cs_we_oe_0=  (on[09])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram10_cs_we_oe_0=  (on[10])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram11_cs_we_oe_0=  (on[11])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram12_cs_we_oe_0=  (on[12])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram13_cs_we_oe_0=  (on[13])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram14_cs_we_oe_0=  (on[14])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram15_cs_we_oe_0=  (on[15])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram16_cs_we_oe_0=  (on[16])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram17_cs_we_oe_0=  (on[17])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram18_cs_we_oe_0=  (on[18])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram19_cs_we_oe_0=  (on[19])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram20_cs_we_oe_0=  (on[20])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram21_cs_we_oe_0=  (on[21])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram22_cs_we_oe_0=  (on[22])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram23_cs_we_oe_0=  (on[23])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram24_cs_we_oe_0=  (on[24])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram25_cs_we_oe_0=  (on[25])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram26_cs_we_oe_0=  (on[26])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram27_cs_we_oe_0=  (on[27])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram28_cs_we_oe_0=  (on[28])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram29_cs_we_oe_0=  (on[29])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram30_cs_we_oe_0=  (on[30])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram31_cs_we_oe_0=  (on[31])?ram_command:`RAM_COMMAND_WIDTH'b0;

assign ram00_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[0])?temp_reg2[00]:`FFT_DATA_WIDTH'bz;
assign ram01_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[1])?temp_reg2[01]:`FFT_DATA_WIDTH'bz;
assign ram02_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[2])?temp_reg2[02]:`FFT_DATA_WIDTH'bz;
assign ram03_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[3])?temp_reg2[03]:`FFT_DATA_WIDTH'bz;
assign ram04_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[4])?temp_reg2[04]:`FFT_DATA_WIDTH'bz;
assign ram05_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[5])?temp_reg2[05]:`FFT_DATA_WIDTH'bz;
assign ram06_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[6])?temp_reg2[06]:`FFT_DATA_WIDTH'bz;
assign ram07_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[7])?temp_reg2[07]:`FFT_DATA_WIDTH'bz;
assign ram08_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[8])?temp_reg2[08]:`FFT_DATA_WIDTH'bz;
assign ram09_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[9])?temp_reg2[09]:`FFT_DATA_WIDTH'bz;
assign ram10_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[10])?temp_reg2[10]:`FFT_DATA_WIDTH'bz;
assign ram11_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[11])?temp_reg2[11]:`FFT_DATA_WIDTH'bz;
assign ram12_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[12])?temp_reg2[12]:`FFT_DATA_WIDTH'bz;
assign ram13_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[13])?temp_reg2[13]:`FFT_DATA_WIDTH'bz;
assign ram14_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[14])?temp_reg2[14]:`FFT_DATA_WIDTH'bz;
assign ram15_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[15])?temp_reg2[15]:`FFT_DATA_WIDTH'bz;
assign ram16_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[16])?temp_reg2[16]:`FFT_DATA_WIDTH'bz;
assign ram17_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[17])?temp_reg2[17]:`FFT_DATA_WIDTH'bz;
assign ram18_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[18])?temp_reg2[18]:`FFT_DATA_WIDTH'bz;
assign ram19_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[19])?temp_reg2[19]:`FFT_DATA_WIDTH'bz;
assign ram20_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[20])?temp_reg2[20]:`FFT_DATA_WIDTH'bz;
assign ram21_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[21])?temp_reg2[21]:`FFT_DATA_WIDTH'bz;
assign ram22_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[22])?temp_reg2[22]:`FFT_DATA_WIDTH'bz;
assign ram23_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[23])?temp_reg2[23]:`FFT_DATA_WIDTH'bz;
assign ram24_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[24])?temp_reg2[24]:`FFT_DATA_WIDTH'bz;
assign ram25_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[25])?temp_reg2[25]:`FFT_DATA_WIDTH'bz;
assign ram26_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[26])?temp_reg2[26]:`FFT_DATA_WIDTH'bz;
assign ram27_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[27])?temp_reg2[27]:`FFT_DATA_WIDTH'bz;
assign ram28_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[28])?temp_reg2[28]:`FFT_DATA_WIDTH'bz;
assign ram29_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[29])?temp_reg2[29]:`FFT_DATA_WIDTH'bz;
assign ram30_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[30])?temp_reg2[30]:`FFT_DATA_WIDTH'bz; 
assign ram31_port0_bus = (((step==2+1)||(step==0))&~transposer_reset&on[31])?temp_reg2[31]:`FFT_DATA_WIDTH'bz; 


assign ram00_cs_we_oe_1=  (on[31])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram01_cs_we_oe_1=  (on[30])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram02_cs_we_oe_1=  (on[29])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram03_cs_we_oe_1=  (on[28])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram04_cs_we_oe_1=  (on[27])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram05_cs_we_oe_1=  (on[26])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram06_cs_we_oe_1=  (on[25])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram07_cs_we_oe_1=  (on[24])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram08_cs_we_oe_1=  (on[23])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram09_cs_we_oe_1=  (on[22])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram10_cs_we_oe_1=  (on[21])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram11_cs_we_oe_1=  (on[20])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram12_cs_we_oe_1=  (on[19])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram13_cs_we_oe_1=  (on[18])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram14_cs_we_oe_1=  (on[17])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram15_cs_we_oe_1=  (on[16])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram16_cs_we_oe_1=  (on[15])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram17_cs_we_oe_1=  (on[14])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram18_cs_we_oe_1=  (on[13])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram19_cs_we_oe_1=  (on[12])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram20_cs_we_oe_1=  (on[11])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram21_cs_we_oe_1=  (on[10])?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram22_cs_we_oe_1=  (on[9]) ?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram23_cs_we_oe_1=  (on[8]) ?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram24_cs_we_oe_1=  (on[7]) ?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram25_cs_we_oe_1=  (on[6]) ?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram26_cs_we_oe_1=  (on[5]) ?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram27_cs_we_oe_1=  (on[4]) ?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram28_cs_we_oe_1=  (on[3]) ?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram29_cs_we_oe_1=  (on[2]) ?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram30_cs_we_oe_1=  (on[1]) ?ram_command:`RAM_COMMAND_WIDTH'b0;
assign ram31_cs_we_oe_1=  (on[0]) ?ram_command:`RAM_COMMAND_WIDTH'b0;

assign ram00_port1_add=  (on[31])?((done_transpose_local)?ram_exchange_add[00]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+00)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram01_port1_add=  (on[30])?((done_transpose_local)?ram_exchange_add[01]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+01)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram02_port1_add=  (on[29])?((done_transpose_local)?ram_exchange_add[02]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+02)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram03_port1_add=  (on[28])?((done_transpose_local)?ram_exchange_add[03]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+03)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram04_port1_add=  (on[27])?((done_transpose_local)?ram_exchange_add[04]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+04)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram05_port1_add=  (on[26])?((done_transpose_local)?ram_exchange_add[05]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+05)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram06_port1_add=  (on[25])?((done_transpose_local)?ram_exchange_add[06]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+06)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram07_port1_add=  (on[24])?((done_transpose_local)?ram_exchange_add[07]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+07)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram08_port1_add=  (on[23])?((done_transpose_local)?ram_exchange_add[08]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+08)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram09_port1_add=  (on[22])?((done_transpose_local)?ram_exchange_add[09]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+09)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram10_port1_add=  (on[21])?((done_transpose_local)?ram_exchange_add[10]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+10)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram11_port1_add=  (on[20])?((done_transpose_local)?ram_exchange_add[11]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+11)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram12_port1_add=  (on[19])?((done_transpose_local)?ram_exchange_add[12]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+12)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram13_port1_add=  (on[18])?((done_transpose_local)?ram_exchange_add[13]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+13)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram14_port1_add=  (on[17])?((done_transpose_local)?ram_exchange_add[14]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+14)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram15_port1_add=  (on[16])?((done_transpose_local)?ram_exchange_add[15]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+15)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram16_port1_add=  (on[15])?((done_transpose_local)?ram_exchange_add[16]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+16)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram17_port1_add=  (on[14])?((done_transpose_local)?ram_exchange_add[17]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+17)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram18_port1_add=  (on[13])?((done_transpose_local)?ram_exchange_add[18]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+18)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram19_port1_add=  (on[12])?((done_transpose_local)?ram_exchange_add[19]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+19)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram20_port1_add=  (on[11])?((done_transpose_local)?ram_exchange_add[20]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+20)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram21_port1_add=  (on[10])?((done_transpose_local)?ram_exchange_add[21]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+21)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram22_port1_add=  (on[9])? ((done_transpose_local)?ram_exchange_add[22]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+22)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram23_port1_add=  (on[8])? ((done_transpose_local)?ram_exchange_add[23]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+23)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram24_port1_add=  (on[7])? ((done_transpose_local)?ram_exchange_add[24]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+24)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram25_port1_add=  (on[6])? ((done_transpose_local)?ram_exchange_add[25]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+25)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram26_port1_add=  (on[5])? ((done_transpose_local)?ram_exchange_add[26]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+26)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram27_port1_add=  (on[4])? ((done_transpose_local)?ram_exchange_add[27]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+27)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram28_port1_add=  (on[3])? ((done_transpose_local)?ram_exchange_add[28]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+28)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram29_port1_add=  (on[2])? ((done_transpose_local)?ram_exchange_add[29]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+29)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram30_port1_add=  (on[1])? ((done_transpose_local)?ram_exchange_add[30]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+30)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};
assign ram31_port1_add=  (on[0])? ((done_transpose_local)?ram_exchange_add[31]:ram_exchange_add[(`NO_OF_UNITS-delayed_j+31)%`NO_OF_UNITS]):{`FFT2D_C_RAM_ADD_BITS'bz,`RAM_ADD_WIDTH'bz};


assign ram00_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[31])?((done_transpose_local)?temp_reg1[00]:temp_reg1[(`NO_OF_UNITS-delayed_j+00)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram01_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[30])?((done_transpose_local)?temp_reg1[01]:temp_reg1[(`NO_OF_UNITS-delayed_j+01)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram02_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[29])?((done_transpose_local)?temp_reg1[02]:temp_reg1[(`NO_OF_UNITS-delayed_j+02)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram03_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[28])?((done_transpose_local)?temp_reg1[03]:temp_reg1[(`NO_OF_UNITS-delayed_j+03)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram04_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[27])?((done_transpose_local)?temp_reg1[04]:temp_reg1[(`NO_OF_UNITS-delayed_j+04)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram05_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[26])?((done_transpose_local)?temp_reg1[05]:temp_reg1[(`NO_OF_UNITS-delayed_j+05)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram06_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[25])?((done_transpose_local)?temp_reg1[06]:temp_reg1[(`NO_OF_UNITS-delayed_j+06)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram07_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[24])?((done_transpose_local)?temp_reg1[07]:temp_reg1[(`NO_OF_UNITS-delayed_j+07)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram08_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[23])?((done_transpose_local)?temp_reg1[08]:temp_reg1[(`NO_OF_UNITS-delayed_j+08)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram09_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[22])?((done_transpose_local)?temp_reg1[09]:temp_reg1[(`NO_OF_UNITS-delayed_j+09)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram10_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[21])?((done_transpose_local)?temp_reg1[10]:temp_reg1[(`NO_OF_UNITS-delayed_j+10)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram11_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[20])?((done_transpose_local)?temp_reg1[11]:temp_reg1[(`NO_OF_UNITS-delayed_j+11)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram12_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[19])?((done_transpose_local)?temp_reg1[12]:temp_reg1[(`NO_OF_UNITS-delayed_j+12)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram13_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[18])?((done_transpose_local)?temp_reg1[13]:temp_reg1[(`NO_OF_UNITS-delayed_j+13)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram14_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[17])?((done_transpose_local)?temp_reg1[14]:temp_reg1[(`NO_OF_UNITS-delayed_j+14)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram15_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[16])?((done_transpose_local)?temp_reg1[15]:temp_reg1[(`NO_OF_UNITS-delayed_j+15)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram16_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[15])?((done_transpose_local)?temp_reg1[16]:temp_reg1[(`NO_OF_UNITS-delayed_j+16)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram17_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[14])?((done_transpose_local)?temp_reg1[17]:temp_reg1[(`NO_OF_UNITS-delayed_j+17)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram18_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[13])?((done_transpose_local)?temp_reg1[18]:temp_reg1[(`NO_OF_UNITS-delayed_j+18)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram19_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[12])?((done_transpose_local)?temp_reg1[19]:temp_reg1[(`NO_OF_UNITS-delayed_j+19)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram20_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[11])?((done_transpose_local)?temp_reg1[20]:temp_reg1[(`NO_OF_UNITS-delayed_j+20)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram21_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[10])?((done_transpose_local)?temp_reg1[21]:temp_reg1[(`NO_OF_UNITS-delayed_j+21)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram22_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[09])?((done_transpose_local)?temp_reg1[22]:temp_reg1[(`NO_OF_UNITS-delayed_j+22)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram23_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[08])?((done_transpose_local)?temp_reg1[23]:temp_reg1[(`NO_OF_UNITS-delayed_j+23)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram24_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[07])?((done_transpose_local)?temp_reg1[24]:temp_reg1[(`NO_OF_UNITS-delayed_j+24)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram25_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[06])?((done_transpose_local)?temp_reg1[25]:temp_reg1[(`NO_OF_UNITS-delayed_j+25)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram26_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[05])?((done_transpose_local)?temp_reg1[26]:temp_reg1[(`NO_OF_UNITS-delayed_j+26)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram27_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[04])?((done_transpose_local)?temp_reg1[27]:temp_reg1[(`NO_OF_UNITS-delayed_j+27)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram28_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[03])?((done_transpose_local)?temp_reg1[28]:temp_reg1[(`NO_OF_UNITS-delayed_j+28)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram29_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[02])?((done_transpose_local)?temp_reg1[29]:temp_reg1[(`NO_OF_UNITS-delayed_j+29)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram30_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[01])?((done_transpose_local)?temp_reg1[30]:temp_reg1[(`NO_OF_UNITS-delayed_j+30)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;
assign ram31_port1_bus = (((step==2+1)||(step==0))&~transposer_reset&on[00])?((done_transpose_local)?temp_reg1[31]:temp_reg1[(`NO_OF_UNITS-delayed_j+31)%`NO_OF_UNITS]):`FFT_DATA_WIDTH'bz;


//---------------------------------------------------------------------------------------------------------------

`include "Transposer_temp/Transposer_temp.v"


//---------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------



//---------------------------------------------------------------------------------------------------------------

always @ (posedge transposer_clk or posedge transposer_reset)
begin
	if(transposer_reset)
	begin
		add_first_bit	<= 1'b1;	//In reality/practice should be 1'b1.Change when not debugging!
		i 		<= 0;
		j 		<= 1;	
		delayed_j	<= 0;
		step 		<= 0;
		done_transpose  <= 0;
		done_transpose_local <=0;
		counter0 	<= 1;		//bitreversing running var 1
		counter1 	<= 1;		//bitreversing running var 2
		counter2 	<=64;		//bitreversing var 3
		bitstep		<= 0;		//bitreversing var 4
		on 		<=-1;
		ram_command 	<= 3'b1_0_0;
		temp_reg1[0]  <= 0;temp_reg1[1]  <= 0;temp_reg1[2]  <= 0;temp_reg1[3]  <= 0;temp_reg1[4]  <= 0;temp_reg1[5]  <= 0;
		temp_reg1[6]  <= 0;temp_reg1[7]  <= 0;temp_reg1[8]  <= 0;temp_reg1[9]  <= 0;temp_reg1[10] <= 0;temp_reg1[11] <= 0;
		temp_reg1[12] <= 0;temp_reg1[13] <= 0;temp_reg1[14] <= 0;temp_reg1[15] <= 0;temp_reg1[16] <= 0;temp_reg1[17] <= 0;
		temp_reg1[18] <= 0;temp_reg1[19] <= 0;temp_reg1[20] <= 0;temp_reg1[21] <= 0;temp_reg1[22] <= 0;temp_reg1[23] <= 0;
		temp_reg1[24] <= 0;temp_reg1[25] <= 0;temp_reg1[26] <= 0;temp_reg1[27] <= 0;temp_reg1[28] <= 0;temp_reg1[29] <= 0;
		temp_reg1[30] <= 0;temp_reg1[31] <= 0;
		temp_reg2[0]  <= 0;temp_reg2[1]  <= 0;temp_reg2[2]  <= 0;temp_reg2[3]  <= 0;temp_reg2[4]  <= 0;temp_reg2[5]  <= 0;
		temp_reg2[6]  <= 0;temp_reg2[7]  <= 0;temp_reg2[8]  <= 0;temp_reg2[9]  <= 0;temp_reg2[10] <= 0;temp_reg2[11] <= 0;
		temp_reg2[12] <= 0;temp_reg2[13] <= 0;temp_reg2[14] <= 0;temp_reg2[15] <= 0;temp_reg2[16] <= 0;temp_reg2[17] <= 0;
		temp_reg2[18] <= 0;temp_reg2[19] <= 0;temp_reg2[20] <= 0;temp_reg2[21] <= 0;temp_reg2[22] <= 0;temp_reg2[23] <= 0;
		temp_reg2[24] <= 0;temp_reg2[25] <= 0;temp_reg2[26] <= 0;temp_reg2[27] <= 0;temp_reg2[28] <= 0;temp_reg2[29] <= 0;
		temp_reg2[30] <= 0;temp_reg2[31] <= 0;
		ram_exchange_add[0]  <= 0;ram_exchange_add[1]  <= 0;ram_exchange_add[2]  <= 0;ram_exchange_add[3]  <= 0;
		ram_exchange_add[4]  <= 0;ram_exchange_add[5]  <= 0;ram_exchange_add[6]  <= 0;ram_exchange_add[7]  <= 0;
		ram_exchange_add[8]  <= 0;ram_exchange_add[9]  <= 0;ram_exchange_add[10] <= 0;ram_exchange_add[11] <= 0;
		ram_exchange_add[12] <= 0;ram_exchange_add[13] <= 0;ram_exchange_add[14] <= 0;ram_exchange_add[15] <= 0;
		ram_exchange_add[16] <= 0;ram_exchange_add[17] <= 0;ram_exchange_add[18] <= 0;ram_exchange_add[19] <= 0;
		ram_exchange_add[20] <= 0;ram_exchange_add[21] <= 0;ram_exchange_add[22] <= 0;ram_exchange_add[23] <= 0;
		ram_exchange_add[24] <= 0;ram_exchange_add[25] <= 0;ram_exchange_add[26] <= 0;ram_exchange_add[27] <= 0;
		ram_exchange_add[28] <= 0;ram_exchange_add[29] <= 0;ram_exchange_add[30] <= 0;ram_exchange_add[31] <= 0;
		ram00_port0_add <= 0;ram01_port0_add <= 0;ram02_port0_add <= 0;ram03_port0_add <= 0;ram04_port0_add <= 0;
		ram05_port0_add <= 0;ram06_port0_add <= 0;ram07_port0_add <= 0;ram08_port0_add <= 0;ram09_port0_add <= 0;
		ram10_port0_add <= 0;ram11_port0_add <= 0;ram12_port0_add <= 0;ram13_port0_add <= 0;ram14_port0_add <= 0;
		ram15_port0_add <= 0;ram16_port0_add <= 0;ram17_port0_add <= 0;ram18_port0_add <= 0;ram19_port0_add <= 0;
		ram20_port0_add <= 0;ram21_port0_add <= 0;ram22_port0_add <= 0;ram23_port0_add <= 0;ram24_port0_add <= 0;
		ram25_port0_add <= 0;ram26_port0_add <= 0;ram27_port0_add <= 0;ram28_port0_add <= 0;ram29_port0_add <= 0;
		ram30_port0_add <= 0;ram31_port0_add <= 0;
		
	end
	else
	begin
		if(~done_transpose_local)
		begin
			case(step)
			0:begin
				if(j == 0)	//Has reached terminating step
				begin
					if(i==`MAX_RAM_ROWS-1)
					begin
						done_transpose_local <= 1;	//Should be done HERE.
						on <= -1;
						ram_command <= {1'b1,1'b0,1'b0};
						i <= 0;	
					end
				end
				delayed_j <= j;
				step <= step + 1;	
				ram_command <= {1'b1,1'b0,1'b1};	//COMMAND : READ
				if((i==1)&&(j==`NO_OF_UNITS+1))
				begin
					on <= ((-1)>>1)	;
				end
				else if(j>=`NO_OF_UNITS)
				begin
					on <= on &(~(1<<(`NO_OF_POINTS-j)));
				end
	
				ram_exchange_add[00] <= {add_first_bit,((j+00)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_0000:6'b10_0000,1'b0};//'ele2(re)'
				ram_exchange_add[01] <= {add_first_bit,((j+01)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_0001:6'b10_0001,1'b0};//'ele2(re)'
				ram_exchange_add[02] <= {add_first_bit,((j+02)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_0010:6'b10_0010,1'b0};//'ele2(re)'
				ram_exchange_add[03] <= {add_first_bit,((j+03)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_0011:6'b10_0011,1'b0};//'ele2(re)'
				ram_exchange_add[04] <= {add_first_bit,((j+04)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_0100:6'b10_0100,1'b0};//'ele2(re)'
				ram_exchange_add[05] <= {add_first_bit,((j+05)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_0101:6'b10_0101,1'b0};//'ele2(re)'
				ram_exchange_add[06] <= {add_first_bit,((j+06)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_0110:6'b10_0110,1'b0};//'ele2(re)'
				ram_exchange_add[07] <= {add_first_bit,((j+07)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_0111:6'b10_0111,1'b0};//'ele2(re)'
				ram_exchange_add[08] <= {add_first_bit,((j+08)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_1000:6'b10_1000,1'b0};//'ele2(re)'
				ram_exchange_add[09] <= {add_first_bit,((j+09)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_1001:6'b10_1001,1'b0};//'ele2(re)'
				ram_exchange_add[10] <= {add_first_bit,((j+10)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_1010:6'b10_1010,1'b0};//'ele2(re)'
				ram_exchange_add[11] <= {add_first_bit,((j+11)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_1011:6'b10_1011,1'b0};//'ele2(re)'
				ram_exchange_add[12] <= {add_first_bit,((j+12)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_1100:6'b10_1100,1'b0};//'ele2(re)'
				ram_exchange_add[13] <= {add_first_bit,((j+13)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_1101:6'b10_1101,1'b0};//'ele2(re)'
				ram_exchange_add[14] <= {add_first_bit,((j+14)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_1110:6'b10_1110,1'b0};//'ele2(re)'
				ram_exchange_add[15] <= {add_first_bit,((j+15)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_1111:6'b10_1111,1'b0};//'ele2(re)'
				ram_exchange_add[16] <= {add_first_bit,((j+16)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_0000:6'b11_0000,1'b0};//'ele2(re)'
				ram_exchange_add[17] <= {add_first_bit,((j+17)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_0001:6'b11_0001,1'b0};//'ele2(re)'
				ram_exchange_add[18] <= {add_first_bit,((j+18)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_0010:6'b11_0010,1'b0};//'ele2(re)'
				ram_exchange_add[19] <= {add_first_bit,((j+19)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_0011:6'b11_0011,1'b0};//'ele2(re)'
				ram_exchange_add[20] <= {add_first_bit,((j+20)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_0100:6'b11_0100,1'b0};//'ele2(re)'
				ram_exchange_add[21] <= {add_first_bit,((j+21)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_0101:6'b11_0101,1'b0};//'ele2(re)'
				ram_exchange_add[22] <= {add_first_bit,((j+22)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_0110:6'b11_0110,1'b0};//'ele2(re)'
				ram_exchange_add[23] <= {add_first_bit,((j+23)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_0111:6'b11_0111,1'b0};//'ele2(re)'
				ram_exchange_add[24] <= {add_first_bit,((j+24)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_1000:6'b11_1000,1'b0};//'ele2(re)'
				ram_exchange_add[25] <= {add_first_bit,((j+25)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_1001:6'b11_1001,1'b0};//'ele2(re)'
				ram_exchange_add[26] <= {add_first_bit,((j+26)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_1010:6'b11_1010,1'b0};//'ele2(re)'
				ram_exchange_add[27] <= {add_first_bit,((j+27)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_1011:6'b11_1011,1'b0};//'ele2(re)'
				ram_exchange_add[28] <= {add_first_bit,((j+28)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_1100:6'b11_1100,1'b0};//'ele2(re)'
				ram_exchange_add[29] <= {add_first_bit,((j+29)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_1101:6'b11_1101,1'b0};//'ele2(re)'
				ram_exchange_add[30] <= {add_first_bit,((j+30)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_1110:6'b11_1110,1'b0};//'ele2(re)'
				ram_exchange_add[31] <= {add_first_bit,((j+31)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_1111:6'b11_1111,1'b0};//'ele2(re)'	
			
				ram00_port0_add  <= {add_first_bit,i,j+6'b00_0000,1'b0};//'ele1(re)'
				ram01_port0_add  <= {add_first_bit,i,j+6'b00_0001,1'b0};//'ele1(re)'
				ram02_port0_add  <= {add_first_bit,i,j+6'b00_0010,1'b0};//'ele1(re)'
				ram03_port0_add  <= {add_first_bit,i,j+6'b00_0011,1'b0};//'ele1(re)'
				ram04_port0_add  <= {add_first_bit,i,j+6'b00_0100,1'b0};//'ele1(re)'
				ram05_port0_add  <= {add_first_bit,i,j+6'b00_0101,1'b0};//'ele1(re)'
				ram06_port0_add  <= {add_first_bit,i,j+6'b00_0110,1'b0};//'ele1(re)'
				ram07_port0_add  <= {add_first_bit,i,j+6'b00_0111,1'b0};//'ele1(re)'
				ram08_port0_add  <= {add_first_bit,i,j+6'b00_1000,1'b0};//'ele1(re)'
				ram09_port0_add  <= {add_first_bit,i,j+6'b00_1001,1'b0};//'ele1(re)'
				ram10_port0_add  <= {add_first_bit,i,j+6'b00_1010,1'b0};//'ele1(re)'
				ram11_port0_add  <= {add_first_bit,i,j+6'b00_1011,1'b0};//'ele1(re)'
				ram12_port0_add  <= {add_first_bit,i,j+6'b00_1100,1'b0};//'ele1(re)'
				ram13_port0_add  <= {add_first_bit,i,j+6'b00_1101,1'b0};//'ele1(re)'
				ram14_port0_add  <= {add_first_bit,i,j+6'b00_1110,1'b0};//'ele1(re)'
				ram15_port0_add  <= {add_first_bit,i,j+6'b00_1111,1'b0};//'ele1(re)'
				ram16_port0_add  <= {add_first_bit,i,j+6'b01_0000,1'b0};//'ele1(re)'
				ram17_port0_add  <= {add_first_bit,i,j+6'b01_0001,1'b0};//'ele1(re)'
				ram18_port0_add  <= {add_first_bit,i,j+6'b01_0010,1'b0};//'ele1(re)'
				ram19_port0_add  <= {add_first_bit,i,j+6'b01_0011,1'b0};//'ele1(re)'
				ram20_port0_add  <= {add_first_bit,i,j+6'b01_0100,1'b0};//'ele1(re)'
				ram21_port0_add  <= {add_first_bit,i,j+6'b01_0101,1'b0};//'ele1(re)'
				ram22_port0_add  <= {add_first_bit,i,j+6'b01_0110,1'b0};//'ele1(re)'
				ram23_port0_add  <= {add_first_bit,i,j+6'b01_0111,1'b0};//'ele1(re)'
				ram24_port0_add  <= {add_first_bit,i,j+6'b01_1000,1'b0};//'ele1(re)'
				ram25_port0_add  <= {add_first_bit,i,j+6'b01_1001,1'b0};//'ele1(re)'
				ram26_port0_add  <= {add_first_bit,i,j+6'b01_1010,1'b0};//'ele1(re)'
				ram27_port0_add  <= {add_first_bit,i,j+6'b01_1011,1'b0};//'ele1(re)'
				ram28_port0_add  <= {add_first_bit,i,j+6'b01_1100,1'b0};//'ele1(re)'
				ram29_port0_add  <= {add_first_bit,i,j+6'b01_1101,1'b0};//'ele1(re)'
				ram30_port0_add  <= {add_first_bit,i,j+6'b01_1110,1'b0};//'ele1(re)'
				ram31_port0_add  <= {add_first_bit,i,j+6'b01_1111,1'b0};//'ele1(re)'			
	
			end
			1:begin
				step <= step + 1;			//COMMAND : READ
				//cant sample databus into temp regs here
			end
			2:begin
				step <= step + 1;	
				ram_command <= {1'b1,1'b1,1'b0};	//COMMAND :WRITE
				temp_reg1[00] <= ram00_port0_bus;
				temp_reg1[01] <= ram01_port0_bus;
				temp_reg1[02] <= ram02_port0_bus;
				temp_reg1[03] <= ram03_port0_bus;
				temp_reg1[04] <= ram04_port0_bus;
				temp_reg1[05] <= ram05_port0_bus;
				temp_reg1[06] <= ram06_port0_bus;
				temp_reg1[07] <= ram07_port0_bus;
				temp_reg1[08] <= ram08_port0_bus;
				temp_reg1[09] <= ram09_port0_bus;
				temp_reg1[10] <= ram10_port0_bus;
				temp_reg1[11] <= ram11_port0_bus;
				temp_reg1[12] <= ram12_port0_bus;
				temp_reg1[13] <= ram13_port0_bus;
				temp_reg1[14] <= ram14_port0_bus;
				temp_reg1[15] <= ram15_port0_bus;
				temp_reg1[16] <= ram16_port0_bus;
				temp_reg1[17] <= ram17_port0_bus;
				temp_reg1[18] <= ram18_port0_bus;
				temp_reg1[19] <= ram19_port0_bus;
				temp_reg1[20] <= ram20_port0_bus;
				temp_reg1[21] <= ram21_port0_bus;
				temp_reg1[22] <= ram22_port0_bus;
				temp_reg1[23] <= ram23_port0_bus;
				temp_reg1[24] <= ram24_port0_bus;
				temp_reg1[25] <= ram25_port0_bus;
				temp_reg1[26] <= ram26_port0_bus;
				temp_reg1[27] <= ram27_port0_bus;
				temp_reg1[28] <= ram28_port0_bus;
				temp_reg1[29] <= ram29_port0_bus;
				temp_reg1[30] <= ram30_port0_bus;
				temp_reg1[31] <= ram31_port0_bus;
				
				temp_reg2[00] <= ram_exchange_bus[( 1)*`FFT_DATA_WIDTH-1:( 0)*`FFT_DATA_WIDTH];
				temp_reg2[01] <= ram_exchange_bus[( 2)*`FFT_DATA_WIDTH-1:( 1)*`FFT_DATA_WIDTH];
				temp_reg2[02] <= ram_exchange_bus[( 3)*`FFT_DATA_WIDTH-1:( 2)*`FFT_DATA_WIDTH];
				temp_reg2[03] <= ram_exchange_bus[( 4)*`FFT_DATA_WIDTH-1:( 3)*`FFT_DATA_WIDTH];
				temp_reg2[04] <= ram_exchange_bus[( 5)*`FFT_DATA_WIDTH-1:( 4)*`FFT_DATA_WIDTH];
				temp_reg2[05] <= ram_exchange_bus[( 6)*`FFT_DATA_WIDTH-1:( 5)*`FFT_DATA_WIDTH];
				temp_reg2[06] <= ram_exchange_bus[( 7)*`FFT_DATA_WIDTH-1:( 6)*`FFT_DATA_WIDTH];
				temp_reg2[07] <= ram_exchange_bus[( 8)*`FFT_DATA_WIDTH-1:( 7)*`FFT_DATA_WIDTH];
				temp_reg2[08] <= ram_exchange_bus[( 9)*`FFT_DATA_WIDTH-1:( 8)*`FFT_DATA_WIDTH];
				temp_reg2[09] <= ram_exchange_bus[(10)*`FFT_DATA_WIDTH-1:( 9)*`FFT_DATA_WIDTH];
				temp_reg2[10] <= ram_exchange_bus[(11)*`FFT_DATA_WIDTH-1:(10)*`FFT_DATA_WIDTH];
				temp_reg2[11] <= ram_exchange_bus[(12)*`FFT_DATA_WIDTH-1:(11)*`FFT_DATA_WIDTH];
				temp_reg2[12] <= ram_exchange_bus[(13)*`FFT_DATA_WIDTH-1:(12)*`FFT_DATA_WIDTH];
				temp_reg2[13] <= ram_exchange_bus[(14)*`FFT_DATA_WIDTH-1:(13)*`FFT_DATA_WIDTH];
				temp_reg2[14] <= ram_exchange_bus[(15)*`FFT_DATA_WIDTH-1:(14)*`FFT_DATA_WIDTH];
				temp_reg2[15] <= ram_exchange_bus[(16)*`FFT_DATA_WIDTH-1:(15)*`FFT_DATA_WIDTH];
				temp_reg2[16] <= ram_exchange_bus[(17)*`FFT_DATA_WIDTH-1:(16)*`FFT_DATA_WIDTH];
				temp_reg2[17] <= ram_exchange_bus[(18)*`FFT_DATA_WIDTH-1:(17)*`FFT_DATA_WIDTH];
				temp_reg2[18] <= ram_exchange_bus[(19)*`FFT_DATA_WIDTH-1:(18)*`FFT_DATA_WIDTH];
				temp_reg2[19] <= ram_exchange_bus[(20)*`FFT_DATA_WIDTH-1:(19)*`FFT_DATA_WIDTH];
				temp_reg2[20] <= ram_exchange_bus[(21)*`FFT_DATA_WIDTH-1:(20)*`FFT_DATA_WIDTH];
				temp_reg2[21] <= ram_exchange_bus[(22)*`FFT_DATA_WIDTH-1:(21)*`FFT_DATA_WIDTH];
				temp_reg2[22] <= ram_exchange_bus[(23)*`FFT_DATA_WIDTH-1:(22)*`FFT_DATA_WIDTH];
				temp_reg2[23] <= ram_exchange_bus[(24)*`FFT_DATA_WIDTH-1:(23)*`FFT_DATA_WIDTH];
				temp_reg2[24] <= ram_exchange_bus[(25)*`FFT_DATA_WIDTH-1:(24)*`FFT_DATA_WIDTH];
				temp_reg2[25] <= ram_exchange_bus[(26)*`FFT_DATA_WIDTH-1:(25)*`FFT_DATA_WIDTH];
				temp_reg2[26] <= ram_exchange_bus[(27)*`FFT_DATA_WIDTH-1:(26)*`FFT_DATA_WIDTH];
				temp_reg2[27] <= ram_exchange_bus[(28)*`FFT_DATA_WIDTH-1:(27)*`FFT_DATA_WIDTH];
				temp_reg2[28] <= ram_exchange_bus[(29)*`FFT_DATA_WIDTH-1:(28)*`FFT_DATA_WIDTH];
				temp_reg2[29] <= ram_exchange_bus[(30)*`FFT_DATA_WIDTH-1:(29)*`FFT_DATA_WIDTH];
				temp_reg2[30] <= ram_exchange_bus[(31)*`FFT_DATA_WIDTH-1:(30)*`FFT_DATA_WIDTH];
				temp_reg2[31] <= ram_exchange_bus[(32)*`FFT_DATA_WIDTH-1:(31)*`FFT_DATA_WIDTH];

			end
			3:begin
				step <= step + 1;
				ram_command <= {1'b1,1'b0,1'b1};	//COMMAND : READ
				//ram writing takes place at this cycle's start. 
				//Now can change the command reg back to reading
				ram_exchange_add[00] <= {add_first_bit,((j+00)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_0000:6'b10_0000,1'b1};//'ele2(im)'
				ram_exchange_add[01] <= {add_first_bit,((j+01)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_0001:6'b10_0001,1'b1};//'ele2(im)'
				ram_exchange_add[02] <= {add_first_bit,((j+02)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_0010:6'b10_0010,1'b1};//'ele2(im)'
				ram_exchange_add[03] <= {add_first_bit,((j+03)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_0011:6'b10_0011,1'b1};//'ele2(im)'
				ram_exchange_add[04] <= {add_first_bit,((j+04)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_0100:6'b10_0100,1'b1};//'ele2(im)'
				ram_exchange_add[05] <= {add_first_bit,((j+05)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_0101:6'b10_0101,1'b1};//'ele2(im)'
				ram_exchange_add[06] <= {add_first_bit,((j+06)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_0110:6'b10_0110,1'b1};//'ele2(im)'
				ram_exchange_add[07] <= {add_first_bit,((j+07)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_0111:6'b10_0111,1'b1};//'ele2(im)'
				ram_exchange_add[08] <= {add_first_bit,((j+08)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_1000:6'b10_1000,1'b1};//'ele2(im)'
				ram_exchange_add[09] <= {add_first_bit,((j+09)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_1001:6'b10_1001,1'b1};//'ele2(im)'
				ram_exchange_add[10] <= {add_first_bit,((j+10)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_1010:6'b10_1010,1'b1};//'ele2(im)'
				ram_exchange_add[11] <= {add_first_bit,((j+11)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_1011:6'b10_1011,1'b1};//'ele2(im)'
				ram_exchange_add[12] <= {add_first_bit,((j+12)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_1100:6'b10_1100,1'b1};//'ele2(im)'
				ram_exchange_add[13] <= {add_first_bit,((j+13)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_1101:6'b10_1101,1'b1};//'ele2(im)'
				ram_exchange_add[14] <= {add_first_bit,((j+14)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_1110:6'b10_1110,1'b1};//'ele2(im)'
				ram_exchange_add[15] <= {add_first_bit,((j+15)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b00_1111:6'b10_1111,1'b1};//'ele2(im)'
				ram_exchange_add[16] <= {add_first_bit,((j+16)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_0000:6'b11_0000,1'b1};//'ele2(im)'
				ram_exchange_add[17] <= {add_first_bit,((j+17)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_0001:6'b11_0001,1'b1};//'ele2(im)'
				ram_exchange_add[18] <= {add_first_bit,((j+18)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_0010:6'b11_0010,1'b1};//'ele2(im)'
				ram_exchange_add[19] <= {add_first_bit,((j+19)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_0011:6'b11_0011,1'b1};//'ele2(im)'
				ram_exchange_add[20] <= {add_first_bit,((j+20)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_0100:6'b11_0100,1'b1};//'ele2(im)'
				ram_exchange_add[21] <= {add_first_bit,((j+21)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_0101:6'b11_0101,1'b1};//'ele2(im)'
				ram_exchange_add[22] <= {add_first_bit,((j+22)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_0110:6'b11_0110,1'b1};//'ele2(im)'
				ram_exchange_add[23] <= {add_first_bit,((j+23)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_0111:6'b11_0111,1'b1};//'ele2(im)'
				ram_exchange_add[24] <= {add_first_bit,((j+24)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_1000:6'b11_1000,1'b1};//'ele2(im)'
				ram_exchange_add[25] <= {add_first_bit,((j+25)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_1001:6'b11_1001,1'b1};//'ele2(im)'
				ram_exchange_add[26] <= {add_first_bit,((j+26)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_1010:6'b11_1010,1'b1};//'ele2(im)'
				ram_exchange_add[27] <= {add_first_bit,((j+27)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_1011:6'b11_1011,1'b1};//'ele2(im)'
				ram_exchange_add[28] <= {add_first_bit,((j+28)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_1100:6'b11_1100,1'b1};//'ele2(im)'
				ram_exchange_add[29] <= {add_first_bit,((j+29)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_1101:6'b11_1101,1'b1};//'ele2(im)'
				ram_exchange_add[30] <= {add_first_bit,((j+30)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_1110:6'b11_1110,1'b1};//'ele2(im)'
				ram_exchange_add[31] <= {add_first_bit,((j+31)> `NO_OF_UNITS-1)? 1'b1:1'b0,(i==0)?6'b01_1111:6'b11_1111,1'b1};//'ele2(im)'		
			
				ram00_port0_add  <= {add_first_bit,i,j+6'b00_0000,1'b1};//'ele1(im)'
				ram01_port0_add  <= {add_first_bit,i,j+6'b00_0001,1'b1};//'ele1(im)'
				ram02_port0_add  <= {add_first_bit,i,j+6'b00_0010,1'b1};//'ele1(im)'
				ram03_port0_add  <= {add_first_bit,i,j+6'b00_0011,1'b1};//'ele1(im)'
				ram04_port0_add  <= {add_first_bit,i,j+6'b00_0100,1'b1};//'ele1(im)'
				ram05_port0_add  <= {add_first_bit,i,j+6'b00_0101,1'b1};//'ele1(im)'
				ram06_port0_add  <= {add_first_bit,i,j+6'b00_0110,1'b1};//'ele1(im)'
				ram07_port0_add  <= {add_first_bit,i,j+6'b00_0111,1'b1};//'ele1(im)'
				ram08_port0_add  <= {add_first_bit,i,j+6'b00_1000,1'b1};//'ele1(im)'
				ram09_port0_add  <= {add_first_bit,i,j+6'b00_1001,1'b1};//'ele1(im)'
				ram10_port0_add  <= {add_first_bit,i,j+6'b00_1010,1'b1};//'ele1(im)'
				ram11_port0_add  <= {add_first_bit,i,j+6'b00_1011,1'b1};//'ele1(im)'
				ram12_port0_add  <= {add_first_bit,i,j+6'b00_1100,1'b1};//'ele1(im)'
				ram13_port0_add  <= {add_first_bit,i,j+6'b00_1101,1'b1};//'ele1(im)'
				ram14_port0_add  <= {add_first_bit,i,j+6'b00_1110,1'b1};//'ele1(im)'
				ram15_port0_add  <= {add_first_bit,i,j+6'b00_1111,1'b1};//'ele1(im)'
				ram16_port0_add  <= {add_first_bit,i,j+6'b01_0000,1'b1};//'ele1(im)'
				ram17_port0_add  <= {add_first_bit,i,j+6'b01_0001,1'b1};//'ele1(im)'
				ram18_port0_add  <= {add_first_bit,i,j+6'b01_0010,1'b1};//'ele1(im)'
				ram19_port0_add  <= {add_first_bit,i,j+6'b01_0011,1'b1};//'ele1(im)'
				ram20_port0_add  <= {add_first_bit,i,j+6'b01_0100,1'b1};//'ele1(im)'
				ram21_port0_add  <= {add_first_bit,i,j+6'b01_0101,1'b1};//'ele1(im)'
				ram22_port0_add  <= {add_first_bit,i,j+6'b01_0110,1'b1};//'ele1(im)'
				ram23_port0_add  <= {add_first_bit,i,j+6'b01_0111,1'b1};//'ele1(im)'
				ram24_port0_add  <= {add_first_bit,i,j+6'b01_1000,1'b1};//'ele1(im)'
				ram25_port0_add  <= {add_first_bit,i,j+6'b01_1001,1'b1};//'ele1(im)'
				ram26_port0_add  <= {add_first_bit,i,j+6'b01_1010,1'b1};//'ele1(im)'
				ram27_port0_add  <= {add_first_bit,i,j+6'b01_1011,1'b1};//'ele1(im)'
				ram28_port0_add  <= {add_first_bit,i,j+6'b01_1100,1'b1};//'ele1(im)'
				ram29_port0_add  <= {add_first_bit,i,j+6'b01_1101,1'b1};//'ele1(im)'
				ram30_port0_add  <= {add_first_bit,i,j+6'b01_1110,1'b1};//'ele1(im)'
				ram31_port0_add  <= {add_first_bit,i,j+6'b01_1111,1'b1};//'ele1(im)'	
	
			end
			4:begin
				step <= step + 1;				//COMMAND : READ
				//cant sample databus into temp regs here
			end
			5:begin
				ram_command <= {1'b1,1'b1,1'b0};	//COMMAND :WRITE
	
				temp_reg1[00] <= ram00_port0_bus;
				temp_reg1[01] <= ram01_port0_bus;
				temp_reg1[02] <= ram02_port0_bus;
				temp_reg1[03] <= ram03_port0_bus;
				temp_reg1[04] <= ram04_port0_bus;
				temp_reg1[05] <= ram05_port0_bus;
				temp_reg1[06] <= ram06_port0_bus;
				temp_reg1[07] <= ram07_port0_bus;
				temp_reg1[08] <= ram08_port0_bus;
				temp_reg1[09] <= ram09_port0_bus;
				temp_reg1[10] <= ram10_port0_bus;
				temp_reg1[11] <= ram11_port0_bus;
				temp_reg1[12] <= ram12_port0_bus;
				temp_reg1[13] <= ram13_port0_bus;
				temp_reg1[14] <= ram14_port0_bus;
				temp_reg1[15] <= ram15_port0_bus;
				temp_reg1[16] <= ram16_port0_bus;
				temp_reg1[17] <= ram17_port0_bus;
				temp_reg1[18] <= ram18_port0_bus;
				temp_reg1[19] <= ram19_port0_bus;
				temp_reg1[20] <= ram20_port0_bus;
				temp_reg1[21] <= ram21_port0_bus;
				temp_reg1[22] <= ram22_port0_bus;
				temp_reg1[23] <= ram23_port0_bus;
				temp_reg1[24] <= ram24_port0_bus;
				temp_reg1[25] <= ram25_port0_bus;
				temp_reg1[26] <= ram26_port0_bus;
				temp_reg1[27] <= ram27_port0_bus;
				temp_reg1[28] <= ram28_port0_bus;
				temp_reg1[29] <= ram29_port0_bus;
				temp_reg1[30] <= ram30_port0_bus;
				temp_reg1[31] <= ram31_port0_bus;

//COPY HERE
				temp_reg2[00] <= ram_exchange_bus[( 1)*`FFT_DATA_WIDTH-1:( 0)*`FFT_DATA_WIDTH];
				temp_reg2[01] <= ram_exchange_bus[( 2)*`FFT_DATA_WIDTH-1:( 1)*`FFT_DATA_WIDTH];
				temp_reg2[02] <= ram_exchange_bus[( 3)*`FFT_DATA_WIDTH-1:( 2)*`FFT_DATA_WIDTH];
				temp_reg2[03] <= ram_exchange_bus[( 4)*`FFT_DATA_WIDTH-1:( 3)*`FFT_DATA_WIDTH];
				temp_reg2[04] <= ram_exchange_bus[( 5)*`FFT_DATA_WIDTH-1:( 4)*`FFT_DATA_WIDTH];
				temp_reg2[05] <= ram_exchange_bus[( 6)*`FFT_DATA_WIDTH-1:( 5)*`FFT_DATA_WIDTH];
				temp_reg2[06] <= ram_exchange_bus[( 7)*`FFT_DATA_WIDTH-1:( 6)*`FFT_DATA_WIDTH];
				temp_reg2[07] <= ram_exchange_bus[( 8)*`FFT_DATA_WIDTH-1:( 7)*`FFT_DATA_WIDTH];
				temp_reg2[08] <= ram_exchange_bus[( 9)*`FFT_DATA_WIDTH-1:( 8)*`FFT_DATA_WIDTH];
				temp_reg2[09] <= ram_exchange_bus[(10)*`FFT_DATA_WIDTH-1:( 9)*`FFT_DATA_WIDTH];
				temp_reg2[10] <= ram_exchange_bus[(11)*`FFT_DATA_WIDTH-1:(10)*`FFT_DATA_WIDTH];
				temp_reg2[11] <= ram_exchange_bus[(12)*`FFT_DATA_WIDTH-1:(11)*`FFT_DATA_WIDTH];
				temp_reg2[12] <= ram_exchange_bus[(13)*`FFT_DATA_WIDTH-1:(12)*`FFT_DATA_WIDTH];
				temp_reg2[13] <= ram_exchange_bus[(14)*`FFT_DATA_WIDTH-1:(13)*`FFT_DATA_WIDTH];
				temp_reg2[14] <= ram_exchange_bus[(15)*`FFT_DATA_WIDTH-1:(14)*`FFT_DATA_WIDTH];
				temp_reg2[15] <= ram_exchange_bus[(16)*`FFT_DATA_WIDTH-1:(15)*`FFT_DATA_WIDTH];
				temp_reg2[16] <= ram_exchange_bus[(17)*`FFT_DATA_WIDTH-1:(16)*`FFT_DATA_WIDTH];
				temp_reg2[17] <= ram_exchange_bus[(18)*`FFT_DATA_WIDTH-1:(17)*`FFT_DATA_WIDTH];
				temp_reg2[18] <= ram_exchange_bus[(19)*`FFT_DATA_WIDTH-1:(18)*`FFT_DATA_WIDTH];
				temp_reg2[19] <= ram_exchange_bus[(20)*`FFT_DATA_WIDTH-1:(19)*`FFT_DATA_WIDTH];
				temp_reg2[20] <= ram_exchange_bus[(21)*`FFT_DATA_WIDTH-1:(20)*`FFT_DATA_WIDTH];
				temp_reg2[21] <= ram_exchange_bus[(22)*`FFT_DATA_WIDTH-1:(21)*`FFT_DATA_WIDTH];
				temp_reg2[22] <= ram_exchange_bus[(23)*`FFT_DATA_WIDTH-1:(22)*`FFT_DATA_WIDTH];
				temp_reg2[23] <= ram_exchange_bus[(24)*`FFT_DATA_WIDTH-1:(23)*`FFT_DATA_WIDTH];
				temp_reg2[24] <= ram_exchange_bus[(25)*`FFT_DATA_WIDTH-1:(24)*`FFT_DATA_WIDTH];
				temp_reg2[25] <= ram_exchange_bus[(26)*`FFT_DATA_WIDTH-1:(25)*`FFT_DATA_WIDTH];
				temp_reg2[26] <= ram_exchange_bus[(27)*`FFT_DATA_WIDTH-1:(26)*`FFT_DATA_WIDTH];
				temp_reg2[27] <= ram_exchange_bus[(28)*`FFT_DATA_WIDTH-1:(27)*`FFT_DATA_WIDTH];
				temp_reg2[28] <= ram_exchange_bus[(29)*`FFT_DATA_WIDTH-1:(28)*`FFT_DATA_WIDTH];
				temp_reg2[29] <= ram_exchange_bus[(30)*`FFT_DATA_WIDTH-1:(29)*`FFT_DATA_WIDTH];
				temp_reg2[30] <= ram_exchange_bus[(31)*`FFT_DATA_WIDTH-1:(30)*`FFT_DATA_WIDTH];
				temp_reg2[31] <= ram_exchange_bus[(32)*`FFT_DATA_WIDTH-1:(31)*`FFT_DATA_WIDTH];
	
				if((j == `NO_OF_POINTS-1)&(i==0))
				begin
					//increment i and reset j
					i <= i+1		;
					j <= `NO_OF_UNITS +1	;	
					step <= 0		;
				end
				else
				begin
					j <= j + 1;	
					step <= 0 ;
				end
			end
			default:;
			endcase
		end
		else if(~do_bitreversing)
		begin
			done_transpose <= 1;
		end
		else
		begin
			case(bitstep)
			0:
			begin
				if (counter1 > counter0)
				begin		//DO SWAPPING...have to take care of i
					case(step)
					0:begin
						step <= step + 1;	
						ram_command <= {1'b1,1'b0,1'b1};	//COMMAND : READ
						on <= -1	;
			
						ram_exchange_add[00] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[01] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[02] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[03] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[04] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[05] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[06] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[07] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[08] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[09] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[10] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[11] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[12] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[13] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[14] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[15] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[16] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[17] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[18] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[19] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[20] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[21] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[22] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[23] <= {add_first_bit,i,counter6};//'ele2(re)'
						ram_exchange_add[24] <= {add_first_bit,i,counter6};//'ele2(re)'	
						ram_exchange_add[25] <= {add_first_bit,i,counter6};//'ele2(re)'	
						ram_exchange_add[26] <= {add_first_bit,i,counter6};//'ele2(re)'	
						ram_exchange_add[27] <= {add_first_bit,i,counter6};//'ele2(re)'	
						ram_exchange_add[28] <= {add_first_bit,i,counter6};//'ele2(re)'	
						ram_exchange_add[29] <= {add_first_bit,i,counter6};//'ele2(re)'	
						ram_exchange_add[30] <= {add_first_bit,i,counter6};//'ele2(re)'	
						ram_exchange_add[31] <= {add_first_bit,i,counter6};//'ele2(re)'	
				
						ram00_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram01_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram02_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram03_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram04_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram05_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram06_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram07_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram08_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram09_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram10_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram11_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram12_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram13_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram14_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram15_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram16_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram17_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram18_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram19_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram20_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram21_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram22_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram23_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram24_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram25_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram26_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram27_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram28_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram29_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram30_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'
						ram31_port0_add  <= {add_first_bit,i,counter5};//'ele1(re)'			
	
					end
					1:begin
						step <= step + 1;			//COMMAND : READ
						//cant sample databus into temp regs here
					end
					2:begin
						step <= step + 1;	
						ram_command <= {1'b1,1'b1,1'b0};	//COMMAND :WRITE
						temp_reg1[00] <= ram00_port0_bus;
						temp_reg1[01] <= ram01_port0_bus;
						temp_reg1[02] <= ram02_port0_bus;
						temp_reg1[03] <= ram03_port0_bus;
						temp_reg1[04] <= ram04_port0_bus;
						temp_reg1[05] <= ram05_port0_bus;
						temp_reg1[06] <= ram06_port0_bus;
						temp_reg1[07] <= ram07_port0_bus;
						temp_reg1[08] <= ram08_port0_bus;
						temp_reg1[09] <= ram09_port0_bus;
						temp_reg1[10] <= ram10_port0_bus;
						temp_reg1[11] <= ram11_port0_bus;
						temp_reg1[12] <= ram12_port0_bus;
						temp_reg1[13] <= ram13_port0_bus;
						temp_reg1[14] <= ram14_port0_bus;
						temp_reg1[15] <= ram15_port0_bus;
						temp_reg1[16] <= ram16_port0_bus;
						temp_reg1[17] <= ram17_port0_bus;
						temp_reg1[18] <= ram18_port0_bus;
						temp_reg1[19] <= ram19_port0_bus;
						temp_reg1[20] <= ram20_port0_bus;
						temp_reg1[21] <= ram21_port0_bus;
						temp_reg1[22] <= ram22_port0_bus;
						temp_reg1[23] <= ram23_port0_bus;
						temp_reg1[24] <= ram24_port0_bus;
						temp_reg1[25] <= ram25_port0_bus;
						temp_reg1[26] <= ram26_port0_bus;
						temp_reg1[27] <= ram27_port0_bus;
						temp_reg1[28] <= ram28_port0_bus;
						temp_reg1[29] <= ram29_port0_bus;
						temp_reg1[30] <= ram30_port0_bus;
						temp_reg1[31] <= ram31_port0_bus;
				
						temp_reg2[00] <= ram00_port1_bus;
						temp_reg2[01] <= ram01_port1_bus;
						temp_reg2[02] <= ram02_port1_bus;
						temp_reg2[03] <= ram03_port1_bus;
						temp_reg2[04] <= ram04_port1_bus;
						temp_reg2[05] <= ram05_port1_bus;
						temp_reg2[06] <= ram06_port1_bus;
						temp_reg2[07] <= ram07_port1_bus; 
						temp_reg2[08] <= ram08_port1_bus; 
						temp_reg2[09] <= ram09_port1_bus; 
						temp_reg2[10] <= ram10_port1_bus; 
						temp_reg2[11] <= ram11_port1_bus; 
						temp_reg2[12] <= ram12_port1_bus; 
						temp_reg2[13] <= ram13_port1_bus; 
						temp_reg2[14] <= ram14_port1_bus; 
						temp_reg2[15] <= ram15_port1_bus; 
						temp_reg2[16] <= ram16_port1_bus; 
						temp_reg2[17] <= ram17_port1_bus; 
						temp_reg2[18] <= ram18_port1_bus; 
						temp_reg2[19] <= ram19_port1_bus; 
						temp_reg2[20] <= ram20_port1_bus; 
						temp_reg2[21] <= ram21_port1_bus; 
						temp_reg2[22] <= ram22_port1_bus; 
						temp_reg2[23] <= ram23_port1_bus; 
						temp_reg2[24] <= ram24_port1_bus; 
						temp_reg2[25] <= ram25_port1_bus; 
						temp_reg2[26] <= ram26_port1_bus; 
						temp_reg2[27] <= ram27_port1_bus; 
						temp_reg2[28] <= ram28_port1_bus; 
						temp_reg2[29] <= ram29_port1_bus; 
						temp_reg2[30] <= ram30_port1_bus; 
						temp_reg2[31] <= ram31_port1_bus; 

					end
					3:begin
						step <= step + 1;
						ram_command <= {1'b1,1'b0,1'b1};	//COMMAND : READ
						//ram writing takes place at this cycle's start. 
						//Now can change the command reg back to reading

						ram_exchange_add[00] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[01] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[02] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[03] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[04] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[05] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[06] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[07] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[08] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[09] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[10] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[11] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[12] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[13] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[14] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[15] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[16] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[17] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[18] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[19] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[20] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[21] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[22] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[23] <= {add_first_bit,i,counter1};//'ele2(re)'
						ram_exchange_add[24] <= {add_first_bit,i,counter1};//'ele2(re)'	
						ram_exchange_add[25] <= {add_first_bit,i,counter1};//'ele2(re)'	
						ram_exchange_add[26] <= {add_first_bit,i,counter1};//'ele2(re)'	
						ram_exchange_add[27] <= {add_first_bit,i,counter1};//'ele2(re)'	
						ram_exchange_add[28] <= {add_first_bit,i,counter1};//'ele2(re)'	
						ram_exchange_add[29] <= {add_first_bit,i,counter1};//'ele2(re)'	
						ram_exchange_add[30] <= {add_first_bit,i,counter1};//'ele2(re)'	
						ram_exchange_add[31] <= {add_first_bit,i,counter1};//'ele2(re)'	
				
						ram00_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram01_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram02_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram03_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram04_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram05_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram06_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram07_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram08_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram09_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram10_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram11_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram12_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram13_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram14_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram15_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram16_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram17_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram18_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram19_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram20_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram21_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram22_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram23_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram24_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram25_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram26_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram27_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram28_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram29_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram30_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
						ram31_port0_add  <= {add_first_bit,i,counter0};//'ele1(im)'
					end
					4:begin
						step <= step + 1;				//COMMAND : READ
						//cant sample databus into temp regs here
					end
					5:begin
						ram_command <= {1'b1,1'b1,1'b0};	//COMMAND :WRITE
			
						temp_reg1[00] <= ram00_port0_bus;
						temp_reg1[01] <= ram01_port0_bus;
						temp_reg1[02] <= ram02_port0_bus;
						temp_reg1[03] <= ram03_port0_bus;
						temp_reg1[04] <= ram04_port0_bus;
						temp_reg1[05] <= ram05_port0_bus;
						temp_reg1[06] <= ram06_port0_bus;
						temp_reg1[07] <= ram07_port0_bus;
						temp_reg1[08] <= ram08_port0_bus;
						temp_reg1[09] <= ram09_port0_bus;
						temp_reg1[10] <= ram10_port0_bus;
						temp_reg1[11] <= ram11_port0_bus;
						temp_reg1[12] <= ram12_port0_bus;
						temp_reg1[13] <= ram13_port0_bus;
						temp_reg1[14] <= ram14_port0_bus;
						temp_reg1[15] <= ram15_port0_bus;
						temp_reg1[16] <= ram16_port0_bus;
						temp_reg1[17] <= ram17_port0_bus;
						temp_reg1[18] <= ram18_port0_bus;
						temp_reg1[19] <= ram19_port0_bus;
						temp_reg1[20] <= ram20_port0_bus;
						temp_reg1[21] <= ram21_port0_bus;
						temp_reg1[22] <= ram22_port0_bus;
						temp_reg1[23] <= ram23_port0_bus;
						temp_reg1[24] <= ram24_port0_bus;
						temp_reg1[25] <= ram25_port0_bus;
						temp_reg1[26] <= ram26_port0_bus;
						temp_reg1[27] <= ram27_port0_bus;
						temp_reg1[28] <= ram28_port0_bus;
						temp_reg1[29] <= ram29_port0_bus;
						temp_reg1[30] <= ram30_port0_bus;
						temp_reg1[31] <= ram31_port0_bus;

//COPY HERE
						temp_reg2[00] <= ram00_port1_bus;
						temp_reg2[01] <= ram01_port1_bus;
						temp_reg2[02] <= ram02_port1_bus;
						temp_reg2[03] <= ram03_port1_bus;
						temp_reg2[04] <= ram04_port1_bus;
						temp_reg2[05] <= ram05_port1_bus;
						temp_reg2[06] <= ram06_port1_bus;
						temp_reg2[07] <= ram07_port1_bus; 
						temp_reg2[08] <= ram08_port1_bus; 
						temp_reg2[09] <= ram09_port1_bus; 
						temp_reg2[10] <= ram10_port1_bus; 
						temp_reg2[11] <= ram11_port1_bus; 
						temp_reg2[12] <= ram12_port1_bus; 
						temp_reg2[13] <= ram13_port1_bus; 
						temp_reg2[14] <= ram14_port1_bus; 
						temp_reg2[15] <= ram15_port1_bus; 
						temp_reg2[16] <= ram16_port1_bus; 
						temp_reg2[17] <= ram17_port1_bus; 
						temp_reg2[18] <= ram18_port1_bus; 
						temp_reg2[19] <= ram19_port1_bus; 
						temp_reg2[20] <= ram20_port1_bus; 
						temp_reg2[21] <= ram21_port1_bus; 
						temp_reg2[22] <= ram22_port1_bus; 
						temp_reg2[23] <= ram23_port1_bus; 
						temp_reg2[24] <= ram24_port1_bus; 
						temp_reg2[25] <= ram25_port1_bus; 
						temp_reg2[26] <= ram26_port1_bus; 
						temp_reg2[27] <= ram27_port1_bus; 
						temp_reg2[28] <= ram28_port1_bus; 
						temp_reg2[29] <= ram29_port1_bus; 
						temp_reg2[30] <= ram30_port1_bus; 
						temp_reg2[31] <= ram31_port1_bus; 
						bitstep <= bitstep + 1;	
						step <= 0 ;
					end
					default:;
					endcase
				end
				else
				begin
					bitstep <= bitstep + 1;
					on <= 0;
					ram_command <= {1'b1,1'b0,1'b0};
					step <= 0;
				end
			end
			1:
			begin
				counter2 <= `NO_OF_POINTS;
				bitstep <= bitstep + 1;
				on <= 0;
				ram_command <= {1'b1,1'b0,1'b0};
			end
			2:
			begin
				if(counter2>=2 && counter1>counter2)
				begin	
					counter1 <= counter1 - counter2;
					counter2 <= counter2 >> 1;
				end
				else
				begin
					counter1 <= counter1+counter2;
					if(counter0==2*`NO_OF_POINTS-1)
					begin
						if(i==`MAX_RAM_ROWS-1)
						begin
							done_transpose <= 1;
						end
						else
						begin
							i <= i + 1;
							counter0 	<= 1;		//bitreversing running var 1
							counter1 	<= 1;		//bitreversing running var 2
							counter2 	<=64;		//bitreversing var 3
							bitstep		<= 0;		//bitreversing var 4
							on 		<= 0;
						end
					end
					else
					begin
						counter0 <= counter0 + 2;
						bitstep <= 0;
					end
				end	
			end
			default: ;
			endcase
		end
	end
end
	
endmodule
