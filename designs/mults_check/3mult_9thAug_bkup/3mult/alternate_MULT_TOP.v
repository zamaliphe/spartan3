//test bed
`timescale 1ns/1ns

module alternate_MULT_TOP ;

parameter M_bits = 12, N_bits = 8;//UNFORTUNATELY HARD CODED
  reg [M_bits-1:0] mpd;
  reg [N_bits-1:0] mpr;
  reg start;
  wire [M_bits+N_bits-1:0] answer;
  wire busy;
  parameter Del = 10;

booth_encode bm01(mpd,mpr,start,busy,answer);

initial begin
	start <= 0;
	mpd <= 12'b1111_0000_0000;
	mpr <= 8'b1111_0000;

	#Del start = 1;

	#(5*Del) $finish;
end

initial
begin
       $recordfile("wave.trn");
       $recordvars();
      // #100 $finish;//you can change this value whenever you need.
end

/*End of reuse code*/
endmodule
