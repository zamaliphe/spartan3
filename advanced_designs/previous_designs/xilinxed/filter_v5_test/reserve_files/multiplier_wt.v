`include "00defines.v"

module multiplier(
xMultiplicand,
xMultiplier,
xProductMSB
);

output [`BF_MULT_BITS-1:0] xProductMSB;	//for 16*16 this is 32 bits
input  [`BF_MULT_BITS-1:0] xMultiplicand	 ;	//M bits
input  [`BF_MULT_BITS-1:0] xMultiplier		 ;	//M bits

wire [`BF_MULT_BITS-1:0] xProductMSB  ;	//output
wire [`BF_MULT_BITS-1:0] xMultiplier		 ;	//input2
wire [`BF_MULT_BITS-1:0] xMultiplicand		 ;	//input1 

//Local wires
wire [`BF_MULT_BITS+`BF_MULT_BITS-1:0] xProduct;	//for 16*16 this is 32 bits
wire carry_md,carry_mr,carry_tp1,carry_tp2		;
wire [`BF_MULT_BITS-1:0] claResult_md,claResult_mr	;
wire [`BF_MULT_BITS-1:0] feedWallace_md,feedWallace_mr	; 
wire [`BF_MULT_BITS+`BF_MULT_BITS-1:0] claResult_tp	;
wire [`BF_MULT_BITS+`BF_MULT_BITS-1:0] tempProduct	;


assign xProductMSB = xProduct[`BF_MULT_BITS+`BF_MULT_BITS-1:`BF_MULT_BITS];
//Decideing on which to send to wallace multiplier
assign feedWallace_mr = (xMultiplier[`BF_MULT_BITS-1]==1'b1)?  claResult_mr:  xMultiplier	 ;
assign feedWallace_md = (xMultiplicand[`BF_MULT_BITS-1]==1'b1)?claResult_md:xMultiplicand	 ;

//Getting 2's complement of the essential numbers
Butterfly_Mult_CLA16 cla_md00(1'b1,~xMultiplicand,16'b0,claResult_md,carry_md)			 ;
Butterfly_Mult_CLA16 cla_mr00(1'b1,~xMultiplier,16'b0,claResult_mr,  carry_mr)			 ;
Butterfly_Mult_CLA16 cla_tp00(1'b1,~tempProduct[15:0],16'b0,claResult_tp[15:0],carry_tp1)	 ;
Butterfly_Mult_CLA16 cla_tp01(carry_tp1,~tempProduct[31:16],16'b0,claResult_tp[31:16],carry_tp2);

//Instantiating the Wallace unsigned Multiplier
Butterfly_Mult_Wallace wtm01(tempProduct,feedWallace_mr,feedWallace_md);

//Deciding on which output to take based on the signs of the inputs
assign xProduct=(xMultiplicand==0 || xMultiplier==0)?0:
		(({xMultiplier[`BF_MULT_BITS-1],xMultiplicand[`BF_MULT_BITS-1]}==2'b00)||({xMultiplier[`BF_MULT_BITS-1],xMultiplicand[`BF_MULT_BITS-1]}==2'b11))?tempProduct:claResult_tp;

endmodule

