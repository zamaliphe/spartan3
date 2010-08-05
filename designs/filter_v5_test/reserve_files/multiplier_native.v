module multiplier(
xMultiplicand,
xMultiplier,
xProduct
);

output [16-1:0] xProduct			;	//for 16*16 this is 32 bits
input  [16-1:0] xMultiplicand	 	;	//M bits
input  [16-1:0] xMultiplier		 	;	//M bits

wire signed [16-1:0] xProduct  		;	//output
wire signed [16-1:0] xMultiplier	;	//input2
wire signed [16-1:0] xMultiplicand	;	//input1 
wire signed [32-1:0] xProductFull  	;	//output

assign xProductFull = xMultiplier*xMultiplicand;
assign xProduct = {xProductFull[32-1],xProductFull[32-1:17]};//extra divide by two happening

endmodule

