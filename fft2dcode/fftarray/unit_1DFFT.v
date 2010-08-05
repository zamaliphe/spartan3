`include "00defines.v"

module unit_1DFFT(
//io_fft_data	,
i_fft_base_clock,
command		,
//status	,
//RAM Ports:
//ram_clk	,
ram0_add	, // i_ram_address_0 Input
ram0_bus	, // io_data_0 bi-directional
ram_cs_0	, // Chip Select
ram_we_0	, // Write Enable/Read Enable
ram_oe_0	, // Output Enable
ram1_add	, // i_ram_address_1 Input
ram1_bus	, // io_data_1 bi-directional
ram_cs_1	, // Chip Select
ram_we_1	, // Write Enable/Read Enable
ram_oe_1	, // Output Enable
//ROM Ports:
//rom_add		, // Address input(input)
//rom_bus		, // Data output  (output)
//rom_re 		, // Read Enable  (control)
//rom_cs 		, // Chip Enable  (control)
//rom_tri		  //tristate cotrol
controlIFFT
);



//inout [`FFT_DATA_WIDTH-1:0] io_fft_data;//X bit words will be input serially at present from the testbench
input i_fft_base_clock;	
input [`SEQUENCE_MODE_LENGTH +2 -1:0] command;
//output [`LOG_N+2 + `AGU_MODE_WIDTH+1-1:0] status;
//RAM
//output ram_clk;
output ram_cs_0;
output ram_we_0;
output ram_oe_0;
output ram_cs_1;
output ram_we_1;
output ram_oe_1;
output [`FFT_AGU_ADD_WIDTH-1:0]	ram0_add      ; // i_ram_address_0 Input
inout [`FFT_DATA_WIDTH-1:0]	ram0_bus      ; // io_data_0 bi-directional
output [`FFT_AGU_ADD_WIDTH-1:0]	ram1_add      ; // i_ram_address_1 Input
inout [`FFT_DATA_WIDTH-1:0]	ram1_bus      ; // io_data_1 bi-directional
//ROM
//output rom_re;
//output rom_cs;
//output rom_tri;
//input [`FFT_DATA_WIDTH-1:0]    	rom_bus       ; // Data output  (output)
//output [`ROM_ADD_WIDTH-1:0] 	rom_add       ; // Data output  (output)
input controlIFFT;
 

wire [`FFT_DATA_WIDTH-1:0] io_fft_data;//Dummy
wire i_fft_base_clock;	
wire [`SEQUENCE_MODE_LENGTH +2 -1:0] command;
wire [`LOG_N+2 + `AGU_MODE_WIDTH+1-1:0] status; //Dummy
//RAM
wire ram_clk;	//Dummy
wire ram_cs_0;
wire ram_we_0;
wire ram_oe_0;
wire ram_cs_1;
wire ram_we_1;
wire ram_oe_1;
wire [`FFT_AGU_ADD_WIDTH-1:0] 	ram0_add      ; // i_ram_address_0 Input
wire [`FFT_DATA_WIDTH-1:0]	ram0_bus      ; // io_data_0 bi-directional
wire [`FFT_AGU_ADD_WIDTH-1:0] 	ram1_add      ; // i_ram_address_1 Input
wire [`FFT_DATA_WIDTH-1:0]	ram1_bus      ; // io_data_1 bi-directional
//ROM
wire rom_re;	//Dummy
wire rom_cs;	//Dummy
wire rom_tri;	//Dummy
wire [`FFT_DATA_WIDTH-1:0]    	rom_bus       ; // Data output  (output)//Dummy
wire [`ROM_ADD_WIDTH-1:0] 	rom_add       ; // Data output  (output)//Dummy
wire controlIFFT; 




//internal wires and regs

//To be combined into `command' and `status' ports
wire i_fft_reset;	//part of command	
wire i_fft_start;	//part of command
wire [`SEQUENCE_MODE_LENGTH-1:0] sequence;//part of command
wire [`LOG_N-1:0] operation_count;//part of status
wire [`AGU_MODE_WIDTH+1-1:0] mode_termination;//part of status
//Controller
wire o_TIP;			
wire o_busy;		
//AGU
wire agu_clock;
wire agu_start;
wire agu_reset;
wire agu_oe;
wire [`AGU_MODE_WIDTH-1:0]agu_mode;
wire x_we_ram;
//Butterfly
wire butter_clock;
wire butter_start;
wire butter_reset;
wire butter_o_tri;
//IO
wire io_tri_outgoing_line;
wire io_tri_incoming_line;
wire io_cs;
wire io_ext_write;
wire io_clock;
wire io_reset;

wire [`FFT_AGU_ADD_WIDTH-1:0]	agu_radd      ;
wire [`FFT_AGU_ADD_WIDTH-1:0] 	agu_wadd      ;
wire [`FFT_DATA_WIDTH-1:0]    	bf_ip         ;
wire [`FFT_DATA_WIDTH-1:0]    	bf_op         ;
wire [`FFT_DATA_WIDTH-1:0]    	io_ip_to_ram  ;
wire [`FFT_DATA_WIDTH-1:0]    	io_op_from_ram;
wire [`LOG_N + 2-1:0]		cc_counter   ;






//Assignments
assign {i_fft_reset,i_fft_start,sequence}= command; 
assign status = {mode_termination,cc_counter};
assign ram0_add = agu_radd;
assign ram1_add = agu_wadd;
assign bf_ip = ram0_bus;
assign io_op_from_ram = ram0_bus;
//assign ram0_bus = `RAM_DATA_WIDTH'bZ;	//Luck Theja 13th oct 2008
assign ram1_bus = (butter_reset==0)?bf_op:`RAM_DATA_WIDTH'bZ;		//Modified by Theja 20081012
//assign ram1_bus = bf_op;		//Modified by Theja 20081012
//assign ram1_bus = io_ip_to_ram;	//commented by Theja 20081012
//assign ram1_bus = rom_bus;		//Commented by Theja 20081012
assign rom_add = agu_radd[`ROM_ADD_WIDTH-1:0];


//instantiations

Controller c01(
sequence,
mode_termination,
//AGU
agu_clock,
agu_start,
agu_reset,
agu_oe,
agu_mode,
x_we_ram,
//Butterfly
butter_clock,
butter_start,
butter_reset,
butter_o_tri,
//RAM
ram_clk,
ram_cs_0,
ram_we_0,
ram_oe_0,
ram_cs_1,
ram_we_1,
ram_oe_1,
//ROM
rom_re,
rom_cs,
rom_tri,
//IO
io_tri_outgoing_line,
io_tri_incoming_line,
io_cs,
io_ext_write,
io_clock,
io_reset,
//output of the controller : To the External World
o_busy,
o_TIP,
cc_counter,
//input to the controller : From the external World
i_fft_start,
i_fft_start,	//This contol starts the fft process on the whole..input->compute->output
i_fft_reset,
i_fft_base_clock
);

AGU agu01(
agu_radd,
agu_clock,
agu_start,
agu_reset,
agu_oe,
agu_wadd,
agu_mode,
operation_count,
x_we_ram,
controlIFFT
);	

Butterfly bf01(
bf_ip,
butter_clock,
butter_start,
butter_reset,
bf_op,
butter_o_tri
);	

IO io01(
io_fft_data,
io_ip_to_ram,
io_op_from_ram,
io_tri_outgoing_line,
io_tri_incoming_line,
io_cs,
io_ext_write,
io_clock,
io_reset
);



endmodule
