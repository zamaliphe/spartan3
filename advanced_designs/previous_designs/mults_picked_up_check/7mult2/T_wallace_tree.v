module T_wallace_tree;
parameter MBITS =12, NBITS = 8;

reg [MBITS:0]pp0;
reg [MBITS:0]pp1;//13 bits in total
reg [MBITS:0]pp2;
reg [MBITS:0]pp3;

wire answer;

wallace_tree wa01 (pp0,pp1,pp2,pp3,answer);

initial begin
pp0 = 0;
pp1 = 2;
pp2 = 4;
pp3 = 8;

#50 $finish;
end
initial
begin
       $recordfile("wave.trn");
       $recordvars();
      // #100 $finish;//you can change this value whenever you need.
end

/*End of reuse code*/


endmodule
