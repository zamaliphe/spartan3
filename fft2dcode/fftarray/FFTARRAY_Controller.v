/* Operation divided into 2 stages: 
stage0=idle.
Stage1=Rowwise 1D FFTs. 
Note: 32 instantiations are fixed. 
*/

`include "00defines.v"
`define nMCNT_1 646

module FFTARRAY_Controller(
extc_base_clock	,
extc_asyn_reset	,
exts_busy	,
//unit_1DFFTX()
f_unified_command
);

parameter STATE_MODE_WIDTH		= 2;
parameter CONTROLLER_STATE_IDLE	 	= 0;
parameter CONTROLLER_STATE_FFT	 	= 1;


//Input-output and type declarations
input  extc_base_clock	;
input  extc_asyn_reset	;
output exts_busy	;
//unit_1DFFTX()
output [`SEQUENCE_MODE_LENGTH+2-1:0]f_unified_command;

//Type Declarations
wire extc_base_clock	;
wire extc_asyn_reset	;
reg  exts_busy		;
//unit_1DFFTX()
reg [`SEQUENCE_MODE_LENGTH+2-1:0]f_unified_command;	



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
			exts_busy		<=	 0;
			f_unified_command <= {1'b1,1'b0,4'b0000};	
		
		end
		CONTROLLER_STATE_FFT:
		begin
			
			if (master_counter == `nMCNT_1)//HARDCODE
			begin
				master_counter 	<= 	 0;
				controller_state <= CONTROLLER_STATE_IDLE;
				exts_busy		<=	 0;
				f_unified_command <= {1'b1,1'b0,4'b0000};
			end
			else
			begin
				exts_busy		<=	 1;
				master_counter <= master_counter + 1;
				//Setting all the units to ONLY_FFT mode
				f_unified_command <= {1'b0,1'b1,4'b0010};
			end	
		end //closing this case.
		default: ;
	endcase
end


endmodule

