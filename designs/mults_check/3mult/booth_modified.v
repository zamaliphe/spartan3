//booth decoder
module booth_modified(answer,mpd,mpr,busy, start);
//module booth_modified(prod,mpd,mpr,clk,busy, start);
parameter MBITS = 12, NBITS = 8, COUNTBITS = 4;
//Note param MBITS also linked with alu.v's param MBITS

//output [MBITS+NBITS-1:0] prod;//final result...bits:
output busy;		        //busy flag
output [MBITS+NBITS-1:0] answer;

input [MBITS-1:0] mpd;//M bits
input [NBITS-1:0] mpr;//N bits....N<M...for omega
//input clk;	       //Clock	
input start;	       //Starts the Multiplier

//wire clk;
wire start;
wire [NBITS-1:0] mpr;
wire [MBITS-1:0] mpd;


reg [MBITS:0] pp0,pp1,pp2,pp3;
//reg [MBITS+NBITS-1:0] prod;
reg busy;

always @(posedge start)begin
		busy <= 1'b1;
		case (mpr[1:0])
			3'b0_0_0 : pp0[12:0] <= 0;
			//3'b0_0_1 : pp0[12:0] <= {0,mpd[11:0]};
			3'b0_1_0 : pp0[12:0] <= {0,mpd[11:0]};
			//3'b0_1_1 : pp0[12:0] <= {mpd[11:0],0};
			3'b1_0_0 : pp0[12:0] <= {~mpd[11:0]+1,0};//is this correct
			//3'b1_0_1 : pp0[12:0] <= {0,~mpd[11:0]+1};
			3'b1_1_0 : pp0[12:0] <= {0,~mpd[11:0]+1};
			//3'b1_1_1 : pp0[12:0] <= 0;
		endcase
		
		case (mpr[3:1])
			3'b0_0_0 : pp1[12:0] <= 0;
			3'b0_0_1 : pp1[12:0] <= {0,mpd[11:0]};
			3'b0_1_0 : pp1[12:0] <= {0,mpd[11:0]};
			3'b0_1_1 : pp1[12:0] <= {mpd[11:0],0};
			3'b1_0_0 : pp1[12:0] <= {~mpd[11:0]+1,0};//is this correct
			3'b1_0_1 : pp1[12:0] <= {0,~mpd[11:0]+1};
			3'b1_1_0 : pp1[12:0] <= {0,~mpd[11:0]+1};
			3'b1_1_1 : pp1[12:0] <= 0;
		endcase
		
		case (mpr[5:3])
			3'b0_0_0 : pp2[12:0] <= 0;
			3'b0_0_1 : pp2[12:0] <= {0,mpd[11:0]};
			3'b0_1_0 : pp2[12:0] <= {0,mpd[11:0]};
			3'b0_1_1 : pp2[12:0] <= {mpd[11:0],0};
			3'b1_0_0 : pp2[12:0] <= {~mpd[11:0]+1,0};//is this correct
			3'b1_0_1 : pp2[12:0] <= {0,~mpd[11:0]+1};
			3'b1_1_0 : pp2[12:0] <= {0,~mpd[11:0]+1};
			3'b1_1_1 : pp2[12:0] <= 0;
		endcase
		
		case (mpr[7:5])
			3'b0_0_0 : pp3[12:0] <= 0;
			3'b0_0_1 : pp3[12:0] <= {0,mpd[11:0]};
			3'b0_1_0 : pp3[12:0] <= {0,mpd[11:0]};
			3'b0_1_1 : pp3[12:0] <= {mpd[11:0],0};
			3'b1_0_0 : pp3[12:0] <= {~mpd[11:0]+1,0};//is this correct
			3'b1_0_1 : pp3[12:0] <= {0,~mpd[11:0]+1};
			3'b1_1_0 : pp3[12:0] <= {0,~mpd[11:0]+1};
			3'b1_1_1 : pp3[12:0] <= 0;
		endcase
end //always end

wall_tree_answer wta01(pp1,pp2,pp3,pp4,answer);

endmodule
