`timescale 1ns/1ns

module 			detailed_testbench;
parameter 		N = 8;
parameter 		DELAY = 30;

reg 			clk30x;
reg 			donext;
wire [15:0] 	yout;
wire [15:0] 	xin_d;
reg 			rst;
reg  [15:0] 	xin;

integer 		fout;
integer 		read_element32;
integer 		i;
reg [16-1:0] 	ip_data_mem [0:N-1] 	;


//------------------Instantiations----------------
//the element
systolic_wrapper array(xin,yout,xin_d, clk30x, donext, rst);

//------------------Assignments-------------------
//connecting the clk
always #(DELAY/DELAY) clk30x = ~clk30x;


//------------------Logic-------------------------
initial begin
  $readmemh("array_ip_data.list.matlab", ip_data_mem); // memory_list is memory file
end

initial
begin
	i				<= 0;
	rst	 			<= 1;
	clk30x 			<= 0;
	read_element32	<= 0;
	xin				<= 0;
	fout = $fopen("array_results_first.list")			;
	$fmonitor(fout,"%d %d",read_element32, (8+i-2)%8)	;
	$monitoroff;
	#(2*DELAY) rst 	<= 0;
	#(2*DELAY)donext<= 1;
	xin 			<= ip_data_mem[i];
	read_element32 	<= {(yout[15]==1)?16'b1111_1111_1111_1111:0,yout};
	#2 donext 		<= 0;
	$monitoron;
	for(i=1;i<3*N;i=i+1)
	begin
		#(2*DELAY) donext	<= 1				;
		xin 				<= ip_data_mem[i%N]	;
		read_element32 		<= {(yout[15]==1)?16'b1111_1111_1111_1111:0,yout};
		#2 donext 			<= 0				;
	end
	$monitoroff;	
	#(2*DELAY) rst 	<= 1;
	$fclose(fout);
	$finish;
end

endmodule		
