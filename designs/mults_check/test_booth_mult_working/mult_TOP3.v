//PARAMETERS ARE DEPENDENT ON ALL THE SUPPORTING TEST BENCHES
// AND MODULE FILES CHANGING PARAMS IN ONLY 1FILE WILL CREATE PROBLEMS

// Running exhausive tests:

module mult_TOP3;
parameter MBITS = 12, NBITS = 8, DELAY = 5;

  reg [MBITS-1:0] mpd;
  reg [NBITS-1:0] mpr;
  reg signed [MBITS+NBITS-1:0] Correct;
  reg clk, start;
  reg Error;
  integer Tot_errors, Cycles;
  integer J,K;  
  wire [MBITS+NBITS-1:0] prod;
  wire busy;
	wire [31:0] extendedmpr, extendedmpd, extendedprod, extendedCorrect;
	integer iprod,impd,impr,iCorrect;

/*The following codes go into each test bench...*/
/*
initial
begin
        $recordfile("wave.trn");
        $recordvars();
//        #400 $finish;//you can change this value whenever you need.
end
*/
/*End of reuse code*/



// Stopwatch
  initial begin
  #9000 $finish;
  end

// Clock generator
	initial begin clk = 0; forever #DELAY clk = ~clk; end

/* Initialize certain startup variables. 
Loop and generate potentially exhaustive sequence
of multiplier and multiplicand values.
The valuse will be 19bit
Gather data about any incorrect products that might be calculated. */

	initial begin
		start = 0;
		Tot_errors = 0;
		Cycles = -2;
		#(2*DELAY) for (K=3; K>=3; K=K-1) begin
			for (J=7;J>=-7; J=J-1) begin
				mpd = K;
				mpr = J;
				Correct = K*J;
				Error = 0;
				@(posedge clk) start = 1;
				#DELAY start = 1'b0;
				@(negedge busy) if (Correct-prod) Error = 1;
				Tot_errors = Tot_errors + Error;
				check (Correct);
				end
			end 
		end

/* Calculate number of cycles to perform each multiplication. The value -2 
compensates for extra cycles that are included in the count.*/
	always #1 iprod <= extendedprod;
	always #1 impd <= extendedmpd;
	always #1 impr <= extendedmpr;
	always #1 iCorrect <= extendedCorrect;
	assign extendedprod = {(prod[19]==1)?12'hFFF:0,prod};
	assign extendedCorrect = {(Correct[19]==1)?12'hFFF:0,Correct};
	assign extendedmpd = {(mpd[11]==1)?20'b1111_1111_1111_1111_1111:0,mpd};
	assign extendedmpr = {(mpr[7]==1)?24'hFFFFFF:0,mpr};

	always @ (posedge clk or busy) begin
		if(busy) Cycles = Cycles + 1;
		else #1 Cycles = -2;
		end
// Print information about each product calculated.

  task check;
    input [MBITS+NBITS-1:0] Correct;
    $display ("Time = %d, Cycles = %d, mpd = %d, mpr = %d, prod = %d,Correct prod = %d, Correct prod (readable) = %d,Error = %h, T_Errors = %d",$time, Cycles, impd, impr, prod, Correct, iCorrect, Error, Tot_errors);
  endtask

// Module instances
mult theja (prod,mpd,mpr,clk,busy,start);

endmodule
