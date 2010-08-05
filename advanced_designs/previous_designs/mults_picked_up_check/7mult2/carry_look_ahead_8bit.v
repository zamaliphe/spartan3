//cla 8 bit module 13th Aug Theja
module carry_look_ahead_8bit(operand1,operand2,result,carry_out);

input [7:0] operand1,operand2;

output[7:0] result;
output carry_out;
wire c_between;

carry_look_ahead_4bit cla00(operand1[3:0],operand2[3:0],1'b0,result[3:0],c_between);
carry_look_ahead_4bit cla01(operand1[7:4],operand2[7:4],c_between,result[7:4],carry_out);

endmodule
