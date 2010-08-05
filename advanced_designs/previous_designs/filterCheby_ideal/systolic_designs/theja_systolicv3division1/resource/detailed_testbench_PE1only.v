`timescale 1ns/1ns

module 			detailed_testbench;
parameter 		N = 8;
parameter 		DELAY = 30;

reg 			clk30x;
wire [15:0] 	yout;
reg 			rst;
reg  [15:0] 	xin;

integer 		fout;
integer 		read_element32;
integer 		i;
reg [16-1:0] 	ip_data_mem [0:N-1] 	;


//------------------Instantiations----------------
//the element
systolic_PE1 pe1(xin,yout,clk30x, rst);

//------------------Assignments-------------------
//connecting the clk
always #(DELAY/30) clk30x = ~clk30x;


//------------------Logic-------------------------
initial begin
  $readmemh("pe_ip_data.list.matlab", ip_data_mem); // memory_list is memory file
end

initial
begin
	i		<= 0;
	rst	 	<= 1;
	clk30x 		<= 0;
	read_element32	<= 0;
	xin		<= 0;
	fout = $fopen("pe_results_first.list");
	//#(3*DELAY) 	rst <= 0; //NOTE: starts the filter.
	$fmonitor(fout,"%d %d",read_element32, i);
	$monitoroff;
	for(i=0;i<N;i=i+1)
	begin
		#(2*DELAY) rst 		<= 0;
		xin <= ip_data_mem[i];
		read_element32 <= {(yout[15]==1)?16'b1111_1111_1111_1111:0,yout};
		$monitoron;
	end
	$monitoroff;
	for(i=0;i<N;i=i+1)
	begin
		#(2*DELAY) xin <= ip_data_mem[i];
		read_element32 <= {(yout[15]==1)?16'b1111_1111_1111_1111:0,yout};
		$monitoron;
	end
	$monitoroff;
	for(i=0;i<N;i=i+1)
	begin
		#(2*DELAY) xin <= ip_data_mem[i];
		read_element32 <= {(yout[15]==1)?16'b1111_1111_1111_1111:0,yout};
		$monitoron;
	end
	
	#(2*DELAY) rst <= 1;
	$fclose(fout);
	$finish;
end

endmodule		
