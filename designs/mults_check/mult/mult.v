module mult(prod,mpd,mpr,clk,busy, start);

parameter M_bits = 12, N_bits = 8, Count_bits = 4;

output [M_bits+N_bits-1:0] prod;//final result...bits:
output busy;		        //busy flag

input [M_bits-1:0] mpd;//M bits
input [N_bits-1:0] mpr;//N bits....N<M...for omega
input clk;	       //Clock	
input start;	       //Starts the Multiplier

wire clk;
wire start;
wire [N_bits-1:0] mpr;
wire [M_bits-1:0] mpd;
wire [M_bits-1:0] sum, difference;//local wires to produce partial sum/diff
wire busy;//Output wired. CAUTION.


//reg [M_bits+N_bits-1:0] prod;


//Internal registers
reg [M_bits-1:0]A;//partial product
reg [N_bits-1:0]Q;//multiplier
reg [M_bits-1:0]M;//Multiplicand
reg Q_1;	  //1 bit reg for 01,11,10 bit sequence checking in multiplier
reg [Count_bits-1:0] count;// Counts the number of cycles


always @(posedge clk)
begin
   if (start) begin
      A <= 0;      //partial product init to 0
      M <= mpd;		//multiplicand loaded to internal reg..:Necessary?
      Q <= mpr;		//Multiplier loaded to internal reg..:Necessary?
      Q_1 <= 1'b0;      // sequence checking bit reg init. to 0
      count <= 4'b0;	//Theja_didnt
   end
   else begin
      case ({Q[0], Q_1})
         2'b0_1 : {A, Q, Q_1} <= {sum[M_bits-1], sum, Q};
         2'b1_0 : {A, Q, Q_1} <= {difference[M_bits-1], difference, Q};
         default: {A, Q, Q_1} <= {A[M_bits-1], A, Q};
      endcase
      count <= count + 1'b1;
   end
end

alu adder (sum, A, M, 1'b0);
alu subtracter (difference, A, ~M, 1'b1);

assign prod = {A, Q};
assign busy = (count < N_bits);

endmodule



//-------------------2nd MODULE---------------------------- 
//The following is an alu.  
//It is an adder, but capable of subtraction:
//Subtraction means adding the two's complement--
//a - b = a + (-b) = a + (inverted b + 1)
//The 1 will be coming in as cin (carry-in)
module alu(out, a, b, cin);

parameter M_bits = 12 ;

output [M_bits-1:0] out;
input [M_bits-1:0] a;
input [M_bits-1:0] b;
input cin;

assign out = a + b + cin;

endmodule
//---------------------------------------------------------
