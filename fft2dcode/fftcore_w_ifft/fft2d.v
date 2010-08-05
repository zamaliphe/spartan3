`include "00defines.v"

module FFT2D(
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
wire [`FFT2D_C_RAM_ADD_BITS-1:0]  present_ram_row;

//FFT2D : REQIRED FOR MUXING PRESENT_RAM_ROW and 0: INTERNAL
wire [`FFT2D_C_RAM_ADD_BITS-1:0] muxed_present_ram_row0;
wire [`FFT2D_C_RAM_ADD_BITS-1:0] muxed_present_ram_row1;
//2DIO: DUMMY
wire [`FFT_DATA_WIDTH-1:0] io2d_data_for_units;

//RAMs

//start of dummy wires
wire  ram00_clk,ram01_clk,ram02_clk,ram03_clk,ram04_clk,ram05_clk,ram06_clk,ram07_clk;
wire  ram08_clk,ram09_clk,ram10_clk,ram11_clk,ram12_clk,ram13_clk,ram14_clk,ram15_clk;
wire  ram16_clk,ram17_clk,ram18_clk,ram19_clk,ram20_clk,ram21_clk,ram22_clk,ram23_clk;
wire  ram24_clk,ram25_clk,ram26_clk,ram27_clk,ram28_clk,ram29_clk,ram30_clk,ram31_clk;
//end of dummy wires

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

wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram00port0_add_direct,ram01port0_add_direct,ram02port0_add_direct,ram03port0_add_direct,ram04port0_add_direct,ram05port0_add_direct,ram06port0_add_direct,ram07port0_add_direct;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram08port0_add_direct,ram09port0_add_direct,ram10port0_add_direct,ram11port0_add_direct,ram12port0_add_direct,ram13port0_add_direct,ram14port0_add_direct,ram15port0_add_direct;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram16port0_add_direct,ram17port0_add_direct,ram18port0_add_direct,ram19port0_add_direct,ram20port0_add_direct,ram21port0_add_direct,ram22port0_add_direct,ram23port0_add_direct;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram24port0_add_direct,ram25port0_add_direct,ram26port0_add_direct,ram27port0_add_direct,ram28port0_add_direct,ram29port0_add_direct,ram30port0_add_direct,ram31port0_add_direct;

wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram00port1_add_direct,ram01port1_add_direct,ram02port1_add_direct,ram03port1_add_direct,ram04port1_add_direct,ram05port1_add_direct,ram06port1_add_direct,ram07port1_add_direct;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram08port1_add_direct,ram09port1_add_direct,ram10port1_add_direct,ram11port1_add_direct,ram12port1_add_direct,ram13port1_add_direct,ram14port1_add_direct,ram15port1_add_direct;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram16port1_add_direct,ram17port1_add_direct,ram18port1_add_direct,ram19port1_add_direct,ram20port1_add_direct,ram21port1_add_direct,ram22port1_add_direct,ram23port1_add_direct;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram24port1_add_direct,ram25port1_add_direct,ram26port1_add_direct,ram27port1_add_direct,ram28port1_add_direct,ram29port1_add_direct,ram30port1_add_direct,ram31port1_add_direct;

//END OF REQUIRED TO BE CONNECTED TO THE UNIT_1DFFT: INTERNAL WIRES

//ROM : ALL ROM WIRES ARE DUMMY
wire [`ROM_ADD_WIDTH-1:0] rom00_add,rom01_add,rom02_add,rom03_add,rom04_add,rom05_add,rom06_add,rom07_add;
wire [`ROM_ADD_WIDTH-1:0] rom08_add,rom09_add,rom10_add,rom11_add,rom12_add,rom13_add,rom14_add,rom15_add;
wire [`ROM_ADD_WIDTH-1:0] rom16_add,rom17_add,rom18_add,rom19_add,rom20_add,rom21_add,rom22_add,rom23_add;
wire [`ROM_ADD_WIDTH-1:0] rom24_add,rom25_add,rom26_add,rom27_add,rom28_add,rom29_add,rom30_add,rom31_add;
wire [`FFT_DATA_WIDTH-1:0] rom_bus;
wire  rom00_re,rom01_re,rom02_re,rom03_re,rom04_re,rom05_re,rom06_re,rom07_re;
wire  rom08_re,rom09_re,rom10_re,rom11_re,rom12_re,rom13_re,rom14_re,rom15_re;
wire  rom16_re,rom17_re,rom18_re,rom19_re,rom20_re,rom21_re,rom22_re,rom23_re;
wire  rom24_re,rom25_re,rom26_re,rom27_re,rom28_re,rom29_re,rom30_re,rom31_re;
wire  rom00_cs,rom01_cs,rom02_cs,rom03_cs,rom04_cs,rom05_cs,rom06_cs,rom07_cs;
wire  rom08_cs,rom09_cs,rom10_cs,rom11_cs,rom12_cs,rom13_cs,rom14_cs,rom15_cs;
wire  rom16_cs,rom17_cs,rom18_cs,rom19_cs,rom20_cs,rom21_cs,rom22_cs,rom23_cs;
wire  rom24_cs,rom25_cs,rom26_cs,rom27_cs,rom28_cs,rom29_cs,rom30_cs,rom31_cs;
wire  rom00_tri,rom01_tri,rom02_tri,rom03_tri,rom04_tri,rom05_tri,rom06_tri,rom07_tri;
wire  rom08_tri,rom09_tri,rom10_tri,rom11_tri,rom12_tri,rom13_tri,rom14_tri,rom15_tri;
wire  rom16_tri,rom17_tri,rom18_tri,rom19_tri,rom20_tri,rom21_tri,rom22_tri,rom23_tri;
wire  rom24_tri,rom25_tri,rom26_tri,rom27_tri,rom28_tri,rom29_tri,rom30_tri,rom31_tri;

//TRANSPOSER RELATED DECLARATIONS: INTERNAL
wire transposer_clk	;
wire transposer_reset	;
wire do_transpose	;
wire do_bitreversing	;
wire done_transpose	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram00_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram00_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram00_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram00_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram01_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram01_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram01_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram01_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram02_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram02_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram02_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram02_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram03_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram03_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram03_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram03_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram04_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram04_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram04_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram04_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram05_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram05_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram05_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram05_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram06_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram06_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram06_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram06_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram07_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram07_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram07_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram07_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram08_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram08_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram08_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram08_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram09_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram09_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram09_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram09_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram10_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram10_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram10_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram10_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram11_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram11_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram11_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram11_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram12_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram12_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram12_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram12_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram13_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram13_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram13_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram13_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram14_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram14_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram14_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram14_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram15_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram15_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram15_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram15_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram16_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram16_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram16_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram16_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram17_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram17_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram17_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram17_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram18_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram18_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram18_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram18_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram19_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram19_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram19_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram19_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram20_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram20_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram20_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram20_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram21_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram21_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram21_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram21_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram22_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram22_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram22_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram22_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram23_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram23_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram23_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram23_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram24_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram24_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram24_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram24_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram25_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram25_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram25_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram25_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram26_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram26_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram26_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram26_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram27_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram27_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram27_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram27_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram28_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram28_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram28_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram28_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram29_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram29_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram29_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram29_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram30_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram30_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram30_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram30_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram31_port0_add;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram31_port1_add;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram31_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram31_cs_we_oe_1	;



//---------------------------ASSIGNMENTS----------------------------------------
//MUXING PERIPHERAL ADDRESSES USING THE DO_TRANSPOSE SIGNAL
assign FFT_addra = (do_transpose==1'b1)?{tr_ram31_port0_add,tr_ram30_port0_add,tr_ram29_port0_add,
tr_ram28_port0_add,tr_ram27_port0_add,tr_ram26_port0_add,tr_ram25_port0_add,tr_ram24_port0_add,
tr_ram23_port0_add,tr_ram22_port0_add,tr_ram21_port0_add,tr_ram20_port0_add,tr_ram19_port0_add,
tr_ram18_port0_add,tr_ram17_port0_add,tr_ram16_port0_add,tr_ram15_port0_add,tr_ram14_port0_add,
tr_ram13_port0_add,tr_ram12_port0_add,tr_ram11_port0_add,tr_ram10_port0_add,tr_ram09_port0_add,
tr_ram08_port0_add,tr_ram07_port0_add,tr_ram06_port0_add,tr_ram05_port0_add,tr_ram04_port0_add,
tr_ram03_port0_add,tr_ram02_port0_add,tr_ram01_port0_add,tr_ram00_port0_add}:{ram31port0_add_direct,ram30port0_add_direct,ram29port0_add_direct,
ram28port0_add_direct,ram27port0_add_direct,ram26port0_add_direct,ram25port0_add_direct,ram24port0_add_direct,
ram23port0_add_direct,ram22port0_add_direct,ram21port0_add_direct,ram20port0_add_direct,ram19port0_add_direct,
ram18port0_add_direct,ram17port0_add_direct,ram16port0_add_direct,ram15port0_add_direct,ram14port0_add_direct,
ram13port0_add_direct,ram12port0_add_direct,ram11port0_add_direct,ram10port0_add_direct,ram09port0_add_direct,
ram08port0_add_direct,ram07port0_add_direct,ram06port0_add_direct,ram05port0_add_direct,ram04port0_add_direct,
ram03port0_add_direct,ram02port0_add_direct,ram01port0_add_direct,ram00port0_add_direct};

assign FFT_addrb = (do_transpose==1'b1)?{tr_ram31_port1_add,tr_ram30_port1_add,tr_ram29_port1_add,
tr_ram28_port1_add,tr_ram27_port1_add,tr_ram26_port1_add,tr_ram25_port1_add,tr_ram24_port1_add,
tr_ram23_port1_add,tr_ram22_port1_add,tr_ram21_port1_add,tr_ram20_port1_add,tr_ram19_port1_add,
tr_ram18_port1_add,tr_ram17_port1_add,tr_ram16_port1_add,tr_ram15_port1_add,tr_ram14_port1_add,
tr_ram13_port1_add,tr_ram12_port1_add,tr_ram11_port1_add,tr_ram10_port1_add,tr_ram09_port1_add,
tr_ram08_port1_add,tr_ram07_port1_add,tr_ram06_port1_add,tr_ram05_port1_add,tr_ram04_port1_add,
tr_ram03_port1_add,tr_ram02_port1_add,tr_ram01_port1_add,tr_ram00_port1_add}:{ram31port1_add_direct,ram30port1_add_direct,ram29port1_add_direct,
ram28port1_add_direct,ram27port1_add_direct,ram26port1_add_direct,ram25port1_add_direct,ram24port1_add_direct,
ram23port1_add_direct,ram22port1_add_direct,ram21port1_add_direct,ram20port1_add_direct,ram19port1_add_direct,
ram18port1_add_direct,ram17port1_add_direct,ram16port1_add_direct,ram15port1_add_direct,ram14port1_add_direct,
ram13port1_add_direct,ram12port1_add_direct,ram11port1_add_direct,ram10port1_add_direct,ram09port1_add_direct,
ram08port1_add_direct,ram07port1_add_direct,ram06port1_add_direct,ram05port1_add_direct,ram04port1_add_direct,
ram03port1_add_direct,ram02port1_add_direct,ram01port1_add_direct,ram00port1_add_direct};
//END OF MUXING PERIPHERAL ADDRESSES USING THE DO_TRANSPOSE SIGNAL

//MUXING PERIPHERAL CONTROLS USING THE DO_TRANSPOSE SIGNAL
assign FFT_wea = (do_transpose==1'b1)?{tr_ram31_cs_we_oe_0[1],tr_ram30_cs_we_oe_0[1],tr_ram29_cs_we_oe_0[1],
tr_ram28_cs_we_oe_0[1],tr_ram27_cs_we_oe_0[1],tr_ram26_cs_we_oe_0[1],tr_ram25_cs_we_oe_0[1],tr_ram24_cs_we_oe_0[1],
tr_ram23_cs_we_oe_0[1],tr_ram22_cs_we_oe_0[1],tr_ram21_cs_we_oe_0[1],tr_ram20_cs_we_oe_0[1],tr_ram19_cs_we_oe_0[1],
tr_ram18_cs_we_oe_0[1],tr_ram17_cs_we_oe_0[1],tr_ram16_cs_we_oe_0[1],tr_ram15_cs_we_oe_0[1],tr_ram14_cs_we_oe_0[1],
tr_ram13_cs_we_oe_0[1],tr_ram12_cs_we_oe_0[1],tr_ram11_cs_we_oe_0[1],tr_ram10_cs_we_oe_0[1],tr_ram09_cs_we_oe_0[1],
tr_ram08_cs_we_oe_0[1],tr_ram07_cs_we_oe_0[1],tr_ram06_cs_we_oe_0[1],tr_ram05_cs_we_oe_0[1],tr_ram04_cs_we_oe_0[1],
tr_ram03_cs_we_oe_0[1],tr_ram02_cs_we_oe_0[1],tr_ram01_cs_we_oe_0[1],tr_ram00_cs_we_oe_0[1]}:({ram31_we_0_direct,ram30_we_0_direct,ram29_we_0_direct,
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
ram03_cs_0_direct,ram02_cs_0_direct,ram01_cs_0_direct,ram00_cs_0_direct});

assign FFT_rea = (do_transpose==1'b1)?{tr_ram31_cs_we_oe_0[0],tr_ram30_cs_we_oe_0[0],tr_ram29_cs_we_oe_0[0],
tr_ram28_cs_we_oe_0[0],tr_ram27_cs_we_oe_0[0],tr_ram26_cs_we_oe_0[0],tr_ram25_cs_we_oe_0[0],tr_ram24_cs_we_oe_0[0],
tr_ram23_cs_we_oe_0[0],tr_ram22_cs_we_oe_0[0],tr_ram21_cs_we_oe_0[0],tr_ram20_cs_we_oe_0[0],tr_ram19_cs_we_oe_0[0],
tr_ram18_cs_we_oe_0[0],tr_ram17_cs_we_oe_0[0],tr_ram16_cs_we_oe_0[0],tr_ram15_cs_we_oe_0[0],tr_ram14_cs_we_oe_0[0],
tr_ram13_cs_we_oe_0[0],tr_ram12_cs_we_oe_0[0],tr_ram11_cs_we_oe_0[0],tr_ram10_cs_we_oe_0[0],tr_ram09_cs_we_oe_0[0],
tr_ram08_cs_we_oe_0[0],tr_ram07_cs_we_oe_0[0],tr_ram06_cs_we_oe_0[0],tr_ram05_cs_we_oe_0[0],tr_ram04_cs_we_oe_0[0],
tr_ram03_cs_we_oe_0[0],tr_ram02_cs_we_oe_0[0],tr_ram01_cs_we_oe_0[0],tr_ram00_cs_we_oe_0[0]}:({ram31_oe_0_direct,ram30_oe_0_direct,ram29_oe_0_direct,
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
ram03_cs_0_direct,ram02_cs_0_direct,ram01_cs_0_direct,ram00_cs_0_direct});

assign FFT_web = (do_transpose==1'b1)?{tr_ram31_cs_we_oe_1[1],tr_ram30_cs_we_oe_1[1],tr_ram29_cs_we_oe_1[1],
tr_ram28_cs_we_oe_1[1],tr_ram27_cs_we_oe_1[1],tr_ram26_cs_we_oe_1[1],tr_ram25_cs_we_oe_1[1],tr_ram24_cs_we_oe_1[1],
tr_ram23_cs_we_oe_1[1],tr_ram22_cs_we_oe_1[1],tr_ram21_cs_we_oe_1[1],tr_ram20_cs_we_oe_1[1],tr_ram19_cs_we_oe_1[1],
tr_ram18_cs_we_oe_1[1],tr_ram17_cs_we_oe_1[1],tr_ram16_cs_we_oe_1[1],tr_ram15_cs_we_oe_1[1],tr_ram14_cs_we_oe_1[1],
tr_ram13_cs_we_oe_1[1],tr_ram12_cs_we_oe_1[1],tr_ram11_cs_we_oe_1[1],tr_ram10_cs_we_oe_1[1],tr_ram09_cs_we_oe_1[1],
tr_ram08_cs_we_oe_1[1],tr_ram07_cs_we_oe_1[1],tr_ram06_cs_we_oe_1[1],tr_ram05_cs_we_oe_1[1],tr_ram04_cs_we_oe_1[1],
tr_ram03_cs_we_oe_1[1],tr_ram02_cs_we_oe_1[1],tr_ram01_cs_we_oe_1[1],tr_ram00_cs_we_oe_1[1]}:({ram31_we_1_direct,ram30_we_1_direct,ram29_we_1_direct,
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
ram03_cs_1_direct,ram02_cs_1_direct,ram01_cs_1_direct,ram00_cs_1_direct});

assign FFT_reb = (do_transpose==1'b1)?{tr_ram31_cs_we_oe_1[0],tr_ram30_cs_we_oe_1[0],tr_ram29_cs_we_oe_1[0],
tr_ram28_cs_we_oe_1[0],tr_ram27_cs_we_oe_1[0],tr_ram26_cs_we_oe_1[0],tr_ram25_cs_we_oe_1[0],tr_ram24_cs_we_oe_1[0],
tr_ram23_cs_we_oe_1[0],tr_ram22_cs_we_oe_1[0],tr_ram21_cs_we_oe_1[0],tr_ram20_cs_we_oe_1[0],tr_ram19_cs_we_oe_1[0],
tr_ram18_cs_we_oe_1[0],tr_ram17_cs_we_oe_1[0],tr_ram16_cs_we_oe_1[0],tr_ram15_cs_we_oe_1[0],tr_ram14_cs_we_oe_1[0],
tr_ram13_cs_we_oe_1[0],tr_ram12_cs_we_oe_1[0],tr_ram11_cs_we_oe_1[0],tr_ram10_cs_we_oe_1[0],tr_ram09_cs_we_oe_1[0],
tr_ram08_cs_we_oe_1[0],tr_ram07_cs_we_oe_1[0],tr_ram06_cs_we_oe_1[0],tr_ram05_cs_we_oe_1[0],tr_ram04_cs_we_oe_1[0],
tr_ram03_cs_we_oe_1[0],tr_ram02_cs_we_oe_1[0],tr_ram01_cs_we_oe_1[0],tr_ram00_cs_we_oe_1[0]}:({ram31_oe_1_direct,ram30_oe_1_direct,ram29_oe_1_direct,
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
ram03_cs_1_direct,ram02_cs_1_direct,ram01_cs_1_direct,ram00_cs_1_direct});

//END OF MUXING PERIPHERAL CONTROLS USING THE DO_TRANSPOSE SIGNAL


//INTERNAL WIRINGS : IMPORTANT: DIRECT ADDR TO RAMS = f(muxed_PRESENT_RAM_ROW,ADDR_F)

assign muxed_present_ram_row0 = (ram00port0_add_f[`LOG_N+2-1]==1)?present_ram_row:`FFT2D_C_RAM_ADD_BITS'b0;
assign muxed_present_ram_row1 = (ram00port1_add_f[`LOG_N+2-1]==1)?present_ram_row:`FFT2D_C_RAM_ADD_BITS'b0;

assign ram00port0_add_direct = {ram00port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram00port0_add_f[`LOG_N+2-2:0]};
assign ram01port0_add_direct = {ram01port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram01port0_add_f[`LOG_N+2-2:0]};
assign ram02port0_add_direct = {ram02port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram02port0_add_f[`LOG_N+2-2:0]};
assign ram03port0_add_direct = {ram03port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram03port0_add_f[`LOG_N+2-2:0]};
assign ram04port0_add_direct = {ram04port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram04port0_add_f[`LOG_N+2-2:0]};
assign ram05port0_add_direct = {ram05port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram05port0_add_f[`LOG_N+2-2:0]};
assign ram06port0_add_direct = {ram06port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram06port0_add_f[`LOG_N+2-2:0]};
assign ram07port0_add_direct = {ram07port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram07port0_add_f[`LOG_N+2-2:0]};
assign ram08port0_add_direct = {ram08port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram08port0_add_f[`LOG_N+2-2:0]};
assign ram09port0_add_direct = {ram09port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram09port0_add_f[`LOG_N+2-2:0]};
assign ram10port0_add_direct = {ram10port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram10port0_add_f[`LOG_N+2-2:0]};
assign ram11port0_add_direct = {ram11port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram11port0_add_f[`LOG_N+2-2:0]};
assign ram12port0_add_direct = {ram12port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram12port0_add_f[`LOG_N+2-2:0]};
assign ram13port0_add_direct = {ram13port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram13port0_add_f[`LOG_N+2-2:0]};
assign ram14port0_add_direct = {ram14port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram14port0_add_f[`LOG_N+2-2:0]};
assign ram15port0_add_direct = {ram15port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram15port0_add_f[`LOG_N+2-2:0]};
assign ram16port0_add_direct = {ram16port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram16port0_add_f[`LOG_N+2-2:0]};
assign ram17port0_add_direct = {ram17port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram17port0_add_f[`LOG_N+2-2:0]};
assign ram18port0_add_direct = {ram18port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram18port0_add_f[`LOG_N+2-2:0]};
assign ram19port0_add_direct = {ram19port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram19port0_add_f[`LOG_N+2-2:0]};
assign ram20port0_add_direct = {ram20port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram20port0_add_f[`LOG_N+2-2:0]};
assign ram21port0_add_direct = {ram21port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram21port0_add_f[`LOG_N+2-2:0]};
assign ram22port0_add_direct = {ram22port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram22port0_add_f[`LOG_N+2-2:0]};
assign ram23port0_add_direct = {ram23port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram23port0_add_f[`LOG_N+2-2:0]};
assign ram24port0_add_direct = {ram24port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram24port0_add_f[`LOG_N+2-2:0]};
assign ram25port0_add_direct = {ram25port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram25port0_add_f[`LOG_N+2-2:0]};
assign ram26port0_add_direct = {ram26port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram26port0_add_f[`LOG_N+2-2:0]};
assign ram27port0_add_direct = {ram27port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram27port0_add_f[`LOG_N+2-2:0]};
assign ram28port0_add_direct = {ram28port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram28port0_add_f[`LOG_N+2-2:0]};
assign ram29port0_add_direct = {ram29port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram29port0_add_f[`LOG_N+2-2:0]};
assign ram30port0_add_direct = {ram30port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram30port0_add_f[`LOG_N+2-2:0]};
assign ram31port0_add_direct = {ram31port0_add_f[`LOG_N+2-1],muxed_present_ram_row0,ram31port0_add_f[`LOG_N+2-2:0]};

assign ram00port1_add_direct = {ram00port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram00port1_add_f[`LOG_N+2-2:0]};
assign ram01port1_add_direct = {ram01port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram01port1_add_f[`LOG_N+2-2:0]};
assign ram02port1_add_direct = {ram02port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram02port1_add_f[`LOG_N+2-2:0]};
assign ram03port1_add_direct = {ram03port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram03port1_add_f[`LOG_N+2-2:0]};
assign ram04port1_add_direct = {ram04port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram04port1_add_f[`LOG_N+2-2:0]};
assign ram05port1_add_direct = {ram05port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram05port1_add_f[`LOG_N+2-2:0]};
assign ram06port1_add_direct = {ram06port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram06port1_add_f[`LOG_N+2-2:0]};
assign ram07port1_add_direct = {ram07port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram07port1_add_f[`LOG_N+2-2:0]};
assign ram08port1_add_direct = {ram08port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram08port1_add_f[`LOG_N+2-2:0]};
assign ram09port1_add_direct = {ram09port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram09port1_add_f[`LOG_N+2-2:0]};
assign ram10port1_add_direct = {ram10port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram10port1_add_f[`LOG_N+2-2:0]};
assign ram11port1_add_direct = {ram11port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram11port1_add_f[`LOG_N+2-2:0]};
assign ram12port1_add_direct = {ram12port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram12port1_add_f[`LOG_N+2-2:0]};
assign ram13port1_add_direct = {ram13port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram13port1_add_f[`LOG_N+2-2:0]};
assign ram14port1_add_direct = {ram14port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram14port1_add_f[`LOG_N+2-2:0]};
assign ram15port1_add_direct = {ram15port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram15port1_add_f[`LOG_N+2-2:0]};
assign ram16port1_add_direct = {ram16port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram16port1_add_f[`LOG_N+2-2:0]};
assign ram17port1_add_direct = {ram17port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram17port1_add_f[`LOG_N+2-2:0]};
assign ram18port1_add_direct = {ram18port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram18port1_add_f[`LOG_N+2-2:0]};
assign ram19port1_add_direct = {ram19port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram19port1_add_f[`LOG_N+2-2:0]};
assign ram20port1_add_direct = {ram20port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram20port1_add_f[`LOG_N+2-2:0]};
assign ram21port1_add_direct = {ram21port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram21port1_add_f[`LOG_N+2-2:0]};
assign ram22port1_add_direct = {ram22port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram22port1_add_f[`LOG_N+2-2:0]};
assign ram23port1_add_direct = {ram23port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram23port1_add_f[`LOG_N+2-2:0]};
assign ram24port1_add_direct = {ram24port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram24port1_add_f[`LOG_N+2-2:0]};
assign ram25port1_add_direct = {ram25port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram25port1_add_f[`LOG_N+2-2:0]};
assign ram26port1_add_direct = {ram26port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram26port1_add_f[`LOG_N+2-2:0]};
assign ram27port1_add_direct = {ram27port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram27port1_add_f[`LOG_N+2-2:0]};
assign ram28port1_add_direct = {ram28port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram28port1_add_f[`LOG_N+2-2:0]};
assign ram29port1_add_direct = {ram29port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram29port1_add_f[`LOG_N+2-2:0]};
assign ram30port1_add_direct = {ram30port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram30port1_add_f[`LOG_N+2-2:0]};
assign ram31port1_add_direct = {ram31port1_add_f[`LOG_N+2-1],muxed_present_ram_row1,ram31port1_add_f[`LOG_N+2-2:0]};

//END OF INTERNAL WIRINGS : IMPORTANT: DIRECT ADDR TO RAMS = f(muxed_PRESENT_RAM_ROW,ADDR_F)



//------------------Instantiations----------------


FFT2D_Controller fft2d_c01(
FFT_baseclock	,
FFT_reset	,
FFT_busyflag	,
//unit_1DFFTX()
f_unified_command,	
//RAMXAddbits()
present_ram_row,
//Transposer
transposer_reset,	
do_transpose	,
do_bitreversing	,
done_transpose		
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



Transposer tran01(
FFT_baseclock	,
transposer_reset,
do_transpose	,	//start signal as well as the tri-stater
do_bitreversing ,
done_transpose	,	//status flag indicating operation finish
tr_ram00_port0_add	,
FFT_dataa[(00+1)*16-1:00*16]	,
tr_ram00_port1_add	,
FFT_datab[(00+1)*16-1:00*16]	,
tr_ram00_cs_we_oe_0,
tr_ram00_cs_we_oe_1,	//Have to repeat this for all rams
tr_ram01_port0_add	,
FFT_dataa[(01+1)*16-1:01*16]	,
tr_ram01_port1_add	,
FFT_datab[(01+1)*16-1:01*16]	,
tr_ram01_cs_we_oe_0,
tr_ram01_cs_we_oe_1,
tr_ram02_port0_add	,
FFT_dataa[(02+1)*16-1:02*16]	,
tr_ram02_port1_add	,
FFT_datab[(02+1)*16-1:02*16]	,
tr_ram02_cs_we_oe_0,
tr_ram02_cs_we_oe_1,
tr_ram03_port0_add	,
FFT_dataa[(03+1)*16-1:03*16]	,
tr_ram03_port1_add	,
FFT_datab[(03+1)*16-1:03*16]	,
tr_ram03_cs_we_oe_0,
tr_ram03_cs_we_oe_1,
tr_ram04_port0_add	,
FFT_dataa[(04+1)*16-1:04*16]	,
tr_ram04_port1_add	,
FFT_datab[(04+1)*16-1:04*16]	,
tr_ram04_cs_we_oe_0,
tr_ram04_cs_we_oe_1,
tr_ram05_port0_add	,
FFT_dataa[(05+1)*16-1:05*16]	,
tr_ram05_port1_add	,
FFT_datab[(05+1)*16-1:05*16]	,
tr_ram05_cs_we_oe_0,
tr_ram05_cs_we_oe_1,
tr_ram06_port0_add	,
FFT_dataa[(06+1)*16-1:06*16]	,
tr_ram06_port1_add	,
FFT_datab[(06+1)*16-1:06*16]	,
tr_ram06_cs_we_oe_0,
tr_ram06_cs_we_oe_1,
tr_ram07_port0_add	,
FFT_dataa[(07+1)*16-1:07*16]	,
tr_ram07_port1_add	,
FFT_datab[(07+1)*16-1:07*16]	,
tr_ram07_cs_we_oe_0,
tr_ram07_cs_we_oe_1,
tr_ram08_port0_add	,
FFT_dataa[(08+1)*16-1:08*16]	,
tr_ram08_port1_add	,
FFT_datab[(08+1)*16-1:08*16]	,
tr_ram08_cs_we_oe_0,
tr_ram08_cs_we_oe_1,
tr_ram09_port0_add	,
FFT_dataa[(09+1)*16-1:09*16]	,
tr_ram09_port1_add	,
FFT_datab[(09+1)*16-1:09*16]	,
tr_ram09_cs_we_oe_0,
tr_ram09_cs_we_oe_1,
tr_ram10_port0_add	,
FFT_dataa[(10+1)*16-1:10*16]	,
tr_ram10_port1_add	,
FFT_datab[(10+1)*16-1:10*16]	,
tr_ram10_cs_we_oe_0,
tr_ram10_cs_we_oe_1,
tr_ram11_port0_add	,
FFT_dataa[(11+1)*16-1:11*16]	,
tr_ram11_port1_add	,
FFT_datab[(11+1)*16-1:11*16]	,
tr_ram11_cs_we_oe_0,
tr_ram11_cs_we_oe_1,
tr_ram12_port0_add	,
FFT_dataa[(12+1)*16-1:12*16]	,
tr_ram12_port1_add	,
FFT_datab[(12+1)*16-1:12*16]	,
tr_ram12_cs_we_oe_0,
tr_ram12_cs_we_oe_1,
tr_ram13_port0_add	,
FFT_dataa[(13+1)*16-1:13*16]	,
tr_ram13_port1_add	,
FFT_datab[(13+1)*16-1:13*16]	,
tr_ram13_cs_we_oe_0,
tr_ram13_cs_we_oe_1,
tr_ram14_port0_add	,
FFT_dataa[(14+1)*16-1:14*16]	,
tr_ram14_port1_add	,
FFT_datab[(14+1)*16-1:14*16]	,
tr_ram14_cs_we_oe_0,
tr_ram14_cs_we_oe_1,
tr_ram15_port0_add	,
FFT_dataa[(15+1)*16-1:15*16]	,
tr_ram15_port1_add	,
FFT_datab[(15+1)*16-1:15*16]	,
tr_ram15_cs_we_oe_0,
tr_ram15_cs_we_oe_1,
tr_ram16_port0_add	,
FFT_dataa[(16+1)*16-1:16*16]	,
tr_ram16_port1_add	,
FFT_datab[(16+1)*16-1:16*16]	,
tr_ram16_cs_we_oe_0,
tr_ram16_cs_we_oe_1,
tr_ram17_port0_add	,
FFT_dataa[(17+1)*16-1:17*16]	,
tr_ram17_port1_add	,
FFT_datab[(17+1)*16-1:17*16]	,
tr_ram17_cs_we_oe_0,
tr_ram17_cs_we_oe_1,
tr_ram18_port0_add	,
FFT_dataa[(18+1)*16-1:18*16]	,
tr_ram18_port1_add	,
FFT_datab[(18+1)*16-1:18*16]	,
tr_ram18_cs_we_oe_0,
tr_ram18_cs_we_oe_1,
tr_ram19_port0_add	,
FFT_dataa[(19+1)*16-1:19*16]	,
tr_ram19_port1_add	,
FFT_datab[(19+1)*16-1:19*16]	,
tr_ram19_cs_we_oe_0,
tr_ram19_cs_we_oe_1,
tr_ram20_port0_add	,
FFT_dataa[(20+1)*16-1:20*16]	,
tr_ram20_port1_add	,
FFT_datab[(20+1)*16-1:20*16]	,
tr_ram20_cs_we_oe_0,
tr_ram20_cs_we_oe_1,
tr_ram21_port0_add	,
FFT_dataa[(21+1)*16-1:21*16]	,
tr_ram21_port1_add	,
FFT_datab[(21+1)*16-1:21*16]	,
tr_ram21_cs_we_oe_0,
tr_ram21_cs_we_oe_1,
tr_ram22_port0_add	,
FFT_dataa[(22+1)*16-1:22*16]	,
tr_ram22_port1_add	,
FFT_datab[(22+1)*16-1:22*16]	,
tr_ram22_cs_we_oe_0,
tr_ram22_cs_we_oe_1,
tr_ram23_port0_add	,
FFT_dataa[(23+1)*16-1:23*16]	,
tr_ram23_port1_add	,
FFT_datab[(23+1)*16-1:23*16]	,
tr_ram23_cs_we_oe_0,
tr_ram23_cs_we_oe_1,
tr_ram24_port0_add	,
FFT_dataa[(24+1)*16-1:24*16]	,
tr_ram24_port1_add	,
FFT_datab[(24+1)*16-1:24*16]	,
tr_ram24_cs_we_oe_0,
tr_ram24_cs_we_oe_1,
tr_ram25_port0_add	,
FFT_dataa[(25+1)*16-1:25*16]	,
tr_ram25_port1_add	,
FFT_datab[(25+1)*16-1:25*16]	,
tr_ram25_cs_we_oe_0,
tr_ram25_cs_we_oe_1,
tr_ram26_port0_add	,
FFT_dataa[(26+1)*16-1:26*16]	,
tr_ram26_port1_add	,
FFT_datab[(26+1)*16-1:26*16]	,
tr_ram26_cs_we_oe_0,
tr_ram26_cs_we_oe_1,
tr_ram27_port0_add	,
FFT_dataa[(27+1)*16-1:27*16]	,
tr_ram27_port1_add	,
FFT_datab[(27+1)*16-1:27*16]	,
tr_ram27_cs_we_oe_0,
tr_ram27_cs_we_oe_1,
tr_ram28_port0_add	,
FFT_dataa[(28+1)*16-1:28*16]	,
tr_ram28_port1_add	,
FFT_datab[(28+1)*16-1:28*16]	,
tr_ram28_cs_we_oe_0,
tr_ram28_cs_we_oe_1,
tr_ram29_port0_add	,
FFT_dataa[(29+1)*16-1:29*16]	,
tr_ram29_port1_add	,
FFT_datab[(29+1)*16-1:29*16]	,
tr_ram29_cs_we_oe_0,
tr_ram29_cs_we_oe_1,
tr_ram30_port0_add	,
FFT_dataa[(30+1)*16-1:30*16]	,
tr_ram30_port1_add	,
FFT_datab[(30+1)*16-1:30*16]	,
tr_ram30_cs_we_oe_0,
tr_ram30_cs_we_oe_1,
tr_ram31_port0_add	,
FFT_dataa[(31+1)*16-1:31*16]	,
tr_ram31_port1_add	,
FFT_datab[(31+1)*16-1:31*16]	,
tr_ram31_cs_we_oe_0,
tr_ram31_cs_we_oe_1
);



//assign FFT_dataa = 512'bZ;
//assign FFT_datab = 512'bZ;

endmodule		
