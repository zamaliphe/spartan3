module mult_TOP2;
parameter M_bits = 12, N_bits = 8;
  reg [M_bits-1:0] Mpd;
  reg [N_bits-1:0] Mpr;
  reg [M_bits+N_bits-1:0] Correct;
  reg Clk, Start;
  reg Error;
  integer	Tot_errors, Cycles;
  integer J,K;  
  wire [M_bits+N_bits-1:0] Prod;
  wire Busy;
  parameter Del = 5;

// Stopwatch
  initial begin
  #9000000 $finish;
  end

// Clock generator
	initial begin Clk = 0; forever #Del Clk = ~Clk; end

/* Initialize certain startup variables. 
Loop and generate potentially exhaustive sequence
of multiplier and multiplicand values.
Gather data about any incorrect products that might be calculated. */

	initial begin
		Start = 0;
		Tot_errors = 0;
		Cycles = -2;
		#(2*Del) for (K=127; K>=-127; K=K-1) begin
			for (J=127;J>=-127; J=J-1) begin
				Mpd = K;
				Mpr = J;
				Correct = K*J;
				Error = 0;
				@(posedge Clk) Start = 1;
				#(2*Del) Start = 1'b0;
				@(negedge Busy) if (Correct-Prod) Error = 1;
				Tot_errors = Tot_errors + Error;
				//$display("Test");
				$strobe("Time = %d, Cycles = %d, Mpd = %b, Mpr = %b, Prod = %b, Correct prod = %b, Error = %h, T_Errors = %d",$time, Cycles, Mpd, Mpr, Prod, Correct, Error, Tot_errors);
				end
			end 
		end

/* Calculate number of cycles to perform each multiplication. The value -2 
compensates for extra cycles that are included in the count.*/

	always @ (posedge Clk or Busy) begin
		if(Busy) Cycles = Cycles + 1;
		else #1 Cycles = -2;
		end

// Module instances
mult B (Prod, Mpd, Mpr, Clk,busy, Start);


initial
begin
        $recordfile("wave.trn");
        $recordvars();
//        #100 $finish;//you can change this value whenever you need.
end

/*End of reuse code*/



endmodule
