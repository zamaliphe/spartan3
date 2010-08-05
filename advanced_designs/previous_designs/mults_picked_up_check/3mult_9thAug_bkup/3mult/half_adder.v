//half adder
// Verilog one-bit half adder slice Theja 6th Aug

module half_adder(a_one,a_two,s,c_out);//combi block
   input  a_one;
   input  a_two; 
   output s;
   output c_out;

   assign  s = a_one ^ a_two;

   assign  c_out = (a_one & a_two);  

endmodule