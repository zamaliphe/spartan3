`timescale 1ns/1ns

module 			detailed_testbench;
parameter 		N = 8;
parameter 		DELAY = 60;

reg 			clk30x;
reg  [32-1:0]	timing;
wire [15:0] 	yout;
reg 			rst;
reg  [15:0] 	xin;

integer 		fout;
integer 		read_element32;
integer 		i;
reg [16-1:0] 	ip_data_mem [0:N-1] 	;


//------------------Instantiations----------------
//the element
citi iirsummer(xin,yout,clk30x, timing, rst);

//------------------Assignments-------------------
//connecting the clk
always #(DELAY/DELAY) clk30x = ~clk30x;


//------------------Logic-------------------------
initial begin
  $readmemh("citi_ip_data.list.matlab", ip_data_mem); // *.list.* is memory file in hex/binary format!
end

initial
begin
	timing	<= DELAY-1;
	i		<= 0;
	rst	 	<= 1;
	clk30x 		<= 0;
	read_element32	<= 0;
	xin		<= 0;
	fout = $fopen("citi_results_first.list");
	$fmonitor(fout,"%d %d",read_element32, (8+i-2)%8);
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
