module booth_encode(mpd,mpr,start,answer);
parameter MBITS = 12, NBITS = 8, COUNTBITS = 4;

output [MBITS+NBITS-1:0] answer;

input [MBITS-1:0] mpd;//M bits
input [NBITS-1:0] mpr;//N bits....N<M...for omega
input start;	       //Starts the Multiplier

wire start;
wire [NBITS-1:0] mpr;
wire [MBITS-1:0] mpd;

wire [MBITS+NBITS-1:0] answer;//output

reg [MBITS:0] pp0,pp1,pp2,pp3;//bit extended to cater for 2*mpd


wallace_tree wta01(~pp0[12],pp0[11:0],~pp1[12],pp1[11:0],~pp2[12],pp2[11:0],~pp3[12],pp3[11:0],answer);

always @(posedge start)begin
		
		case (mpr[1:0])
			2'b0_0 : pp0[12:0] <= 13'b0;
			2'b0_1 : pp0[12:0] <= {mpd[11],mpd[11:0]};
			2'b1_0 : pp0[12:0] <= {~mpd[11:0]+1'b1,1'b0};//is this correct
			2'b1_1 : pp0[12:0] <= {~mpd[11],~mpd[11:0]+1'b1};
		endcase
		
		case (mpr[3:1])
			3'b0_0_0 : pp1[12:0] <= 13'b0;
			3'b0_0_1 : pp1[12:0] <= {mpd[11],mpd[11:0]};
			3'b0_1_0 : pp1[12:0] <= {mpd[11],mpd[11:0]};
			3'b0_1_1 : pp1[12:0] <= {mpd[11:0],1'b0};
			3'b1_0_0 : pp1[12:0] <= {~mpd[11:0]+1'b1,1'b0};//is this correct
			3'b1_0_1 : pp1[12:0] <= {~mpd[11],~mpd[11:0]+1'b1};
			3'b1_1_0 : pp1[12:0] <= {~mpd[11],~mpd[11:0]+1'b1};
			3'b1_1_1 : pp1[12:0] <= 13'b0;
		endcase
		
		case (mpr[5:3])
			3'b0_0_0 : pp2[12:0] <= 13'b0;
			3'b0_0_1 : pp2[12:0] <= {mpd[11],mpd[11:0]};
			3'b0_1_0 : pp2[12:0] <= {mpd[11],mpd[11:0]};
			3'b0_1_1 : pp2[12:0] <= {mpd[11:0],1'b0};
			3'b1_0_0 : pp2[12:0] <= {~mpd[11:0]+1'b1,1'b0};//is this correct
			3'b1_0_1 : pp2[12:0] <= {~mpd[11],~mpd[11:0]+1'b1};
			3'b1_1_0 : pp2[12:0] <= {~mpd[11],~mpd[11:0]+1'b1};
			3'b1_1_1 : pp2[12:0] <= 13'b0;
		endcase
		
		case (mpr[7:5])
			3'b0_0_0 : pp3[12:0] <= 13'b0;
			3'b0_0_1 : pp3[12:0] <= {mpd[11],mpd[11:0]};
			3'b0_1_0 : pp3[12:0] <= {mpd[11],mpd[11:0]};
			3'b0_1_1 : pp3[12:0] <= {mpd[11:0],1'b0};
			3'b1_0_0 : pp3[12:0] <= {~mpd[11:0]+1'b1,1'b0};//is this correct
			3'b1_0_1 : pp3[12:0] <= {~mpd[11],~mpd[11:0]+1'b1};
			3'b1_1_0 : pp3[12:0] <= {~mpd[11],~mpd[11:0]+1'b1};
			3'b1_1_1 : pp3[12:0] <= 13'b0;
		endcase
end //always end


endmodule

