`include "00defines.v"

module Butterfly_Mult(
xMultiplicand,
xMultiplier,
xProduct
);

output [`BF_MULT_BITS+`BF_MULT_BITS-1:0] xProduct;	//for 16*16 this is 32 bits
input  [`BF_MULT_BITS-1:0] xMultiplicand	 ;	//M bits
input  [`BF_MULT_BITS-1:0] xMultiplier		 ;	//M bits

wire signed [`BF_MULT_BITS+`BF_MULT_BITS-1:0] xProduct  ;	//output
wire signed [`BF_MULT_BITS-1:0] xMultiplier		 ;	//input2
wire signed [`BF_MULT_BITS-1:0] xMultiplicand		 ;	//input1 

//wire signed [17:0] A		 ;	//input1 
//wire signed [17:0] B		 ;	//input1 
//wire signed [35:0] C		 ;	//input1 

//assign A = {xMultiplier[15],xMultiplier[15],xMultiplier};
//assign B = {xMultiplicand[15],xMultiplicand[15],xMultiplicand};
//assign C=A*B;
//assign xProduct = C[`BF_MULT_BITS+`BF_MULT_BITS-1:0];
assign xProduct = xMultiplier*xMultiplicand;

endmodule

