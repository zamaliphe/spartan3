module mult_TOP;

parameter M_bits = 12, N_bits = 8;
reg clk;
reg start;
reg [M_bits-1:0] mpd;
reg [N_bits-1:0] mpr;
//mpr should not exceed 1100011 which is 99 assuming there is a fixed pt after the first sign bit in mpr
//mpd should be at max sign_111.XXXX_XXXX and at min sign_000.XXXX_XXXX
//Claim : No padding required for multiplier. final result*2^-4 is the answer
  
wire [M_bits+N_bits-1:0] prod;
wire busy;

mult multiplier(prod,mpd, mpr, clk, busy, start);


/*The following codes go into each test bench...*/

initial
begin
        $recordfile("wave.trn");
        $recordvars();
//        #100 $finish;//you can change this value whenever you need.
end

/*End of reuse code*/


initial begin
clk = 0;
$display("first example: mpd = 1 b = 64");
mpd <= 12'b0001_0000_0000; mpr <= 8'b0_100_0000; start = 1; #50 start = 0;
#80 $display("first example done");
$display("second example: mpd = -5.0 mpr = 64(or 0.64 if you call it like that)");
mpd <= 12'b1_010_0000_0001; mpr <= 8'b0_100_0000; start = 1; #50 start = 0;
#80 $display("second example done");
$finish;
end

always #5 clk = !clk;

always @(posedge clk) $strobe("prod: %b busy: %d at time=%t", prod, busy, $stime);

endmodule
