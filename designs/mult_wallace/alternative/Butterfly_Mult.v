`include "00defines.v"

module Butterfly_Mult(
xMultiplicand,
xMultiplier,
xProduct
);

output [`BF_MULT_BITS+`BF_MULT_BITS-1:0] xProduct;	//for 16*16 this is 32 bits
input [`BF_MULT_BITS-1:0] xMultiplicand	 ;	//M bits
input [`BF_MULT_BITS-1:0] xMultiplier		 ;	//M bits

wire signed [`BF_MULT_BITS+`BF_MULT_BITS-1:0] xProduct  ;	//output
wire signed [`BF_MULT_BITS-1:0] xMultiplier		 ;	//input2
wire signed [`BF_MULT_BITS-1:0] xMultiplicand		 ;	//input1 

assign xProduct = xMultiplicand*xMultiplier;

endmodule

