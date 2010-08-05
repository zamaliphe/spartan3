//test bed
// how to design_analyser if a group of v files
//Exhausive test bench

`timescale 1ns/1ns

module alternate_MULT_TOP2 ;

parameter M_bits = 12, N_bits = 8;//UNFORTUNATELY HARD CODED
  reg [M_bits-1:0] mpd;
  reg [N_bits-1:0] mpr;
  reg start;
  reg clk;	
  wire [M_bits+N_bits-1:0] prod;
  wire busy;
  parameter Del = 10;


initial begin clk = 0; forever #Del clk = ~clk; end


top_layer bm01(mpd,mpr,start,clk,busy,prod);

initial begin
	start <= 0;
	mpd <= 12'b1111_1111_1111;
	mpr <= 8'b1111_1111;

	#(Del-1) start = 1;

	#Del	start <= 0;
	mpd <= 12'b0111_1101_1111;
	mpr <= 8'b0111_0111;

	#Del start = 1;
	
	#Del	start <= 0;
	mpd <= 12'b0110_1101_1101;
	mpr <= 8'b1111_1111;

	#Del start = 1;

	#Del	start <= 0;
	mpd <= 12'b1000_1011_0111;
	mpr <= 8'b0001_1111;

	#Del start = 1;

	#Del	start <= 0;
	mpd <= 12'b0;
	mpr <= 8'b0;

	#Del start = 1;

	#Del	start <= 0;
	mpd <= 12'b1010_1010_1011;
	mpr <= 8'b1101_1111;

	#Del start = 1;







	

	#Del $finish;
end

initial
begin
       $recordfile("wave.trn");
       $recordvars();
      // #100 $finish;//you can change this value whenever you need.
end

/*End of reuse code*/
endmodule
