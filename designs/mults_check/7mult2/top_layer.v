module top_layer(mpd, mpr, clk, start, busy, prod);
parameter MBITS = 12, NBITS = 8;
output busy;                    //busy flag
output [MBITS+NBITS-1:0] prod;
input [MBITS-1:0] mpd;//M bits
input [NBITS-1:0] mpr;//N bits....N<M...for omega
input clk;             //Clock
input start;           //Starts the Multiplier

wire clk;
wire start;
wire [NBITS-1:0] mpr;
wire [MBITS-1:0] mpd;
wire [MBITS+NBITS-1:0] answer;

reg [MBITS+NBITS-1:0] prod;
reg busy;

booth_encode bm01(mpd,mpr,start,answer);

always @(posedge clk) begin
        if(start) begin
                busy <= 1'b1;
                prod = answer;
        end
        else begin
                busy <= 1'b0;
                prod <= 0;
        end
end

endmodule

