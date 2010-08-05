//test bed
`timescale 1ns/1ns

module booth_modified_TOP ;

parameter M_bits = 12, N_bits = 8;//UNFORTUNATELY HARD CODED
  reg [M_bits-1:0] mpd;
  reg [N_bits-1:0] mpr;
  reg start;
  wire [M_bits+N_bits-1:0] answer;
  wire busy;
  parameter Del = 10;

booth_modified bm01(answer,mpd,mpr,busy, start);

initial begin
	start <= 0;
	mpd <= 12'b0001_0000_0000;
	mpr <= 8'b0001_0000;

	#Del start = 1;

	#5*Del $finish;
end

initial
begin
       $recordfile("wave.trn");
       $recordvars();
      // #100 $finish;//you can change this value whenever you need.
end

/*End of reuse code*/
endmodule