//PARAMETERS ARE DEPENDENT ON ALL THE SUPPORTING TEST BENCHES
// AND MODULE FILES CHANGING PARAMS IN ONLY 1FILE WILL CREATE PROBLEMS

module mult(xProd,xMpd,mpr,wClk,busy, start);

parameter MBITS = 12, NBITS = 8, COUNTBITS = 4;
//Note param MBITS also linked with alu.v's param MBITS

output [MBITS+NBITS-1:0] xProd;//final result...bits:
output busy;		        //busy flag

input [MBITS-1:0] xMpd;//M bits
input [NBITS-1:0] mpr;//N bits....N<M...for omega
input wClk;	       //Clock	
input start;	       //Starts the Multiplier

wire wClk;
wire start;
wire [NBITS-1:0] mpr;
wire [MBITS-1:0] xMpd;
wire [MBITS-1:0] sum, difference;//local wires to xProduce partial sum/diff



reg [MBITS+NBITS-1:0] xProd;
reg busy;
reg [MBITS-1:0]A;//partial xProduct
reg [NBITS-1:0]Q;//multiplier
reg rSequenceBit;	  //1 bit reg for 01,11,10 bit sequence checking in multiplier
reg [COUNTBITS-1:0] count;// Counts the number of cycles

always @(posedge start)begin
	busy <= 1'b1;

end

always @(posedge wClk)
begin
   if (start) begin
      A <= 0;      //partial xProduct init to 0
      Q <= mpr;		//Multiplier loaded to internal reg..:Necessary?
      rSequenceBit <= 1'b0;      // sequence checking bit reg init. to 0
      count <= 0;	//counting the operations
      xProd <= 0;
   end
   else if (count==NBITS) begin
	 xProd <= {A, Q};
	 busy <= 1'b0;
   end
   else begin
      case ({Q[0], rSequenceBit})
         2'b0_1 : {A, Q,rSequenceBit} <= {sum[MBITS-1], sum, Q};
         2'b1_0 : {A, Q,rSequenceBit} <= {difference[MBITS-1], difference, Q};
         default: {A, Q,rSequenceBit} <= {A[MBITS-1], A, Q};
      endcase
      count <= count + 1'b1;
	 //xProd <= {A, Q};
   end
end

alu adder (sum, A, xMpd, 1'b0);
alu subtracter (difference, A, ~xMpd, 1'b1);

endmodule
