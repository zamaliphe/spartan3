`timescale 1ns/1ns
module detailed_testbench;
parameter N = 4096;

reg 			clk;
wire [15:0] 	yout;
reg 			rst;
reg  [15:0] 	xin;
wire clk_en;

integer 	count;
integer 	fout;
integer read_element32;
integer 	i;
reg [16-1:0] 	ip_data_mem [0:N-1] 	;
//------------------Instantiations----------------

//the filter
filter_ideal f001(clk,clk_en, rst,xin, yout);

//------------------Assignments-------------------
assign clk_en = 1'b1;
//connecting the clk
always #1 clk = ~clk;


//------------------Logic-------------------------
initial begin
  $readmemb("ip_data.list.matlab", ip_data_mem); // memory_list is memory file
end

initial
begin
	i		<= 0;
	rst	 	<= 1;
	clk 		<= 0;
	read_element32	<= 0;
	xin		<= 0;
	fout = $fopen("results_first.list");
	#3 rst 		<= 0;	//NOTE: starts the filter.
	$fmonitor(fout,"%d %d",read_element32, i);
	$monitoroff;
	for(i=0;i<N;i=i+1)
	begin
		#2 xin <= ip_data_mem[i];
		read_element32 <= {(yout[15]==1)?16'b1111_1111_1111_1111:0,yout};
		$monitoron;
	end
	
	#2 rst <= 1;
	$fclose(fout);
	$finish;
end

endmodule		
