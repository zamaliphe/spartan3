// 4-bit adder using hierarchical logic. Theja 6th Aug
// A 1-bit full adder is instantiated four times.
// The four 1-bit adders are wired together to comprise a 4-bit adder.

module full_adder_4bit (addend_one,addend_two,carry_in,sum,carry_out); 
   input [3:0]   addend_one;   // Four-bit signal with msb addend_one[3].  
   input [3:0]   addend_two;
   input         carry_in;
   output [3:0]  sum;
   output        carry_out;

    wire carry_out_0;  // 1-bit wire  
    wire carry_out_1;  // 1-bit wire 
    wire carry_out_2;  // 1-bit wire   

    // 4 instantiations of the full_adder module. 
	full_adder_1bit fa0(addend_one[0],addend_two[0],carry_in,s[0],carry_out_0);
	full_adder_1bit fa1(addend_one[1],addend_two[1],carry_out_0,s[1],carry_out_1);
	full_adder_1bit fa2(addend_one[2],addend_two[2],carry_out_1,s[2],carry_out_2);
	full_adder_1bit fa3(addend_one[3],addend_two[3],carry_out_2,s[3],carry_out);

endmodule
