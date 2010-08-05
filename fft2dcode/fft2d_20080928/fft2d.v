`include "00defines.v"

module FFT2D(
io_fft2d_data,
i_fft2d_reset,
i_fft2d_start,
i_read_rom_ram,
i_fft2d_base_clock,
o_TIP,
o_busy
);

inout [`FFT_DATA_WIDTH-1:0] io_fft2d_data;
input i_fft2d_reset;
input i_fft2d_base_clock;
input i_fft2d_start;	
input i_read_rom_ram;
output o_TIP;	
output o_busy;

wire [`FFT_DATA_WIDTH-1:0] io_fft2d_data;
wire i_fft2d_reset;	
wire i_fft2d_base_clock;	
wire i_fft2d_start;
wire i_read_rom_ram;	
wire o_TIP;		
wire o_busy;

//--------Internal wires and registers------------

//Controller
wire f_base_clock	;	
wire [`SEQUENCE_MODE_LENGTH +2 -1:0] f00_command,f01_command,f02_command,f03_command,f04_command,f05_command,f06_command,f07_command;
wire [`SEQUENCE_MODE_LENGTH +2 -1:0] f08_command,f09_command,f10_command,f11_command,f12_command,f13_command,f14_command,f15_command;
wire [`SEQUENCE_MODE_LENGTH +2 -1:0] f16_command,f17_command,f18_command,f19_command,f20_command,f21_command,f22_command,f23_command;
wire [`SEQUENCE_MODE_LENGTH +2 -1:0] f24_command,f25_command,f26_command,f27_command,f28_command,f29_command,f30_command,f31_command;
wire [`LOG_N+2 + `AGU_MODE_WIDTH +1 -1:0] f00_status,f01_status,f02_status,f03_status,f04_status,f05_status,f06_status,f07_status;
wire [`LOG_N+2 + `AGU_MODE_WIDTH +1 -1:0] f08_status,f09_status,f10_status,f11_status,f12_status,f13_status,f14_status,f15_status;
wire [`LOG_N+2 + `AGU_MODE_WIDTH +1 -1:0] f16_status,f17_status,f18_status,f19_status,f20_status,f21_status,f22_status,f23_status;
wire [`LOG_N+2 + `AGU_MODE_WIDTH +1 -1:0] f24_status,f25_status,f26_status,f27_status,f28_status,f29_status,f30_status,f31_status;
wire [`FFT2D_C_RAM_ADD_BITS-1:0] ram00_add_c,ram01_add_c,ram02_add_c,ram03_add_c,ram04_add_c,ram05_add_c,ram06_add_c,ram07_add_c;
wire [`FFT2D_C_RAM_ADD_BITS-1:0] ram08_add_c,ram09_add_c,ram10_add_c,ram11_add_c,ram12_add_c,ram13_add_c,ram14_add_c,ram15_add_c;
wire [`FFT2D_C_RAM_ADD_BITS-1:0] ram16_add_c,ram17_add_c,ram18_add_c,ram19_add_c,ram20_add_c,ram21_add_c,ram22_add_c,ram23_add_c;
wire [`FFT2D_C_RAM_ADD_BITS-1:0] ram24_add_c,ram25_add_c,ram26_add_c,ram27_add_c,ram28_add_c,ram29_add_c,ram30_add_c,ram31_add_c;

wire [`FFT2D_C_RAM_ADD_BITS-1:0] ram00_add_c1,ram01_add_c1,ram02_add_c1,ram03_add_c1,ram04_add_c1,ram05_add_c1,ram06_add_c1,ram07_add_c1;
wire [`FFT2D_C_RAM_ADD_BITS-1:0] ram08_add_c1,ram09_add_c1,ram10_add_c1,ram11_add_c1,ram12_add_c1,ram13_add_c1,ram14_add_c1,ram15_add_c1;
wire [`FFT2D_C_RAM_ADD_BITS-1:0] ram16_add_c1,ram17_add_c1,ram18_add_c1,ram19_add_c1,ram20_add_c1,ram21_add_c1,ram22_add_c1,ram23_add_c1;
wire [`FFT2D_C_RAM_ADD_BITS-1:0] ram24_add_c1,ram25_add_c1,ram26_add_c1,ram27_add_c1,ram28_add_c1,ram29_add_c1,ram30_add_c1,ram31_add_c1;
wire [`FFT2D_C_RAM_ADD_BITS-1:0] ram00_add_c2,ram01_add_c2,ram02_add_c2,ram03_add_c2,ram04_add_c2,ram05_add_c2,ram06_add_c2,ram07_add_c2;
wire [`FFT2D_C_RAM_ADD_BITS-1:0] ram08_add_c2,ram09_add_c2,ram10_add_c2,ram11_add_c2,ram12_add_c2,ram13_add_c2,ram14_add_c2,ram15_add_c2;
wire [`FFT2D_C_RAM_ADD_BITS-1:0] ram16_add_c2,ram17_add_c2,ram18_add_c2,ram19_add_c2,ram20_add_c2,ram21_add_c2,ram22_add_c2,ram23_add_c2;
wire [`FFT2D_C_RAM_ADD_BITS-1:0] ram24_add_c2,ram25_add_c2,ram26_add_c2,ram27_add_c2,ram28_add_c2,ram29_add_c2,ram30_add_c2,ram31_add_c2;
//IO
wire [`FFT_DATA_WIDTH-1:0] io2d_data_for_units;
wire io2d_clk  	;
wire io2d_reset	;
wire io2d_wr_cs	;
wire io2d_rd_cs	;
wire io2d_rd_en	;
wire io2d_wr_en	;
wire io2d_empty	;
wire io2d_full 	;
//unit_1DFFTs

//RAMs //DATAbuses being bidirectional have not been gated!!! (ref. transposer ops, fft ops, direct,do_transpose tristate control)
wire  ram00_clk,ram01_clk,ram02_clk,ram03_clk,ram04_clk,ram05_clk,ram06_clk,ram07_clk;
wire  ram08_clk,ram09_clk,ram10_clk,ram11_clk,ram12_clk,ram13_clk,ram14_clk,ram15_clk;
wire  ram16_clk,ram17_clk,ram18_clk,ram19_clk,ram20_clk,ram21_clk,ram22_clk,ram23_clk;
wire  ram24_clk,ram25_clk,ram26_clk,ram27_clk,ram28_clk,ram29_clk,ram30_clk,ram31_clk;

wire  ram00_cs_0,ram01_cs_0,ram02_cs_0,ram03_cs_0,ram04_cs_0,ram05_cs_0,ram06_cs_0,ram07_cs_0;
wire  ram08_cs_0,ram09_cs_0,ram10_cs_0,ram11_cs_0,ram12_cs_0,ram13_cs_0,ram14_cs_0,ram15_cs_0;
wire  ram16_cs_0,ram17_cs_0,ram18_cs_0,ram19_cs_0,ram20_cs_0,ram21_cs_0,ram22_cs_0,ram23_cs_0;
wire  ram24_cs_0,ram25_cs_0,ram26_cs_0,ram27_cs_0,ram28_cs_0,ram29_cs_0,ram30_cs_0,ram31_cs_0;

wire  ram00_we_0,ram01_we_0,ram02_we_0,ram03_we_0,ram04_we_0,ram05_we_0,ram06_we_0,ram07_we_0;
wire  ram08_we_0,ram09_we_0,ram10_we_0,ram11_we_0,ram12_we_0,ram13_we_0,ram14_we_0,ram15_we_0;
wire  ram16_we_0,ram17_we_0,ram18_we_0,ram19_we_0,ram20_we_0,ram21_we_0,ram22_we_0,ram23_we_0;
wire  ram24_we_0,ram25_we_0,ram26_we_0,ram27_we_0,ram28_we_0,ram29_we_0,ram30_we_0,ram31_we_0;

wire  ram00_oe_0,ram01_oe_0,ram02_oe_0,ram03_oe_0,ram04_oe_0,ram05_oe_0,ram06_oe_0,ram07_oe_0;
wire  ram08_oe_0,ram09_oe_0,ram10_oe_0,ram11_oe_0,ram12_oe_0,ram13_oe_0,ram14_oe_0,ram15_oe_0;
wire  ram16_oe_0,ram17_oe_0,ram18_oe_0,ram19_oe_0,ram20_oe_0,ram21_oe_0,ram22_oe_0,ram23_oe_0;
wire  ram24_oe_0,ram25_oe_0,ram26_oe_0,ram27_oe_0,ram28_oe_0,ram29_oe_0,ram30_oe_0,ram31_oe_0;

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

wire [`LOG_N+2-1:0] ram00port0_add_f,ram01port0_add_f,ram02port0_add_f,ram03port0_add_f,ram04port0_add_f,ram05port0_add_f,ram06port0_add_f,ram07port0_add_f;
wire [`LOG_N+2-1:0] ram08port0_add_f,ram09port0_add_f,ram10port0_add_f,ram11port0_add_f,ram12port0_add_f,ram13port0_add_f,ram14port0_add_f,ram15port0_add_f;
wire [`LOG_N+2-1:0] ram16port0_add_f,ram17port0_add_f,ram18port0_add_f,ram19port0_add_f,ram20port0_add_f,ram21port0_add_f,ram22port0_add_f,ram23port0_add_f;
wire [`LOG_N+2-1:0] ram24port0_add_f,ram25port0_add_f,ram26port0_add_f,ram27port0_add_f,ram28port0_add_f,ram29port0_add_f,ram30port0_add_f,ram31port0_add_f;

wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram00port0_add,ram01port0_add,ram02port0_add,ram03port0_add,ram04port0_add,ram05port0_add,ram06port0_add,ram07port0_add;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram08port0_add,ram09port0_add,ram10port0_add,ram11port0_add,ram12port0_add,ram13port0_add,ram14port0_add,ram15port0_add;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram16port0_add,ram17port0_add,ram18port0_add,ram19port0_add,ram20port0_add,ram21port0_add,ram22port0_add,ram23port0_add;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram24port0_add,ram25port0_add,ram26port0_add,ram27port0_add,ram28port0_add,ram29port0_add,ram30port0_add,ram31port0_add;

wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram00port0_add_direct,ram01port0_add_direct,ram02port0_add_direct,ram03port0_add_direct,ram04port0_add_direct,ram05port0_add_direct,ram06port0_add_direct,ram07port0_add_direct;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram08port0_add_direct,ram09port0_add_direct,ram10port0_add_direct,ram11port0_add_direct,ram12port0_add_direct,ram13port0_add_direct,ram14port0_add_direct,ram15port0_add_direct;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram16port0_add_direct,ram17port0_add_direct,ram18port0_add_direct,ram19port0_add_direct,ram20port0_add_direct,ram21port0_add_direct,ram22port0_add_direct,ram23port0_add_direct;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram24port0_add_direct,ram25port0_add_direct,ram26port0_add_direct,ram27port0_add_direct,ram28port0_add_direct,ram29port0_add_direct,ram30port0_add_direct,ram31port0_add_direct;

wire [`FFT_DATA_WIDTH-1:0] ram00port0_bus,ram01port0_bus,ram02port0_bus,ram03port0_bus,ram04port0_bus,ram05port0_bus,ram06port0_bus,ram07port0_bus;
wire [`FFT_DATA_WIDTH-1:0] ram08port0_bus,ram09port0_bus,ram10port0_bus,ram11port0_bus,ram12port0_bus,ram13port0_bus,ram14port0_bus,ram15port0_bus;
wire [`FFT_DATA_WIDTH-1:0] ram16port0_bus,ram17port0_bus,ram18port0_bus,ram19port0_bus,ram20port0_bus,ram21port0_bus,ram22port0_bus,ram23port0_bus;
wire [`FFT_DATA_WIDTH-1:0] ram24port0_bus,ram25port0_bus,ram26port0_bus,ram27port0_bus,ram28port0_bus,ram29port0_bus,ram30port0_bus,ram31port0_bus;

wire  ram00_cs_1,ram01_cs_1,ram02_cs_1,ram03_cs_1,ram04_cs_1,ram05_cs_1,ram06_cs_1,ram07_cs_1;
wire  ram08_cs_1,ram09_cs_1,ram10_cs_1,ram11_cs_1,ram12_cs_1,ram13_cs_1,ram14_cs_1,ram15_cs_1;
wire  ram16_cs_1,ram17_cs_1,ram18_cs_1,ram19_cs_1,ram20_cs_1,ram21_cs_1,ram22_cs_1,ram23_cs_1;
wire  ram24_cs_1,ram25_cs_1,ram26_cs_1,ram27_cs_1,ram28_cs_1,ram29_cs_1,ram30_cs_1,ram31_cs_1;

wire  ram00_we_1,ram01_we_1,ram02_we_1,ram03_we_1,ram04_we_1,ram05_we_1,ram06_we_1,ram07_we_1;
wire  ram08_we_1,ram09_we_1,ram10_we_1,ram11_we_1,ram12_we_1,ram13_we_1,ram14_we_1,ram15_we_1;
wire  ram16_we_1,ram17_we_1,ram18_we_1,ram19_we_1,ram20_we_1,ram21_we_1,ram22_we_1,ram23_we_1;
wire  ram24_we_1,ram25_we_1,ram26_we_1,ram27_we_1,ram28_we_1,ram29_we_1,ram30_we_1,ram31_we_1;

wire  ram00_oe_1,ram01_oe_1,ram02_oe_1,ram03_oe_1,ram04_oe_1,ram05_oe_1,ram06_oe_1,ram07_oe_1;
wire  ram08_oe_1,ram09_oe_1,ram10_oe_1,ram11_oe_1,ram12_oe_1,ram13_oe_1,ram14_oe_1,ram15_oe_1;
wire  ram16_oe_1,ram17_oe_1,ram18_oe_1,ram19_oe_1,ram20_oe_1,ram21_oe_1,ram22_oe_1,ram23_oe_1;
wire  ram24_oe_1,ram25_oe_1,ram26_oe_1,ram27_oe_1,ram28_oe_1,ram29_oe_1,ram30_oe_1,ram31_oe_1;

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


wire [`LOG_N+2-1:0] ram00port1_add_f,ram01port1_add_f,ram02port1_add_f,ram03port1_add_f,ram04port1_add_f,ram05port1_add_f,ram06port1_add_f,ram07port1_add_f;
wire [`LOG_N+2-1:0] ram08port1_add_f,ram09port1_add_f,ram10port1_add_f,ram11port1_add_f,ram12port1_add_f,ram13port1_add_f,ram14port1_add_f,ram15port1_add_f;
wire [`LOG_N+2-1:0] ram16port1_add_f,ram17port1_add_f,ram18port1_add_f,ram19port1_add_f,ram20port1_add_f,ram21port1_add_f,ram22port1_add_f,ram23port1_add_f;
wire [`LOG_N+2-1:0] ram24port1_add_f,ram25port1_add_f,ram26port1_add_f,ram27port1_add_f,ram28port1_add_f,ram29port1_add_f,ram30port1_add_f,ram31port1_add_f;

wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram00port1_add,ram01port1_add,ram02port1_add,ram03port1_add,ram04port1_add,ram05port1_add,ram06port1_add,ram07port1_add;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram08port1_add,ram09port1_add,ram10port1_add,ram11port1_add,ram12port1_add,ram13port1_add,ram14port1_add,ram15port1_add;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram16port1_add,ram17port1_add,ram18port1_add,ram19port1_add,ram20port1_add,ram21port1_add,ram22port1_add,ram23port1_add;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram24port1_add,ram25port1_add,ram26port1_add,ram27port1_add,ram28port1_add,ram29port1_add,ram30port1_add,ram31port1_add;

wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram00port1_add_direct,ram01port1_add_direct,ram02port1_add_direct,ram03port1_add_direct,ram04port1_add_direct,ram05port1_add_direct,ram06port1_add_direct,ram07port1_add_direct;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram08port1_add_direct,ram09port1_add_direct,ram10port1_add_direct,ram11port1_add_direct,ram12port1_add_direct,ram13port1_add_direct,ram14port1_add_direct,ram15port1_add_direct;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram16port1_add_direct,ram17port1_add_direct,ram18port1_add_direct,ram19port1_add_direct,ram20port1_add_direct,ram21port1_add_direct,ram22port1_add_direct,ram23port1_add_direct;
wire [`LOG_N+2+`FFT2D_C_RAM_ADD_BITS-1:0] ram24port1_add_direct,ram25port1_add_direct,ram26port1_add_direct,ram27port1_add_direct,ram28port1_add_direct,ram29port1_add_direct,ram30port1_add_direct,ram31port1_add_direct;


wire [`FFT_DATA_WIDTH-1:0] ram00port1_bus,ram01port1_bus,ram02port1_bus,ram03port1_bus,ram04port1_bus,ram05port1_bus,ram06port1_bus,ram07port1_bus;
wire [`FFT_DATA_WIDTH-1:0] ram08port1_bus,ram09port1_bus,ram10port1_bus,ram11port1_bus,ram12port1_bus,ram13port1_bus,ram14port1_bus,ram15port1_bus;
wire [`FFT_DATA_WIDTH-1:0] ram16port1_bus,ram17port1_bus,ram18port1_bus,ram19port1_bus,ram20port1_bus,ram21port1_bus,ram22port1_bus,ram23port1_bus;
wire [`FFT_DATA_WIDTH-1:0] ram24port1_bus,ram25port1_bus,ram26port1_bus,ram27port1_bus,ram28port1_bus,ram29port1_bus,ram30port1_bus,ram31port1_bus;

//ROM
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


//Transposer
wire transposer_clk	;
wire transposer_reset	;
wire do_transpose	;
wire do_bitreversing	;
wire done_transpose	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram00_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram00_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram00_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram00_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram00_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram00_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram01_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram01_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram01_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram01_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram01_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram01_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram02_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram02_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram02_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram02_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram02_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram02_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram03_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram03_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram03_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram03_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram03_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram03_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram04_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram04_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram04_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram04_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram04_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram04_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram05_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram05_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram05_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram05_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram05_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram05_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram06_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram06_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram06_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram06_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram06_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram06_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram07_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram07_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram07_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram07_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram07_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram07_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram08_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram08_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram08_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram08_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram08_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram08_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram09_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram09_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram09_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram09_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram09_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram09_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram10_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram10_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram10_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram10_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram10_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram10_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram11_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram11_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram11_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram11_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram11_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram11_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram12_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram12_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram12_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram12_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram12_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram12_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram13_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram13_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram13_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram13_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram13_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram13_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram14_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram14_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram14_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram14_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram14_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram14_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram15_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram15_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram15_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram15_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram15_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram15_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram16_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram16_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram16_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram16_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram16_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram16_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram17_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram17_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram17_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram17_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram17_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram17_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram18_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram18_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram18_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram18_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram18_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram18_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram19_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram19_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram19_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram19_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram19_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram19_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram20_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram20_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram20_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram20_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram20_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram20_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram21_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram21_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram21_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram21_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram21_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram21_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram22_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram22_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram22_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram22_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram22_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram22_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram23_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram23_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram23_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram23_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram23_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram23_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram24_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram24_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram24_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram24_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram24_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram24_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram25_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram25_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram25_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram25_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram25_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram25_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram26_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram26_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram26_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram26_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram26_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram26_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram27_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram27_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram27_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram27_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram27_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram27_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram28_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram28_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram28_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram28_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram28_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram28_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram29_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram29_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram29_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram29_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram29_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram29_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram30_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram30_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram30_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram30_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram30_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram30_cs_we_oe_1	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram31_port0_add;
//wire [`FFT_DATA_WIDTH-1:0]ram31_port0_bus	;
wire [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0]tr_ram31_port1_add;
//wire [`FFT_DATA_WIDTH-1:0]ram31_port1_bus	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram31_cs_we_oe_0	;
wire [`RAM_COMMAND_WIDTH-1:0]tr_ram31_cs_we_oe_1	;



//----------------------Assignments---------------

assign ram00port0_add = (do_transpose==1'b1)?tr_ram00_port0_add:ram00port0_add_direct;
assign ram01port0_add = (do_transpose==1'b1)?tr_ram01_port0_add:ram01port0_add_direct;
assign ram02port0_add = (do_transpose==1'b1)?tr_ram02_port0_add:ram02port0_add_direct;
assign ram03port0_add = (do_transpose==1'b1)?tr_ram03_port0_add:ram03port0_add_direct;
assign ram04port0_add = (do_transpose==1'b1)?tr_ram04_port0_add:ram04port0_add_direct;
assign ram05port0_add = (do_transpose==1'b1)?tr_ram05_port0_add:ram05port0_add_direct;
assign ram06port0_add = (do_transpose==1'b1)?tr_ram06_port0_add:ram06port0_add_direct;
assign ram07port0_add = (do_transpose==1'b1)?tr_ram07_port0_add:ram07port0_add_direct;
assign ram08port0_add = (do_transpose==1'b1)?tr_ram08_port0_add:ram08port0_add_direct;
assign ram09port0_add = (do_transpose==1'b1)?tr_ram09_port0_add:ram09port0_add_direct;
assign ram10port0_add = (do_transpose==1'b1)?tr_ram10_port0_add:ram10port0_add_direct;
assign ram11port0_add = (do_transpose==1'b1)?tr_ram11_port0_add:ram11port0_add_direct;
assign ram12port0_add = (do_transpose==1'b1)?tr_ram12_port0_add:ram12port0_add_direct;
assign ram13port0_add = (do_transpose==1'b1)?tr_ram13_port0_add:ram13port0_add_direct;
assign ram14port0_add = (do_transpose==1'b1)?tr_ram14_port0_add:ram14port0_add_direct;
assign ram15port0_add = (do_transpose==1'b1)?tr_ram15_port0_add:ram15port0_add_direct;
assign ram16port0_add = (do_transpose==1'b1)?tr_ram16_port0_add:ram16port0_add_direct;
assign ram17port0_add = (do_transpose==1'b1)?tr_ram17_port0_add:ram17port0_add_direct;
assign ram18port0_add = (do_transpose==1'b1)?tr_ram18_port0_add:ram18port0_add_direct;
assign ram19port0_add = (do_transpose==1'b1)?tr_ram19_port0_add:ram19port0_add_direct;
assign ram20port0_add = (do_transpose==1'b1)?tr_ram20_port0_add:ram20port0_add_direct;
assign ram21port0_add = (do_transpose==1'b1)?tr_ram21_port0_add:ram21port0_add_direct;
assign ram22port0_add = (do_transpose==1'b1)?tr_ram22_port0_add:ram22port0_add_direct;
assign ram23port0_add = (do_transpose==1'b1)?tr_ram23_port0_add:ram23port0_add_direct;
assign ram24port0_add = (do_transpose==1'b1)?tr_ram24_port0_add:ram24port0_add_direct;
assign ram25port0_add = (do_transpose==1'b1)?tr_ram25_port0_add:ram25port0_add_direct;
assign ram26port0_add = (do_transpose==1'b1)?tr_ram26_port0_add:ram26port0_add_direct;
assign ram27port0_add = (do_transpose==1'b1)?tr_ram27_port0_add:ram27port0_add_direct;
assign ram28port0_add = (do_transpose==1'b1)?tr_ram28_port0_add:ram28port0_add_direct;
assign ram29port0_add = (do_transpose==1'b1)?tr_ram29_port0_add:ram29port0_add_direct;
assign ram30port0_add = (do_transpose==1'b1)?tr_ram30_port0_add:ram30port0_add_direct;
assign ram31port0_add = (do_transpose==1'b1)?tr_ram31_port0_add:ram31port0_add_direct;

assign ram00port1_add = (do_transpose==1'b1)?tr_ram00_port1_add:ram00port1_add_direct;
assign ram01port1_add = (do_transpose==1'b1)?tr_ram01_port1_add:ram01port1_add_direct;
assign ram02port1_add = (do_transpose==1'b1)?tr_ram02_port1_add:ram02port1_add_direct;
assign ram03port1_add = (do_transpose==1'b1)?tr_ram03_port1_add:ram03port1_add_direct;
assign ram04port1_add = (do_transpose==1'b1)?tr_ram04_port1_add:ram04port1_add_direct;
assign ram05port1_add = (do_transpose==1'b1)?tr_ram05_port1_add:ram05port1_add_direct;
assign ram06port1_add = (do_transpose==1'b1)?tr_ram06_port1_add:ram06port1_add_direct;
assign ram07port1_add = (do_transpose==1'b1)?tr_ram07_port1_add:ram07port1_add_direct;
assign ram08port1_add = (do_transpose==1'b1)?tr_ram08_port1_add:ram08port1_add_direct;
assign ram09port1_add = (do_transpose==1'b1)?tr_ram09_port1_add:ram09port1_add_direct;
assign ram10port1_add = (do_transpose==1'b1)?tr_ram10_port1_add:ram10port1_add_direct;
assign ram11port1_add = (do_transpose==1'b1)?tr_ram11_port1_add:ram11port1_add_direct;
assign ram12port1_add = (do_transpose==1'b1)?tr_ram12_port1_add:ram12port1_add_direct;
assign ram13port1_add = (do_transpose==1'b1)?tr_ram13_port1_add:ram13port1_add_direct;
assign ram14port1_add = (do_transpose==1'b1)?tr_ram14_port1_add:ram14port1_add_direct;
assign ram15port1_add = (do_transpose==1'b1)?tr_ram15_port1_add:ram15port1_add_direct;
assign ram16port1_add = (do_transpose==1'b1)?tr_ram16_port1_add:ram16port1_add_direct;
assign ram17port1_add = (do_transpose==1'b1)?tr_ram17_port1_add:ram17port1_add_direct;
assign ram18port1_add = (do_transpose==1'b1)?tr_ram18_port1_add:ram18port1_add_direct;
assign ram19port1_add = (do_transpose==1'b1)?tr_ram19_port1_add:ram19port1_add_direct;
assign ram20port1_add = (do_transpose==1'b1)?tr_ram20_port1_add:ram20port1_add_direct;
assign ram21port1_add = (do_transpose==1'b1)?tr_ram21_port1_add:ram21port1_add_direct;
assign ram22port1_add = (do_transpose==1'b1)?tr_ram22_port1_add:ram22port1_add_direct;
assign ram23port1_add = (do_transpose==1'b1)?tr_ram23_port1_add:ram23port1_add_direct;
assign ram24port1_add = (do_transpose==1'b1)?tr_ram24_port1_add:ram24port1_add_direct;
assign ram25port1_add = (do_transpose==1'b1)?tr_ram25_port1_add:ram25port1_add_direct;
assign ram26port1_add = (do_transpose==1'b1)?tr_ram26_port1_add:ram26port1_add_direct;
assign ram27port1_add = (do_transpose==1'b1)?tr_ram27_port1_add:ram27port1_add_direct;
assign ram28port1_add = (do_transpose==1'b1)?tr_ram28_port1_add:ram28port1_add_direct;
assign ram29port1_add = (do_transpose==1'b1)?tr_ram29_port1_add:ram29port1_add_direct;
assign ram30port1_add = (do_transpose==1'b1)?tr_ram30_port1_add:ram30port1_add_direct;
assign ram31port1_add = (do_transpose==1'b1)?tr_ram31_port1_add:ram31port1_add_direct;

assign {ram00_cs_0,ram00_we_0,ram00_oe_0}=(do_transpose==1'b1)?tr_ram00_cs_we_oe_0:{ram00_cs_0_direct,ram00_we_0_direct,ram00_oe_0_direct};
assign {ram01_cs_0,ram01_we_0,ram01_oe_0}=(do_transpose==1'b1)?tr_ram01_cs_we_oe_0:{ram01_cs_0_direct,ram01_we_0_direct,ram01_oe_0_direct};
assign {ram02_cs_0,ram02_we_0,ram02_oe_0}=(do_transpose==1'b1)?tr_ram02_cs_we_oe_0:{ram02_cs_0_direct,ram02_we_0_direct,ram02_oe_0_direct};
assign {ram03_cs_0,ram03_we_0,ram03_oe_0}=(do_transpose==1'b1)?tr_ram03_cs_we_oe_0:{ram03_cs_0_direct,ram03_we_0_direct,ram03_oe_0_direct};
assign {ram04_cs_0,ram04_we_0,ram04_oe_0}=(do_transpose==1'b1)?tr_ram04_cs_we_oe_0:{ram04_cs_0_direct,ram04_we_0_direct,ram04_oe_0_direct};
assign {ram05_cs_0,ram05_we_0,ram05_oe_0}=(do_transpose==1'b1)?tr_ram05_cs_we_oe_0:{ram05_cs_0_direct,ram05_we_0_direct,ram05_oe_0_direct};
assign {ram06_cs_0,ram06_we_0,ram06_oe_0}=(do_transpose==1'b1)?tr_ram06_cs_we_oe_0:{ram06_cs_0_direct,ram06_we_0_direct,ram06_oe_0_direct};
assign {ram07_cs_0,ram07_we_0,ram07_oe_0}=(do_transpose==1'b1)?tr_ram07_cs_we_oe_0:{ram07_cs_0_direct,ram07_we_0_direct,ram07_oe_0_direct};
assign {ram08_cs_0,ram08_we_0,ram08_oe_0}=(do_transpose==1'b1)?tr_ram08_cs_we_oe_0:{ram08_cs_0_direct,ram08_we_0_direct,ram08_oe_0_direct};
assign {ram09_cs_0,ram09_we_0,ram09_oe_0}=(do_transpose==1'b1)?tr_ram09_cs_we_oe_0:{ram09_cs_0_direct,ram09_we_0_direct,ram09_oe_0_direct};
assign {ram10_cs_0,ram10_we_0,ram10_oe_0}=(do_transpose==1'b1)?tr_ram10_cs_we_oe_0:{ram10_cs_0_direct,ram10_we_0_direct,ram10_oe_0_direct};
assign {ram11_cs_0,ram11_we_0,ram11_oe_0}=(do_transpose==1'b1)?tr_ram11_cs_we_oe_0:{ram11_cs_0_direct,ram11_we_0_direct,ram11_oe_0_direct};
assign {ram12_cs_0,ram12_we_0,ram12_oe_0}=(do_transpose==1'b1)?tr_ram12_cs_we_oe_0:{ram12_cs_0_direct,ram12_we_0_direct,ram12_oe_0_direct};
assign {ram13_cs_0,ram13_we_0,ram13_oe_0}=(do_transpose==1'b1)?tr_ram13_cs_we_oe_0:{ram13_cs_0_direct,ram13_we_0_direct,ram13_oe_0_direct};
assign {ram14_cs_0,ram14_we_0,ram14_oe_0}=(do_transpose==1'b1)?tr_ram14_cs_we_oe_0:{ram14_cs_0_direct,ram14_we_0_direct,ram14_oe_0_direct};
assign {ram15_cs_0,ram15_we_0,ram15_oe_0}=(do_transpose==1'b1)?tr_ram15_cs_we_oe_0:{ram15_cs_0_direct,ram15_we_0_direct,ram15_oe_0_direct};
assign {ram16_cs_0,ram16_we_0,ram16_oe_0}=(do_transpose==1'b1)?tr_ram16_cs_we_oe_0:{ram16_cs_0_direct,ram16_we_0_direct,ram16_oe_0_direct};
assign {ram17_cs_0,ram17_we_0,ram17_oe_0}=(do_transpose==1'b1)?tr_ram17_cs_we_oe_0:{ram17_cs_0_direct,ram17_we_0_direct,ram17_oe_0_direct};
assign {ram18_cs_0,ram18_we_0,ram18_oe_0}=(do_transpose==1'b1)?tr_ram18_cs_we_oe_0:{ram18_cs_0_direct,ram18_we_0_direct,ram18_oe_0_direct};
assign {ram19_cs_0,ram19_we_0,ram19_oe_0}=(do_transpose==1'b1)?tr_ram19_cs_we_oe_0:{ram19_cs_0_direct,ram19_we_0_direct,ram19_oe_0_direct};
assign {ram20_cs_0,ram20_we_0,ram20_oe_0}=(do_transpose==1'b1)?tr_ram20_cs_we_oe_0:{ram20_cs_0_direct,ram20_we_0_direct,ram20_oe_0_direct};
assign {ram21_cs_0,ram21_we_0,ram21_oe_0}=(do_transpose==1'b1)?tr_ram21_cs_we_oe_0:{ram21_cs_0_direct,ram21_we_0_direct,ram21_oe_0_direct};
assign {ram22_cs_0,ram22_we_0,ram22_oe_0}=(do_transpose==1'b1)?tr_ram22_cs_we_oe_0:{ram22_cs_0_direct,ram22_we_0_direct,ram22_oe_0_direct};
assign {ram23_cs_0,ram23_we_0,ram23_oe_0}=(do_transpose==1'b1)?tr_ram23_cs_we_oe_0:{ram23_cs_0_direct,ram23_we_0_direct,ram23_oe_0_direct};
assign {ram24_cs_0,ram24_we_0,ram24_oe_0}=(do_transpose==1'b1)?tr_ram24_cs_we_oe_0:{ram24_cs_0_direct,ram24_we_0_direct,ram24_oe_0_direct};
assign {ram25_cs_0,ram25_we_0,ram25_oe_0}=(do_transpose==1'b1)?tr_ram25_cs_we_oe_0:{ram25_cs_0_direct,ram25_we_0_direct,ram25_oe_0_direct};
assign {ram26_cs_0,ram26_we_0,ram26_oe_0}=(do_transpose==1'b1)?tr_ram26_cs_we_oe_0:{ram26_cs_0_direct,ram26_we_0_direct,ram26_oe_0_direct};
assign {ram27_cs_0,ram27_we_0,ram27_oe_0}=(do_transpose==1'b1)?tr_ram27_cs_we_oe_0:{ram27_cs_0_direct,ram27_we_0_direct,ram27_oe_0_direct};
assign {ram28_cs_0,ram28_we_0,ram28_oe_0}=(do_transpose==1'b1)?tr_ram28_cs_we_oe_0:{ram28_cs_0_direct,ram28_we_0_direct,ram28_oe_0_direct};
assign {ram29_cs_0,ram29_we_0,ram29_oe_0}=(do_transpose==1'b1)?tr_ram29_cs_we_oe_0:{ram29_cs_0_direct,ram29_we_0_direct,ram29_oe_0_direct};
assign {ram30_cs_0,ram30_we_0,ram30_oe_0}=(do_transpose==1'b1)?tr_ram30_cs_we_oe_0:{ram30_cs_0_direct,ram30_we_0_direct,ram30_oe_0_direct};
assign {ram31_cs_0,ram31_we_0,ram31_oe_0}=(do_transpose==1'b1)?tr_ram31_cs_we_oe_0:{ram31_cs_0_direct,ram31_we_0_direct,ram31_oe_0_direct};

assign {ram00_cs_1,ram00_we_1,ram00_oe_1}=(do_transpose==1'b1)?tr_ram00_cs_we_oe_1:{ram00_cs_1_direct,ram00_we_1_direct,ram00_oe_1_direct};
assign {ram01_cs_1,ram01_we_1,ram01_oe_1}=(do_transpose==1'b1)?tr_ram01_cs_we_oe_1:{ram01_cs_1_direct,ram01_we_1_direct,ram01_oe_1_direct};
assign {ram02_cs_1,ram02_we_1,ram02_oe_1}=(do_transpose==1'b1)?tr_ram02_cs_we_oe_1:{ram02_cs_1_direct,ram02_we_1_direct,ram02_oe_1_direct};
assign {ram03_cs_1,ram03_we_1,ram03_oe_1}=(do_transpose==1'b1)?tr_ram03_cs_we_oe_1:{ram03_cs_1_direct,ram03_we_1_direct,ram03_oe_1_direct};
assign {ram04_cs_1,ram04_we_1,ram04_oe_1}=(do_transpose==1'b1)?tr_ram04_cs_we_oe_1:{ram04_cs_1_direct,ram04_we_1_direct,ram04_oe_1_direct};
assign {ram05_cs_1,ram05_we_1,ram05_oe_1}=(do_transpose==1'b1)?tr_ram05_cs_we_oe_1:{ram05_cs_1_direct,ram05_we_1_direct,ram05_oe_1_direct};
assign {ram06_cs_1,ram06_we_1,ram06_oe_1}=(do_transpose==1'b1)?tr_ram06_cs_we_oe_1:{ram06_cs_1_direct,ram06_we_1_direct,ram06_oe_1_direct};
assign {ram07_cs_1,ram07_we_1,ram07_oe_1}=(do_transpose==1'b1)?tr_ram07_cs_we_oe_1:{ram07_cs_1_direct,ram07_we_1_direct,ram07_oe_1_direct};
assign {ram08_cs_1,ram08_we_1,ram08_oe_1}=(do_transpose==1'b1)?tr_ram08_cs_we_oe_1:{ram08_cs_1_direct,ram08_we_1_direct,ram08_oe_1_direct};
assign {ram09_cs_1,ram09_we_1,ram09_oe_1}=(do_transpose==1'b1)?tr_ram09_cs_we_oe_1:{ram09_cs_1_direct,ram09_we_1_direct,ram09_oe_1_direct};
assign {ram10_cs_1,ram10_we_1,ram10_oe_1}=(do_transpose==1'b1)?tr_ram10_cs_we_oe_1:{ram10_cs_1_direct,ram10_we_1_direct,ram10_oe_1_direct};
assign {ram11_cs_1,ram11_we_1,ram11_oe_1}=(do_transpose==1'b1)?tr_ram11_cs_we_oe_1:{ram11_cs_1_direct,ram11_we_1_direct,ram11_oe_1_direct};
assign {ram12_cs_1,ram12_we_1,ram12_oe_1}=(do_transpose==1'b1)?tr_ram12_cs_we_oe_1:{ram12_cs_1_direct,ram12_we_1_direct,ram12_oe_1_direct};
assign {ram13_cs_1,ram13_we_1,ram13_oe_1}=(do_transpose==1'b1)?tr_ram13_cs_we_oe_1:{ram13_cs_1_direct,ram13_we_1_direct,ram13_oe_1_direct};
assign {ram14_cs_1,ram14_we_1,ram14_oe_1}=(do_transpose==1'b1)?tr_ram14_cs_we_oe_1:{ram14_cs_1_direct,ram14_we_1_direct,ram14_oe_1_direct};
assign {ram15_cs_1,ram15_we_1,ram15_oe_1}=(do_transpose==1'b1)?tr_ram15_cs_we_oe_1:{ram15_cs_1_direct,ram15_we_1_direct,ram15_oe_1_direct};
assign {ram16_cs_1,ram16_we_1,ram16_oe_1}=(do_transpose==1'b1)?tr_ram16_cs_we_oe_1:{ram16_cs_1_direct,ram16_we_1_direct,ram16_oe_1_direct};
assign {ram17_cs_1,ram17_we_1,ram17_oe_1}=(do_transpose==1'b1)?tr_ram17_cs_we_oe_1:{ram17_cs_1_direct,ram17_we_1_direct,ram17_oe_1_direct};
assign {ram18_cs_1,ram18_we_1,ram18_oe_1}=(do_transpose==1'b1)?tr_ram18_cs_we_oe_1:{ram18_cs_1_direct,ram18_we_1_direct,ram18_oe_1_direct};
assign {ram19_cs_1,ram19_we_1,ram19_oe_1}=(do_transpose==1'b1)?tr_ram19_cs_we_oe_1:{ram19_cs_1_direct,ram19_we_1_direct,ram19_oe_1_direct};
assign {ram20_cs_1,ram20_we_1,ram20_oe_1}=(do_transpose==1'b1)?tr_ram20_cs_we_oe_1:{ram20_cs_1_direct,ram20_we_1_direct,ram20_oe_1_direct};
assign {ram21_cs_1,ram21_we_1,ram21_oe_1}=(do_transpose==1'b1)?tr_ram21_cs_we_oe_1:{ram21_cs_1_direct,ram21_we_1_direct,ram21_oe_1_direct};
assign {ram22_cs_1,ram22_we_1,ram22_oe_1}=(do_transpose==1'b1)?tr_ram22_cs_we_oe_1:{ram22_cs_1_direct,ram22_we_1_direct,ram22_oe_1_direct};
assign {ram23_cs_1,ram23_we_1,ram23_oe_1}=(do_transpose==1'b1)?tr_ram23_cs_we_oe_1:{ram23_cs_1_direct,ram23_we_1_direct,ram23_oe_1_direct};
assign {ram24_cs_1,ram24_we_1,ram24_oe_1}=(do_transpose==1'b1)?tr_ram24_cs_we_oe_1:{ram24_cs_1_direct,ram24_we_1_direct,ram24_oe_1_direct};
assign {ram25_cs_1,ram25_we_1,ram25_oe_1}=(do_transpose==1'b1)?tr_ram25_cs_we_oe_1:{ram25_cs_1_direct,ram25_we_1_direct,ram25_oe_1_direct};
assign {ram26_cs_1,ram26_we_1,ram26_oe_1}=(do_transpose==1'b1)?tr_ram26_cs_we_oe_1:{ram26_cs_1_direct,ram26_we_1_direct,ram26_oe_1_direct};
assign {ram27_cs_1,ram27_we_1,ram27_oe_1}=(do_transpose==1'b1)?tr_ram27_cs_we_oe_1:{ram27_cs_1_direct,ram27_we_1_direct,ram27_oe_1_direct};
assign {ram28_cs_1,ram28_we_1,ram28_oe_1}=(do_transpose==1'b1)?tr_ram28_cs_we_oe_1:{ram28_cs_1_direct,ram28_we_1_direct,ram28_oe_1_direct};
assign {ram29_cs_1,ram29_we_1,ram29_oe_1}=(do_transpose==1'b1)?tr_ram29_cs_we_oe_1:{ram29_cs_1_direct,ram29_we_1_direct,ram29_oe_1_direct};
assign {ram30_cs_1,ram30_we_1,ram30_oe_1}=(do_transpose==1'b1)?tr_ram30_cs_we_oe_1:{ram30_cs_1_direct,ram30_we_1_direct,ram30_oe_1_direct};
assign {ram31_cs_1,ram31_we_1,ram31_oe_1}=(do_transpose==1'b1)?tr_ram31_cs_we_oe_1:{ram31_cs_1_direct,ram31_we_1_direct,ram31_oe_1_direct};

assign ram00port0_add_direct = {ram00port0_add_f[`LOG_N+2-1],ram00_add_c1,ram00port0_add_f[`LOG_N+2-2:0]};
assign ram01port0_add_direct = {ram01port0_add_f[`LOG_N+2-1],ram01_add_c1,ram01port0_add_f[`LOG_N+2-2:0]};
assign ram02port0_add_direct = {ram02port0_add_f[`LOG_N+2-1],ram02_add_c1,ram02port0_add_f[`LOG_N+2-2:0]};
assign ram03port0_add_direct = {ram03port0_add_f[`LOG_N+2-1],ram03_add_c1,ram03port0_add_f[`LOG_N+2-2:0]};
assign ram04port0_add_direct = {ram04port0_add_f[`LOG_N+2-1],ram04_add_c1,ram04port0_add_f[`LOG_N+2-2:0]};
assign ram05port0_add_direct = {ram05port0_add_f[`LOG_N+2-1],ram05_add_c1,ram05port0_add_f[`LOG_N+2-2:0]};
assign ram06port0_add_direct = {ram06port0_add_f[`LOG_N+2-1],ram06_add_c1,ram06port0_add_f[`LOG_N+2-2:0]};
assign ram07port0_add_direct = {ram07port0_add_f[`LOG_N+2-1],ram07_add_c1,ram07port0_add_f[`LOG_N+2-2:0]};
assign ram08port0_add_direct = {ram08port0_add_f[`LOG_N+2-1],ram08_add_c1,ram08port0_add_f[`LOG_N+2-2:0]};
assign ram09port0_add_direct = {ram09port0_add_f[`LOG_N+2-1],ram09_add_c1,ram09port0_add_f[`LOG_N+2-2:0]};
assign ram10port0_add_direct = {ram10port0_add_f[`LOG_N+2-1],ram10_add_c1,ram10port0_add_f[`LOG_N+2-2:0]};
assign ram11port0_add_direct = {ram11port0_add_f[`LOG_N+2-1],ram11_add_c1,ram11port0_add_f[`LOG_N+2-2:0]};
assign ram12port0_add_direct = {ram12port0_add_f[`LOG_N+2-1],ram12_add_c1,ram12port0_add_f[`LOG_N+2-2:0]};
assign ram13port0_add_direct = {ram13port0_add_f[`LOG_N+2-1],ram13_add_c1,ram13port0_add_f[`LOG_N+2-2:0]};
assign ram14port0_add_direct = {ram14port0_add_f[`LOG_N+2-1],ram14_add_c1,ram14port0_add_f[`LOG_N+2-2:0]};
assign ram15port0_add_direct = {ram15port0_add_f[`LOG_N+2-1],ram15_add_c1,ram15port0_add_f[`LOG_N+2-2:0]};
assign ram16port0_add_direct = {ram16port0_add_f[`LOG_N+2-1],ram16_add_c1,ram16port0_add_f[`LOG_N+2-2:0]};
assign ram17port0_add_direct = {ram17port0_add_f[`LOG_N+2-1],ram17_add_c1,ram17port0_add_f[`LOG_N+2-2:0]};
assign ram18port0_add_direct = {ram18port0_add_f[`LOG_N+2-1],ram18_add_c1,ram18port0_add_f[`LOG_N+2-2:0]};
assign ram19port0_add_direct = {ram19port0_add_f[`LOG_N+2-1],ram19_add_c1,ram19port0_add_f[`LOG_N+2-2:0]};
assign ram20port0_add_direct = {ram20port0_add_f[`LOG_N+2-1],ram20_add_c1,ram20port0_add_f[`LOG_N+2-2:0]};
assign ram21port0_add_direct = {ram21port0_add_f[`LOG_N+2-1],ram21_add_c1,ram21port0_add_f[`LOG_N+2-2:0]};
assign ram22port0_add_direct = {ram22port0_add_f[`LOG_N+2-1],ram22_add_c1,ram22port0_add_f[`LOG_N+2-2:0]};
assign ram23port0_add_direct = {ram23port0_add_f[`LOG_N+2-1],ram23_add_c1,ram23port0_add_f[`LOG_N+2-2:0]};
assign ram24port0_add_direct = {ram24port0_add_f[`LOG_N+2-1],ram24_add_c1,ram24port0_add_f[`LOG_N+2-2:0]};
assign ram25port0_add_direct = {ram25port0_add_f[`LOG_N+2-1],ram25_add_c1,ram25port0_add_f[`LOG_N+2-2:0]};
assign ram26port0_add_direct = {ram26port0_add_f[`LOG_N+2-1],ram26_add_c1,ram26port0_add_f[`LOG_N+2-2:0]};
assign ram27port0_add_direct = {ram27port0_add_f[`LOG_N+2-1],ram27_add_c1,ram27port0_add_f[`LOG_N+2-2:0]};
assign ram28port0_add_direct = {ram28port0_add_f[`LOG_N+2-1],ram28_add_c1,ram28port0_add_f[`LOG_N+2-2:0]};
assign ram29port0_add_direct = {ram29port0_add_f[`LOG_N+2-1],ram29_add_c1,ram29port0_add_f[`LOG_N+2-2:0]};
assign ram30port0_add_direct = {ram30port0_add_f[`LOG_N+2-1],ram30_add_c1,ram30port0_add_f[`LOG_N+2-2:0]};
assign ram31port0_add_direct = {ram31port0_add_f[`LOG_N+2-1],ram31_add_c1,ram31port0_add_f[`LOG_N+2-2:0]};

assign ram00_add_c1 = (ram00port0_add_f[`LOG_N+2-1]==1)?ram00_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram01_add_c1 = (ram01port0_add_f[`LOG_N+2-1]==1)?ram01_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram02_add_c1 = (ram02port0_add_f[`LOG_N+2-1]==1)?ram02_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram03_add_c1 = (ram03port0_add_f[`LOG_N+2-1]==1)?ram03_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram04_add_c1 = (ram04port0_add_f[`LOG_N+2-1]==1)?ram04_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram05_add_c1 = (ram05port0_add_f[`LOG_N+2-1]==1)?ram05_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram06_add_c1 = (ram06port0_add_f[`LOG_N+2-1]==1)?ram06_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram07_add_c1 = (ram07port0_add_f[`LOG_N+2-1]==1)?ram07_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram08_add_c1 = (ram08port0_add_f[`LOG_N+2-1]==1)?ram08_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram09_add_c1 = (ram09port0_add_f[`LOG_N+2-1]==1)?ram09_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram10_add_c1 = (ram10port0_add_f[`LOG_N+2-1]==1)?ram10_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram11_add_c1 = (ram11port0_add_f[`LOG_N+2-1]==1)?ram11_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram12_add_c1 = (ram12port0_add_f[`LOG_N+2-1]==1)?ram12_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram13_add_c1 = (ram13port0_add_f[`LOG_N+2-1]==1)?ram13_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram14_add_c1 = (ram14port0_add_f[`LOG_N+2-1]==1)?ram14_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram15_add_c1 = (ram15port0_add_f[`LOG_N+2-1]==1)?ram15_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram16_add_c1 = (ram16port0_add_f[`LOG_N+2-1]==1)?ram16_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram17_add_c1 = (ram17port0_add_f[`LOG_N+2-1]==1)?ram17_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram18_add_c1 = (ram18port0_add_f[`LOG_N+2-1]==1)?ram18_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram19_add_c1 = (ram19port0_add_f[`LOG_N+2-1]==1)?ram19_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram20_add_c1 = (ram20port0_add_f[`LOG_N+2-1]==1)?ram20_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram21_add_c1 = (ram21port0_add_f[`LOG_N+2-1]==1)?ram21_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram22_add_c1 = (ram22port0_add_f[`LOG_N+2-1]==1)?ram22_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram23_add_c1 = (ram23port0_add_f[`LOG_N+2-1]==1)?ram23_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram24_add_c1 = (ram24port0_add_f[`LOG_N+2-1]==1)?ram24_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram25_add_c1 = (ram25port0_add_f[`LOG_N+2-1]==1)?ram25_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram26_add_c1 = (ram26port0_add_f[`LOG_N+2-1]==1)?ram26_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram27_add_c1 = (ram27port0_add_f[`LOG_N+2-1]==1)?ram27_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram28_add_c1 = (ram28port0_add_f[`LOG_N+2-1]==1)?ram28_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram29_add_c1 = (ram29port0_add_f[`LOG_N+2-1]==1)?ram29_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram30_add_c1 = (ram30port0_add_f[`LOG_N+2-1]==1)?ram30_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram31_add_c1 = (ram31port0_add_f[`LOG_N+2-1]==1)?ram31_add_c:`FFT2D_C_RAM_ADD_BITS'b0;



assign ram00port1_add_direct = {ram00port1_add_f[`LOG_N+2-1],ram00_add_c2,ram00port1_add_f[`LOG_N+2-2:0]};
assign ram01port1_add_direct = {ram01port1_add_f[`LOG_N+2-1],ram01_add_c2,ram01port1_add_f[`LOG_N+2-2:0]};
assign ram02port1_add_direct = {ram02port1_add_f[`LOG_N+2-1],ram02_add_c2,ram02port1_add_f[`LOG_N+2-2:0]};
assign ram03port1_add_direct = {ram03port1_add_f[`LOG_N+2-1],ram03_add_c2,ram03port1_add_f[`LOG_N+2-2:0]};
assign ram04port1_add_direct = {ram04port1_add_f[`LOG_N+2-1],ram04_add_c2,ram04port1_add_f[`LOG_N+2-2:0]};
assign ram05port1_add_direct = {ram05port1_add_f[`LOG_N+2-1],ram05_add_c2,ram05port1_add_f[`LOG_N+2-2:0]};
assign ram06port1_add_direct = {ram06port1_add_f[`LOG_N+2-1],ram06_add_c2,ram06port1_add_f[`LOG_N+2-2:0]};
assign ram07port1_add_direct = {ram07port1_add_f[`LOG_N+2-1],ram07_add_c2,ram07port1_add_f[`LOG_N+2-2:0]};
assign ram08port1_add_direct = {ram08port1_add_f[`LOG_N+2-1],ram08_add_c2,ram08port1_add_f[`LOG_N+2-2:0]};
assign ram09port1_add_direct = {ram09port1_add_f[`LOG_N+2-1],ram09_add_c2,ram09port1_add_f[`LOG_N+2-2:0]};
assign ram10port1_add_direct = {ram10port1_add_f[`LOG_N+2-1],ram10_add_c2,ram10port1_add_f[`LOG_N+2-2:0]};
assign ram11port1_add_direct = {ram11port1_add_f[`LOG_N+2-1],ram11_add_c2,ram11port1_add_f[`LOG_N+2-2:0]};
assign ram12port1_add_direct = {ram12port1_add_f[`LOG_N+2-1],ram12_add_c2,ram12port1_add_f[`LOG_N+2-2:0]};
assign ram13port1_add_direct = {ram13port1_add_f[`LOG_N+2-1],ram13_add_c2,ram13port1_add_f[`LOG_N+2-2:0]};
assign ram14port1_add_direct = {ram14port1_add_f[`LOG_N+2-1],ram14_add_c2,ram14port1_add_f[`LOG_N+2-2:0]};
assign ram15port1_add_direct = {ram15port1_add_f[`LOG_N+2-1],ram15_add_c2,ram15port1_add_f[`LOG_N+2-2:0]};
assign ram16port1_add_direct = {ram16port1_add_f[`LOG_N+2-1],ram16_add_c2,ram16port1_add_f[`LOG_N+2-2:0]};
assign ram17port1_add_direct = {ram17port1_add_f[`LOG_N+2-1],ram17_add_c2,ram17port1_add_f[`LOG_N+2-2:0]};
assign ram18port1_add_direct = {ram18port1_add_f[`LOG_N+2-1],ram18_add_c2,ram18port1_add_f[`LOG_N+2-2:0]};
assign ram19port1_add_direct = {ram19port1_add_f[`LOG_N+2-1],ram19_add_c2,ram19port1_add_f[`LOG_N+2-2:0]};
assign ram20port1_add_direct = {ram20port1_add_f[`LOG_N+2-1],ram20_add_c2,ram20port1_add_f[`LOG_N+2-2:0]};
assign ram21port1_add_direct = {ram21port1_add_f[`LOG_N+2-1],ram21_add_c2,ram21port1_add_f[`LOG_N+2-2:0]};
assign ram22port1_add_direct = {ram22port1_add_f[`LOG_N+2-1],ram22_add_c2,ram22port1_add_f[`LOG_N+2-2:0]};
assign ram23port1_add_direct = {ram23port1_add_f[`LOG_N+2-1],ram23_add_c2,ram23port1_add_f[`LOG_N+2-2:0]};
assign ram24port1_add_direct = {ram24port1_add_f[`LOG_N+2-1],ram24_add_c2,ram24port1_add_f[`LOG_N+2-2:0]};
assign ram25port1_add_direct = {ram25port1_add_f[`LOG_N+2-1],ram25_add_c2,ram25port1_add_f[`LOG_N+2-2:0]};
assign ram26port1_add_direct = {ram26port1_add_f[`LOG_N+2-1],ram26_add_c2,ram26port1_add_f[`LOG_N+2-2:0]};
assign ram27port1_add_direct = {ram27port1_add_f[`LOG_N+2-1],ram27_add_c2,ram27port1_add_f[`LOG_N+2-2:0]};
assign ram28port1_add_direct = {ram28port1_add_f[`LOG_N+2-1],ram28_add_c2,ram28port1_add_f[`LOG_N+2-2:0]};
assign ram29port1_add_direct = {ram29port1_add_f[`LOG_N+2-1],ram29_add_c2,ram29port1_add_f[`LOG_N+2-2:0]};
assign ram30port1_add_direct = {ram30port1_add_f[`LOG_N+2-1],ram30_add_c2,ram30port1_add_f[`LOG_N+2-2:0]};
assign ram31port1_add_direct = {ram31port1_add_f[`LOG_N+2-1],ram31_add_c2,ram31port1_add_f[`LOG_N+2-2:0]};

assign ram00_add_c2 = (ram00port1_add_f[`LOG_N+2-1]==1)?ram00_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram01_add_c2 = (ram01port1_add_f[`LOG_N+2-1]==1)?ram01_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram02_add_c2 = (ram02port1_add_f[`LOG_N+2-1]==1)?ram02_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram03_add_c2 = (ram03port1_add_f[`LOG_N+2-1]==1)?ram03_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram04_add_c2 = (ram04port1_add_f[`LOG_N+2-1]==1)?ram04_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram05_add_c2 = (ram05port1_add_f[`LOG_N+2-1]==1)?ram05_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram06_add_c2 = (ram06port1_add_f[`LOG_N+2-1]==1)?ram06_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram07_add_c2 = (ram07port1_add_f[`LOG_N+2-1]==1)?ram07_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram08_add_c2 = (ram08port1_add_f[`LOG_N+2-1]==1)?ram08_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram09_add_c2 = (ram09port1_add_f[`LOG_N+2-1]==1)?ram09_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram10_add_c2 = (ram10port1_add_f[`LOG_N+2-1]==1)?ram10_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram11_add_c2 = (ram11port1_add_f[`LOG_N+2-1]==1)?ram11_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram12_add_c2 = (ram12port1_add_f[`LOG_N+2-1]==1)?ram12_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram13_add_c2 = (ram13port1_add_f[`LOG_N+2-1]==1)?ram13_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram14_add_c2 = (ram14port1_add_f[`LOG_N+2-1]==1)?ram14_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram15_add_c2 = (ram15port1_add_f[`LOG_N+2-1]==1)?ram15_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram16_add_c2 = (ram16port1_add_f[`LOG_N+2-1]==1)?ram16_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram17_add_c2 = (ram17port1_add_f[`LOG_N+2-1]==1)?ram17_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram18_add_c2 = (ram18port1_add_f[`LOG_N+2-1]==1)?ram18_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram19_add_c2 = (ram19port1_add_f[`LOG_N+2-1]==1)?ram19_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram20_add_c2 = (ram20port1_add_f[`LOG_N+2-1]==1)?ram20_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram21_add_c2 = (ram21port1_add_f[`LOG_N+2-1]==1)?ram21_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram22_add_c2 = (ram22port1_add_f[`LOG_N+2-1]==1)?ram22_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram23_add_c2 = (ram23port1_add_f[`LOG_N+2-1]==1)?ram23_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram24_add_c2 = (ram24port1_add_f[`LOG_N+2-1]==1)?ram24_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram25_add_c2 = (ram25port1_add_f[`LOG_N+2-1]==1)?ram25_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram26_add_c2 = (ram26port1_add_f[`LOG_N+2-1]==1)?ram26_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram27_add_c2 = (ram27port1_add_f[`LOG_N+2-1]==1)?ram27_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram28_add_c2 = (ram28port1_add_f[`LOG_N+2-1]==1)?ram28_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram29_add_c2 = (ram29port1_add_f[`LOG_N+2-1]==1)?ram29_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram30_add_c2 = (ram30port1_add_f[`LOG_N+2-1]==1)?ram30_add_c:`FFT2D_C_RAM_ADD_BITS'b0;
assign ram31_add_c2 = (ram31port1_add_f[`LOG_N+2-1]==1)?ram31_add_c:`FFT2D_C_RAM_ADD_BITS'b0;

//------------------Instantiations----------------

//FFT2D_Controller
FFT2D_Controller fft2d_c01(
i_fft2d_base_clock,
i_fft2d_reset	,
i_fft2d_start	,
i_read_rom_ram	,
o_busy	,
o_TIP	,
//unit_1DFFTX()
f_base_clock	,	
f00_command	,	
f00_status	,
f01_command	,	
f01_status	,
f02_command	,	
f02_status	,
f03_command	,	
f03_status	,
f04_command	,	
f04_status	,
f05_command	,	
f05_status	,
f06_command	,	
f06_status	,
f07_command	,	
f07_status	,
f08_command	,	
f08_status	,
f09_command	,	
f09_status	,
f10_command	,	
f10_status	,
f11_command	,	
f11_status	,
f12_command	,	
f12_status	,
f13_command	,	
f13_status	,
f14_command	,	
f14_status	,
f15_command	,	
f15_status	,
f16_command	,	
f16_status	,
f17_command	,	
f17_status	,
f18_command	,	
f18_status	,
f19_command	,	
f19_status	,
f20_command	,	
f20_status	,
f21_command	,	
f21_status	,
f22_command	,	
f22_status	,
f23_command	,	
f23_status	,
f24_command	,	
f24_status	,
f25_command	,	
f25_status	,
f26_command	,	
f26_status	,
f27_command	,	
f27_status	,
f28_command	,	
f28_status	,
f29_command	,	
f29_status	,
f30_command	,	
f30_status	,
f31_command	,	
f31_status	,		
//RAMXAddbits()
ram00_add_c		,
ram01_add_c		,
ram02_add_c		,
ram03_add_c		,
ram04_add_c		,
ram05_add_c		,
ram06_add_c		,
ram07_add_c		,
ram08_add_c		,
ram09_add_c		,
ram10_add_c		,
ram11_add_c		,
ram12_add_c		,
ram13_add_c		,
ram14_add_c		,
ram15_add_c		,
ram16_add_c		,
ram17_add_c		,
ram18_add_c		,
ram19_add_c		,
ram20_add_c		,
ram21_add_c		,
ram22_add_c		,
ram23_add_c		,
ram24_add_c		,
ram25_add_c		,
ram26_add_c		,
ram27_add_c		,
ram28_add_c		,
ram29_add_c		,
ram30_add_c		,
ram31_add_c		,
//IO
io2d_clk	      	,
io2d_reset		,
io2d_wr_cs	      	,
io2d_rd_cs	      	,
io2d_rd_en	      	,
io2d_wr_en	      	,
io2d_empty	      	,
io2d_full		,
//Transposer
transposer_clk		,
transposer_reset	,
do_transpose		,
do_bitreversing		,
done_transpose		
);

//unit_1DFFTs
unit_1DFFT f00(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f00_command	,	//Connection twixt unit-FFT2D_Controller
f00_status	,	//Connection twixt unit-FFT2D_controller
ram00_clk	,	//Connection twixt unit-RAM-TransposeControl
ram00port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram00port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram00_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram00_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram00_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram00port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram00port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram00_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram00_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram00_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom00_add	, 	//Connection twixt unit00-ROM only, others NC
rom_bus		, 	//Connection twixt unit-ROM
rom00_re 	, 	//Connection twixt unit00-ROM only, others NC
rom00_cs 	, 	//Connection twixt unit00-ROM only, others NC
rom00_tri	  	//Connection twixt unit00-ROM only, others NC
);

unit_1DFFT f01(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f01_command	,	//Connection twixt unit-FFT2D_Controller
f01_status	,	//Connection twixt unit-FFT2D_Controller
ram01_clk	,	//Connection twixt unit-RAM-TransposeControl
ram01port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram01port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram01_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram01_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram01_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram01port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram01port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram01_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram01_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram01_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom01_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom01_re 	, 	//NC
rom01_cs 	, 	//NC
rom01_tri	  	//NC
);

unit_1DFFT f02(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f02_command	,	//Connection twixt unit-FFT2D_Controller
f02_status	,	//Connection twixt unit-FFT2D_Controller
ram02_clk	,	//Connection twixt unit-RAM-TransposeControl
ram02port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram02port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram02_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram02_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram02_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram02port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram02port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram02_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram02_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram02_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom02_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom02_re 	, 	//NC
rom02_cs 	, 	//NC
rom02_tri	  	//NC
);

unit_1DFFT f03(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f03_command	,	//Connection twixt unit-FFT2D_Controller
f03_status	,	//Connection twixt unit-FFT2D_Controller
ram03_clk	,	//Connection twixt unit-RAM-TransposeControl
ram03port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram03port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram03_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram03_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram03_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram03port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram03port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram03_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram03_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram03_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom03_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom03_re 	, 	//NC
rom03_cs 	, 	//NC
rom03_tri	  	//NC
);


unit_1DFFT f04(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f04_command	,	//Connection twixt unit-FFT2D_Controller
f04_status	,	//Connection twixt unit-FFT2D_Controller
ram04_clk	,	//Connection twixt unit-RAM-TransposeControl
ram04port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram04port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram04_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram04_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram04_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram04port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram04port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram04_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram04_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram04_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom04_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom04_re 	, 	//NC
rom04_cs 	, 	//NC
rom04_tri	  	//NC
);


unit_1DFFT f05(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f05_command	,	//Connection twixt unit-FFT2D_Controller
f05_status	,	//Connection twixt unit-FFT2D_Controller
ram05_clk	,	//Connection twixt unit-RAM-TransposeControl
ram05port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram05port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram05_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram05_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram05_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram05port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram05port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram05_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram05_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram05_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom05_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom05_re 	, 	//NC
rom05_cs 	, 	//NC
rom05_tri	  	//NC
);


unit_1DFFT f06(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f06_command	,	//Connection twixt unit-FFT2D_Controller
f06_status	,	//Connection twixt unit-FFT2D_Controller
ram06_clk	,	//Connection twixt unit-RAM-TransposeControl
ram06port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram06port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram06_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram06_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram06_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram06port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram06port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram06_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram06_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram06_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom06_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom06_re 	, 	//NC
rom06_cs 	, 	//NC
rom06_tri	  	//NC
);


unit_1DFFT f07(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f07_command	,	//Connection twixt unit-FFT2D_Controller
f07_status	,	//Connection twixt unit-FFT2D_Controller
ram07_clk	,	//Connection twixt unit-RAM-TransposeControl
ram07port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram07port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram07_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram07_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram07_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram07port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram07port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram07_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram07_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram07_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom07_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom07_re 	, 	//NC
rom07_cs 	, 	//NC
rom07_tri	  	//NC
);


unit_1DFFT f08(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f08_command	,	//Connection twixt unit-FFT2D_Controller
f08_status	,	//Connection twixt unit-FFT2D_Controller
ram08_clk	,	//Connection twixt unit-RAM-TransposeControl
ram08port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram08port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram08_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram08_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram08_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram08port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram08port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram08_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram08_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram08_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom08_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom08_re 	, 	//NC
rom08_cs 	, 	//NC
rom08_tri	  	//NC
);


unit_1DFFT f09(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f09_command	,	//Connection twixt unit-FFT2D_Controller
f09_status	,	//Connection twixt unit-FFT2D_Controller
ram09_clk	,	//Connection twixt unit-RAM-TransposeControl
ram09port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram09port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram09_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram09_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram09_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram09port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram09port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram09_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram09_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram09_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom09_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom09_re 	, 	//NC
rom09_cs 	, 	//NC
rom09_tri	  	//NC
);


unit_1DFFT f10(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f10_command	,	//Connection twixt unit-FFT2D_Controller
f10_status	,	//Connection twixt unit-FFT2D_Controller
ram10_clk	,	//Connection twixt unit-RAM-TransposeControl
ram10port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram10port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram10_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram10_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram10_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram10port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram10port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram10_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram10_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram10_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom10_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom10_re 	, 	//NC
rom10_cs 	, 	//NC
rom10_tri	  	//NC
);


unit_1DFFT f11(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f11_command	,	//Connection twixt unit-FFT2D_Controller
f11_status	,	//Connection twixt unit-FFT2D_Controller
ram11_clk	,	//Connection twixt unit-RAM-TransposeControl
ram11port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram11port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram11_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram11_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram11_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram11port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram11port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram11_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram11_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram11_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom11_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom11_re 	, 	//NC
rom11_cs 	, 	//NC
rom11_tri	  	//NC
);


unit_1DFFT f12(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f12_command	,	//Connection twixt unit-FFT2D_Controller
f12_status	,	//Connection twixt unit-FFT2D_Controller
ram12_clk	,	//Connection twixt unit-RAM-TransposeControl
ram12port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram12port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram12_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram12_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram12_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram12port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram12port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram12_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram12_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram12_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom12_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom12_re 	, 	//NC
rom12_cs 	, 	//NC
rom12_tri	  	//NC
);


unit_1DFFT f13(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f13_command	,	//Connection twixt unit-FFT2D_Controller
f13_status	,	//Connection twixt unit-FFT2D_Controller
ram13_clk	,	//Connection twixt unit-RAM-TransposeControl
ram13port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram13port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram13_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram13_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram13_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram13port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram13port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram13_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram13_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram13_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom13_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom13_re 	, 	//NC
rom13_cs 	, 	//NC
rom13_tri	  	//NC
);


unit_1DFFT f14(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f14_command	,	//Connection twixt unit-FFT2D_Controller
f14_status	,	//Connection twixt unit-FFT2D_Controller
ram14_clk	,	//Connection twixt unit-RAM-TransposeControl
ram14port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram14port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram14_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram14_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram14_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram14port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram14port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram14_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram14_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram14_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom14_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom14_re 	, 	//NC
rom14_cs 	, 	//NC
rom14_tri	  	//NC
);


unit_1DFFT f15(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f15_command	,	//Connection twixt unit-FFT2D_Controller
f15_status	,	//Connection twixt unit-FFT2D_Controller
ram15_clk	,	//Connection twixt unit-RAM-TransposeControl
ram15port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram15port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram15_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram15_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram15_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram15port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram15port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram15_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram15_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram15_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom15_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom15_re 	, 	//NC
rom15_cs 	, 	//NC
rom15_tri	  	//NC
);


unit_1DFFT f16(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f16_command	,	//Connection twixt unit-FFT2D_Controller
f16_status	,	//Connection twixt unit-FFT2D_Controller
ram16_clk	,	//Connection twixt unit-RAM-TransposeControl
ram16port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram16port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram16_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram16_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram16_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram16port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram16port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram16_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram16_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram16_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom16_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom16_re 	, 	//NC
rom16_cs 	, 	//NC
rom16_tri	  	//NC
);


unit_1DFFT f17(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f17_command	,	//Connection twixt unit-FFT2D_Controller
f17_status	,	//Connection twixt unit-FFT2D_Controller
ram17_clk	,	//Connection twixt unit-RAM-TransposeControl
ram17port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram17port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram17_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram17_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram17_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram17port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram17port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram17_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram17_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram17_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom17_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom17_re 	, 	//NC
rom17_cs 	, 	//NC
rom17_tri	  	//NC
);


unit_1DFFT f18(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f18_command	,	//Connection twixt unit-FFT2D_Controller
f18_status	,	//Connection twixt unit-FFT2D_Controller
ram18_clk	,	//Connection twixt unit-RAM-TransposeControl
ram18port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram18port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram18_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram18_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram18_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram18port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram18port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram18_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram18_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram18_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom18_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom18_re 	, 	//NC
rom18_cs 	, 	//NC
rom18_tri	  	//NC
);


unit_1DFFT f19(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f19_command	,	//Connection twixt unit-FFT2D_Controller
f19_status	,	//Connection twixt unit-FFT2D_Controller
ram19_clk	,	//Connection twixt unit-RAM-TransposeControl
ram19port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram19port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram19_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram19_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram19_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram19port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram19port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram19_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram19_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram19_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom19_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom19_re 	, 	//NC
rom19_cs 	, 	//NC
rom19_tri	  	//NC
);


unit_1DFFT f20(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f20_command	,	//Connection twixt unit-FFT2D_Controller
f20_status	,	//Connection twixt unit-FFT2D_Controller
ram20_clk	,	//Connection twixt unit-RAM-TransposeControl
ram20port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram20port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram20_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram20_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram20_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram20port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram20port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram20_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram20_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram20_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom20_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom20_re 	, 	//NC
rom20_cs 	, 	//NC
rom20_tri	  	//NC
);


unit_1DFFT f21(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f21_command	,	//Connection twixt unit-FFT2D_Controller
f21_status	,	//Connection twixt unit-FFT2D_Controller
ram21_clk	,	//Connection twixt unit-RAM-TransposeControl
ram21port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram21port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram21_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram21_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram21_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram21port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram21port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram21_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram21_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram21_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom21_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom21_re 	, 	//NC
rom21_cs 	, 	//NC
rom21_tri	  	//NC
);


unit_1DFFT f22(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f22_command	,	//Connection twixt unit-FFT2D_Controller
f22_status	,	//Connection twixt unit-FFT2D_Controller
ram22_clk	,	//Connection twixt unit-RAM-TransposeControl
ram22port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram22port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram22_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram22_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram22_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram22port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram22port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram22_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram22_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram22_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom22_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom22_re 	, 	//NC
rom22_cs 	, 	//NC
rom22_tri	  	//NC
);


unit_1DFFT f23(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f23_command	,	//Connection twixt unit-FFT2D_Controller
f23_status	,	//Connection twixt unit-FFT2D_Controller
ram23_clk	,	//Connection twixt unit-RAM-TransposeControl
ram23port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram23port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram23_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram23_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram23_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram23port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram23port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram23_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram23_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram23_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom23_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom23_re 	, 	//NC
rom23_cs 	, 	//NC
rom23_tri	  	//NC
);


unit_1DFFT f24(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f24_command	,	//Connection twixt unit-FFT2D_Controller
f24_status	,	//Connection twixt unit-FFT2D_Controller
ram24_clk	,	//Connection twixt unit-RAM-TransposeControl
ram24port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram24port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram24_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram24_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram24_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram24port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram24port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram24_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram24_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram24_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom24_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom24_re 	, 	//NC
rom24_cs 	, 	//NC
rom24_tri	  	//NC
);


unit_1DFFT f25(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f25_command	,	//Connection twixt unit-FFT2D_Controller
f25_status	,	//Connection twixt unit-FFT2D_Controller
ram25_clk	,	//Connection twixt unit-RAM-TransposeControl
ram25port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram25port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram25_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram25_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram25_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram25port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram25port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram25_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram25_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram25_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom25_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom25_re 	, 	//NC
rom25_cs 	, 	//NC
rom25_tri	  	//NC
);


unit_1DFFT f26(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f26_command	,	//Connection twixt unit-FFT2D_Controller
f26_status	,	//Connection twixt unit-FFT2D_Controller
ram26_clk	,	//Connection twixt unit-RAM-TransposeControl
ram26port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram26port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram26_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram26_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram26_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram26port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram26port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram26_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram26_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram26_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom26_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom26_re 	, 	//NC
rom26_cs 	, 	//NC
rom26_tri	  	//NC
);


unit_1DFFT f27(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f27_command	,	//Connection twixt unit-FFT2D_Controller
f27_status	,	//Connection twixt unit-FFT2D_Controller
ram27_clk	,	//Connection twixt unit-RAM-TransposeControl
ram27port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram27port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram27_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram27_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram27_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram27port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram27port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram27_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram27_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram27_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom27_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom27_re 	, 	//NC
rom27_cs 	, 	//NC
rom27_tri	  	//NC
);


unit_1DFFT f28(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f28_command	,	//Connection twixt unit-FFT2D_Controller
f28_status	,	//Connection twixt unit-FFT2D_Controller
ram28_clk	,	//Connection twixt unit-RAM-TransposeControl
ram28port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram28port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram28_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram28_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram28_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram28port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram28port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram28_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram28_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram28_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom28_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom28_re 	, 	//NC
rom28_cs 	, 	//NC
rom28_tri	  	//NC
);


unit_1DFFT f29(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f29_command	,	//Connection twixt unit-FFT2D_Controller
f29_status	,	//Connection twixt unit-FFT2D_Controller
ram29_clk	,	//Connection twixt unit-RAM-TransposeControl
ram29port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram29port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram29_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram29_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram29_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram29port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram29port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram29_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram29_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram29_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom29_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom29_re 	, 	//NC
rom29_cs 	, 	//NC
rom29_tri	  	//NC
);


unit_1DFFT f30(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f30_command	,	//Connection twixt unit-FFT2D_Controller
f30_status	,	//Connection twixt unit-FFT2D_Controller
ram30_clk	,	//Connection twixt unit-RAM-TransposeControl
ram30port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram30port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram30_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram30_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram30_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram30port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram30port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram30_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram30_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram30_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom30_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom30_re 	, 	//NC
rom30_cs 	, 	//NC
rom30_tri	  	//NC
);


unit_1DFFT f31(
io2d_data_for_units,	//Connection twixt unit-FFT2D_IO : Common for all units
f_base_clock	,	//Connection twixt unit-FFT2D_Controller-COMMON
f31_command	,	//Connection twixt unit-FFT2D_Controller
f31_status	,	//Connection twixt unit-FFT2D_Controller
ram31_clk	,	//Connection twixt unit-RAM-TransposeControl
ram31port0_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_0 Input
ram31port0_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_0 bi-directional
ram31_cs_0_direct  	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram31_we_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram31_oe_0_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
ram31port1_add_f, 	//Connection twixt unit-RAM-TransposeControl i_ram_address_1 Input
ram31port1_bus	, 	//Connection twixt unit-RAM-TransposeControl io_data_1 bi-directional
ram31_cs_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Chip Select
ram31_we_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Write Enable/Read Enable
ram31_oe_1_direct	, 	//Connection twixt unit-RAM-TransposeControl Output Enable
rom31_add	, 	//NC
rom_bus		, 	//Connection twixt unit-ROM
rom31_re 	, 	//NC
rom31_cs 	, 	//NC
rom31_tri	  	//NC
);







//RAMs
FFT2D_RAM ram00(
ram00_clk	,
ram00port0_add  , // i_ram_address_0 Input
ram00port0_bus  , // io_data_0 bi-directional
ram00_cs_0      , // Chip Select
ram00_we_0      , // Write Enable/Read Enable
ram00_oe_0      , // Output Enable
ram00port1_add  , // i_ram_address_1 Input
ram00port1_bus  , // io_data_1 bi-directional
ram00_cs_1      , // Chip Select
ram00_we_1      , // Write Enable/Read Enable
ram00_oe_1        // Output Enable
);

FFT2D_RAM ram01(
ram01_clk	,
ram01port0_add  , // i_ram_address_0 Input
ram01port0_bus  , // io_data_0 bi-directional
ram01_cs_0      , // Chip Select
ram01_we_0      , // Write Enable/Read Enable
ram01_oe_0      , // Output Enable
ram01port1_add  , // i_ram_address_1 Input
ram01port1_bus  , // io_data_1 bi-directional
ram01_cs_1      , // Chip Select
ram01_we_1      , // Write Enable/Read Enable
ram01_oe_1        // Output Enable
); 

FFT2D_RAM ram02(
ram02_clk	,
ram02port0_add  , // i_ram_address_0 Input
ram02port0_bus  , // io_data_0 bi-directional
ram02_cs_0      , // Chip Select
ram02_we_0      , // Write Enable/Read Enable
ram02_oe_0      , // Output Enable
ram02port1_add  , // i_ram_address_1 Input
ram02port1_bus  , // io_data_1 bi-directional
ram02_cs_1      , // Chip Select
ram02_we_1      , // Write Enable/Read Enable
ram02_oe_1        // Output Enable
); 

FFT2D_RAM ram03(
ram03_clk	,
ram03port0_add  , // i_ram_address_0 Input
ram03port0_bus  , // io_data_0 bi-directional
ram03_cs_0      , // Chip Select
ram03_we_0      , // Write Enable/Read Enable
ram03_oe_0      , // Output Enable
ram03port1_add  , // i_ram_address_1 Input
ram03port1_bus  , // io_data_1 bi-directional
ram03_cs_1      , // Chip Select
ram03_we_1      , // Write Enable/Read Enable
ram03_oe_1        // Output Enable
); 

FFT2D_RAM ram04(
ram04_clk	,
ram04port0_add  , // i_ram_address_0 Input
ram04port0_bus  , // io_data_0 bi-directional
ram04_cs_0      , // Chip Select
ram04_we_0      , // Write Enable/Read Enable
ram04_oe_0      , // Output Enable
ram04port1_add  , // i_ram_address_1 Input
ram04port1_bus  , // io_data_1 bi-directional
ram04_cs_1      , // Chip Select
ram04_we_1      , // Write Enable/Read Enable
ram04_oe_1        // Output Enable
); 

FFT2D_RAM ram05(
ram05_clk	,
ram05port0_add  , // i_ram_address_0 Input
ram05port0_bus  , // io_data_0 bi-directional
ram05_cs_0      , // Chip Select
ram05_we_0      , // Write Enable/Read Enable
ram05_oe_0      , // Output Enable
ram05port1_add  , // i_ram_address_1 Input
ram05port1_bus  , // io_data_1 bi-directional
ram05_cs_1      , // Chip Select
ram05_we_1      , // Write Enable/Read Enable
ram05_oe_1        // Output Enable
); 

FFT2D_RAM ram06(
ram06_clk	,
ram06port0_add  , // i_ram_address_0 Input
ram06port0_bus  , // io_data_0 bi-directional
ram06_cs_0      , // Chip Select
ram06_we_0      , // Write Enable/Read Enable
ram06_oe_0      , // Output Enable
ram06port1_add  , // i_ram_address_1 Input
ram06port1_bus  , // io_data_1 bi-directional
ram06_cs_1      , // Chip Select
ram06_we_1      , // Write Enable/Read Enable
ram06_oe_1        // Output Enable
); 

FFT2D_RAM ram07(
ram07_clk	,
ram07port0_add  , // i_ram_address_0 Input
ram07port0_bus  , // io_data_0 bi-directional
ram07_cs_0      , // Chip Select
ram07_we_0      , // Write Enable/Read Enable
ram07_oe_0      , // Output Enable
ram07port1_add  , // i_ram_address_1 Input
ram07port1_bus  , // io_data_1 bi-directional
ram07_cs_1      , // Chip Select
ram07_we_1      , // Write Enable/Read Enable
ram07_oe_1        // Output Enable
); 

FFT2D_RAM ram08(
ram08_clk	,
ram08port0_add  , // i_ram_address_0 Input
ram08port0_bus  , // io_data_0 bi-directional
ram08_cs_0      , // Chip Select
ram08_we_0      , // Write Enable/Read Enable
ram08_oe_0      , // Output Enable
ram08port1_add  , // i_ram_address_1 Input
ram08port1_bus  , // io_data_1 bi-directional
ram08_cs_1      , // Chip Select
ram08_we_1      , // Write Enable/Read Enable
ram08_oe_1        // Output Enable
); 

FFT2D_RAM ram09(
ram09_clk	,
ram09port0_add  , // i_ram_address_0 Input
ram09port0_bus  , // io_data_0 bi-directional
ram09_cs_0      , // Chip Select
ram09_we_0      , // Write Enable/Read Enable
ram09_oe_0      , // Output Enable
ram09port1_add  , // i_ram_address_1 Input
ram09port1_bus  , // io_data_1 bi-directional
ram09_cs_1      , // Chip Select
ram09_we_1      , // Write Enable/Read Enable
ram09_oe_1        // Output Enable
); 

FFT2D_RAM ram10(
ram10_clk	,
ram10port0_add  , // i_ram_address_0 Input
ram10port0_bus  , // io_data_0 bi-directional
ram10_cs_0      , // Chip Select
ram10_we_0      , // Write Enable/Read Enable
ram10_oe_0      , // Output Enable
ram10port1_add  , // i_ram_address_1 Input
ram10port1_bus  , // io_data_1 bi-directional
ram10_cs_1      , // Chip Select
ram10_we_1      , // Write Enable/Read Enable
ram10_oe_1        // Output Enable
); 

FFT2D_RAM ram11(
ram11_clk	,
ram11port0_add  , // i_ram_address_0 Input
ram11port0_bus  , // io_data_0 bi-directional
ram11_cs_0      , // Chip Select
ram11_we_0      , // Write Enable/Read Enable
ram11_oe_0      , // Output Enable
ram11port1_add  , // i_ram_address_1 Input
ram11port1_bus  , // io_data_1 bi-directional
ram11_cs_1      , // Chip Select
ram11_we_1      , // Write Enable/Read Enable
ram11_oe_1        // Output Enable
); 

FFT2D_RAM ram12(
ram12_clk	,
ram12port0_add  , // i_ram_address_0 Input
ram12port0_bus  , // io_data_0 bi-directional
ram12_cs_0      , // Chip Select
ram12_we_0      , // Write Enable/Read Enable
ram12_oe_0      , // Output Enable
ram12port1_add  , // i_ram_address_1 Input
ram12port1_bus  , // io_data_1 bi-directional
ram12_cs_1      , // Chip Select
ram12_we_1      , // Write Enable/Read Enable
ram12_oe_1        // Output Enable
); 

FFT2D_RAM ram13(
ram13_clk	,
ram13port0_add  , // i_ram_address_0 Input
ram13port0_bus  , // io_data_0 bi-directional
ram13_cs_0      , // Chip Select
ram13_we_0      , // Write Enable/Read Enable
ram13_oe_0      , // Output Enable
ram13port1_add  , // i_ram_address_1 Input
ram13port1_bus  , // io_data_1 bi-directional
ram13_cs_1      , // Chip Select
ram13_we_1      , // Write Enable/Read Enable
ram13_oe_1        // Output Enable
); 

FFT2D_RAM ram14(
ram14_clk	,
ram14port0_add  , // i_ram_address_0 Input
ram14port0_bus  , // io_data_0 bi-directional
ram14_cs_0      , // Chip Select
ram14_we_0      , // Write Enable/Read Enable
ram14_oe_0      , // Output Enable
ram14port1_add  , // i_ram_address_1 Input
ram14port1_bus  , // io_data_1 bi-directional
ram14_cs_1      , // Chip Select
ram14_we_1      , // Write Enable/Read Enable
ram14_oe_1        // Output Enable
); 

FFT2D_RAM ram15(
ram15_clk	,
ram15port0_add  , // i_ram_address_0 Input
ram15port0_bus  , // io_data_0 bi-directional
ram15_cs_0      , // Chip Select
ram15_we_0      , // Write Enable/Read Enable
ram15_oe_0      , // Output Enable
ram15port1_add  , // i_ram_address_1 Input
ram15port1_bus  , // io_data_1 bi-directional
ram15_cs_1      , // Chip Select
ram15_we_1      , // Write Enable/Read Enable
ram15_oe_1        // Output Enable
); 

FFT2D_RAM ram16(
ram16_clk	,
ram16port0_add  , // i_ram_address_0 Input
ram16port0_bus  , // io_data_0 bi-directional
ram16_cs_0      , // Chip Select
ram16_we_0      , // Write Enable/Read Enable
ram16_oe_0      , // Output Enable
ram16port1_add  , // i_ram_address_1 Input
ram16port1_bus  , // io_data_1 bi-directional
ram16_cs_1      , // Chip Select
ram16_we_1      , // Write Enable/Read Enable
ram16_oe_1        // Output Enable
); 

FFT2D_RAM ram17(
ram17_clk	,
ram17port0_add  , // i_ram_address_0 Input
ram17port0_bus  , // io_data_0 bi-directional
ram17_cs_0      , // Chip Select
ram17_we_0      , // Write Enable/Read Enable
ram17_oe_0      , // Output Enable
ram17port1_add  , // i_ram_address_1 Input
ram17port1_bus  , // io_data_1 bi-directional
ram17_cs_1      , // Chip Select
ram17_we_1      , // Write Enable/Read Enable
ram17_oe_1        // Output Enable
); 

FFT2D_RAM ram18(
ram18_clk	,
ram18port0_add  , // i_ram_address_0 Input
ram18port0_bus  , // io_data_0 bi-directional
ram18_cs_0      , // Chip Select
ram18_we_0      , // Write Enable/Read Enable
ram18_oe_0      , // Output Enable
ram18port1_add  , // i_ram_address_1 Input
ram18port1_bus  , // io_data_1 bi-directional
ram18_cs_1      , // Chip Select
ram18_we_1      , // Write Enable/Read Enable
ram18_oe_1        // Output Enable
); 

FFT2D_RAM ram19(
ram19_clk	,
ram19port0_add  , // i_ram_address_0 Input
ram19port0_bus  , // io_data_0 bi-directional
ram19_cs_0      , // Chip Select
ram19_we_0      , // Write Enable/Read Enable
ram19_oe_0      , // Output Enable
ram19port1_add  , // i_ram_address_1 Input
ram19port1_bus  , // io_data_1 bi-directional
ram19_cs_1      , // Chip Select
ram19_we_1      , // Write Enable/Read Enable
ram19_oe_1        // Output Enable
); 

FFT2D_RAM ram20(
ram20_clk	,
ram20port0_add  , // i_ram_address_0 Input
ram20port0_bus  , // io_data_0 bi-directional
ram20_cs_0      , // Chip Select
ram20_we_0      , // Write Enable/Read Enable
ram20_oe_0      , // Output Enable
ram20port1_add  , // i_ram_address_1 Input
ram20port1_bus  , // io_data_1 bi-directional
ram20_cs_1      , // Chip Select
ram20_we_1      , // Write Enable/Read Enable
ram20_oe_1        // Output Enable
); 

FFT2D_RAM ram21(
ram21_clk	,
ram21port0_add  , // i_ram_address_0 Input
ram21port0_bus  , // io_data_0 bi-directional
ram21_cs_0      , // Chip Select
ram21_we_0      , // Write Enable/Read Enable
ram21_oe_0      , // Output Enable
ram21port1_add  , // i_ram_address_1 Input
ram21port1_bus  , // io_data_1 bi-directional
ram21_cs_1      , // Chip Select
ram21_we_1      , // Write Enable/Read Enable
ram21_oe_1        // Output Enable
); 

FFT2D_RAM ram22(
ram22_clk	,
ram22port0_add  , // i_ram_address_0 Input
ram22port0_bus  , // io_data_0 bi-directional
ram22_cs_0      , // Chip Select
ram22_we_0      , // Write Enable/Read Enable
ram22_oe_0      , // Output Enable
ram22port1_add  , // i_ram_address_1 Input
ram22port1_bus  , // io_data_1 bi-directional
ram22_cs_1      , // Chip Select
ram22_we_1      , // Write Enable/Read Enable
ram22_oe_1        // Output Enable
); 

FFT2D_RAM ram23(
ram23_clk	,
ram23port0_add  , // i_ram_address_0 Input
ram23port0_bus  , // io_data_0 bi-directional
ram23_cs_0      , // Chip Select
ram23_we_0      , // Write Enable/Read Enable
ram23_oe_0      , // Output Enable
ram23port1_add  , // i_ram_address_1 Input
ram23port1_bus  , // io_data_1 bi-directional
ram23_cs_1      , // Chip Select
ram23_we_1      , // Write Enable/Read Enable
ram23_oe_1        // Output Enable
); 

FFT2D_RAM ram24(
ram24_clk	,
ram24port0_add  , // i_ram_address_0 Input
ram24port0_bus  , // io_data_0 bi-directional
ram24_cs_0      , // Chip Select
ram24_we_0      , // Write Enable/Read Enable
ram24_oe_0      , // Output Enable
ram24port1_add  , // i_ram_address_1 Input
ram24port1_bus  , // io_data_1 bi-directional
ram24_cs_1      , // Chip Select
ram24_we_1      , // Write Enable/Read Enable
ram24_oe_1        // Output Enable
); 

FFT2D_RAM ram25(
ram25_clk	,
ram25port0_add  , // i_ram_address_0 Input
ram25port0_bus  , // io_data_0 bi-directional
ram25_cs_0      , // Chip Select
ram25_we_0      , // Write Enable/Read Enable
ram25_oe_0      , // Output Enable
ram25port1_add  , // i_ram_address_1 Input
ram25port1_bus  , // io_data_1 bi-directional
ram25_cs_1      , // Chip Select
ram25_we_1      , // Write Enable/Read Enable
ram25_oe_1        // Output Enable
); 

FFT2D_RAM ram26(
ram26_clk	,
ram26port0_add  , // i_ram_address_0 Input
ram26port0_bus  , // io_data_0 bi-directional
ram26_cs_0      , // Chip Select
ram26_we_0      , // Write Enable/Read Enable
ram26_oe_0      , // Output Enable
ram26port1_add  , // i_ram_address_1 Input
ram26port1_bus  , // io_data_1 bi-directional
ram26_cs_1      , // Chip Select
ram26_we_1      , // Write Enable/Read Enable
ram26_oe_1        // Output Enable
); 

FFT2D_RAM ram27(
ram27_clk	,
ram27port0_add  , // i_ram_address_0 Input
ram27port0_bus  , // io_data_0 bi-directional
ram27_cs_0      , // Chip Select
ram27_we_0      , // Write Enable/Read Enable
ram27_oe_0      , // Output Enable
ram27port1_add  , // i_ram_address_1 Input
ram27port1_bus  , // io_data_1 bi-directional
ram27_cs_1      , // Chip Select
ram27_we_1      , // Write Enable/Read Enable
ram27_oe_1        // Output Enable
); 

FFT2D_RAM ram28(
ram28_clk	,
ram28port0_add  , // i_ram_address_0 Input
ram28port0_bus  , // io_data_0 bi-directional
ram28_cs_0      , // Chip Select
ram28_we_0      , // Write Enable/Read Enable
ram28_oe_0      , // Output Enable
ram28port1_add  , // i_ram_address_1 Input
ram28port1_bus  , // io_data_1 bi-directional
ram28_cs_1      , // Chip Select
ram28_we_1      , // Write Enable/Read Enable
ram28_oe_1        // Output Enable
); 

FFT2D_RAM ram29(
ram29_clk	,
ram29port0_add  , // i_ram_address_0 Input
ram29port0_bus  , // io_data_0 bi-directional
ram29_cs_0      , // Chip Select
ram29_we_0      , // Write Enable/Read Enable
ram29_oe_0      , // Output Enable
ram29port1_add  , // i_ram_address_1 Input
ram29port1_bus  , // io_data_1 bi-directional
ram29_cs_1      , // Chip Select
ram29_we_1      , // Write Enable/Read Enable
ram29_oe_1        // Output Enable
); 

FFT2D_RAM ram30(
ram30_clk	,
ram30port0_add  , // i_ram_address_0 Input
ram30port0_bus  , // io_data_0 bi-directional
ram30_cs_0      , // Chip Select
ram30_we_0      , // Write Enable/Read Enable
ram30_oe_0      , // Output Enable
ram30port1_add  , // i_ram_address_1 Input
ram30port1_bus  , // io_data_1 bi-directional
ram30_cs_1      , // Chip Select
ram30_we_1      , // Write Enable/Read Enable
ram30_oe_1        // Output Enable
); 

FFT2D_RAM ram31(
ram31_clk	,
ram31port0_add  , // i_ram_address_0 Input
ram31port0_bus  , // io_data_0 bi-directional
ram31_cs_0      , // Chip Select
ram31_we_0      , // Write Enable/Read Enable
ram31_oe_0      , // Output Enable
ram31port1_add  , // i_ram_address_1 Input
ram31port1_bus  , // io_data_1 bi-directional
ram31_cs_1      , // Chip Select
ram31_we_1      , // Write Enable/Read Enable
ram31_oe_1        // Output Enable
); 


//ROM
ROM fft2d_rom01(
rom00_add	, //Connection twixt rom-unit00
rom_bus 	, //Connection twixt rom-units(ALL)
rom00_re 	, //Connection twixt rom-unit00
rom00_cs      	, //Connection twixt rom-unit00
rom00_tri	  //Connection twixt rom-unit00
);


//IO
FFT2D_IO fft2d_io01(
io_fft2d_data		,//Connection twixt FFT2D_IO-External World
io2d_data_for_units	,//Connection twixt FFT2D_IO-units(ALL)
io2d_wr_cs	   	,//Connection twixt FFT2D_IO-FFT2D_Controller
io2d_rd_cs	   	,//Connection twixt FFT2D_IO-FFT2D_Controller
io2d_rd_en	   	,//Connection twixt FFT2D_IO-FFT2D_Controller
io2d_wr_en	   	,//Connection twixt FFT2D_IO-FFT2D_Controller
io2d_empty	   	,//Connection twixt FFT2D_IO-FFT2D_Controller
io2d_full	   	,//Connection twixt FFT2D_IO-FFT2D_Controller
io2d_clk	   	,//Connection twixt FFT2D_IO-FFT2D_Controller
io2d_reset
);



Transposer tran01(
transposer_clk	,
transposer_reset,
do_transpose	,	//start signal as well as the tri-stater
do_bitreversing ,
done_transpose	,	//status flag indicating operation finish
tr_ram00_port0_add	,
ram00port0_bus	,
tr_ram00_port1_add	,
ram00port1_bus	,
tr_ram00_cs_we_oe_0,
tr_ram00_cs_we_oe_1,	//Have to repeat this for all rams
tr_ram01_port0_add	,
ram01port0_bus	,
tr_ram01_port1_add	,
ram01port1_bus	,
tr_ram01_cs_we_oe_0,
tr_ram01_cs_we_oe_1,
tr_ram02_port0_add	,
ram02port0_bus	,
tr_ram02_port1_add	,
ram02port1_bus	,
tr_ram02_cs_we_oe_0,
tr_ram02_cs_we_oe_1,
tr_ram03_port0_add	,
ram03port0_bus	,
tr_ram03_port1_add	,
ram03port1_bus	,
tr_ram03_cs_we_oe_0,
tr_ram03_cs_we_oe_1,
tr_ram04_port0_add	,
ram04port0_bus	,
tr_ram04_port1_add	,
ram04port1_bus	,
tr_ram04_cs_we_oe_0,
tr_ram04_cs_we_oe_1,
tr_ram05_port0_add	,
ram05port0_bus	,
tr_ram05_port1_add	,
ram05port1_bus	,
tr_ram05_cs_we_oe_0,
tr_ram05_cs_we_oe_1,
tr_ram06_port0_add	,
ram06port0_bus	,
tr_ram06_port1_add	,
ram06port1_bus	,
tr_ram06_cs_we_oe_0,
tr_ram06_cs_we_oe_1,
tr_ram07_port0_add	,
ram07port0_bus	,
tr_ram07_port1_add	,
ram07port1_bus	,
tr_ram07_cs_we_oe_0,
tr_ram07_cs_we_oe_1,
tr_ram08_port0_add	,
ram08port0_bus	,
tr_ram08_port1_add	,
ram08port1_bus	,
tr_ram08_cs_we_oe_0,
tr_ram08_cs_we_oe_1,
tr_ram09_port0_add	,
ram09port0_bus	,
tr_ram09_port1_add	,
ram09port1_bus	,
tr_ram09_cs_we_oe_0,
tr_ram09_cs_we_oe_1,
tr_ram10_port0_add	,
ram10port0_bus	,
tr_ram10_port1_add	,
ram10port1_bus	,
tr_ram10_cs_we_oe_0,
tr_ram10_cs_we_oe_1,
tr_ram11_port0_add	,
ram11port0_bus	,
tr_ram11_port1_add	,
ram11port1_bus	,
tr_ram11_cs_we_oe_0,
tr_ram11_cs_we_oe_1,
tr_ram12_port0_add	,
ram12port0_bus	,
tr_ram12_port1_add	,
ram12port1_bus	,
tr_ram12_cs_we_oe_0,
tr_ram12_cs_we_oe_1,
tr_ram13_port0_add	,
ram13port0_bus	,
tr_ram13_port1_add	,
ram13port1_bus	,
tr_ram13_cs_we_oe_0,
tr_ram13_cs_we_oe_1,
tr_ram14_port0_add	,
ram14port0_bus	,
tr_ram14_port1_add	,
ram14port1_bus	,
tr_ram14_cs_we_oe_0,
tr_ram14_cs_we_oe_1,
tr_ram15_port0_add	,
ram15port0_bus	,
tr_ram15_port1_add	,
ram15port1_bus	,
tr_ram15_cs_we_oe_0,
tr_ram15_cs_we_oe_1,
tr_ram16_port0_add	,
ram16port0_bus	,
tr_ram16_port1_add	,
ram16port1_bus	,
tr_ram16_cs_we_oe_0,
tr_ram16_cs_we_oe_1,
tr_ram17_port0_add	,
ram17port0_bus	,
tr_ram17_port1_add	,
ram17port1_bus	,
tr_ram17_cs_we_oe_0,
tr_ram17_cs_we_oe_1,
tr_ram18_port0_add	,
ram18port0_bus	,
tr_ram18_port1_add	,
ram18port1_bus	,
tr_ram18_cs_we_oe_0,
tr_ram18_cs_we_oe_1,
tr_ram19_port0_add	,
ram19port0_bus	,
tr_ram19_port1_add	,
ram19port1_bus	,
tr_ram19_cs_we_oe_0,
tr_ram19_cs_we_oe_1,
tr_ram20_port0_add	,
ram20port0_bus	,
tr_ram20_port1_add	,
ram20port1_bus	,
tr_ram20_cs_we_oe_0,
tr_ram20_cs_we_oe_1,
tr_ram21_port0_add	,
ram21port0_bus	,
tr_ram21_port1_add	,
ram21port1_bus	,
tr_ram21_cs_we_oe_0,
tr_ram21_cs_we_oe_1,
tr_ram22_port0_add	,
ram22port0_bus	,
tr_ram22_port1_add	,
ram22port1_bus	,
tr_ram22_cs_we_oe_0,
tr_ram22_cs_we_oe_1,
tr_ram23_port0_add	,
ram23port0_bus	,
tr_ram23_port1_add	,
ram23port1_bus	,
tr_ram23_cs_we_oe_0,
tr_ram23_cs_we_oe_1,
tr_ram24_port0_add	,
ram24port0_bus	,
tr_ram24_port1_add	,
ram24port1_bus	,
tr_ram24_cs_we_oe_0,
tr_ram24_cs_we_oe_1,
tr_ram25_port0_add	,
ram25port0_bus	,
tr_ram25_port1_add	,
ram25port1_bus	,
tr_ram25_cs_we_oe_0,
tr_ram25_cs_we_oe_1,
tr_ram26_port0_add	,
ram26port0_bus	,
tr_ram26_port1_add	,
ram26port1_bus	,
tr_ram26_cs_we_oe_0,
tr_ram26_cs_we_oe_1,
tr_ram27_port0_add	,
ram27port0_bus	,
tr_ram27_port1_add	,
ram27port1_bus	,
tr_ram27_cs_we_oe_0,
tr_ram27_cs_we_oe_1,
tr_ram28_port0_add	,
ram28port0_bus	,
tr_ram28_port1_add	,
ram28port1_bus	,
tr_ram28_cs_we_oe_0,
tr_ram28_cs_we_oe_1,
tr_ram29_port0_add	,
ram29port0_bus	,
tr_ram29_port1_add	,
ram29port1_bus	,
tr_ram29_cs_we_oe_0,
tr_ram29_cs_we_oe_1,
tr_ram30_port0_add	,
ram30port0_bus	,
tr_ram30_port1_add	,
ram30port1_bus	,
tr_ram30_cs_we_oe_0,
tr_ram30_cs_we_oe_1,
tr_ram31_port0_add	,
ram31port0_bus	,
tr_ram31_port1_add	,
ram31port1_bus	,
tr_ram31_cs_we_oe_0,
tr_ram31_cs_we_oe_1
);

endmodule		
