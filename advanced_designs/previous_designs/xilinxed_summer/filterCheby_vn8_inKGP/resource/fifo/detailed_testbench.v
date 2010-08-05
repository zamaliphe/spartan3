`timescale 1ns/1ns

module 			detailed_testbench;
parameter 		N = 8;
parameter 		DELAY = 30;

reg 			clk30x;
reg 			wr_cs;
reg 			rd_cs;
reg 			rd_en;
reg 			wr_en;
wire [15:0] 	yout;
reg 			rst;
reg  [15:0] 	xin;
wire			empty;
wire 			full;


integer 		fout;
integer 		read_element32;
integer 		i;
reg [16-1:0] 	ip_data_mem [0:N-1] 	;


//------------------Instantiations----------------
//the element
syncFifo fifo(
clk30x   , // Clock input
rst      , // Active high reset
wr_cs    , // Write chip select
rd_cs    , // Read chip select
xin	     , // Data input
rd_en    , // Read enable
wr_en    , // Write Enable
yout     , // Data Output
empty    , // FIFO empty
full       // FIFO full
);

//------------------Assignments-------------------
//connecting the clk
always #(DELAY/DELAY) clk30x = ~clk30x;


//------------------Logic-------------------------
initial begin
  $readmemh("fifo_ip_data.list.matlab", ip_data_mem); // *.list.* is memory file in hex/binary format!
end

initial
begin
	i				<= 0;
	rst	 			<= 1;
	clk30x 			<= 0;
	read_element32	<= 0;
	xin				<= 0;
	wr_cs			<= 0;
	rd_cs			<= 0;
	wr_en			<= 0;
	rd_en			<= 0;
	fout = $fopen("fifo_results_first.list")			;
	$fmonitor(fout,"%d %d",read_element32, (8+i-2)%8)	;
	$monitoroff;
	#(2*DELAY) rst 	<= 0;
	#(2*DELAY)wr_cs <= 1;
	rd_cs			<= 1;
	xin 			<= ip_data_mem[0];
	wr_en			<= 1;
	#2	wr_en		<= 0;
	#2	rd_en		<= 1;
	#2	read_element32 	<= {(yout[15]==1)?16'b1111_1111_1111_1111:0,yout};
		rd_en		<= 0;
	#2	$fclose(fout);
	$finish;
end

endmodule
