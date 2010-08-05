module temp_MultTOP;
wire[31:0] PROD;
reg[15:0] A,B;
wire [31:0] extendedA, extendedB;
integer iprod,ia,ib;

always #1 iprod <= PROD;
always #1 ia <= extendedA;
always #1 ib <= extendedB;


Butterfly_Mult theja(A,B,PROD);
initial
begin
A=-25;B=25;
#20 A=19;B=-2;
#20 A=-19;B=-25;
#20 $finish;
end

assign extendedA = {(A[15]==1)?16'b1111_1111_1111_1111:0,A};
assign extendedB = {(B[15]==1)?16'b1111_1111_1111_1111:0,B};

initial
begin
$monitor("%d %d %d",iprod,ia,ib);
end
endmodule








