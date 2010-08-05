//PARAMETERS ARE DEPENDENT ON ALL THE SUPPORTING TEST BENCHES
// AND MODULE FILES CHANGING PARAMS IN ONLY 1FILE WILL CREATE PROBLEMS

// Running exhausive tests:

module mult_TOP3;
parameter MBITS = 12, NBITS = 8, DELAY = 5;

  reg [MBITS-1:0] mpd;
  reg [NBITS-1:0] mpr;
  reg [MBITS+NBITS-1:0] Correct;
  reg clk, start;
  reg Error;
  integer Tot_errors, Cycles;
  integer J,K;  
  wire [MBITS+NBITS-1:0] prod;
  wire busy;


/*The following codes go into each test bench...*/

initial
begin
        $recordfile("wave.trn");
        $recordvars();
//        #400 $finish;//you can change this value whenever you need.
end

/*End of reuse code*/



// Stopwatch
  initial begin
  #9000000 $finish;
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
		#(2*DELAY) for (K=2047; K>=-2047; K=K-1) begin
			for (J=127;J>=-127; J=J-1) begin
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

	always @ (posedge clk or busy) begin
		if(busy) Cycles = Cycles + 1;
		else #1 Cycles = -2;
		end
// Print information about each product calculated.

  task check;
    input [MBITS+NBITS-1:0] Correct;
    $display ("Time = %d, Cycles = %d, mpd = %h, mpr = %h, prod = %h,Correct prod = %h, Error = %h, T_Errors = %d",$time, Cycles, mpd, mpr, prod, Correct, Error, Tot_errors);
  endtask

// Module instances
mult theja (prod,mpd,mpr,clk,busy,start);

endmodule
