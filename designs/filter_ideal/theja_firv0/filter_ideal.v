module filter_ideal (xin, yout, clk,rst);

input [15:0] xin;
output [15:0] yout;
input clk;
input rst;

reg [15:0] yout;
wire [15:0] xin;
wire clk;
wire rst;

//filter related
wire [16-1:0] coeff [0:32];//33 in total for a 32 order filter
wire [16-1:0] intermediate[0:32];
reg [16-1:0] interreg[1:32];

multiplier m00 (xin,coeff[00],intermediate[00]);
multiplier m01 (xin,coeff[01],intermediate[01]);
multiplier m02 (xin,coeff[02],intermediate[02]);
multiplier m03 (xin,coeff[03],intermediate[03]);
multiplier m04 (xin,coeff[04],intermediate[04]);
multiplier m05 (xin,coeff[05],intermediate[05]);
multiplier m06 (xin,coeff[06],intermediate[06]);
multiplier m07 (xin,coeff[07],intermediate[07]);
multiplier m08 (xin,coeff[08],intermediate[08]);
multiplier m09 (xin,coeff[09],intermediate[09]);
multiplier m10 (xin,coeff[10],intermediate[10]);
multiplier m11 (xin,coeff[11],intermediate[11]);
multiplier m12 (xin,coeff[12],intermediate[12]);
multiplier m13 (xin,coeff[13],intermediate[13]);
multiplier m14 (xin,coeff[14],intermediate[14]);
multiplier m15 (xin,coeff[15],intermediate[15]);
multiplier m16 (xin,coeff[16],intermediate[16]);
multiplier m17 (xin,coeff[17],intermediate[17]);
multiplier m18 (xin,coeff[18],intermediate[18]);
multiplier m19 (xin,coeff[19],intermediate[19]);
multiplier m20 (xin,coeff[20],intermediate[20]);
multiplier m21 (xin,coeff[21],intermediate[21]);
multiplier m22 (xin,coeff[22],intermediate[22]);
multiplier m23 (xin,coeff[23],intermediate[23]);
multiplier m24 (xin,coeff[24],intermediate[24]);
multiplier m25 (xin,coeff[25],intermediate[25]);
multiplier m26 (xin,coeff[26],intermediate[26]);
multiplier m27 (xin,coeff[27],intermediate[27]);
multiplier m28 (xin,coeff[28],intermediate[28]);
multiplier m29 (xin,coeff[29],intermediate[29]);
multiplier m30 (xin,coeff[30],intermediate[30]);
multiplier m31 (xin,coeff[31],intermediate[31]);
multiplier m32 (xin,coeff[32],intermediate[32]);
/* have to be descaled : mult by 0.2
assign coeff[00] = 16'h1398;
assign coeff[01] = 16'h0000;
assign coeff[02] = 16'hE99C;
assign coeff[03] = 16'hE7E3;
assign coeff[04] = 16'hF9D5;
assign coeff[05] = 16'h06BA;
assign coeff[06] = 16'h0000;
assign coeff[07] = 16'hF7C7;
assign coeff[08] = 16'h0940;
assign coeff[09] = 16'h2CC9;
assign coeff[10] = 16'h343F;
assign coeff[11] = 16'h0000;
assign coeff[12] = 16'hB1A2;
assign coeff[13] = 16'h9782;
assign coeff[14] = 16'hDB00;
assign coeff[15] = 16'h4A00;
assign coeff[16] = 16'h7FFF;
assign coeff[17] = 16'h4A00;
assign coeff[18] = 16'hDB00;
assign coeff[19] = 16'h9782;
assign coeff[20] = 16'hB1A2;
assign coeff[21] = 16'h0000;
assign coeff[22] = 16'h343F;
assign coeff[23] = 16'h2CC9;
assign coeff[24] = 16'h0940;
assign coeff[25] = 16'hF7C7;
assign coeff[26] = 16'h0000;
assign coeff[27] = 16'h06BA;
assign coeff[28] = 16'hF9D5;
assign coeff[29] = 16'hE7E3;
assign coeff[30] = 16'hE99C;
assign coeff[31] = 16'h0000;
assign coeff[32] = 16'h1398;
*/
assign coeff[0] = 16'h03EB;
assign coeff[1] = 16'h0000;
assign coeff[2] = 16'hFB85;
assign coeff[3] = 16'hFB2D;
assign coeff[4] = 16'hFEC4;
assign coeff[5] = 16'h0158;
assign coeff[6] = 16'h0000;
assign coeff[7] = 16'hFE5B;
assign coeff[8] = 16'h01D9;
assign coeff[9] = 16'h08F5;
assign coeff[10] = 16'h0A73;
assign coeff[11] = 16'h0000;
assign coeff[12] = 16'hF053;
assign coeff[13] = 16'hEB1A;
assign coeff[14] = 16'hF899;
assign coeff[15] = 16'h0ECC;
assign coeff[16] = 16'h1999;
assign coeff[17] = 16'h0ECC;
assign coeff[18] = 16'hF899;
assign coeff[19] = 16'hEB1A;
assign coeff[20] = 16'hF053;
assign coeff[21] = 16'h0000;
assign coeff[22] = 16'h0A73;
assign coeff[23] = 16'h08F5;
assign coeff[24] = 16'h01D9;
assign coeff[25] = 16'hFE5B;
assign coeff[26] = 16'h0000;
assign coeff[27] = 16'h0158;
assign coeff[28] = 16'hFEC4;
assign coeff[29] = 16'hFB2D;
assign coeff[30] = 16'hFB85;
assign coeff[31] = 16'h0000;
assign coeff[32] = 16'h03EB;



always @ (posedge clk)
begin
	if (rst==1)
	begin
		yout <=16'h0000;
		interreg[00] <= 0;interreg[01] <= 0;interreg[02] <= 0;interreg[03] <= 0;interreg[04] <= 0;
		interreg[05] <= 0;interreg[06] <= 0;interreg[07] <= 0;interreg[08] <= 0;interreg[09] <= 0;
		interreg[10] <= 0;interreg[11] <= 0;interreg[12] <= 0;interreg[13] <= 0;interreg[14] <= 0;
		interreg[15] <= 0;interreg[16] <= 0;interreg[17] <= 0;interreg[18] <= 0;interreg[19] <= 0;
		interreg[20] <= 0;interreg[21] <= 0;interreg[22] <= 0;interreg[23] <= 0;interreg[24] <= 0;
		interreg[25] <= 0;interreg[26] <= 0;interreg[27] <= 0;interreg[28] <= 0;interreg[29] <= 0;
		interreg[30] <= 0;interreg[31] <= 0;interreg[32] <= 0;
	end
	else
	begin
		yout <= intermediate[0] + interreg[1];
		interreg[1] <= intermediate[1] + interreg[2];
		interreg[2] <= intermediate[2] + interreg[3];
		interreg[3] <= intermediate[3] + interreg[4];
		interreg[4] <= intermediate[4] + interreg[5];
		interreg[5] <= intermediate[5] + interreg[6];
		interreg[6] <= intermediate[6] + interreg[7];
		interreg[7] <= intermediate[7] + interreg[8];
		interreg[8] <= intermediate[8] + interreg[9];
		interreg[9] <= intermediate[9] + interreg[10];
		interreg[10] <= intermediate[10] + interreg[11];
		interreg[11] <= intermediate[11] + interreg[12];
		interreg[12] <= intermediate[12] + interreg[13];
		interreg[13] <= intermediate[13] + interreg[14];
		interreg[14] <= intermediate[14] + interreg[15];
		interreg[15] <= intermediate[15] + interreg[16];
		interreg[16] <= intermediate[16] + interreg[17];
		interreg[17] <= intermediate[17] + interreg[18];
		interreg[18] <= intermediate[18] + interreg[19];
		interreg[19] <= intermediate[19] + interreg[20];
		interreg[20] <= intermediate[20] + interreg[21];
		interreg[21] <= intermediate[21] + interreg[22];
		interreg[22] <= intermediate[22] + interreg[23];
		interreg[23] <= intermediate[23] + interreg[24];
		interreg[24] <= intermediate[24] + interreg[25];
		interreg[25] <= intermediate[25] + interreg[26];
		interreg[26] <= intermediate[26] + interreg[27];
		interreg[27] <= intermediate[27] + interreg[28];
		interreg[28] <= intermediate[28] + interreg[29];
		interreg[29] <= intermediate[29] + interreg[30];
		interreg[30] <= intermediate[30] + interreg[31];
		interreg[31] <= intermediate[31] + interreg[32];		
		interreg[32] <= intermediate[32];
	end
end
endmodule
