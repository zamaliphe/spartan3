/*
Has been Configured for 16*16 operation on 10th Feb 2008
Requires 00defines.v
Working FSM description is given at the end of this file
*/
`include "00defines.v"

module Butterfly(
xInput,
xClock,
xStart,
xReset,
xtriOutput,
c_output_tri
);


//impressions
// check whether register folding can be done.
// doingOperation 1b seems redundant
// count 4b seems redundant: similar to butterly_count in AGU generator: CHECK
// xOutput 16b seems essential : can it be folded?
// mpd 16b seems essential
// mpr 16b seems essential
// ar 16b seems redundant : can it be folded
// ai 16b seems redundant : can it be folded
// localReg 16b seems redundant; can it be folded?
// pr 32b seems redundant : can it be folded?
// pi 32b seems redundant : can it be folded



input xReset				;	//Control Input
input xClock				;	//system clock
input xStart				;	//control input
input c_output_tri			;	//control input for tristating
input [`BF_MULT_BITS-1:0] xInput	;	//All the RAM reads 
output [`BF_MULT_BITS-1:0] xtriOutput	;	//All the RAM writes

wire xReset				;
wire xClock				;
wire xStart				;
wire c_output_tri			;
wire [`BF_MULT_BITS-1:0] xInput		;
wire [`BF_MULT_BITS-1:0]xtriOutput	;	




//Local Variables (registers)
reg 				doingOperation	;	//flag to keep control on operation
reg  [`BF_COUNTERBITS-1:0] 	count		;	//count steps of 1 butterfly operation
reg  [`BF_MULT_BITS-1:0] 	xOutput		;	
reg  [`BF_MULT_BITS-1:0] 	mpd		;	
reg  [`BF_MULT_BITS-1:0] 	mpr		;	
reg  [`BF_MULT_BITS-1:0] 	ar,ai,localReg	;	
reg  [`BF_MULT_BITS+`BF_MULT_BITS-1:0]pr,pi	;	
wire [`BF_MULT_BITS+`BF_MULT_BITS-1:0] mResult  ; 	

//Instantiations
Butterfly_Mult m001(mpd,mpr,mResult)		;

//Assignments
assign xtriOutput = (c_output_tri)?`BF_MULT_BITS'bz:xOutput;	

always@(posedge xClock)
begin
	if(xReset)
	begin
		count 		<= 0	;
		ar 		<= 0	; 
		ai 		<= 0	;
		mpr		<= 0	;
		mpd		<= 0	;
		localReg 	<= 0	;
		pr 		<= 0	;
		pi 		<= 0	;
		doingOperation 	<= 0	;
	end
	else if(xStart|doingOperation)
	begin
		if(~doingOperation)
		begin
			doingOperation <= 1;
		end
			
		case(count)
			0:
			begin
				mpd 	 <= xInput	;	//br -> mpd 
				localReg <= xInput	;	//br -> tempM
				xOutput  <= localReg	;	//write r2i
				count <= count+1	;
			end
			1:
			begin
				mpr <= xInput		;	//This is wr	
								//Multiplier is combinatorial. 
								//So expect to clock
								//output of mult (br*wr) 
				count <= count+1	;
			end
			2:
			begin
				mpd <= xInput		;	//bi -> mpd
								//Multiplier input has changed, hence output(bi*wr) to be
								//"regged" in the next count
				pr  <= mResult		;	//copy mult output (br*wr) to pr..
								//its important to be non-blocking
				count <= count+1	;	
			end
			3:
			begin
				mpr <= xInput		;	//this is wi, multipier i/p has changed again
								//next bi*wi will be "regged"
				pi  <= mResult		;	//bi*wr is stored in pi
				count <= count+1	;
			end
			4:
			begin
				ar  <= xInput		;	//reading ar 
				mpd <= localReg		;
								//change mult input to br, again br*wi
								//Will be regged next 
				pr  <= pr - mResult	;	//doing br*wr - bi*wi (bi*wi not regged actually)
								//REPLACE BY ADDER32_32
				count <= count+1	;
			end
			5:
			begin
				ai <= xInput		;	//reading ai
				pi <= pi + mResult	;	//doing bi*wr(previously in pi) + br*wi(nResult)
								//REPLACE BY ADDER32_32
				xOutput     <={ar[`BF_MULT_BITS-1],ar[`BF_MULT_BITS-1:1]} + {pr[`BF_MULT_BITS+`BF_MULT_BITS-1-1],pr[`BF_MULT_BITS+`BF_MULT_BITS-1-1:`BF_MULT_BITS]};			  //doing right shift for divide by 2. REPLACE BY ADDER16_16
				count <= count+1	;
			end
			6:
			begin
				xOutput     <={ai[`BF_MULT_BITS-1],ai[`BF_MULT_BITS-1:1]} + {pi[`BF_MULT_BITS+`BF_MULT_BITS-1-1],pi[`BF_MULT_BITS+`BF_MULT_BITS-1-1:`BF_MULT_BITS]};			  //REPLACE BY ADDER16_16
				localReg    <={ar[`BF_MULT_BITS-1],ar[`BF_MULT_BITS-1:1]} - {pr[`BF_MULT_BITS+`BF_MULT_BITS-1-1],pr[`BF_MULT_BITS+`BF_MULT_BITS-1-1:`BF_MULT_BITS]};
								//This is because 2nd term is already div by 2.
								//REPLACE BY ADDER16_16
				count <= count+1	;
			end
			7:
			begin
				localReg <= 	{ai[`BF_MULT_BITS-1],ai[`BF_MULT_BITS-1:1]} - {pi[`BF_MULT_BITS+`BF_MULT_BITS-1-1],pi[`BF_MULT_BITS+`BF_MULT_BITS-1-1:`BF_MULT_BITS]};
								//This is because 2nd term is already div by 2.
								//REPLACE BY ADDER16_16
				xOutput	 <=	localReg;	//r2r
				count 	 <=	0	;	//reinit
			end
			default: 			;	//do nothing
		endcase
	end


end

endmodule

/*
WORKING:				//Revised on 10th feb 2008

i = iota;
A = complex(ar,ai); 			//(16bits, 16 bits)
B = complex(br,bi); 			//(16bits, 16 bits)
W = complex(wr,wi); 			//(16bits, 16 bits)
also
pr = br*wr - bi*wi;			//intermediate 32 bit 
pi = br*wi + bi*wr;			//intermediate 32 bit
P = B*W = complex(pr,pi); 		//intermediate (32 bits, 32 bits)

finally
Result1 = A+B*W = A+P = complex(ar+pr,ai+pi);	//32bits each
Result2 = A-B*W = A-P = complex(ar-pr,ai-pi);	//32bits each

 8 clock cycles.
CLK	IN	OUT
0.	br	r2i
1.	wr
2.	bi
3.	wi
4.	ar
5.	ai	r1r
6.		r1i
7.		r2r
*/
