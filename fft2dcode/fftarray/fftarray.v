`include "00defines.v"

module FFTARRAY(
FFT_reset,
FFT_baseclock,
FFT_busyflag,
FFT_chooseIFFT,
FFT_dataa, //tristate data portA (32*16 bit)
FFT_datab, //tristate data portB (32*16 bit)
FFT_addra, //address portA (32*9 bit)
FFT_addrb, //address portB (32*9 bit)
FFT_wea, //write enable portA (32*1 bit)
FFT_web, //write enable portB (32*1 bit)
FFT_rea, //read (tri-state) enable portA (32*1 bit)
FFT_reb //read (tri-state) enable portB (32*1 bit)
);

//HARDCODED e.g. address bus sizes.
input FFT_reset;
input FFT_baseclock;
output FFT_busyflag;
input FFT_chooseIFFT;
inout [511:0] FFT_dataa; //tristate data portA (32*16 bit)
inout [511:0] FFT_datab; //tristate data portB (32*16 bit)
output [287:0] FFT_addra; //address portA (32*9 bit)
output [287:0] FFT_addrb; //address portB (32*9 bit)
output [31:0] FFT_wea; //write enable portA (32*1 bit)
output [31:0] FFT_web; //write enable portB (32*1 bit)
output [31:0] FFT_rea; //read (tri-state) enable portA (32*1 bit)
output [31:0] FFT_reb; //read (tri-state) enable portB (32*1 bit)


//HARDCODED e.g. address bus sizes.
wire FFT_reset;	
wire FFT_baseclock;	
wire FFT_busyflag;
wire FFT_chooseIFFT;
wire [511:0] FFT_dataa; //tristate data portA (32*16 bit)
wire [511:0] FFT_datab; //tristate data portB (32*16 bit)
wire [287:0] FFT_addra; //address portA (32*9 bit)
wire [287:0] FFT_addrb; //address portB (32*9 bit)
wire [31:0] FFT_wea; //write enable portA (32*1 bit)
wire [31:0] FFT_web; //write enable portB (32*1 bit)
wire [31:0] FFT_rea; //read (tri-state) enable portA (32*1 bit)
wire [31:0] FFT_reb; //read (tri-state) enable portB (32*1 bit)

//--------Internal wires and registers------------

//Controller
wire [`SEQUENCE_MODE_LENGTH +2 -1:0] f_unified_command;

//RAMs

//REQUIRED TO BE CONNECTED TO THE UNIT_1DFFT: INTERNAL WIRES
wire  ram00_cs_0_direct,ram01_cs_0_direct,ram02_cs_0_direct,ram03_cs_0_direct,ram04_cs_0_direct,ram05_cs_0_direct,ram06_cs_0_direct,ram07_cs_0_direct;
wire  ram08_cs_0_direct,ram09_cs_0_direct,ram10_cs_0_direct,ram11_cs_0_direct,ram12_cs_0_direct,ram13_cs_0_direct,ram14_cs_0_direct,ram15_cs_0_direct;
wire  ram16_cs_0_direct,ram17_cs_0_direct,ram18_cs_0_direct,ram19_cs_0_direct,ram20_cs_0_direct,ram21_cs_0_direct,ram22_cs_0_direct,ram23_cs_0_direct;
wire  ram24_cs_0_direct,ram25_cs_0_direct,ram26_cs_0_direct,ram27_cs_0_direct,ram28_cs_0_direct,ram29_cs_0_direct,ram30_cs_0_direct,ram31_cs_0_direct;

wire  ram00_we_0_direct,ram01_we_0_direct,ram02_we_0_direct,ram03_we_0_direct,ram04_we_0_direct,ram05_we_0_direct,ram06_we_0_direct,ram07_we_0_direct;
wire  ram08_we_0_direct,ram09_we_0_direct,ram10_we_0_direct,ram11_we_0_direct,ram12_we_0_direct,ram13_we_0_direct,ram14_we_0_direct,ram15_we_0_direct;
wire  ram16_we_0_direct,ram17_we_0_direct,ram18_we_0_direct,ram19_we_0_direct,ram20_we_0_direct,ram21_we_0_direct,ram22_we_0_direct,ram23_we_0_direct;
wire  ram24_we_0_direct,ram25_we_0_direct,ram26_we_0_direct,ram27_we_0_direct,ram28_we_0_direct,ram29_we_0_direct,ram30_we_0_direct,ram31_we_0_direct;

wire  ram00_oe_0_direct,ram01_oe_0_direct,ram02_oe_0_direct,ram03_oe_0_direct,ram04_oe_0_direct,ram05_oe_0_direct,ram06_oe_0_direct,ram07_oe_0_direct;
wire  ram08_oe_0_direct,ram09_oe_0_direct,ram10_oe_0_direct,ram11_oe_0_direct,ram12_oe_0_direct,ram13_oe_0_direct,ram14_oe_0_direct,ram15_oe_0_direct;
wire  ram16_oe_0_direct,ram17_oe_0_direct,ram18_oe_0_direct,ram19_oe_0_direct,ram20_oe_0_direct,ram21_oe_0_direct,ram22_oe_0_direct,ram23_oe_0_direct;
wire  ram24_oe_0_direct,ram25_oe_0_direct,ram26_oe_0_direct,ram27_oe_0_direct,ram28_oe_0_direct,ram29_oe_0_direct,ram30_oe_0_direct,ram31_oe_0_direct;

wire  ram00_cs_1_direct,ram01_cs_1_direct,ram02_cs_1_direct,ram03_cs_1_direct,ram04_cs_1_direct,ram05_cs_1_direct,ram06_cs_1_direct,ram07_cs_1_direct;
wire  ram08_cs_1_direct,ram09_cs_1_direct,ram10_cs_1_direct,ram11_cs_1_direct,ram12_cs_1_direct,ram13_cs_1_direct,ram14_cs_1_direct,ram15_cs_1_direct;
wire  ram16_cs_1_direct,ram17_cs_1_direct,ram18_cs_1_direct,ram19_cs_1_direct,ram20_cs_1_direct,ram21_cs_1_direct,ram22_cs_1_direct,ram23_cs_1_direct;
wire  ram24_cs_1_direct,ram25_cs_1_direct,ram26_cs_1_direct,ram27_cs_1_direct,ram28_cs_1_direct,ram29_cs_1_direct,ram30_cs_1_direct,ram31_cs_1_direct;

wire  ram00_we_1_direct,ram01_we_1_direct,ram02_we_1_direct,ram03_we_1_direct,ram04_we_1_direct,ram05_we_1_direct,ram06_we_1_direct,ram07_we_1_direct;
wire  ram08_we_1_direct,ram09_we_1_direct,ram10_we_1_direct,ram11_we_1_direct,ram12_we_1_direct,ram13_we_1_direct,ram14_we_1_direct,ram15_we_1_direct;
wire  ram16_we_1_direct,ram17_we_1_direct,ram18_we_1_direct,ram19_we_1_direct,ram20_we_1_direct,ram21_we_1_direct,ram22_we_1_direct,ram23_we_1_direct;
wire  ram24_we_1_direct,ram25_we_1_direct,ram26_we_1_direct,ram27_we_1_direct,ram28_we_1_direct,ram29_we_1_direct,ram30_we_1_direct,ram31_we_1_direct;

wire  ram00_oe_1_direct,ram01_oe_1_direct,ram02_oe_1_direct,ram03_oe_1_direct,ram04_oe_1_direct,ram05_oe_1_direct,ram06_oe_1_direct,ram07_oe_1_direct;
wire  ram08_oe_1_direct,ram09_oe_1_direct,ram10_oe_1_direct,ram11_oe_1_direct,ram12_oe_1_direct,ram13_oe_1_direct,ram14_oe_1_direct,ram15_oe_1_direct;
wire  ram16_oe_1_direct,ram17_oe_1_direct,ram18_oe_1_direct,ram19_oe_1_direct,ram20_oe_1_direct,ram21_oe_1_direct,ram22_oe_1_direct,ram23_oe_1_direct;
wire  ram24_oe_1_direct,ram25_oe_1_direct,ram26_oe_1_direct,ram27_oe_1_direct,ram28_oe_1_direct,ram29_oe_1_direct,ram30_oe_1_direct,ram31_oe_1_direct;


wire [`LOG_N+2-1:0] ram00port0_add_f,ram01port0_add_f,ram02port0_add_f,ram03port0_add_f,ram04port0_add_f,ram05port0_add_f,ram06port0_add_f,ram07port0_add_f;
wire [`LOG_N+2-1:0] ram08port0_add_f,ram09port0_add_f,ram10port0_add_f,ram11port0_add_f,ram12port0_add_f,ram13port0_add_f,ram14port0_add_f,ram15port0_add_f;
wire [`LOG_N+2-1:0] ram16port0_add_f,ram17port0_add_f,ram18port0_add_f,ram19port0_add_f,ram20port0_add_f,ram21port0_add_f,ram22port0_add_f,ram23port0_add_f;
wire [`LOG_N+2-1:0] ram24port0_add_f,ram25port0_add_f,ram26port0_add_f,ram27port0_add_f,ram28port0_add_f,ram29port0_add_f,ram30port0_add_f,ram31port0_add_f;

wire [`LOG_N+2-1:0] ram00port1_add_f,ram01port1_add_f,ram02port1_add_f,ram03port1_add_f,ram04port1_add_f,ram05port1_add_f,ram06port1_add_f,ram07port1_add_f;
wire [`LOG_N+2-1:0] ram08port1_add_f,ram09port1_add_f,ram10port1_add_f,ram11port1_add_f,ram12port1_add_f,ram13port1_add_f,ram14port1_add_f,ram15port1_add_f;
wire [`LOG_N+2-1:0] ram16port1_add_f,ram17port1_add_f,ram18port1_add_f,ram19port1_add_f,ram20port1_add_f,ram21port1_add_f,ram22port1_add_f,ram23port1_add_f;
wire [`LOG_N+2-1:0] ram24port1_add_f,ram25port1_add_f,ram26port1_add_f,ram27port1_add_f,ram28port1_add_f,ram29port1_add_f,ram30port1_add_f,ram31port1_add_f;

//END OF REQUIRED TO BE CONNECTED TO THE UNIT_1DFFT: INTERNAL WIRES


//---------------------------ASSIGNMENTS----------------------------------------
//MUXING PERIPHERAL ADDRESSES USING THE DO_TRANSPOSE SIGNAL
assign FFT_addra = {{1'b0,ram31port0_add_f[`LOG_N+1],1'b0,ram31port0_add_f[`LOG_N:0]},{1'b0,ram30port0_add_f[`LOG_N+1],1'b0,ram30port0_add_f[`LOG_N:0]},{1'b0,ram29port0_add_f[`LOG_N+1],1'b0,ram29port0_add_f[`LOG_N:0]},{1'b0,ram28port0_add_f[`LOG_N+1],1'b0,
ram28port0_add_f[`LOG_N:0]},{1'b0,ram27port0_add_f[`LOG_N+1],1'b0,ram27port0_add_f[`LOG_N:0]},{1'b0,ram26port0_add_f[`LOG_N+1],1'b0,ram26port0_add_f[`LOG_N:0]},{1'b0,ram25port0_add_f[`LOG_N+1],1'b0,ram25port0_add_f[`LOG_N:0]},{1'b0,ram24port0_add_f[`LOG_N+1],1'b0,ram24port0_add_f[`LOG_N:0]},{1'b0,ram23port0_add_f[`LOG_N+1],1'b0,ram23port0_add_f[`LOG_N:0]},{1'b0,ram22port0_add_f[`LOG_N+1],1'b0,ram22port0_add_f[`LOG_N:0]},{1'b0,ram21port0_add_f[`LOG_N+1],1'b0,ram21port0_add_f[`LOG_N:0]},{1'b0,ram20port0_add_f[`LOG_N+1],1'b0,ram20port0_add_f[`LOG_N:0]},{1'b0,ram19port0_add_f[`LOG_N+1],1'b0,ram19port0_add_f[`LOG_N:0]},{1'b0,ram18port0_add_f[`LOG_N+1],1'b0,ram18port0_add_f[`LOG_N:0]},{1'b0,ram17port0_add_f[`LOG_N+1],1'b0,ram17port0_add_f[`LOG_N:0]},{1'b0,ram16port0_add_f[`LOG_N+1],1'b0,ram16port0_add_f[`LOG_N:0]},{1'b0,ram15port0_add_f[`LOG_N+1],1'b0,ram15port0_add_f[`LOG_N:0]},{1'b0,ram14port0_add_f[`LOG_N+1],1'b0,ram14port0_add_f[`LOG_N:0]},{1'b0,ram13port0_add_f[`LOG_N+1],1'b0,ram13port0_add_f[`LOG_N:0]},{1'b0,ram12port0_add_f[`LOG_N+1],1'b0,ram12port0_add_f[`LOG_N:0]},{1'b0,ram11port0_add_f[`LOG_N+1],1'b0,ram11port0_add_f[`LOG_N:0]},{1'b0,ram10port0_add_f[`LOG_N+1],1'b0,ram10port0_add_f[`LOG_N:0]},{1'b0,ram09port0_add_f[`LOG_N+1],1'b0,ram09port0_add_f[`LOG_N:0]},{1'b0,ram08port0_add_f[`LOG_N+1],1'b0,ram08port0_add_f[`LOG_N:0]},{1'b0,ram07port0_add_f[`LOG_N+1],1'b0,ram07port0_add_f[`LOG_N:0]},{1'b0,ram06port0_add_f[`LOG_N+1],1'b0,ram06port0_add_f[`LOG_N:0]},{1'b0,ram05port0_add_f[`LOG_N+1],1'b0,ram05port0_add_f[`LOG_N:0]},{1'b0,ram04port0_add_f[`LOG_N+1],1'b0,ram04port0_add_f[`LOG_N:0]},{1'b0,ram03port0_add_f[`LOG_N+1],1'b0,ram03port0_add_f[`LOG_N:0]},{1'b0,ram02port0_add_f[`LOG_N+1],1'b0,ram02port0_add_f[`LOG_N:0]},{1'b0,ram01port0_add_f[`LOG_N+1],1'b0,ram01port0_add_f[`LOG_N:0]},{1'b0,ram00port0_add_f[`LOG_N+1],1'b0,ram00port0_add_f[`LOG_N:0]}};

assign FFT_addrb = {{1'b0,ram31port1_add_f[`LOG_N+1],1'b0,ram31port1_add_f[`LOG_N:0]},{1'b0,ram30port1_add_f[`LOG_N+1],1'b0,ram30port1_add_f[`LOG_N:0]},{1'b0,ram29port1_add_f[`LOG_N+1],1'b0,ram29port1_add_f[`LOG_N:0]},{1'b0,ram28port1_add_f[`LOG_N+1],1'b0,
ram28port1_add_f[`LOG_N:0]},{1'b0,ram27port1_add_f[`LOG_N+1],1'b0,ram27port1_add_f[`LOG_N:0]},{1'b0,ram26port1_add_f[`LOG_N+1],1'b0,ram26port1_add_f[`LOG_N:0]},{1'b0,ram25port1_add_f[`LOG_N+1],1'b0,ram25port1_add_f[`LOG_N:0]},{1'b0,ram24port1_add_f[`LOG_N+1],1'b0,ram24port1_add_f[`LOG_N:0]},{1'b0,ram23port1_add_f[`LOG_N+1],1'b0,ram23port1_add_f[`LOG_N:0]},{1'b0,ram22port1_add_f[`LOG_N+1],1'b0,ram22port1_add_f[`LOG_N:0]},{1'b0,ram21port1_add_f[`LOG_N+1],1'b0,ram21port1_add_f[`LOG_N:0]},{1'b0,ram20port1_add_f[`LOG_N+1],1'b0,ram20port1_add_f[`LOG_N:0]},{1'b0,ram19port1_add_f[`LOG_N+1],1'b0,ram19port1_add_f[`LOG_N:0]},{1'b0,ram18port1_add_f[`LOG_N+1],1'b0,ram18port1_add_f[`LOG_N:0]},{1'b0,ram17port1_add_f[`LOG_N+1],1'b0,ram17port1_add_f[`LOG_N:0]},{1'b0,ram16port1_add_f[`LOG_N+1],1'b0,ram16port1_add_f[`LOG_N:0]},{1'b0,ram15port1_add_f[`LOG_N+1],1'b0,ram15port1_add_f[`LOG_N:0]},{1'b0,ram14port1_add_f[`LOG_N+1],1'b0,ram14port1_add_f[`LOG_N:0]},{1'b0,ram13port1_add_f[`LOG_N+1],1'b0,ram13port1_add_f[`LOG_N:0]},{1'b0,ram12port1_add_f[`LOG_N+1],1'b0,ram12port1_add_f[`LOG_N:0]},{1'b0,ram11port1_add_f[`LOG_N+1],1'b0,ram11port1_add_f[`LOG_N:0]},{1'b0,ram10port1_add_f[`LOG_N+1],1'b0,ram10port1_add_f[`LOG_N:0]},{1'b0,ram09port1_add_f[`LOG_N+1],1'b0,ram09port1_add_f[`LOG_N:0]},{1'b0,ram08port1_add_f[`LOG_N+1],1'b0,ram08port1_add_f[`LOG_N:0]},{1'b0,ram07port1_add_f[`LOG_N+1],1'b0,ram07port1_add_f[`LOG_N:0]},{1'b0,ram06port1_add_f[`LOG_N+1],1'b0,ram06port1_add_f[`LOG_N:0]},{1'b0,ram05port1_add_f[`LOG_N+1],1'b0,ram05port1_add_f[`LOG_N:0]},{1'b0,ram04port1_add_f[`LOG_N+1],1'b0,ram04port1_add_f[`LOG_N:0]},{1'b0,ram03port1_add_f[`LOG_N+1],1'b0,ram03port1_add_f[`LOG_N:0]},{1'b0,ram02port1_add_f[`LOG_N+1],1'b0,ram02port1_add_f[`LOG_N:0]},{1'b0,ram01port1_add_f[`LOG_N+1],1'b0,ram01port1_add_f[`LOG_N:0]},{1'b0,ram00port1_add_f[`LOG_N+1],1'b0,ram00port1_add_f[`LOG_N:0]}};
//END OF MUXING PERIPHERAL ADDRESSES USING THE DO_TRANSPOSE SIGNAL

//MUXING PERIPHERAL CONTROLS USING THE DO_TRANSPOSE SIGNAL
assign FFT_wea = {ram31_we_0_direct,ram30_we_0_direct,ram29_we_0_direct,
ram28_we_0_direct,ram27_we_0_direct,ram26_we_0_direct,ram25_we_0_direct,ram24_we_0_direct,
ram23_we_0_direct,ram22_we_0_direct,ram21_we_0_direct,ram20_we_0_direct,ram19_we_0_direct,
ram18_we_0_direct,ram17_we_0_direct,ram16_we_0_direct,ram15_we_0_direct,ram14_we_0_direct,
ram13_we_0_direct,ram12_we_0_direct,ram11_we_0_direct,ram10_we_0_direct,ram09_we_0_direct,
ram08_we_0_direct,ram07_we_0_direct,ram06_we_0_direct,ram05_we_0_direct,ram04_we_0_direct,
ram03_we_0_direct,ram02_we_0_direct,ram01_we_0_direct,ram00_we_0_direct}&{ram31_cs_0_direct,ram30_cs_0_direct,ram29_cs_0_direct,
ram28_cs_0_direct,ram27_cs_0_direct,ram26_cs_0_direct,ram25_cs_0_direct,ram24_cs_0_direct,
ram23_cs_0_direct,ram22_cs_0_direct,ram21_cs_0_direct,ram20_cs_0_direct,ram19_cs_0_direct,
ram18_cs_0_direct,ram17_cs_0_direct,ram16_cs_0_direct,ram15_cs_0_direct,ram14_cs_0_direct,
ram13_cs_0_direct,ram12_cs_0_direct,ram11_cs_0_direct,ram10_cs_0_direct,ram09_cs_0_direct,
ram08_cs_0_direct,ram07_cs_0_direct,ram06_cs_0_direct,ram05_cs_0_direct,ram04_cs_0_direct,
ram03_cs_0_direct,ram02_cs_0_direct,ram01_cs_0_direct,ram00_cs_0_direct};

assign FFT_rea = {ram31_oe_0_direct,ram30_oe_0_direct,ram29_oe_0_direct,
ram28_oe_0_direct,ram27_oe_0_direct,ram26_oe_0_direct,ram25_oe_0_direct,ram24_oe_0_direct,
ram23_oe_0_direct,ram22_oe_0_direct,ram21_oe_0_direct,ram20_oe_0_direct,ram19_oe_0_direct,
ram18_oe_0_direct,ram17_oe_0_direct,ram16_oe_0_direct,ram15_oe_0_direct,ram14_oe_0_direct,
ram13_oe_0_direct,ram12_oe_0_direct,ram11_oe_0_direct,ram10_oe_0_direct,ram09_oe_0_direct,
ram08_oe_0_direct,ram07_oe_0_direct,ram06_oe_0_direct,ram05_oe_0_direct,ram04_oe_0_direct,
ram03_oe_0_direct,ram02_oe_0_direct,ram01_oe_0_direct,ram00_oe_0_direct}&{ram31_cs_0_direct,ram30_cs_0_direct,ram29_cs_0_direct,
ram28_cs_0_direct,ram27_cs_0_direct,ram26_cs_0_direct,ram25_cs_0_direct,ram24_cs_0_direct,
ram23_cs_0_direct,ram22_cs_0_direct,ram21_cs_0_direct,ram20_cs_0_direct,ram19_cs_0_direct,
ram18_cs_0_direct,ram17_cs_0_direct,ram16_cs_0_direct,ram15_cs_0_direct,ram14_cs_0_direct,
ram13_cs_0_direct,ram12_cs_0_direct,ram11_cs_0_direct,ram10_cs_0_direct,ram09_cs_0_direct,
ram08_cs_0_direct,ram07_cs_0_direct,ram06_cs_0_direct,ram05_cs_0_direct,ram04_cs_0_direct,
ram03_cs_0_direct,ram02_cs_0_direct,ram01_cs_0_direct,ram00_cs_0_direct};

assign FFT_web = {ram31_we_1_direct,ram30_we_1_direct,ram29_we_1_direct,
ram28_we_1_direct,ram27_we_1_direct,ram26_we_1_direct,ram25_we_1_direct,ram24_we_1_direct,
ram23_we_1_direct,ram22_we_1_direct,ram21_we_1_direct,ram20_we_1_direct,ram19_we_1_direct,
ram18_we_1_direct,ram17_we_1_direct,ram16_we_1_direct,ram15_we_1_direct,ram14_we_1_direct,
ram13_we_1_direct,ram12_we_1_direct,ram11_we_1_direct,ram10_we_1_direct,ram09_we_1_direct,
ram08_we_1_direct,ram07_we_1_direct,ram06_we_1_direct,ram05_we_1_direct,ram04_we_1_direct,
ram03_we_1_direct,ram02_we_1_direct,ram01_we_1_direct,ram00_we_1_direct}&{ram31_cs_1_direct,ram30_cs_1_direct,ram29_cs_1_direct,
ram28_cs_1_direct,ram27_cs_1_direct,ram26_cs_1_direct,ram25_cs_1_direct,ram24_cs_1_direct,
ram23_cs_1_direct,ram22_cs_1_direct,ram21_cs_1_direct,ram20_cs_1_direct,ram19_cs_1_direct,
ram18_cs_1_direct,ram17_cs_1_direct,ram16_cs_1_direct,ram15_cs_1_direct,ram14_cs_1_direct,
ram13_cs_1_direct,ram12_cs_1_direct,ram11_cs_1_direct,ram10_cs_1_direct,ram09_cs_1_direct,
ram08_cs_1_direct,ram07_cs_1_direct,ram06_cs_1_direct,ram05_cs_1_direct,ram04_cs_1_direct,
ram03_cs_1_direct,ram02_cs_1_direct,ram01_cs_1_direct,ram00_cs_1_direct};

assign FFT_reb = {ram31_oe_1_direct,ram30_oe_1_direct,ram29_oe_1_direct,
ram28_oe_1_direct,ram27_oe_1_direct,ram26_oe_1_direct,ram25_oe_1_direct,ram24_oe_1_direct,
ram23_oe_1_direct,ram22_oe_1_direct,ram21_oe_1_direct,ram20_oe_1_direct,ram19_oe_1_direct,
ram18_oe_1_direct,ram17_oe_1_direct,ram16_oe_1_direct,ram15_oe_1_direct,ram14_oe_1_direct,
ram13_oe_1_direct,ram12_oe_1_direct,ram11_oe_1_direct,ram10_oe_1_direct,ram09_oe_1_direct,
ram08_oe_1_direct,ram07_oe_1_direct,ram06_oe_1_direct,ram05_oe_1_direct,ram04_oe_1_direct,
ram03_oe_1_direct,ram02_oe_1_direct,ram01_oe_1_direct,ram00_oe_1_direct}&{ram31_cs_1_direct,ram30_cs_1_direct,ram29_cs_1_direct,
ram28_cs_1_direct,ram27_cs_1_direct,ram26_cs_1_direct,ram25_cs_1_direct,ram24_cs_1_direct,
ram23_cs_1_direct,ram22_cs_1_direct,ram21_cs_1_direct,ram20_cs_1_direct,ram19_cs_1_direct,
ram18_cs_1_direct,ram17_cs_1_direct,ram16_cs_1_direct,ram15_cs_1_direct,ram14_cs_1_direct,
ram13_cs_1_direct,ram12_cs_1_direct,ram11_cs_1_direct,ram10_cs_1_direct,ram09_cs_1_direct,
ram08_cs_1_direct,ram07_cs_1_direct,ram06_cs_1_direct,ram05_cs_1_direct,ram04_cs_1_direct,
ram03_cs_1_direct,ram02_cs_1_direct,ram01_cs_1_direct,ram00_cs_1_direct};


//------------------Instantiations----------------


FFTARRAY_Controller fftarray_c01(
FFT_baseclock	,
FFT_reset	,
FFT_busyflag	,
//unit_1DFFTX()
f_unified_command
);


//unit_1DFFTs
unit_1DFFT f31(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram31port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(31+1)*16-1:31*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram31_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram31_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram31_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram31port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(31+1)*16-1:31*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram31_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram31_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram31_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f30(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram30port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(30+1)*16-1:30*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram30_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram30_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram30_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram30port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(30+1)*16-1:30*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram30_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram30_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram30_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f29(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram29port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(29+1)*16-1:29*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram29_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram29_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram29_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram29port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(29+1)*16-1:29*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram29_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram29_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram29_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f28(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram28port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(28+1)*16-1:28*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram28_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram28_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram28_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram28port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(28+1)*16-1:28*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram28_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram28_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram28_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f27(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram27port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(27+1)*16-1:27*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram27_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram27_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram27_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram27port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(27+1)*16-1:27*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram27_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram27_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram27_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f26(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram26port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(26+1)*16-1:26*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram26_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram26_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram26_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram26port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(26+1)*16-1:26*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram26_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram26_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram26_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f25(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram25port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(25+1)*16-1:25*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram25_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram25_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram25_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram25port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(25+1)*16-1:25*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram25_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram25_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram25_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f24(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram24port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(24+1)*16-1:24*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram24_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram24_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram24_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram24port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(24+1)*16-1:24*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram24_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram24_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram24_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f23(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram23port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(23+1)*16-1:23*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram23_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram23_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram23_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram23port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(23+1)*16-1:23*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram23_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram23_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram23_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f22(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram22port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(22+1)*16-1:22*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram22_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram22_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram22_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram22port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(22+1)*16-1:22*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram22_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram22_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram22_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f21(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram21port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(21+1)*16-1:21*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram21_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram21_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram21_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram21port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(21+1)*16-1:21*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram21_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram21_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram21_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f20(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram20port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(20+1)*16-1:20*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram20_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram20_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram20_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram20port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(20+1)*16-1:20*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram20_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram20_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram20_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f19(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram19port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(19+1)*16-1:19*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram19_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram19_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram19_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram19port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(19+1)*16-1:19*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram19_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram19_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram19_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f18(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram18port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(18+1)*16-1:18*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram18_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram18_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram18_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram18port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(18+1)*16-1:18*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram18_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram18_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram18_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f17(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram17port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(17+1)*16-1:17*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram17_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram17_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram17_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram17port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(17+1)*16-1:17*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram17_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram17_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram17_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f16(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram16port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(16+1)*16-1:16*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram16_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram16_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram16_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram16port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(16+1)*16-1:16*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram16_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram16_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram16_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f15(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram15port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(15+1)*16-1:15*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram15_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram15_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram15_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram15port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(15+1)*16-1:15*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram15_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram15_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram15_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f14(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram14port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(14+1)*16-1:14*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram14_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram14_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram14_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram14port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(14+1)*16-1:14*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram14_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram14_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram14_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f13(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram13port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(13+1)*16-1:13*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram13_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram13_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram13_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram13port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(13+1)*16-1:13*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram13_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram13_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram13_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f12(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram12port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(12+1)*16-1:12*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram12_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram12_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram12_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram12port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(12+1)*16-1:12*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram12_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram12_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram12_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f11(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram11port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(11+1)*16-1:11*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram11_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram11_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram11_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram11port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(11+1)*16-1:11*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram11_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram11_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram11_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f10(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram10port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(10+1)*16-1:10*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram10_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram10_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram10_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram10port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(10+1)*16-1:10*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram10_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram10_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram10_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f09(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram09port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(09+1)*16-1:09*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram09_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram09_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram09_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram09port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(09+1)*16-1:09*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram09_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram09_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram09_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f08(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram08port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(08+1)*16-1:08*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram08_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram08_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram08_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram08port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(08+1)*16-1:08*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram08_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram08_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram08_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f07(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram07port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(07+1)*16-1:07*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram07_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram07_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram07_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram07port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(07+1)*16-1:07*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram07_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram07_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram07_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f06(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram06port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(06+1)*16-1:06*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram06_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram06_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram06_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram06port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(06+1)*16-1:06*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram06_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram06_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram06_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f05(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram05port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(05+1)*16-1:05*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram05_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram05_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram05_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram05port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(05+1)*16-1:05*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram05_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram05_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram05_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f04(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram04port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(04+1)*16-1:04*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram04_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram04_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram04_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram04port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(04+1)*16-1:04*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram04_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram04_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram04_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f03(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram03port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(03+1)*16-1:03*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram03_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram03_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram03_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram03port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(03+1)*16-1:03*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram03_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram03_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram03_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f02(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram02port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(02+1)*16-1:02*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram02_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram02_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram02_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram02port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(02+1)*16-1:02*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram02_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram02_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram02_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f01(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram01port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(01+1)*16-1:01*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram01_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram01_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram01_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram01port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(01+1)*16-1:01*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram01_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram01_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram01_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);

unit_1DFFT f00(
FFT_baseclock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f_unified_command,	//Connection twixt unit-FFT2D_Controller
ram00port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
FFT_dataa[(00+1)*16-1:00*16], 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram00_cs_0_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram00_we_0_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram00_oe_0_direct, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram00port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
FFT_datab[(00+1)*16-1:00*16], 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram00_cs_1_direct, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram00_we_1_direct, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram00_oe_1_direct, //Connection twixt unit-RAM-TransposeControl Output Enable
FFT_chooseIFFT);


endmodule		
