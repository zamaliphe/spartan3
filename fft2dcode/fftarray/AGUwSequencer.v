`include "00defines.v"

/* Requires 00defines.v to work
*/

module AGUwSequencer(wBaseAdd,c_wSeq_start,pulse,reset);


input pulse			;	//clock pulse...at each pulse's positive edge, a new address of the twiddle factor is output
input reset			;	//synchronous reset pin
input c_wSeq_start		;	//control pin to start the address generation
output [`LOG_NBY2-1:0] wBaseAdd	;	//outputs address...this is only log(`NO_OF_POINTS/2) bits wide. `NO_OF_POINTSot all twiddle
					//factors till `NO_OF_POINTS need to be there to FFT. Only 0 to (`NO_OF_POINTS/2 -1) will do.
					//that is a total of `NO_OF_POINTS/2 factors will do.

wire pulse			;
wire reset			;
wire c_wSeq_start		;
reg [`LOG_NBY2-1:0] wBaseAdd	;

//internal variables
reg [`NO_BITS_LOG_N-1:0] stage	;
reg [`LOG_NBY2:0]    increment	;	//will vary from `NO_OF_POINTS/2 to `NO_OF_POINTS/`NO_OF_POINTS with a div  factor of 2 per stage
reg [`LOG_NBY2:0]   localCount	;	//will count the total iterations in 1 stage : `NO_OF_POINTS/2 (fixed)
reg start_flag			;	//when a start pulse is applied, this flag will be set 


always @( posedge pulse or posedge reset)
begin
	if(reset)
	begin
		wBaseAdd 	<= 0	;		//output is 0
		increment 	<= (`NO_OF_POINTS/2);	//initial value of increment
		stage 		<= 0	;		//index of the stage
		localCount 	<= -1	;		//counting from 0 to (`NO_OF_POINTS/2-1)
		start_flag 	<= 0	;		//start_flag reset to 0
	end
	else
	begin
		if(c_wSeq_start|start_flag)
		begin
			if(start_flag == 0)
			begin
				start_flag <= 1;
			end
			wBaseAdd <= wBaseAdd + increment[`LOG_NBY2-1:0]		;	//REPLACE BY ADDER(`LOG_NBY2)_(`LOG_NBY2)
			if(localCount == (`NO_OF_POINTS/2 -1) && stage!=`LOG_N)
			begin
				stage 		<= stage + 1;				//REPLACE BY ADDER(`NO_BITS_LOG_N)_1
				increment 	<= {1'b0,increment[`LOG_NBY2:1]};	//divide by 2
				localCount 	<= 0;	     
			end
			else
			begin
				localCount <= localCount + 1;				//REPLACE BY ADDER(`LOG_NBY2)_1
			end			
		end
	end
end
endmodule
