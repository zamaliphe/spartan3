module cla_testbench;


reg [3:0]a;
reg [3:0]b;
reg c_in;

wire [3:0] answer;
wire c_out;

carry_look_ahead_4bit cla4b00 (a,b,c_in,answer,c_out);

initial begin
a = 4'b1010;
b = 4'b0110;
c_in = 1'b0;
#50 
a = 4'b1010;
b = 4'b0110;
c_in = 1'b1;

$finish;
end
initial
begin
       $recordfile("clawave.trn");
       $recordvars();
      // #100 $finish;//you can change this value whenever you need.
end

/*End of reuse code*/


endmodule

