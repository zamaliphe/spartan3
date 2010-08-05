module test_case;
integer a;
integer b;
integer c;
reg [16:0]d;
reg e;
reg [16:0]f;

initial begin
a = 0;
b = 0;
c = 0;
e = 1'b0;
d = 17'b01001110001000000;
f = 0;
#20 	a = -200;
	b = -200;

#10	c = a*b;
	f = a*b;
// f = c[16:0];
if(f==d) e = 1'b0;
else e = 1'b1;
#20 $finish;

end


/*The following codes go into each test bench...*/

initial
begin
        $recordfile("wave.trn");
        $recordvars();
//        #400 $finish;//you can change this value whenever you need.
end

/*End of reuse code*/

endmodule
