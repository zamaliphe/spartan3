//PARAMETERS ARE DEPENDENT ON ALL THE SUPPORTING TEST BENCHES
// AND MODULE FILES CHANGING PARAMS IN ONLY 1FILE WILL CREATE PROBLEMS


//The following is an alu.  
//It is an adder, but capable of subtraction:
//Subtraction means adding the two's complement--
//a - b = a + (-b) = a + (inverted b + 1)
//The 1 will be coming in as cin (carry-in)
module multALU(out, a, b, cin);

parameter MBITS = 16 ;

output [MBITS-1:0] out;
input [MBITS-1:0] a;
input [MBITS-1:0] b;
input cin;

assign out = a + b + cin;

endmodule

