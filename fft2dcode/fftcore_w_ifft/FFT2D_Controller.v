/* Operation divided into 4 stages: 
stage0=idle.
Stage1=Rowwise 1D FFTs. 
Stage2=Transpose. 
Stage3=Rowwise 1D FFTs.

Note: 32 instantiations are fixed. 
*/

`include "00defines.v"
`define nMCNT_1 1542

module FFT2D_Controller(
extc_base_clock	,
extc_asyn_reset	,
exts_busy	,
//unit_1DFFTX()
f_unified_command,	
//RAMXAddbits()
present_ram_row,
transposer_reset,	
do_transpose	,
do_bitreversing	,
done_transpose		
);

parameter STATE_MODE_WIDTH		= 2;
parameter CONTROLLER_STATE_IDLE	 	= 0;
parameter CONTROLLER_STATE_FFT	 	= 1;
parameter CONTROLLER_STATE_TRANSPOSE 	= 2;
parameter CONTROLLER_STATE_FFT_2 	= 3;


//Input-output and type declarations
input  extc_base_clock	;
input  extc_asyn_reset	;
output exts_busy	;
//unit_1DFFTX()
output [`SEQUENCE_MODE_LENGTH+2-1:0]f_unified_command;
//RAMXAddbits()
output [`LOG_M_R_R-1:0] present_ram_row;
//Transposer
output transposer_reset	;
output do_transpose	;
output do_bitreversing	;
input  done_transpose	;

//Type Declarations
wire extc_base_clock	;
wire extc_asyn_reset	;
reg  exts_busy		;
//unit_1DFFTX()
reg [`SEQUENCE_MODE_LENGTH+2-1:0]f_unified_command;
//RAMXAddbits()
reg [`LOG_M_R_R-1:0] present_ram_row;
//Transposer
reg  transposer_reset	;
reg  do_transpose	;
reg  do_bitreversing	;
wire done_transpose	;	



//Internal Wires and Registers

reg [STATE_MODE_WIDTH-1:0] controller_state	;
reg [15:0] master_counter;


//Logic
always @ (posedge extc_base_clock or posedge extc_asyn_reset)
begin
	if(extc_asyn_reset==1'b1)
	begin
		controller_state	<= CONTROLLER_STATE_IDLE;
	end
	else
	begin
		if(controller_state == CONTROLLER_STATE_IDLE)
		begin
			controller_state 	<= CONTROLLER_STATE_FFT;
		end
	end

	case(controller_state)
		CONTROLLER_STATE_IDLE:
		begin
			master_counter		<= 	 0;
			transposer_reset 	<=	 1;
			do_transpose 		<=	 0;
			exts_busy		<=	 0;
			do_bitreversing		<= 	 1;
			present_ram_row		<=	 0;
			f_unified_command <= {1'b1,1'b0,4'b0000};	
		
		end
		CONTROLLER_STATE_FFT,CONTROLLER_STATE_FFT_2:
		begin
			exts_busy		<=	 1;
			if (master_counter == `nMCNT_1)//HARDCODE
			begin
				master_counter 	<= 	 0;
				if(present_ram_row == `MAX_RAM_ROWS -1)
				begin
					if(controller_state == CONTROLLER_STATE_FFT)
					begin
						controller_state <= CONTROLLER_STATE_TRANSPOSE;
						//controller_state <= CONTROLLER_STATE_IDLE;
					end
					else
					begin
						controller_state <= CONTROLLER_STATE_IDLE;
					end
				end
				present_ram_row <= present_ram_row + 1;
				f_unified_command <= {1'b1,1'b0,4'b0000};
			end
			else
			begin
				master_counter <= master_counter + 1;
				//Setting all the units to ONLY_FFT mode
				f_unified_command <= {1'b0,1'b1,4'b0010};
			end	
		end //closing this case.
		CONTROLLER_STATE_TRANSPOSE:
		begin
			exts_busy			<= 1;
			if(~done_transpose)
			begin
				do_transpose 		<= 1;
				transposer_reset	<= 0;
			end
			else
			begin
				transposer_reset	<= 1;
				do_transpose 		<= 0;
				controller_state <= CONTROLLER_STATE_FFT_2;
			end
		end
		default: ;
	endcase
end


endmodule

