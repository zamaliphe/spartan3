module Butterfly_Mult_HalfAdder(sum,carry,a3,b3);

output sum,carry;

input a3,b3;

assign sum=(a3&(~b3))|(b3&(~a3));

assign carry=a3&b3;

endmodule
