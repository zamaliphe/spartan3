// Verilog one-bit adder slice Theja 6th Aug

module full_adder_1bit(a_one,a_two,c_in,s,c_out);//combi block
   input  a_one;
   input  a_two; 
   input  c_in;
   output s;
   output c_out;

   assign  s = a_one ^ a_two ^ c_in;               

   assign  c_out = (a_one & a_two) | (a_one & c_in) | (a_two & c_in);  

endmodule
