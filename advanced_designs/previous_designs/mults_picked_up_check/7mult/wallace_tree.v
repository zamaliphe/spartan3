module wallace_tree(fbit_pp0,pp0,fbit_pp1,pp1,fbit_pp2,pp2,fbit_pp3,pp3,answer);

parameter MBITS =12, NBITS = 8;
input [MBITS-1:0]pp0;
input [MBITS-1:0]pp1;//12 bits these inputs
input [MBITS-1:0]pp2;
input [MBITS-1:0]pp3;
input fbit_pp0,fbit_pp1,fbit_pp2,fbit_pp3;//FADAVI BITS
output [MBITS+NBITS-1:0]answer;//CAUTION CHECK SIZE!!

wire end_carry,discard_bit;
wire [7:0] sum1,carry1;
wire [11:0] sum2,carry2;
wire [15:0] sum3,carry3;//CAUTION CHECK SIZE!! THEJA CHECK

//step 1:


half_adder hfA0(pp2[2],pp3[0],sum1[0],carry1[0]);
half_adder hfA1(pp2[3],pp3[1],sum1[1],carry1[1]);
half_adder hfA2(pp2[4],pp3[2],sum1[2],carry1[2]);
half_adder hfA3(pp2[5],pp3[3],sum1[3],carry1[3]);
half_adder hfA4(pp2[6],pp3[4],sum1[4],carry1[4]);
half_adder hfA5(pp2[7],pp3[5],sum1[5],carry1[5]);
full_adder_1bit csaA0(pp2[8],pp3[6],1'b1,sum1[6],carry1[6]);
half_adder hfA6(pp2[9],1'b1,sum1[7],carry1[7]);


//step 2:
half_adder hfB0(pp1[2],pp2[0],sum2[0],carry2[0]);
half_adder hfB1(pp1[3],pp2[1],sum2[1],carry2[1]);
half_adder hfB2(pp1[4],sum1[0],sum2[2],carry2[2]);
full_adder_1bit csaB1 (pp1[5],sum1[1],carry1[0],sum2[3],carry2[3]);
full_adder_1bit csaB2 (pp1[6],sum1[2],carry1[1],sum2[4],carry2[4]);
full_adder_1bit csaB3 (pp1[7],sum1[3],carry1[2],sum2[5],carry2[5]);
full_adder_1bit csaB4 (pp1[8],sum1[4],carry1[3],sum2[6],carry2[6]);
full_adder_1bit csaB5 (pp1[9],sum1[5],carry1[4],sum2[7],carry2[7]);
full_adder_1bit csaB6 (pp1[10],sum1[6],carry1[5],sum2[8],carry2[8]);
full_adder_1bit csaB7 (pp1[11],sum1[7],carry1[6],sum2[9],carry2[9]);
full_adder_1bit csaB8 (fbit_pp1,pp2[10],carry1[7],sum2[10],carry2[10]);
half_adder hfB3(pp2[11],1'b1,sum2[11],carry2[11]);


//step 3:
half_adder hfC3(pp0[2],pp1[0],sum3[0],carry3[0]);
half_adder hfC2(pp0[3],pp1[1],sum3[1],carry3[1]);
half_adder hfC1(pp0[4],sum2[0],sum3[2],carry3[2]);
full_adder_1bit csaC4(pp0[5],sum2[1],carry2[0],sum3[3],carry3[3]);
full_adder_1bit csaC5(pp0[6],sum2[2],carry2[1],sum3[4],carry3[4]);
full_adder_1bit csaC6(pp0[7],sum2[3],carry2[2],sum3[5],carry3[5]);
full_adder_1bit csaC7(pp0[8],sum2[4],carry2[3],sum3[6],carry3[6]);
full_adder_1bit csaC8(pp0[9],sum2[5],carry2[4],sum3[7],carry3[7]);
full_adder_1bit csaC9(pp0[10],sum2[6],carry2[5],sum3[8],carry3[8]);
full_adder_1bit csaC10(pp0[11],sum2[7],carry2[6],sum3[9],carry3[9]);
full_adder_1bit csaC11(fbit_pp0,sum2[8],carry2[7],sum3[10],carry3[10]);
full_adder_1bit csaC0(pp3[7],sum2[9],carry2[8],sum3[11],carry3[11]);
full_adder_1bit csaC1(pp3[8],sum2[10],carry2[9],sum3[12],carry3[12]);
full_adder_1bit csaC2(pp3[9],sum2[11],carry2[10],sum3[13],carry3[13]);
full_adder_1bit csaC3(pp3[10],fbit_pp2,carry2[11],sum3[14],carry3[14]);
half_adder hfC0(pp3[11],1'b1,sum3[15],carry3[15]);


//step 4:
assign answer[1:0] = pp0[1:0];//last 2 bits
assign answer[2] = sum3[0];


carry_look_ahead_16bit claC0({fbit_pp3,sum3[15:1]},carry3[15:0],answer[18:3],end_carry);
half_adder hfD0(end_carry,1'b1,answer[19],discard_bit);

endmodule
