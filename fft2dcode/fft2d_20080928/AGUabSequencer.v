module AGUabSequencer(upper, lower,c_abSeq_start, pulse, reset);


//impressions:
//counter might be redundant data, can be fetched from upper modules as input
//start flag 1 bit is redundant. will mess up timing if removed.
//doing and done seem essential and cannot be removed.

//removed one, two, stage 
//save 2*6 bit regs and 3 bits reg : 15 bits per fft1d_unit


//LOCAL VARIABLES
//we have to generate '`LOG_N' bit addresses !

reg [`LOG_N-2:0] counter;	//counter to count through the butterflies every stage
					//maybe this counter can be given as an input
//temporary data:
reg [`LOG_N-1:0] doing		;
reg [`LOG_N-1:0] done		;
wire[`LOG_N:0]   counter_ext	;
reg 	   		start_flag	;
assign counter_ext = {1'b0, counter[`LOG_N-2:0], 1'b0};


output 		upper	;
output 		lower	;
input  		pulse	;
input  		reset	;
input c_abSeq_start	;
wire [`LOG_N-1:0] upper, lower;		//Caution : Outputs wired!!
wire pulse, reset,c_abSeq_start;


assign upper = (~done & ~doing & counter_ext[`LOG_N-1:0])
		| ( done & ~doing & {1'b0, counter} );

assign lower = upper | ( ~done & doing );
		

always @(posedge pulse or posedge reset)
begin

	if(reset)		//synchronous reset
	begin
		counter 	<= 0;
		doing 		<= 1;
		done		<= 0;
		start_flag 	<= 0;
	end
	else if(c_abSeq_start==1 && start_flag == 0)
	begin
		start_flag 	<= 1;
	end
	else if(start_flag == 1)
	begin
		counter 	<= counter + 1'b1;
		if(counter == `NO_OF_POINTS_BY2 - 1 )	//potential: constant register
		begin
			done  [`LOG_N-1:0] <= {done [`LOG_N-2:0], 1'b1};
			doing [`LOG_N-1:0] <= {doing[`LOG_N-2:0], 1'b0};
		end
	end
end

endmodule
