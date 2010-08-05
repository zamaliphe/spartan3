module Butterfly_Mult_FullAdder(sum,carry,a2,b2,c);

output sum,carry;

input a2,b2,c;

wire d,e,f;

Butterfly_Mult_HalfAdder ha1(d,e,a2,b2);

Butterfly_Mult_HalfAdder ha2(sum,f,d,c);

assign carry=(d&c)|e;

endmodule
