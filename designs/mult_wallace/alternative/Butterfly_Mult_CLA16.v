/*
Pseudo CLA16: Since its ripples using 4 CLA4 adders
*/
module Butterfly_Mult_CLA16(carryin,operand1,operand2,result,carry_out);

input [15:0] operand1,operand2;
input carryin;
output[15:0] result;
output carry_out;

wire [15:0] operand1,operand2;
wire carryin;
wire [2:0] c_between;

wire[15:0] result;	//CAUTION OUTPUT WIRED!!
wire carry_out;		//CAUTION OUTPUT WIRED!!
Butterfly_Mult_CLA4 cla00(operand1[3:0],operand2[3:0],carryin,result[3:0],c_between[0]);
Butterfly_Mult_CLA4 cla01(operand1[7:4],operand2[7:4],c_between[0],result[7:4],c_between[1]);
Butterfly_Mult_CLA4 cla02(operand1[11:8],operand2[11:8],c_between[1],result[11:8],c_between[2]);
Butterfly_Mult_CLA4 cla03(operand1[15:12],operand2[15:12],c_between[2],result[15:12],carry_out);

//CODE SEGMENT


endmodule
