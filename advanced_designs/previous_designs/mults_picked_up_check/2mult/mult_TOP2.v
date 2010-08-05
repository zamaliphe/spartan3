`timescale 1ns/1ns

module mult_TOP2;
parameter M_bits = 12, N_bits = 8;//UNFORTUNATELY HARD CODED
  reg [M_bits-1:0] Mpd;
  reg [N_bits-1:0] Mpr;
  reg [M_bits+N_bits-1:0] Correct;
  reg Clk, Start;
  wire [M_bits+N_bits-1:0] Prod;
  wire Busy;
  parameter Del = 10;

// Stopwatch
  initial begin
  #90000 $finish;
  end

// Clock generator
	initial begin Clk = 0; forever #Del Clk = ~Clk; end

/* Initialize certain startup variables. 
Loop and generate potentially exhaustive sequence
of multiplier and multiplicand values.
Gather data about any incorrect products that might be calculated. */

	initial begin
		Start = 0;
		$display("the loop has started");
		Mpd <= 12'b000000000000;
		Mpr <= 8'b00000000;


		repeat(127) begin
			repeat(127) begin
				#(2*Del) Mpd <= Mpd + 12'b000000000001;
				@(posedge Clk) Start = 1;
				#Del Start = 1'b0;
				$display("Mpd = %b, Mpr = %b, Prod = %b", Mpd, Mpr, Prod);

			end
			#(2*Del)Mpr <= Mpr + 8'b00000001;
		end
	end

/* Calculate number of cycles to perform each multiplication. The value -2 
compensates for extra cycles that are included in the count.*/

//	always @ (posedge Clk or Busy) begin
//		if(Busy) Cycles = Cycles + 1;
//		else #1 Cycles = -2;
//		end

// Module instances
mult B (Prod, Mpd, Mpr, Clk,busy, Start);


//initial
//begin
//        $recordfile("wave.trn");
//        $recordvars();
//        #100 $finish;//you can change this value whenever you need.
//end

/*End of reuse code*/



endmodule
