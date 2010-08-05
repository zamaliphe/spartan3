`include "00defines.v"

module AGU(readAddress,controlPulse,c_agu_start,reset,outputEnable,writeAddress,c_mode,xOpCount,x_we_ram);

//impressions:
//x_we_ram seems redundant
//generatedAddress seems essential
//generatedAddress2 seems essential
//add_count_per_butterfly seems essential
//opCount seems essential
//offset seems essential
//start_flag seems redundant
//first_cycle seems redundant
//previousLower seems essential
//previousUpper seems essential
//odd_flag seems redundant


input controlPulse;     //clock
input c_agu_start;      //an initiator pulse CAUTION: its a wire!  
input reset;            //to make the AGU unit reinitiate...required when new set of
input outputEnable;     //tristating to leave control of ram add. bus 
input [`AGU_MODE_WIDTH-1:0] c_mode;
output [`FFT_AGU_ADD_WIDTH-1:0] readAddress;
output [`FFT_AGU_ADD_WIDTH-1:0] writeAddress;
output [`LOG_N-1:0] 		xOpCount;	//Counter: 0 to (`NO_OF_POINTS/2)-1 operations per stage
output x_we_ram;


 
wire controlPulse;      // not common to the internal sub-cores
wire c_agu_start;       //initiator its posedge is important
wire reset;             //common to the internal sub-cores too
wire outputEnable;      //contol input signal for tristating
wire [`AGU_MODE_WIDTH-1:0] c_mode;
wire [`FFT_AGU_ADD_WIDTH-1:0] readAddress;//tristated output CAUTION: OUTPUT TRISTATED!
wire [`FFT_AGU_ADD_WIDTH-1:0] writeAddress;//tristated output CAUTION: OUTPUT TRISTATED!
wire [`LOG_N-1:0] xOpCount; 
reg x_we_ram;

//Local registers
reg  [`FFT_AGU_ADD_WIDTH-1:0] generatedAddress;//offsetted address RAM for reading/writing
reg  [`FFT_AGU_ADD_WIDTH-1:0] generatedAddress2;//offsetted address RAM for reading/writing
wire [`AGU_AB_ADD_WIDTH-1:0] upperAddress;   //output of the AGU core to be offsetted 
wire [`AGU_AB_ADD_WIDTH-1:0] lowerAddress;   //output of the AGU core to be offsetted 
wire [`AGU_W_ADD_WIDTH-1:0]  wBaseAddress;   //output of WSEQ core to be offsetted
reg  [2:0] 		add_count_per_butterfly;//6 reads for one Butter. Operation
reg  [`LOG_N-1:0] opCount;	//Counter: 0 to (`NO_OF_POINTS/2)-1 operations per stage
					//IS used in case `AGU_MODE_OP_RAM as a general counter
reg  [`FFT_AGU_ADD_WIDTH-1:0]  offset;//Gives (a,b)address offset
reg  start_flag;			//internal flag to keep module in progress
wire c_abSeq_start;			//start control i/p to abSequencer
wire c_wSeq_start;			//start control i/p to wSequencer
wire pulseToSubCores2;			//common clock to the sub-cores
reg  first_cycle;
reg  [`AGU_AB_ADD_WIDTH-1:0] previousLower;
reg  [`AGU_AB_ADD_WIDTH-1:0] previousUpper;
reg  odd_flag			;	


//INSTANTIATIONS 
AGUabSequencer abSeq01(upperAddress, lowerAddress,c_abSeq_start   , pulseToSubCores2,(c_mode!=`AGU_MODE_BF_RAM));
AGUwSequencer  wSeq01 (wBaseAddress, c_wSeq_start,pulseToSubCores2,(c_mode!=`AGU_MODE_BF_RAM));


assign readAddress = generatedAddress					;
assign writeAddress = (outputEnable==1'b1)?generatedAddress2:`FFT_AGU_ADD_WIDTH'bz;
assign c_wSeq_start  = c_agu_start;	//start pulse to internal instantiated sub-cores
assign c_abSeq_start = c_agu_start;
assign pulseToSubCores2 =(add_count_per_butterfly==7)&(~reset);
assign xOpCount = opCount;

always @ (posedge controlPulse)
begin
	if(reset)
	begin
		generatedAddress	<= 0;
		generatedAddress2	<= 0;
		add_count_per_butterfly <= 7; //hardcoded.
		opCount			<= 0;
		offset       <= 2*`NO_OF_POINTS;	//Different from FFT1D Design. Theja 20080928
		start_flag 		<= 0;
		first_cycle 		<= 1;
		previousLower		<= 0;
		previousUpper		<= 0;
		x_we_ram 		<= 0;
		odd_flag 		<= 0;
	end

	else if(c_agu_start|start_flag)
	begin	
		if(c_agu_start) start_flag <= 1;
		
	case (c_mode)
		`AGU_MODE_OP_RAM:
		begin
			if(first_cycle)
			begin
				generatedAddress2 	<=	offset;
				first_cycle 		<=	0;
				opCount 		<=	0;
				odd_flag 		<=	1;
			end
			else
			begin				
				opCount <= (odd_flag==1)? opCount + 1:opCount;	//REPLACE BY ADDER
				//BITREVERSING BEING DONE HERE: HARDCODED
				//generatedAddress2 <= INITIAL_INPUT_WRITE_LOC + {`AGU_ADD_APPEND'b0,opCount[5],opCount[4],opCount[3],opCount[2],opCount[1],opCount[0],odd_flag};	//DEBUGGING ONLY.. FFT WILL NOT WORK WITH THIS
				generatedAddress2 <= offset + {`AGU_ADD_APPEND'b0,opCount[0],opCount[1],opCount[2],opCount[3],opCount[4],opCount[5],odd_flag};
							//REPLACE BY ADDER
				odd_flag <= ~odd_flag;
			end
		end
		
		`AGU_MODE_ROM_RAM:	//Join only last 8 bits of the address line to the rom address line
		begin
			if(first_cycle)
			begin
				generatedAddress <= 0;	//rom's (source) address location
				generatedAddress2 <= 0;	//ram's (destination) address location
				first_cycle <= 0;
				opCount <= 0;
			end
			else
			begin
				generatedAddress <= generatedAddress   + 1;	//REPLACE BY ADDER
				generatedAddress2 <= generatedAddress2 + 1;	//No terminating logic...see controller
										//REPLACE BY ADDER	
			end
		end		

		`AGU_MODE_BF_RAM:
		begin
			add_count_per_butterfly <= add_count_per_butterfly+1'b1;//will run through values from 0 to 7
										//REPLACE BY ADDER		
				
			case(add_count_per_butterfly)
			7:
			begin	//read add of br to be passed and write address of r1i to be passed
				generatedAddress <= offset + {`AGU_ADD_APPEND'b0,lowerAddress,1'b0};
				generatedAddress2 <= offset + {`AGU_ADD_APPEND'b0,previousUpper,1'b1};
				//add of r1i is obtained from upper
				previousUpper <= upperAddress;		      //this is a remedy for stage switching overlap
			end
			0:
			begin	//wr to be passed and r2r add to be passed
				generatedAddress <= {`AGU_WADD_APPEND'b0,wBaseAddress,1'b0};//REPLACE BY ADDER
				generatedAddress2 <= offset + {`AGU_ADD_APPEND'b0,previousLower,1'b0};
				//add of r2r is from lower,0	//REPLACE BY ADDER
			end
			1:
			begin	//bi to be passed and r2i add to be passed
			
				generatedAddress <= offset + {`AGU_ADD_APPEND'b0,lowerAddress,1'b1};
				previousLower <= lowerAddress;
				generatedAddress2 <= offset + {`AGU_ADD_APPEND'b0,previousLower,1'b1};
				x_we_ram <= 0;	//seems to be out of tune, but is not....is input to controller.. handle with care
			
			end
			2:
			begin	//wi to be passed
				generatedAddress <= {`AGU_WADD_APPEND'b0,wBaseAddress,1'b1};//REPLACE BY ADDER
			end
			3:
			begin	//ar to be passed 
				generatedAddress <= offset + {`AGU_ADD_APPEND'b0,upperAddress,1'b0};
			end
			4: 
			begin	//ai to be passed
				generatedAddress <= offset + {`AGU_ADD_APPEND'b0,upperAddress,1'b1};
			end
			5:	//set x_we_ram..which will be set after one delay ultimately..
			begin
				x_we_ram <= 1;
				previousUpper <= upperAddress;	
			end
			6:	//pass r1r address
			begin
				generatedAddress2 <= offset + {`AGU_ADD_APPEND'b0,previousUpper,1'b0}; 
				//add of r1r is being applied.	REPLACE BY ADDER


				if(opCount==`NO_OF_POINTS/2-1) begin	//One stage computations over 
					opCount <= 0;
				end
				else begin
					opCount <= opCount + 1'b1;	//REPLACE BY ADDER
				end
	
			end
			default:	;				
			endcase
		end
		
		`AGU_MODE_RAM_OP:	
		begin
			if(first_cycle)
			begin
				generatedAddress <= offset;//read final outputs from these locations
				first_cycle <= 0;
				opCount <= 0;	//theja.20080914
			end
			else
			begin
				generatedAddress <= generatedAddress+1;	//No terminating logic...see controller
									//REPLACE BY ADDER
				opCount <= opCount + 1'b1; //theja.20080914

			end
		end

		default: 	;
	endcase

	end
end

endmodule








/*Logic: 
Depending on the mode, this will generate the addresses accordingly
`AGU_MODE_OP_RAM
	The contents floated by the IO module will be written to address locations
	256d to 767d (512 writes). Hence these addresses need to be generated.
	Will be generated in the writeAddress bus.
`AGU_MODE_ROM_RAM
	The contents of the ROM will be copied to the RAM. Hence proper address pairs for (ROM,RAM)
	need to be generated.
`AGU_MODE_BF_RAM
	1.This will generate read addresses for inputs to the butterfly
	in the followin sequence
		br
		wr
		bi
		wi
		ar
		ai
	at each controlPulse.
*/

