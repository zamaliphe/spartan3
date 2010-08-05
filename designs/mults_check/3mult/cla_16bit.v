//cla 16 bit module 6th Aug Theja
module cla_16bit(operand1,operand2,result,carry_out);

input [15:0] operand1,operand2;

output[15:0] result;
output carry_out;
wire [2:0]c_between;

cla_4bit cla00(operand1[3:0],operand2[3:0],0,result[3:0],c_between[0]);
cla_4bit cla00(operand1[7:4],operand2[7:4],c_between[0],result[7:4],c_between[1]);
cla_4bit cla00(operand1[11:8],operand2[11:8],c_between[1],result[11:8],c_between[2]);
cla_4bit cla00(operand1[15:12],operand2[15:12],c_between[2],result[15:12],carry_out);

end module