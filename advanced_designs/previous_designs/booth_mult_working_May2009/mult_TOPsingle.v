//PARAMETERS ARE DEPENDENT ON ALL THE SUPPORTING TEST BENCHES
// AND MODULE FILES CHANGING PARAMS IN ONLY 1FILE WILL CREATE PROBLEMS

module mult_TOPsingle;
parameter MBITS = 16, NBITS = 16, DELAY = 5;

reg [MBITS-1:0] mpd;
reg [NBITS-1:0] mpr;
wire [MBITS+NBITS-1:0] prod;
reg clk, start;
wire busy;
integer Cycles;
wire [31:0] extendedmpr, extendedmpd, extendedprod;
integer impr,impd,iprod;

// Clock generator
initial begin clk = 1; forever #DELAY clk = ~clk; end

/* Initialize certain startup variables. 
The values will be 32bit wide
Gather data about any incorrect products that might be calculated. */

initial begin
	start = 0;
	Cycles = -2;
	mpd = 10;
	mpr = -10;
	#DELAY start = 1;
	#(2*DELAY) start = 1'b0;
	#(34*DELAY)
	Cycles = -2;
	mpd = 10;
	mpr = 10;
	#DELAY start = 1;
	#(2*DELAY) start = 1'b0;
	#(34*DELAY) $finish;
end

always @ (posedge clk) 
begin
	if(busy) Cycles = Cycles + 1;
	else #1 Cycles = -2;
end

/* Calculate number of cycles to perform each multiplication. The value -2 
compensates for extra cycles that are included in the count.*/
	assign extendedmpd = {(mpd[15]==1)?16'b1111_1111_1111_1111:0,mpd};
	assign extendedmpr = {(mpr[15]==1)?16'hFFFF:0,mpr};
	assign extendedprod = prod;
	always #1 impd <= extendedmpd;
	always #1 impr <= extendedmpr;
	always #1 iprod <= extendedprod;


// Print information about each product calculated.
initial begin
    $monitor("Cycles = %d, mpd = %d, mpr = %d, prod (readable) = %d",Cycles, impd, impr, iprod);
end

// Module instances
mult theja (prod,mpd,mpr,clk,busy,start);

endmodule
