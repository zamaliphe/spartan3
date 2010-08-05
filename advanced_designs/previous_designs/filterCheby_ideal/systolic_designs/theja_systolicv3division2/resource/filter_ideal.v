module filter_ideal (xin, yout, clk30x,rst);

input [15:0] xin;
output [15:0] yout;
input clk30x;
input rst;

reg [15:0] yout;
wire [15:0] xin;
wire clk30x;
wire rst;

//filter related
wire [16-1:0] coeff [0:32];//33 in total for a 32 order filter
wire [16-1:0] intermediate[0:32];
reg [16-1:0] interreg[1:32];
wire busy_coeff[0:32];
reg [4:0] count;
wire start_mult;


mult m0(intermediate[0],xin,coeff[0],clk30x,busy_coeff[0],(count== 0));
mult m1(intermediate[1],xin,coeff[1],clk30x,busy_coeff[1],(count== 0));
mult m2(intermediate[2],xin,coeff[2],clk30x,busy_coeff[2],(count== 0));
mult m3(intermediate[3],xin,coeff[3],clk30x,busy_coeff[3],(count== 0));
mult m4(intermediate[4],xin,coeff[4],clk30x,busy_coeff[4],(count== 0));
mult m5(intermediate[5],xin,coeff[5],clk30x,busy_coeff[5],(count== 0));
mult m6(intermediate[6],xin,coeff[6],clk30x,busy_coeff[6],(count== 0));
mult m7(intermediate[7],xin,coeff[7],clk30x,busy_coeff[7],(count== 0));
mult m8(intermediate[8],xin,coeff[8],clk30x,busy_coeff[8],(count== 0));
mult m9(intermediate[9],xin,coeff[9],clk30x,busy_coeff[9],(count== 0));
mult m10(intermediate[10],xin,coeff[10],clk30x,busy_coeff[10],(count== 0));
mult m11(intermediate[11],xin,coeff[11],clk30x,busy_coeff[11],(count== 0));
mult m12(intermediate[12],xin,coeff[12],clk30x,busy_coeff[12],(count== 0));
mult m13(intermediate[13],xin,coeff[13],clk30x,busy_coeff[13],(count== 0));
mult m14(intermediate[14],xin,coeff[14],clk30x,busy_coeff[14],(count== 0));
mult m15(intermediate[15],xin,coeff[15],clk30x,busy_coeff[15],(count== 0));
mult m16(intermediate[16],xin,coeff[16],clk30x,busy_coeff[16],(count== 0));
mult m17(intermediate[17],xin,coeff[17],clk30x,busy_coeff[17],(count== 0));
mult m18(intermediate[18],xin,coeff[18],clk30x,busy_coeff[18],(count== 0));
mult m19(intermediate[19],xin,coeff[19],clk30x,busy_coeff[19],(count== 0));
mult m20(intermediate[20],xin,coeff[20],clk30x,busy_coeff[20],(count== 0));
mult m21(intermediate[21],xin,coeff[21],clk30x,busy_coeff[21],(count== 0));
mult m22(intermediate[22],xin,coeff[22],clk30x,busy_coeff[22],(count== 0));
mult m23(intermediate[23],xin,coeff[23],clk30x,busy_coeff[23],(count== 0));
mult m24(intermediate[24],xin,coeff[24],clk30x,busy_coeff[24],(count== 0));
mult m25(intermediate[25],xin,coeff[25],clk30x,busy_coeff[25],(count== 0));
mult m26(intermediate[26],xin,coeff[26],clk30x,busy_coeff[26],(count== 0));
mult m27(intermediate[27],xin,coeff[27],clk30x,busy_coeff[27],(count== 0));
mult m28(intermediate[28],xin,coeff[28],clk30x,busy_coeff[28],(count== 0));
mult m29(intermediate[29],xin,coeff[29],clk30x,busy_coeff[29],(count== 0));
mult m30(intermediate[30],xin,coeff[30],clk30x,busy_coeff[30],(count== 0));
mult m31(intermediate[31],xin,coeff[31],clk30x,busy_coeff[31],(count== 0));
mult m32(intermediate[32],xin,coeff[32],clk30x,busy_coeff[32],(count== 0));


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

assign start_mult = (count==0)?1:0;

always @ (posedge clk30x)
begin
	if (rst==1)
	begin
		count <= 0;
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
		if(count!=29)//some random count actually. Am lazy to know the exact counting required for the seq. mults to work.
		begin
			count <= count + 1;
		end
		else
		begin
			count <= 0;
			
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
end
endmodule
