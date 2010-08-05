`include "00defines.v"

`define CONTROLLER_STATE_WIDTH   2
module Controller(
//FFT2D_Controller
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
exts_busy,
exts_TIP,
counter,
//input to the controller : From the external World
extc_fft_cs,
extc_data_2_fftchip,	//This contol starts the fft process on the whole..input->compute->output
extc_asyn_reset,
extc_base_clock
);

//Parameters
parameter IDLE 			= 0,
	  READ_INPUTS 		= 1,
	  BUTTERFLY_OPS 	= 2,
	  WRITE_RESULTS		= 3; 

//FFT2D_Controller
input [`SEQUENCE_MODE_LENGTH-1:0] sequence; 
output [`AGU_MODE_WIDTH+1-1:0] mode_termination;
//AGU
output agu_clock;
output agu_start;
output agu_reset;
output agu_oe;
output [`AGU_MODE_WIDTH-1:0] agu_mode;
input x_we_ram;
//Butterfly
output butter_clock;
output butter_start;
output butter_reset;
output butter_o_tri;
//RAM
output ram_clk;
output ram_cs_0;
output ram_we_0;
output ram_oe_0;
output ram_cs_1;
output ram_we_1;
output ram_oe_1;
//ROM
output rom_re;
output rom_cs;
output rom_tri;
//IO
output io_tri_outgoing_line;
output io_tri_incoming_line;
output io_cs;
output io_ext_write;
output io_clock;
output io_reset;
//output of the controller : To the External World
output exts_busy;
output exts_TIP;		//TIP: Transfer in progress for reading as well as writing from ext. world
output counter;
//input to the controller : From the external World
input extc_fft_cs;
input extc_data_2_fftchip;	//This contol starts the fft process on the whole..input->compute->output
input extc_asyn_reset;
input extc_base_clock;



//type declarations reg/wire
wire [`SEQUENCE_MODE_LENGTH-1:0] sequence; 
wire [`AGU_MODE_WIDTH+1-1:0] mode_termination;
wire agu_clock;				//op wired :CLK
reg agu_start;
reg agu_reset;
reg agu_oe;
wire x_we_ram;
reg [`AGU_MODE_WIDTH-1:0] agu_mode;
//Butterfly
wire butter_clock;			//op wired :CLK
reg butter_start;
reg butter_reset;
reg butter_o_tri;
//RAM
wire ram_clk;
reg ram_cs_0;
reg ram_we_0;
reg ram_oe_0;
reg ram_cs_1;
reg ram_we_1;
reg ram_oe_1;
//ROM
reg rom_re;
reg rom_cs;
reg rom_tri;
//IO
reg io_tri_outgoing_line;
reg io_tri_incoming_line;
reg io_cs;
reg io_ext_write;
wire io_clock;				//op wired :CLK
reg io_reset;
//output of the controller : To the External World
reg exts_busy;
reg exts_TIP;		//TIP: Transfer in progress for reading as well as writing from ext. world
reg [`LOG_N + 2-1:0] counter;
//input to the controller : From the external World
wire extc_fft_cs;
wire extc_data_2_fftchip;	//This contol starts the fft process on the whole..input->compute->output
wire extc_asyn_reset;
wire extc_base_clock;

//Instantiations: None

//internal wires and registers
reg [`CONTROLLER_STATE_WIDTH-1:0] state;
reg [`NO_BITS_LOG_N-1:0] stage;

reg first_cycle;
reg termination;
reg [`AGU_MODE_WIDTH-1:0]prev_agu_mode;


//assignments
assign agu_clock 	= extc_base_clock;
assign butter_clock 	= extc_base_clock;
assign ram_clk 		= extc_base_clock;
assign io_clock 	= extc_base_clock;
assign mode_termination = {prev_agu_mode,termination};

//Logic
always @ (posedge extc_base_clock or posedge extc_asyn_reset)	
begin
	if(extc_asyn_reset)
	begin
		state <= IDLE;
		//agu
		agu_start 			<= 0	;
		agu_reset 			<= 1	;	//reset ON
		agu_oe 				<= 0	;

		//butterfly 
		butter_start 			<= 0	;
		butter_reset 			<= 1	; 	//reset ON
		butter_o_tri 			<= 1	;
		//ram
		ram_cs_0 			<= 0	;
		ram_we_0 			<= 0	;	//assuming static read port
		ram_oe_0 			<= 0	;
		ram_cs_1 			<= 0	;
		ram_we_1 			<= 1	;	//assuming statc write port
		ram_oe_1 			<= 0	;
		//rom
		rom_re  			<= 0	;
		rom_cs  			<= 0	;
		rom_tri 			<= 1	;	//tristate ON
		//IO	
		io_tri_outgoing_line 		<= 1	;	//tristate ON
		io_tri_incoming_line 		<= 1	;	//tristate ON
		io_cs 				<= 0	;	
		io_ext_write 			<= 0	;	//initially false
		io_reset 			<= 1	;	//reset ON
		//external outputs	
		exts_busy 			<= 0	;
		exts_TIP 			<= 0	;
		counter 			<= 0	;
		first_cycle 			<= 1	;
		stage 				<= 0	;
		termination 			<= 0	;
	end
	else
	begin
		prev_agu_mode <= agu_mode;
		case(state)
			IDLE:	//initial conditions will be set
			begin
				//agu
				agu_start 			<= 0	;
				agu_reset 			<= 1	;	//reset ON
				agu_oe 				<= 0	;
				if(extc_fft_cs)
				begin
					if(sequence[3]==1'b1)
					begin
						agu_mode <= `AGU_MODE_OP_RAM;
						state <= READ_INPUTS;
					end
					else if(sequence[3:2]==2'b01)
					begin
						agu_mode <= `AGU_MODE_ROM_RAM;
						state <= READ_INPUTS;
					end
					else if(sequence[3:1]==3'b001)
					begin
						agu_mode <= `AGU_MODE_BF_RAM;
						state <= BUTTERFLY_OPS;
					end
					else if(sequence==4'b0001)
					begin 
						agu_mode <= `AGU_MODE_RAM_OP;
						state <= WRITE_RESULTS;
					end
					else
					begin 
						state <= IDLE;
					end
				end
				//butterfly 
				butter_start 			<= 0	;
				butter_reset 			<= 1	; 	//reset ON
				butter_o_tri 			<= 1	;
				//ram
				ram_cs_0 			<= 0	;
				ram_we_0 			<= 0	;	//assuming static read port
				ram_oe_0 			<= 0	;
				ram_cs_1 			<= 0	;
				ram_we_1 			<= 1	;	//assuming statc write port
				ram_oe_1 			<= 0	;
				//rom
				rom_re  			<= 0	;
				rom_cs  			<= 0	;
				rom_tri 			<= 1	;	//tristate ON
				//IO	
				io_tri_outgoing_line 		<= 1	;	//tristate ON
				io_tri_incoming_line 		<= 1	;	//tristate ON
				io_cs 				<= 0	;	
				io_ext_write 			<= 0	;	//initially false
				io_reset 			<= 1	;	//reset ON
				//external outputs	
				exts_busy 			<= 0	;
				exts_TIP 			<= 0	;
				counter 			<= 0	;
				first_cycle 			<= 1	;
				stage 				<= 0	;
				termination 			<= 0	;
			end
										//1cycle			
			READ_INPUTS:						//involves external data, rom data copying.
			begin
			//Phase 1: Output to RAM	
				if(extc_data_2_fftchip&(agu_mode==`AGU_MODE_OP_RAM))
				begin
					if(first_cycle)
					begin
						first_cycle <= 0;
						agu_start <= 1;
						agu_reset <= 0;//IS SYNCHRONOUS
						agu_oe 	  <= 1;
						//ram_cs_1 <= 1;//right side port  for writing data into it.
						ram_we_1 <= 1;
						rom_tri <= 1;
						io_tri_incoming_line <= 0;
						io_cs <= 1;
						io_reset <= 0;
						exts_TIP <= 1;
						exts_busy <= 1;
						counter <= counter + 1;
						termination <= 0;
					end
					else
					begin
						if(counter == `NO_OF_POINTS*2+1)
						begin
							//stopping logic
							agu_start <= 0;
							agu_reset <= 1;
							agu_oe <= 0;
							case(sequence[2])	//xilinx 20080312
								1'b1:			//xilinx 20080312
								begin
									agu_mode <= `AGU_MODE_ROM_RAM;
								end
								default:
								begin 
									agu_mode <= `AGU_MODE_BF_RAM;
									state <= BUTTERFLY_OPS;
								end
							endcase	
							ram_cs_1 <= 0;
							ram_we_1 <= 0;	
							rom_tri  <= 1;
							io_tri_incoming_line <= 1;
							io_cs <= 0;
							io_reset <= 1;
							first_cycle <= 1;
							counter <= 0;
							exts_TIP <= 0;
							//termination <= 1;	
						end
						else
						begin
							counter <= counter + 1;
							if(counter == `NO_OF_POINTS*2+1 - 6)	//-6 because seen in the waveform that way
							begin
								termination <= 1;
							end
							ram_cs_1 <= 1;
						end
					end	
				end
//513 cycles
			//Phase 2:ROM to RAM copying
				else if(agu_mode == `AGU_MODE_ROM_RAM)
				begin
					if(first_cycle)
					begin
						agu_start <= 1;
						agu_reset <= 0;
						agu_oe <= 1;
						ram_cs_1 <= 1;
						ram_we_1 <= 1;
						rom_re <= 1;
						rom_cs <= 1;
						rom_tri <= 0;
						io_tri_incoming_line <= 1;
						butter_o_tri <= 1;
						first_cycle <= 0;
						counter <= counter + 1;
						termination <= 0;
					end
					else
					begin
						if(counter == `NO_OF_POINTS+1)	
						begin
							agu_start <= 0;
							agu_reset <= 1;
							agu_oe <= 0;
							ram_cs_1 <= 0;
							ram_we_1 <= 0;
							rom_re <= 0;
							rom_cs <= 0;
							rom_tri <= 1;
							first_cycle <= 1;
							counter <= 0;
							//termination <= 1;
							case(sequence[1])//xilinx 20080312
								1'b1:		//xilinx 20080312
								begin
									agu_mode <= `AGU_MODE_BF_RAM;
									state <= BUTTERFLY_OPS;
								end
								default:
								begin 
									agu_mode <= `AGU_MODE_OP_RAM;
									state <= IDLE;															  end
							endcase
						end
						else
						begin
							counter <= counter + 1;
							if(counter == `NO_OF_POINTS)
							begin
								termination <= 1;
							end
						end
					end
				end
			end

//258 cycles			
			BUTTERFLY_OPS:
			begin
				if(stage < `LOG_N) //cycles \\: 8*inner
				begin
					//accounting for delay to start wSeq and abSeq
					if(first_cycle)
					begin
						termination <= 0;
						if(counter == 1)	
						begin
							agu_reset <= 0;
							agu_start <= 1;
							agu_oe <= 1;
							ram_cs_0 <= 1;
							ram_oe_0 <= 1;
							ram_we_0 <= 0;		
							ram_cs_1 <= 1;
							ram_we_1 <= 0;//A crucial Thing to do..29th Sept
							ram_oe_1 <= 0;
							counter <= counter + 1;
						end
						else if(counter == 3)
						begin
							butter_start <= 1;
							butter_reset <= 0;
							butter_o_tri <= 0;
							first_cycle <= 0;
							counter <= 0;
						end
						else
						begin
							counter <= counter + 1;
						end
					end
					else
					begin
						ram_we_1 <= x_we_ram;	//Added By Theja on 29th of September

						if(counter == `NO_OF_POINTS*4 -1 )
						begin
							counter <= 0;	//Since counter is not incremented in the first_cycle_case unlike in the previous two macro-cases
							stage <= stage + 1;
						end
						else
						begin
							counter <= counter + 1;	
						end
					end
				end
				else
				begin
					//stopping butterfly operations
					agu_start <= 0;
					agu_reset <= 1;
					agu_oe <= 0;
					butter_start <= 0;
					butter_reset <= 1;
					butter_o_tri <= 1;
					ram_cs_0 <= 0;
					ram_oe_0 <= 0;
					ram_cs_1 <= 0;
					ram_we_1 <= 0;
					counter <= 0;
					first_cycle <= 1;
					termination <= 1;
					case(sequence)
						4'bxxx1:
						begin
							agu_mode <= `AGU_MODE_RAM_OP;
							state <= WRITE_RESULTS;
						end
						default:
						begin 
							agu_mode <= `AGU_MODE_OP_RAM;
							state <= IDLE;
						end
					endcase	
				end		
			end
//cycles: 4(counter vals=1,2,3,0) + 1024*8 + 1 = 8197
			WRITE_RESULTS:
			begin
				if(agu_mode==`AGU_MODE_RAM_OP)
				begin
					if(first_cycle)
					begin
						agu_start <= 1;
						agu_reset <= 0;//IS SYNCHRONOUS
						agu_oe 	  <= 1;
						ram_cs_0 <= 1;//right side port  for writing data into it.
						ram_oe_0 <= 1;
						rom_tri <= 1;
						io_cs <= 1;
						io_reset <= 0;
						exts_TIP <= 1;
						exts_busy <= 1;
						counter <= counter + 1;
						termination <= 0;
						if(counter==1)
						begin
							first_cycle <= 0;
						end
					end
					else
					begin
						if(counter == `NO_OF_POINTS*2+3)//3 to 514 have been counted
						begin
							//stopping logic
							agu_start <= 0;
							agu_reset <= 1;
							agu_oe <= 0;
							ram_cs_0 <= 0;
							ram_oe_0 <= 0;	
							io_tri_outgoing_line <= 1;
							io_cs <= 0;
							io_ext_write <= 0;
							io_reset <= 1;
							first_cycle <= 1;
							counter <= 0;
							exts_TIP <= 0;
							exts_busy <= 0;
							state <= IDLE;
							termination <= 1;
						end
						else
						begin
							io_ext_write <= 1;
							io_tri_outgoing_line <= 0;
							counter <= counter + 1;
							//if(counter == `NO_OF_POINTS*2+1 - 1)	//-2 because seen in the waveform that way
							//begin
							//	termination <= 1;
							//end
						end
					end	
				end
//cycles; 515
			end

			default: ;
		endcase
	end
end
endmodule
