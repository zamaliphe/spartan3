module wall_tree_answer(pp1,pp2,pp3,pp4,answer);

parameter MBITS =12, NBITS = 8;
input [MBITS:0]pp0,pp1,pp2,pp3;//13 bits in total

output [MBITS+NBITS-1:0]answer;

wire [MBITS+NBITS-1:0]carry1,carry2,sum1,sum2;
//handcoded wallace tree

//             19 18 17 16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
//  		                 [13][12][10][9][8][7][6][5][4][3][2][1][0]  //assum. ppt0 13 bits each
//  		[13][12][10][9][8][7][6][5][4][3][2][1][0]
//	  [13][12][10][9][8][7][6][5][4][3][2][1][0]
//  [13][12][10][9][8][7][6][5][4][3][2][1][0]


//step 1:

half_adder hfA0(pp1[11],pp2[9],sum1[13],carry1[13]);
half_adder hfA1(pp1[12],pp2[10],sum1[14],carry1[14]);

full_adder csaA0 (pp1[6],pp2[2],pp3[0],sum1[6],carry1[6]);
full_adder csaA1 (pp1[7],pp2[3],pp3[1],sum1[7],carry1[7]);
full_adder csaA2 (pp1[8],pp2[4],pp3[2],sum1[8],carry1[8]);
full_adder csaA3 (pp1[9],pp2[5],pp3[3],sum1[9],carry1[9]);
full_adder csaA4 (pp1[10],pp2[6],pp3[4],sum1[10],carry1[10]);
full_adder csaA5 (pp1[11],pp2[7],pp3[5],sum1[11],carry1[11]);
full_adder csaA6 (pp1[12],pp2[8],pp3[6],sum1[12],carry1[12]);

half_adder hfA2(pp1[21],pp2[0],sum1[4],carry1[4]);
half_adder hfA3(pp1[3],pp2[1],sum1[5],carry1[5]);

//step2

half_adder hfB0(pp3[10],pp2[12],sum2[16],carry2[16]);

full_adder csaB0(pp3[9],pp2[11],carry1[14],sum2[15],carry2[15]);
full_adder csaB1(pp3[8],sum1[14],carry1[13],sum2[14],carry2[14]);
full_adder csaB2(pp3[7],sum1[13],carry1[12],sum2[13],carry2[13]);
full_adder csaB3(pp0[12],sum1[12],carry1[11],sum2[12],carry2[12]);
full_adder csaB4(pp0[11],sum1[11],carry1[10],sum2[11],carry2[11]);
full_adder csaB5(pp0[10],sum1[10],carry1[9],sum2[10],carry2[10]);
full_adder csaB6(pp0[9],sum1[9],carry1[8],sum2[9],carry2[9]);
full_adder csaB7(pp0[8],sum1[8],carry1[7],sum2[8],carry2[8]);
full_adder csaB8(pp0[7],sum1[7],carry1[6],sum2[7],carry2[7]);
full_adder csaB9(pp0[6],sum1[6],carry1[5],sum2[6],carry2[6]);
full_adder csaB10(pp0[5],sum1[5],carry1[4],sum2[5],carry2[5]);

half_adder hfB1(pp0[4],sum1[4],sum2[4],carry2[4]);
half_adder hfB2(pp0[3],pp1[1],sum2[3],carry2[3]);
half_adder hfB3(pp0[2],pp1[0],sum2[2],carry2[2]);

//step3
answer[1:0] = pp0[1:0];//last 2 bits
answer[2] = sum2[2];
cla_16bit claC0({pp3[12:11],sum2[16:3]},{0,carry2[16:2]},answer[18:3],answer[19]);

end module