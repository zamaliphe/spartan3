//cla 16 bit module 6th Aug Theja
module carry_look_ahead_16bit(operand1,operand2,result,carry_out);

input [15:0] operand1,operand2;

output[15:0] result;
output carry_out;
wire [2:0]c_between;

carry_look_ahead_4bit cla00(operand1[3:0],operand2[3:0],1'b0,result[3:0],c_between[0]);
carry_look_ahead_4bit cla01(operand1[7:4],operand2[7:4],c_between[0],result[7:4],c_between[1]);
carry_look_ahead_4bit cla02(operand1[11:8],operand2[11:8],c_between[1],result[11:8],c_between[2]);
carry_look_ahead_4bit cla03(operand1[15:12],operand2[15:12],c_between[2],result[15:12],carry_out);

endmodule
