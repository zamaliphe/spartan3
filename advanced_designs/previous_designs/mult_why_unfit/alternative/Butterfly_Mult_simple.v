`define LENGTH 16

module Butterfly_Mult(
xMultiplicand,
xMultiplier,
xProduct
);

output [`LENGTH+`LENGTH-1:0] xProduct;	//for 16*16 this is 32 bits
input [`LENGTH-1:0] xMultiplicand	 ;	//M bits
input [`LENGTH-1:0] xMultiplier		 ;	//M bits

wire signed [`LENGTH+`LENGTH-1:0] xProduct  ;	//output
wire signed [`LENGTH-1:0] xMultiplier		 ;	//input2
wire signed [`LENGTH-1:0] xMultiplicand		 ;	//input1 

assign xProduct = xMultiplicand*xMultiplier;

endmodule

