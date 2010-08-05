/* Operation divided into 3 stages: 
Stage1=Rowwise 1D FFTs with Data Input. 
Stage2=Transpose. 
Stage3=Rowwise 1D FFTs with Data Output
Potential pitfall with ram increment : depending on modulo increment (eg 7+1 = 0)

//13th Jan : Not using extc_FFT2D_cs

*/
`include "00defines.v"
`define MCNT_1 68
`define MCNT_2 196
`define MCNT_3 128
`define MCNT_4 8259
`define MCNT_5 8267
`define MCNT_6 9807
`define MCNT_7 5711
`define MCNT_8 12710
`define MCNT_9 14255
`define MCNT_10	14383 
`define MCNT_11	128
`define MCNT_12	22448
`define MCNT_13 68 //not in use; 25th july
`define MCNT_14 12710 
`define MCNT_15 14255
`define MCNT_16 14391
`define MCNT_17 128
`define MCNT_18 22327
`define MCNT_19 1743
`define MCNT_20 9807

module FFT2D_Controller(
extc_base_clock		,
extc_asyn_reset		,
extc_FFT2D_cs		,
extc_read_rom_ram	,
exts_busy		,
exts_TIP		,
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
transposer_clk		,
transposer_reset	,	
do_transpose		,
do_bitreversing		,
done_transpose		
);

parameter STATE_MODE_WIDTH		= 2;
parameter CONTROLLER_STATE_FFT_W_RD 	= 0;
parameter CONTROLLER_STATE_TRANSPOSE 	= 1;
parameter CONTROLLER_STATE_FFT	 	= 2;
parameter CONTROLLER_STATE_WRITE_OUT	= 3;
parameter STATUS_INDEX1			=`LOG_N +2 + `AGU_MODE_WIDTH +1;
parameter STATUS_INDEX2			=`LOG_N +2;

//Input-output and type declarations
input  extc_base_clock	;
input  extc_asyn_reset	;
input  extc_FFT2D_cs	;
input  extc_read_rom_ram;
output exts_busy	;
output exts_TIP		;

//unit_1DFFTX()
output f_base_clock	;	
output [`SEQUENCE_MODE_LENGTH +2 -1:0] f00_command,f01_command,f02_command,f03_command,f04_command,f05_command,f06_command,f07_command;
output [`SEQUENCE_MODE_LENGTH +2 -1:0] f08_command,f09_command,f10_command,f11_command,f12_command,f13_command,f14_command,f15_command;
output [`SEQUENCE_MODE_LENGTH +2 -1:0] f16_command,f17_command,f18_command,f19_command,f20_command,f21_command,f22_command,f23_command;
output [`SEQUENCE_MODE_LENGTH +2 -1:0] f24_command,f25_command,f26_command,f27_command,f28_command,f29_command,f30_command,f31_command;
input [`LOG_N +2 + `AGU_MODE_WIDTH +1 -1:0] f00_status,f01_status,f02_status,f03_status,f04_status,f05_status,f06_status,f07_status;
input [`LOG_N +2 + `AGU_MODE_WIDTH +1 -1:0] f08_status,f09_status,f10_status,f11_status,f12_status,f13_status,f14_status,f15_status;
input [`LOG_N +2 + `AGU_MODE_WIDTH +1 -1:0] f16_status,f17_status,f18_status,f19_status,f20_status,f21_status,f22_status,f23_status;
input [`LOG_N +2 + `AGU_MODE_WIDTH +1 -1:0] f24_status,f25_status,f26_status,f27_status,f28_status,f29_status,f30_status,f31_status;

//RAMXAddbits()
output [`FFT2D_C_RAM_ADD_BITS-1:0] ram00_add_c,ram01_add_c,ram02_add_c,ram03_add_c,ram04_add_c,ram05_add_c,ram06_add_c,ram07_add_c;
output [`FFT2D_C_RAM_ADD_BITS-1:0] ram08_add_c,ram09_add_c,ram10_add_c,ram11_add_c,ram12_add_c,ram13_add_c,ram14_add_c,ram15_add_c;
output [`FFT2D_C_RAM_ADD_BITS-1:0] ram16_add_c,ram17_add_c,ram18_add_c,ram19_add_c,ram20_add_c,ram21_add_c,ram22_add_c,ram23_add_c;
output [`FFT2D_C_RAM_ADD_BITS-1:0] ram24_add_c,ram25_add_c,ram26_add_c,ram27_add_c,ram28_add_c,ram29_add_c,ram30_add_c,ram31_add_c;
//IO
output io2d_clk	      	;
output io2d_reset	;
output io2d_wr_cs	;
output io2d_rd_cs      	;
output io2d_rd_en      	;
output io2d_wr_en      	;
input  io2d_empty      	;
input  io2d_full      	;
//Transposer
output transposer_clk	;
output transposer_reset	;
output do_transpose	;
output do_bitreversing	;
input done_transpose	;

wire extc_base_clock	;
wire extc_asyn_reset	;
wire extc_FFT2D_cs	;
wire extc_read_rom_ram	;
reg  exts_busy		;
reg  exts_TIP		;
//unit_1DFFTX()
wire f_base_clock	;	
wire [`SEQUENCE_MODE_LENGTH+2-1:0]f00_command,f01_command,f02_command,f03_command,f04_command,f05_command,f06_command,f07_command;
wire [`SEQUENCE_MODE_LENGTH+2-1:0]f08_command,f09_command,f10_command,f11_command,f12_command,f13_command,f14_command,f15_command;
wire [`SEQUENCE_MODE_LENGTH+2-1:0]f16_command,f17_command,f18_command,f19_command,f20_command,f21_command,f22_command,f23_command;
wire [`SEQUENCE_MODE_LENGTH+2-1:0]f24_command,f25_command,f26_command,f27_command,f28_command,f29_command,f30_command,f31_command;
wire [`LOG_N+2 + `AGU_MODE_WIDTH +1 -1:0] f00_status,f01_status,f02_status,f03_status,f04_status,f05_status,f06_status,f07_status;
wire [`LOG_N+2 + `AGU_MODE_WIDTH +1 -1:0] f08_status,f09_status,f10_status,f11_status,f12_status,f13_status,f14_status,f15_status;
wire [`LOG_N+2 + `AGU_MODE_WIDTH +1 -1:0] f16_status,f17_status,f18_status,f19_status,f20_status,f21_status,f22_status,f23_status;
wire [`LOG_N+2 + `AGU_MODE_WIDTH +1 -1:0] f24_status,f25_status,f26_status,f27_status,f28_status,f29_status,f30_status,f31_status;
//RAMXAddbits()
wire [`FFT2D_C_RAM_ADD_BITS-1:0] ram00_add_c,ram01_add_c,ram02_add_c,ram03_add_c,ram04_add_c,ram05_add_c,ram06_add_c,ram07_add_c;
wire [`FFT2D_C_RAM_ADD_BITS-1:0] ram08_add_c,ram09_add_c,ram10_add_c,ram11_add_c,ram12_add_c,ram13_add_c,ram14_add_c,ram15_add_c;
wire [`FFT2D_C_RAM_ADD_BITS-1:0] ram16_add_c,ram17_add_c,ram18_add_c,ram19_add_c,ram20_add_c,ram21_add_c,ram22_add_c,ram23_add_c;
wire [`FFT2D_C_RAM_ADD_BITS-1:0] ram24_add_c,ram25_add_c,ram26_add_c,ram27_add_c,ram28_add_c,ram29_add_c,ram30_add_c,ram31_add_c;
//IO
wire io2d_clk	      	;
reg  io2d_reset		;
reg  io2d_wr_cs		;
reg  io2d_rd_cs      	;
reg  io2d_rd_en      	;
reg  io2d_wr_en      	;
wire io2d_empty      	;
wire io2d_full      	;
//Transposer
reg do_transpose	;
reg do_bitreversing	;
reg transposer_reset	;
wire transposer_clk	;
wire done_transpose	;	



//Internal Wires and Registers

//wire [STATUS_INDEX2-1:0]   f_status_part2	;
reg new_start					;
reg [STATE_MODE_WIDTH-1:0] controller_state	;
reg [`LOG_NO_OF_UNITS-1:0] reading_turn		;			
reg [`LOG_MAX_ELEMENTS:0]  write_counter	;
reg 		 	   rom_ram		;
reg [`NO_OF_UNITS-1:0]     free_status		;
reg [`NO_OF_UNITS-1:0]     first_clock_cycle	;
reg [`MAX_RAM_ROWS-1:0]	   present_ram_row	;	
reg [`SEQUENCE_MODE_LENGTH+2-1:0] 	f_command[0:`NO_OF_UNITS-1];
reg [`FFT2D_C_RAM_ADD_BITS-1:0]		ram_add_c[0:`NO_OF_UNITS-1];

//reg [`AGU_MODE_WIDTH+1-1:0] 		f_status[0:`NO_OF_UNITS-1] ;

reg [2:0] readin;	//to count 6. Termination bit becomes HI 6 cycles afore, I want to reset the unit 6 cycles after.
reg checking31;
reg state_fft_stall;
reg [15:0] master_counter;
reg [`LOG_NO_OF_UNITS - 1:0] resetting_counter;	//Size is very important. Using wrap around.



//Assignments
assign f_base_clock 	= extc_base_clock;
assign io2d_clk 	= extc_base_clock;
assign transposer_clk 	= extc_base_clock;
assign f00_command = f_command[0] ; assign f01_command = f_command[1] ; assign f02_command = f_command[2]  ;
assign f03_command = f_command[3] ; assign f04_command = f_command[4] ; assign f05_command = f_command[5]  ;
assign f06_command = f_command[6] ; assign f07_command = f_command[7] ; assign f08_command = f_command[8]  ;
assign f09_command = f_command[9] ; assign f10_command = f_command[10]; assign f11_command = f_command[11] ;
assign f12_command = f_command[12]; assign f13_command = f_command[13]; assign f14_command = f_command[14] ;
assign f15_command = f_command[15]; assign f16_command = f_command[16]; assign f17_command = f_command[17] ;
assign f18_command = f_command[18]; assign f19_command = f_command[19]; assign f20_command = f_command[20] ;
assign f21_command = f_command[21]; assign f22_command = f_command[22]; assign f23_command = f_command[23] ;
assign f24_command = f_command[24]; assign f25_command = f_command[25]; assign f26_command = f_command[26] ;
assign f27_command = f_command[27]; assign f28_command = f_command[28]; assign f29_command = f_command[29] ;
assign f30_command = f_command[30]; assign f31_command = f_command[31];
assign ram00_add_c = ram_add_c[0] ; assign ram01_add_c = ram_add_c[1] ; assign  ram02_add_c = ram_add_c[2] ; 
assign ram03_add_c = ram_add_c[3] ; assign ram04_add_c = ram_add_c[4] ; assign  ram05_add_c = ram_add_c[5] ;  
assign ram06_add_c = ram_add_c[6] ; assign ram07_add_c = ram_add_c[7] ; assign  ram08_add_c = ram_add_c[8] ; 
assign ram09_add_c = ram_add_c[9] ; assign ram10_add_c = ram_add_c[10]; assign  ram11_add_c = ram_add_c[11];  
assign ram12_add_c = ram_add_c[12]; assign ram13_add_c = ram_add_c[13]; assign  ram14_add_c = ram_add_c[14];  
assign ram15_add_c = ram_add_c[15]; assign ram16_add_c = ram_add_c[16]; assign  ram17_add_c = ram_add_c[17];
assign ram18_add_c = ram_add_c[18]; assign ram19_add_c = ram_add_c[19]; assign  ram20_add_c = ram_add_c[20]; 
assign ram21_add_c = ram_add_c[21]; assign ram22_add_c = ram_add_c[22]; assign  ram23_add_c = ram_add_c[23];  
assign ram24_add_c = ram_add_c[24]; assign ram25_add_c = ram_add_c[25]; assign  ram26_add_c = ram_add_c[26];  
assign ram27_add_c = ram_add_c[27]; assign ram28_add_c = ram_add_c[28]; assign  ram29_add_c = ram_add_c[29]; 
assign ram30_add_c = ram_add_c[30]; assign ram31_add_c = ram_add_c[31];



//Logic
always @ (posedge extc_base_clock or posedge extc_asyn_reset)
begin
	if(extc_asyn_reset==1'b1)
	begin
		new_start		<= 	 0;
		resetting_counter	<= 	 0;
		master_counter		<= 	 0;
		state_fft_stall 	<= 	 1;
		checking31		<=   	 1;
		readin			<=	 0;
		controller_state	<= CONTROLLER_STATE_FFT_W_RD;	
		//controller_state	<= CONTROLLER_STATE_FFT;	//ORIGINAL IS ABOVE THIS.. 29th Jan Theja
		rom_ram 		<=	 extc_read_rom_ram;	//keep this LO to disable reading from start
		free_status 		<=	-1;
		first_clock_cycle 	<= 	-1;
		io2d_reset 		<= 	 1;
		io2d_wr_en 		<= 	 0;
		io2d_wr_cs 		<= 	 0;
		io2d_rd_cs      	<=	 0;
		io2d_rd_en      	<= 	 0;
		transposer_reset 	<=	 1;
		do_transpose 		<=	 0;
		do_bitreversing		<= 	 1;
		write_counter 		<=	 0;
		reading_turn 		<=	 0;
		exts_TIP 		<=	 0;
		exts_busy		<=	 0;
		present_ram_row		<=	 0;
		if(extc_read_rom_ram ==1)
		begin
			f_command[0] <= {1'b1,1'b0,4'b0100};f_command[1] <= {1'b1,1'b0,4'b0100};f_command[2] <= {1'b1,1'b0,4'b0100};
			f_command[3] <= {1'b1,1'b0,4'b0100};f_command[4] <= {1'b1,1'b0,4'b0100};f_command[5] <= {1'b1,1'b0,4'b0100};
			f_command[6] <= {1'b1,1'b0,4'b0100};f_command[7] <= {1'b1,1'b0,4'b0100};f_command[8] <= {1'b1,1'b0,4'b0100};
			f_command[9] <= {1'b1,1'b0,4'b0100};f_command[10]<= {1'b1,1'b0,4'b0100};f_command[11]<= {1'b1,1'b0,4'b0100};
			f_command[12]<= {1'b1,1'b0,4'b0100};f_command[13]<= {1'b1,1'b0,4'b0100};f_command[14]<= {1'b1,1'b0,4'b0100};
			f_command[15]<= {1'b1,1'b0,4'b0100};f_command[16]<= {1'b1,1'b0,4'b0100};f_command[17]<= {1'b1,1'b0,4'b0100};
			f_command[18]<= {1'b1,1'b0,4'b0100};f_command[19]<= {1'b1,1'b0,4'b0100};f_command[20]<= {1'b1,1'b0,4'b0100};
			f_command[21]<= {1'b1,1'b0,4'b0100};f_command[22]<= {1'b1,1'b0,4'b0100};f_command[23]<= {1'b1,1'b0,4'b0100};
			f_command[24]<= {1'b1,1'b0,4'b0100};f_command[25]<= {1'b1,1'b0,4'b0100};f_command[26]<= {1'b1,1'b0,4'b0100};
			f_command[27]<= {1'b1,1'b0,4'b0100};f_command[28]<= {1'b1,1'b0,4'b0100};f_command[29]<= {1'b1,1'b0,4'b0100};
			f_command[30]<= {1'b1,1'b0,4'b0100};f_command[31]<= {1'b1,1'b0,4'b0100};
			ram_add_c[0] <= 0; ram_add_c[1] <= 0; ram_add_c[2] <= 0; ram_add_c[3] <= 0; ram_add_c[4] <= 0;
			ram_add_c[5] <= 0; ram_add_c[6] <= 0; ram_add_c[7] <= 0; ram_add_c[8] <= 0; ram_add_c[9] <= 0;
			ram_add_c[10]<= 0; ram_add_c[11]<= 0; ram_add_c[12]<= 0; ram_add_c[13]<= 0; ram_add_c[14]<= 0;
			ram_add_c[15]<= 0; ram_add_c[16]<= 0; ram_add_c[17]<= 0; ram_add_c[18]<= 0; ram_add_c[19]<= 0;
			ram_add_c[20]<= 0; ram_add_c[21]<= 0; ram_add_c[22]<= 0; ram_add_c[23]<= 0; ram_add_c[24]<= 0;
			ram_add_c[25]<= 0; ram_add_c[26]<= 0; ram_add_c[27]<= 0; ram_add_c[28]<= 0; ram_add_c[29]<= 0;
			ram_add_c[30]<= 0; ram_add_c[31]<= 0; 
		end
		else
		begin
			ram_add_c[0] <= -1; ram_add_c[1] <= -1; ram_add_c[2] <= -1;
			ram_add_c[3] <= -1; ram_add_c[4] <= -1; ram_add_c[5] <= -1;
			ram_add_c[6] <= -1; ram_add_c[7] <= -1; ram_add_c[8] <= -1; 
			ram_add_c[9] <= -1; ram_add_c[10]<= -1; ram_add_c[11]<= -1;
			ram_add_c[12]<= -1; ram_add_c[13]<= -1; ram_add_c[14]<= -1;
			ram_add_c[15]<= -1; ram_add_c[16]<= -1; ram_add_c[17]<= -1; 
			ram_add_c[18]<= -1; ram_add_c[19]<= -1; ram_add_c[20]<= -1;
			ram_add_c[21]<= -1; ram_add_c[22]<= -1; ram_add_c[23]<= -1; 
			ram_add_c[24]<= -1; ram_add_c[25]<= -1; ram_add_c[26]<= -1;
			ram_add_c[27]<= -1; ram_add_c[28]<= -1; ram_add_c[29]<= -1;
			ram_add_c[30]<= -1; ram_add_c[31]<= -1;
	
			f_command[0] <= {1'b1,1'b0,4'b0000};f_command[1] <= {1'b1,1'b0,4'b0000};f_command[2] <= {1'b1,1'b0,4'b0000};
			f_command[3] <= {1'b1,1'b0,4'b0000};f_command[4] <= {1'b1,1'b0,4'b0000};f_command[5] <= {1'b1,1'b0,4'b0000};
			f_command[6] <= {1'b1,1'b0,4'b0000};f_command[7] <= {1'b1,1'b0,4'b0000};f_command[8] <= {1'b1,1'b0,4'b0000};
			f_command[9] <= {1'b1,1'b0,4'b0000};f_command[10]<= {1'b1,1'b0,4'b0000};f_command[11]<= {1'b1,1'b0,4'b0000};
			f_command[12]<= {1'b1,1'b0,4'b0000};f_command[13]<= {1'b1,1'b0,4'b0000};f_command[14]<= {1'b1,1'b0,4'b0000};
			f_command[15]<= {1'b1,1'b0,4'b0000};f_command[16]<= {1'b1,1'b0,4'b0000};f_command[17]<= {1'b1,1'b0,4'b0000};
			f_command[18]<= {1'b1,1'b0,4'b0000};f_command[19]<= {1'b1,1'b0,4'b0000};f_command[20]<= {1'b1,1'b0,4'b0000};
			f_command[21]<= {1'b1,1'b0,4'b0000};f_command[22]<= {1'b1,1'b0,4'b0000};f_command[23]<= {1'b1,1'b0,4'b0000};
			f_command[24]<= {1'b1,1'b0,4'b0000};f_command[25]<= {1'b1,1'b0,4'b0000};f_command[26]<= {1'b1,1'b0,4'b0000};
			f_command[27]<= {1'b1,1'b0,4'b0000};f_command[28]<= {1'b1,1'b0,4'b0000};f_command[29]<= {1'b1,1'b0,4'b0000};
			f_command[30]<= {1'b1,1'b0,4'b0000};f_command[31]<= {1'b1,1'b0,4'b0000};	
		end
	end
	else
	begin
		if (extc_FFT2D_cs || new_start)
		begin

			if(~((controller_state == CONTROLLER_STATE_WRITE_OUT) && (reading_turn==`NO_OF_UNITS-1) &&(master_counter >= `MCNT_12)&&(present_ram_row==`MAX_RAM_ROWS-1) && (readin == 4)))
			begin
				master_counter <= master_counter + 1'b1;
			end
		end

		case(controller_state)
			CONTROLLER_STATE_FFT_W_RD:
			begin
				//Dealing with IO for Reading the data from outside world
				if(extc_FFT2D_cs || new_start) //control to start sending in the data. has to be on for 1 cycle.
				//things will remain stalled in this state in subsequent stages till new input is present
				//and this signal will not go HI.
				begin
					new_start <= 1;	
					if(write_counter < `MAX_ELEMENTS+1)
					begin
						io2d_reset 	<= 0;
						io2d_wr_en 	<= 1;
						io2d_wr_cs 	<= 1;
						write_counter <= write_counter + 1;
						exts_TIP   	<= 1;
						exts_busy 	<= 1; //Theja 20080831
					end
					else
					begin
						io2d_wr_en 	<= 0;
						io2d_wr_cs 	<= 0;	
						exts_TIP 	<= 0;
					end
					
					//Dealing with Units to do the Simultaneous ROM_RAM operation
					if(rom_ram == 1'b1)	
					begin
						if(first_clock_cycle == -1 & (master_counter == 0 || master_counter == `MCNT_1-1))	
						begin
						//Setting all the units to ROM_RAM mode
							f_command[0] <= {1'b0,1'b1,4'b0100};f_command[1] <= {1'b0,1'b1,4'b0100};
							f_command[2] <= {1'b0,1'b1,4'b0100};f_command[3] <= {1'b0,1'b1,4'b0100};
							
							f_command[4] <= {1'b0,1'b1,4'b0100};f_command[5] <= {1'b0,1'b1,4'b0100};
							f_command[6] <= {1'b0,1'b1,4'b0100};f_command[7] <= {1'b0,1'b1,4'b0100};
							f_command[8] <= {1'b0,1'b1,4'b0100};f_command[9] <= {1'b0,1'b1,4'b0100};
							
							f_command[10]<= {1'b0,1'b1,4'b0100};f_command[11]<= {1'b0,1'b1,4'b0100};
							f_command[12]<= {1'b0,1'b1,4'b0100};f_command[13]<= {1'b0,1'b1,4'b0100};
							f_command[14]<= {1'b0,1'b1,4'b0100};f_command[15]<= {1'b0,1'b1,4'b0100};
							f_command[16]<= {1'b0,1'b1,4'b0100};f_command[17]<= {1'b0,1'b1,4'b0100};
							
							f_command[18]<= {1'b0,1'b1,4'b0100};f_command[19]<= {1'b0,1'b1,4'b0100};
							f_command[20]<= {1'b0,1'b1,4'b0100};f_command[21]<= {1'b0,1'b1,4'b0100};
							f_command[22]<= {1'b0,1'b1,4'b0100};f_command[23]<= {1'b0,1'b1,4'b0100};
							f_command[24]<= {1'b0,1'b1,4'b0100};f_command[25]<= {1'b0,1'b1,4'b0100};
							f_command[26]<= {1'b0,1'b1,4'b0100};f_command[27]<= {1'b0,1'b1,4'b0100};
							f_command[28]<= {1'b0,1'b1,4'b0100};f_command[29]<= {1'b0,1'b1,4'b0100};
							f_command[30]<= {1'b0,1'b1,4'b0100};f_command[31]<= {1'b0,1'b1,4'b0100};
		
							first_clock_cycle 	<= 0;//Being set for ALL
							free_status 		<= 0;//Being set for ALL
						end	
						else if(master_counter == `MCNT_1)	//Checking only the 0th Unit(Random)
						//else if({`AGU_MODE_ROM_RAM,1'b1}==f_status[0])	//Checking only the 0th Unit(Random)
						begin	
						rom_ram <= 0;
						//Setting ram_add_c bits of all units
							ram_add_c[0] <= -1; ram_add_c[1] <= -1; ram_add_c[2] <= -1;
							ram_add_c[3] <= -1; ram_add_c[4] <= -1; ram_add_c[5] <= -1;
							ram_add_c[6] <= -1; ram_add_c[7] <= -1; ram_add_c[8] <= -1; 
							ram_add_c[9] <= -1; ram_add_c[10]<= -1; ram_add_c[11]<= -1;
							ram_add_c[12]<= -1; ram_add_c[13]<= -1; ram_add_c[14]<= -1;
							ram_add_c[15]<= -1; ram_add_c[16]<= -1; ram_add_c[17]<= -1; 
							ram_add_c[18]<= -1; ram_add_c[19]<= -1; ram_add_c[20]<= -1;
							ram_add_c[21]<= -1; ram_add_c[22]<= -1; ram_add_c[23]<= -1; 
							ram_add_c[24]<= -1; ram_add_c[25]<= -1; ram_add_c[26]<= -1;
							ram_add_c[27]<= -1; ram_add_c[28]<= -1; ram_add_c[29]<= -1;
							ram_add_c[30]<= -1; ram_add_c[31]<= -1;
	
							first_clock_cycle <= -1;
							free_status <= -1;
							f_command[0] <= {1'b1,1'b0,4'b0000};f_command[1] <= {1'b1,1'b0,4'b0000};f_command[2] <= {1'b1,1'b0,4'b0000};
							f_command[3] <= {1'b1,1'b0,4'b0000};f_command[4] <= {1'b1,1'b0,4'b0000};f_command[5] <= {1'b1,1'b0,4'b0000};
							f_command[6] <= {1'b1,1'b0,4'b0000};f_command[7] <= {1'b1,1'b0,4'b0000};f_command[8] <= {1'b1,1'b0,4'b0000};
							f_command[9] <= {1'b1,1'b0,4'b0000};f_command[10]<= {1'b1,1'b0,4'b0000};f_command[11]<= {1'b1,1'b0,4'b0000};
							f_command[12]<= {1'b1,1'b0,4'b0000};f_command[13]<= {1'b1,1'b0,4'b0000};f_command[14]<= {1'b1,1'b0,4'b0000};
							f_command[15]<= {1'b1,1'b0,4'b0000};f_command[16]<= {1'b1,1'b0,4'b0000};f_command[17]<= {1'b1,1'b0,4'b0000};
							f_command[18]<= {1'b1,1'b0,4'b0000};f_command[19]<= {1'b1,1'b0,4'b0000};f_command[20]<= {1'b1,1'b0,4'b0000};
							f_command[21]<= {1'b1,1'b0,4'b0000};f_command[22]<= {1'b1,1'b0,4'b0000};f_command[23]<= {1'b1,1'b0,4'b0000};
							f_command[24]<= {1'b1,1'b0,4'b0000};f_command[25]<= {1'b1,1'b0,4'b0000};f_command[26]<= {1'b1,1'b0,4'b0000};
							f_command[27]<= {1'b1,1'b0,4'b0000};f_command[28]<= {1'b1,1'b0,4'b0000};f_command[29]<= {1'b1,1'b0,4'b0000};
							f_command[30]<= {1'b1,1'b0,4'b0000};f_command[31]<= {1'b1,1'b0,4'b0000};
	
						end
					end
					else
					begin
						if((master_counter > `MCNT_19-1)&&(master_counter < `MCNT_20+1))
						begin
							if((master_counter-`MCNT_19)%`MCNT_17==0)
							begin
								resetting_counter 			<= resetting_counter + 1;
								f_command[resetting_counter] 		<= {1'b1,1'b0,4'b0000}	;//reset
								first_clock_cycle[resetting_counter] 	<= 1			;
								free_status[resetting_counter] 		<= 1			;
							end
						end
	
						if(~io2d_empty&free_status[reading_turn])
						begin
							if(first_clock_cycle[reading_turn])
							begin
								f_command[reading_turn] <= {1'b0,1'b1,4'b1010};
								ram_add_c[reading_turn] <= ram_add_c[reading_turn] + 1;
								first_clock_cycle[reading_turn] <= 0;
	
								io2d_rd_en <= 1;		//multisource sol1
								io2d_rd_cs <= 1;		//multisource sol1 
								free_status[reading_turn] <= 0;
							end
						end
						else if (((master_counter - `MCNT_2)%`MCNT_3 == 0)||(master_counter>`MCNT_4 && master_counter < `MCNT_5))
						begin
							if((reading_turn==`NO_OF_UNITS-1)&(present_ram_row==`MAX_RAM_ROWS-1))
							begin
								if(readin == 6)	//No of cycles in whic you actually have to reset the unit
								begin
									readin <= 0;
									io2d_rd_en <= 0;
									io2d_rd_cs <= 0;
								end
								else
								begin
									readin <= readin + 1;		
								end	
							end	
							else
							begin
								reading_turn <= reading_turn + 1;
							end
						end
						if ((master_counter == `MCNT_6) || (master_counter==`MCNT_7))
						begin
								if(present_ram_row == `MAX_RAM_ROWS -1)
								begin
									present_ram_row <= 0;		//Potential pitfall
									reading_turn 	<= 0;		//potential pitfall
									controller_state <= CONTROLLER_STATE_TRANSPOSE;//After 1st FFTN
								end
								else
								begin
									present_ram_row <= present_ram_row + 1;
								end
						end
					end
					//State change condition. Depends on the status of the 31st block
					//Block termination depends on the status input
					//Both these things are checked at every clock in another always block below
				end
			end
			CONTROLLER_STATE_FFT:
			begin
				if(~state_fft_stall)
				begin

				if ((master_counter == `MCNT_8) || (master_counter==`MCNT_9))
				begin
						if(present_ram_row == `MAX_RAM_ROWS -1)
						begin
							present_ram_row <= 0;		
							reading_turn 	<= 0;		
							controller_state <= CONTROLLER_STATE_WRITE_OUT;//After 2nd FFTN
						end
						else
						begin
							present_ram_row <= present_ram_row + 1;
							checking31 <= 1;
						end
						first_clock_cycle <= -1;
						free_status <= -1;
						f_command[0] <= {1'b1,1'b0,4'b0000};f_command[1] <= {1'b1,1'b0,4'b0000};f_command[2] <= {1'b1,1'b0,4'b0000};
						f_command[3] <= {1'b1,1'b0,4'b0000};f_command[4] <= {1'b1,1'b0,4'b0000};f_command[5] <= {1'b1,1'b0,4'b0000};
						f_command[6] <= {1'b1,1'b0,4'b0000};f_command[7] <= {1'b1,1'b0,4'b0000};f_command[8] <= {1'b1,1'b0,4'b0000};
						f_command[9] <= {1'b1,1'b0,4'b0000};f_command[10]<= {1'b1,1'b0,4'b0000};f_command[11]<= {1'b1,1'b0,4'b0000};
						f_command[12]<= {1'b1,1'b0,4'b0000};f_command[13]<= {1'b1,1'b0,4'b0000};f_command[14]<= {1'b1,1'b0,4'b0000};
						f_command[15]<= {1'b1,1'b0,4'b0000};f_command[16]<= {1'b1,1'b0,4'b0000};f_command[17]<= {1'b1,1'b0,4'b0000};
						f_command[18]<= {1'b1,1'b0,4'b0000};f_command[19]<= {1'b1,1'b0,4'b0000};f_command[20]<= {1'b1,1'b0,4'b0000};
						f_command[21]<= {1'b1,1'b0,4'b0000};f_command[22]<= {1'b1,1'b0,4'b0000};f_command[23]<= {1'b1,1'b0,4'b0000};
						f_command[24]<= {1'b1,1'b0,4'b0000};f_command[25]<= {1'b1,1'b0,4'b0000};f_command[26]<= {1'b1,1'b0,4'b0000};
						f_command[27]<= {1'b1,1'b0,4'b0000};f_command[28]<= {1'b1,1'b0,4'b0000};f_command[29]<= {1'b1,1'b0,4'b0000};
						f_command[30]<= {1'b1,1'b0,4'b0000};f_command[31]<= {1'b1,1'b0,4'b0000};
						
				end
				else
				begin
					if(checking31==1)
					begin
						checking31 <= 0;
						free_status <= 0;	//POTENTIALLY HARMFUL
						//Setting all the units to ONLY_FFT mode
						f_command[0] <= {1'b0,1'b1,4'b0010};f_command[1] <= {1'b0,1'b1,4'b0010};
						f_command[2] <= {1'b0,1'b1,4'b0010};f_command[3] <= {1'b0,1'b1,4'b0010};
						
						f_command[4] <= {1'b0,1'b1,4'b0010};f_command[5] <= {1'b0,1'b1,4'b0010};
						f_command[6] <= {1'b0,1'b1,4'b0010};f_command[7] <= {1'b0,1'b1,4'b0010};
						f_command[8] <= {1'b0,1'b1,4'b0010};f_command[9] <= {1'b0,1'b1,4'b0010};
						
						f_command[10]<= {1'b0,1'b1,4'b0010};f_command[11]<= {1'b0,1'b1,4'b0010};
						f_command[12]<= {1'b0,1'b1,4'b0010};f_command[13]<= {1'b0,1'b1,4'b0010};
						f_command[14]<= {1'b0,1'b1,4'b0010};f_command[15]<= {1'b0,1'b1,4'b0010};
						f_command[16]<= {1'b0,1'b1,4'b0010};f_command[17]<= {1'b0,1'b1,4'b0010};
						
						f_command[18]<= {1'b0,1'b1,4'b0010};f_command[19]<= {1'b0,1'b1,4'b0010};
						f_command[20]<= {1'b0,1'b1,4'b0010};f_command[21]<= {1'b0,1'b1,4'b0010};
						f_command[22]<= {1'b0,1'b1,4'b0010};f_command[23]<= {1'b0,1'b1,4'b0010};
						f_command[24]<= {1'b0,1'b1,4'b0010};f_command[25]<= {1'b0,1'b1,4'b0010};
						f_command[26]<= {1'b0,1'b1,4'b0010};f_command[27]<= {1'b0,1'b1,4'b0010};
						f_command[28]<= {1'b0,1'b1,4'b0010};f_command[29]<= {1'b0,1'b1,4'b0010};
						f_command[30]<= {1'b0,1'b1,4'b0010};f_command[31]<= {1'b0,1'b1,4'b0010};
						
						//I know for a fact that at the end of the first FFT state all the c_bits are 1
						//thats the reason why I am doing this. Otherwise, this is really a bad practice
						//Setting ram_add_c bits of all units
						ram_add_c[00] <= ram_add_c[00] + 1;ram_add_c[01] <= ram_add_c[01] + 1;
						ram_add_c[02] <= ram_add_c[02] + 1;ram_add_c[03] <= ram_add_c[03] + 1;
						ram_add_c[04] <= ram_add_c[04] + 1;ram_add_c[05] <= ram_add_c[05] + 1;
						ram_add_c[06] <= ram_add_c[06] + 1;ram_add_c[07] <= ram_add_c[07] + 1;
						ram_add_c[08] <= ram_add_c[08] + 1;ram_add_c[09] <= ram_add_c[09] + 1;
						ram_add_c[10] <= ram_add_c[10] + 1;ram_add_c[11] <= ram_add_c[11] + 1;
						ram_add_c[12] <= ram_add_c[12] + 1;ram_add_c[13] <= ram_add_c[13] + 1;
						ram_add_c[14] <= ram_add_c[14] + 1;ram_add_c[15] <= ram_add_c[15] + 1;
						ram_add_c[16] <= ram_add_c[16] + 1;ram_add_c[17] <= ram_add_c[17] + 1;
						ram_add_c[18] <= ram_add_c[18] + 1;ram_add_c[19] <= ram_add_c[19] + 1;
						ram_add_c[20] <= ram_add_c[20] + 1;ram_add_c[21] <= ram_add_c[21] + 1;
						ram_add_c[22] <= ram_add_c[22] + 1;ram_add_c[23] <= ram_add_c[23] + 1;
						ram_add_c[24] <= ram_add_c[24] + 1;ram_add_c[25] <= ram_add_c[25] + 1;
						ram_add_c[26] <= ram_add_c[26] + 1;ram_add_c[27] <= ram_add_c[27] + 1;
						ram_add_c[28] <= ram_add_c[28] + 1;ram_add_c[29] <= ram_add_c[29] + 1;
						ram_add_c[30] <= ram_add_c[30] + 1;ram_add_c[31] <= ram_add_c[31] + 1;
							
					end
				end	
				
				end
				else
				begin
						state_fft_stall <= 0;
						f_command[0] <= {1'b1,1'b0,4'b0000};f_command[1] <= {1'b1,1'b0,4'b0000};
						f_command[2] <= {1'b1,1'b0,4'b0000};f_command[3] <= {1'b1,1'b0,4'b0000};
						
						f_command[4] <= {1'b1,1'b0,4'b0000};f_command[5] <= {1'b1,1'b0,4'b0000};
						f_command[6] <= {1'b1,1'b0,4'b0000};f_command[7] <= {1'b1,1'b0,4'b0000};
						f_command[8] <= {1'b1,1'b0,4'b0000};f_command[9] <= {1'b1,1'b0,4'b0000};
						
						f_command[10]<= {1'b1,1'b0,4'b0000};f_command[11]<= {1'b1,1'b0,4'b0000};
						f_command[12]<= {1'b1,1'b0,4'b0000};f_command[13]<= {1'b1,1'b0,4'b0000};
						f_command[14]<= {1'b1,1'b0,4'b0000};f_command[15]<= {1'b1,1'b0,4'b0000};
						f_command[16]<= {1'b1,1'b0,4'b0000};f_command[17]<= {1'b1,1'b0,4'b0000};
						
						f_command[18]<= {1'b1,1'b0,4'b0000};f_command[19]<= {1'b1,1'b0,4'b0000};
						f_command[20]<= {1'b1,1'b0,4'b0000};f_command[21]<= {1'b1,1'b0,4'b0000};
						f_command[22]<= {1'b1,1'b0,4'b0000};f_command[23]<= {1'b1,1'b0,4'b0000};
						f_command[24]<= {1'b1,1'b0,4'b0000};f_command[25]<= {1'b1,1'b0,4'b0000};
						f_command[26]<= {1'b1,1'b0,4'b0000};f_command[27]<= {1'b1,1'b0,4'b0000};
						f_command[28]<= {1'b1,1'b0,4'b0000};f_command[29]<= {1'b1,1'b0,4'b0000};
						f_command[30]<= {1'b1,1'b0,4'b0000};f_command[31]<= {1'b1,1'b0,4'b0000};
				end
			end
			CONTROLLER_STATE_TRANSPOSE:
			begin
				if(~done_transpose)
				begin
					do_transpose 		<= 1;
					transposer_reset	<= 0;
				end
				else
				begin
					transposer_reset	<= 1;
					do_transpose 		<= 0;
					controller_state <= CONTROLLER_STATE_FFT;
					resetting_counter 	<= 0;	//Added Theja May 6th
					readin			<= 0;	//Theja 20080901
				end
			end
			CONTROLLER_STATE_WRITE_OUT:
			begin


				if(master_counter==`MCNT_15+6)
				begin
					exts_TIP <= 1;
				end


				if((master_counter > `MCNT_16-1)&&(master_counter < `MCNT_18+1))
				begin
					if((master_counter-`MCNT_16)%`MCNT_17==0)
					begin
						resetting_counter 			<= resetting_counter + 1;
						f_command[resetting_counter] 		<= {1'b1,1'b0,4'b0000}	;//reset
						first_clock_cycle[resetting_counter] 	<= 1			;
						free_status[resetting_counter] 		<= 1			;
					end
				end

				if(free_status[reading_turn])
				begin
					if(first_clock_cycle[reading_turn])
					begin
						f_command[reading_turn] <= {1'b0,1'b1,4'b0001};
						ram_add_c[reading_turn] <= ram_add_c[reading_turn] + 1;
						first_clock_cycle[reading_turn] <= 0;
					end
					else if(free_status[reading_turn])
					begin
						free_status[reading_turn] <= 0;
					end
				end
				else if (((master_counter-`MCNT_10)%`MCNT_11==0)&&(master_counter < `MCNT_12))
				begin
					if(reading_turn==`NO_OF_UNITS-1)
					begin
						if(present_ram_row==`MAX_RAM_ROWS-1)
						begin
							readin 	<= -1;
													




		
						end
						else
						begin
							reading_turn <= reading_turn + 1;
							present_ram_row <= present_ram_row + 1;
						end
					end
					else	
					begin
						reading_turn <= reading_turn + 1;	
					end
				end
				else if((reading_turn==`NO_OF_UNITS-1) &&(master_counter >= `MCNT_12)&&(present_ram_row==`MAX_RAM_ROWS-1))
				begin
					if(readin == 4)
					begin
							new_start		<= 	 0;
							resetting_counter	<= 	 0;
							master_counter		<= 	 `MCNT_1-1;//Potential Multisource. Theja 20080927
							state_fft_stall 	<= 	 1;
							checking31		<=   	 1;
							readin			<=	 0;
							controller_state	<= CONTROLLER_STATE_FFT_W_RD;	
							//controller_state	<= CONTROLLER_STATE_FFT;	//ORIGINAL IS ABOVE THIS.. 29th Jan Theja
							rom_ram 		<=	 1;	//important to keep this 1. still rom to ram will not happen. check the value of master_counter here which is 68 hardcoded (to remove the counting of rom-to-ram copying).
							free_status 		<=	-1;
							first_clock_cycle 	<= 	-1;
							io2d_reset 		<= 	 1;
							io2d_wr_en 		<= 	 0;
							io2d_wr_cs 		<= 	 0;
							io2d_rd_cs      	<=	 0;
							io2d_rd_en      	<= 	 0;
							transposer_reset 	<=	 1;
							do_transpose 		<=	 0;
							do_bitreversing		<= 	 1;
							write_counter 		<=	 0;
							reading_turn 		<=	 0;
							exts_TIP 		<=	 0;
							exts_busy		<=	 0;
							present_ram_row		<=	 0;
			ram_add_c[0] <= 0; ram_add_c[1] <= 0; ram_add_c[2] <= 0;
			ram_add_c[3] <= 0; ram_add_c[4] <= 0; ram_add_c[5] <= 0;
			ram_add_c[6] <= 0; ram_add_c[7] <= 0; ram_add_c[8] <= 0; 
			ram_add_c[9] <= 0; ram_add_c[10]<= 0; ram_add_c[11]<= 0;
			ram_add_c[12]<= 0; ram_add_c[13]<= 0; ram_add_c[14]<= 0;
			ram_add_c[15]<= 0; ram_add_c[16]<= 0; ram_add_c[17]<= 0; 
			ram_add_c[18]<= 0; ram_add_c[19]<= 0; ram_add_c[20]<= 0;
			ram_add_c[21]<= 0; ram_add_c[22]<= 0; ram_add_c[23]<= 0; 
			ram_add_c[24]<= 0; ram_add_c[25]<= 0; ram_add_c[26]<= 0;
			ram_add_c[27]<= 0; ram_add_c[28]<= 0; ram_add_c[29]<= 0;
			ram_add_c[30]<= 0; ram_add_c[31]<= 0;
	
			f_command[0] <= {1'b1,1'b0,4'b0000};f_command[1] <= {1'b1,1'b0,4'b0000};f_command[2] <= {1'b1,1'b0,4'b0000};
			f_command[3] <= {1'b1,1'b0,4'b0000};f_command[4] <= {1'b1,1'b0,4'b0000};f_command[5] <= {1'b1,1'b0,4'b0000};
			f_command[6] <= {1'b1,1'b0,4'b0000};f_command[7] <= {1'b1,1'b0,4'b0000};f_command[8] <= {1'b1,1'b0,4'b0000};
			f_command[9] <= {1'b1,1'b0,4'b0000};f_command[10]<= {1'b1,1'b0,4'b0000};f_command[11]<= {1'b1,1'b0,4'b0000};
			f_command[12]<= {1'b1,1'b0,4'b0000};f_command[13]<= {1'b1,1'b0,4'b0000};f_command[14]<= {1'b1,1'b0,4'b0000};
			f_command[15]<= {1'b1,1'b0,4'b0000};f_command[16]<= {1'b1,1'b0,4'b0000};f_command[17]<= {1'b1,1'b0,4'b0000};
			f_command[18]<= {1'b1,1'b0,4'b0000};f_command[19]<= {1'b1,1'b0,4'b0000};f_command[20]<= {1'b1,1'b0,4'b0000};
			f_command[21]<= {1'b1,1'b0,4'b0000};f_command[22]<= {1'b1,1'b0,4'b0000};f_command[23]<= {1'b1,1'b0,4'b0000};
			f_command[24]<= {1'b1,1'b0,4'b0000};f_command[25]<= {1'b1,1'b0,4'b0000};f_command[26]<= {1'b1,1'b0,4'b0000};
			f_command[27]<= {1'b1,1'b0,4'b0000};f_command[28]<= {1'b1,1'b0,4'b0000};f_command[29]<= {1'b1,1'b0,4'b0000};
			f_command[30]<= {1'b1,1'b0,4'b0000};f_command[31]<= {1'b1,1'b0,4'b0000};

					end
					else
					begin
						readin <= readin + 1;
					end
				end
			end
			default: ;
		endcase
	end
end


endmodule



	

