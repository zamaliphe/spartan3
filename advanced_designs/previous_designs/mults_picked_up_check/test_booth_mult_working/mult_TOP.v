module mult_TOP;

parameter MBITS = 12, NBITS = 8;
reg clk;
reg start;
reg [MBITS-1:0] mpd;
reg [NBITS-1:0] mpr;
//mpr should not exceed 1100011 which is 99 assuming there is a fixed pt after the first sign bit in mpr
//mpd should be at max sign_111.XXXX_XXXX and at min sign_000.XXXX_XXXX
//Claim : No padding required for multiplier. final result*2^-4 is the answer
  
wire [MBITS+NBITS-1:0] prod;
wire busy;

mult multiplier(prod,mpd, mpr, clk, busy, start);


/*The following codes go into each test bench...*/

initial
begin
        $recordfile("wave.trn");
        $recordvars();
        #400 $finish;//you can change this value whenever you need.
end

/*End of reuse code*/


initial begin
clk = 0;
//$display("first example: mpd = 1 b = .5");
mpd <= 12'b0001_0000_0000; mpr <= 8'b0_100_0000; start = 1; #10 start = 0;
// the mpd is +ve and the mpr is +ve too. Only the 8th bit in mpr and the 12 th bit in mpd are sign bits
//#100 $display("first example done");
//$display("second example: mpd = -5.0(neg. no  in 2's compl form assum. ist 3 bit before dec.) mpr =  0.5 if you call it like that)");
#120
mpd <= 12'b1_011_0000_0000; mpr <= 8'b0_100_0000; start = 1; #10 start = 0;
//the mpd is in the 2's compl form since the first bit is 1(sign bit). The mpr is +ve.
//#100 $display("second example done");
//$finish;
end

always #5 clk = !clk;

//always @(posedge clk) $strobe("prod: %b busy: %d at time=%t", prod, busy, $stime);

endmodule
