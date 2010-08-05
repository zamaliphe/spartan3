`timescale 1ns/100ps
`define TOP_NN2 8192	//N*N*2 (representing the total number of writes or data bytes)
`define TOP_DATA_WIDTH 16//Data width is the same
//IMPORTANT: HARDCODED DATA COLLECTOR
module detailed_2DTOP;

wire [`TOP_DATA_WIDTH-1:0] 	io_fft_data	;
reg  [`TOP_DATA_WIDTH-1:0] 	io_fft_data_r	;
reg 				i_fft_reset	;
reg 				i_fft_start	;
reg 				i_read_rom_ram	;
reg 				i_fft_base_clock;
wire 				o_TIP		;
wire 				o_busy		;

 
//Internal Registers           
reg 		is_input;
integer 	i	;
reg [`TOP_DATA_WIDTH-1:0] ip_data_mem[0:`TOP_NN2-1];  
integer j2;
reg [6:0]j1;

//file added by sam 30/08
integer fout;

//Instantiation of the CUT
FFT2D fft2dtheja(
io_fft_data	,
i_fft_reset	,
i_fft_start	,
i_read_rom_ram  ,
i_fft_base_clock,
o_TIP		,
o_busy		
);


//Reading input from file
initial begin
  $readmemb("ip_data.list", ip_data_mem); 
end

//Clock
always #1 i_fft_base_clock = ~i_fft_base_clock;

//Simvision Related
initial
begin
        $recordfile("wave.trn");
        $recordvars();
end

//Logic
assign io_fft_data = (is_input)?io_fft_data_r:`TOP_DATA_WIDTH'bz;


//--------------------------FIRST TIME --------------------------------------------------
//-------------data input and collection on stdout---------------------------------------
initial
begin
	fout = $fopen("results_first.list");
	i_read_rom_ram <= 1;	//Change this to 0 and insert initialization values in BRAMS. 20080831 Theja.
	i_fft_reset 	<= 1;
	i_fft_start 	<= 0;
	i_fft_base_clock<= 0;
	io_fft_data_r 	<= 0;
	is_input 	<= 0;
	#3
	i_fft_reset 	<= 0;
	i_fft_start 	<= 1;
	//--------------------------
	
	is_input 	<= 1;
	#2
	i_fft_start 	<= 0; 	
	for(i=0;i<`TOP_NN2;i=i+1)
	begin
		#2 io_fft_data_r <= ip_data_mem[i];
	end
	#2 is_input <= 0;
	
end

always #2 j1=j1+1;
always #2 j2 = {(io_fft_data[`TOP_DATA_WIDTH-1]==1)?16'b1111_1111_1111_1111:0,io_fft_data};

initial
begin
	j1=0;
	j2=0;

	#28527				//time required from start of sim. full 2dfft output with proper bit reversing

        j1 = -1;
        #2
	$fmonitor(fout,"%d %d",j2, j1);
        $monitor("%d %d",j2, j1);	//To view indexing on stdout/screen
	#16382				//to monitor all 64 rows of complex data
	$monitoroff;	
	$fclose(fout);
//	$finish;
end
//-------------data collection on stdout---------------------------------------



//******ENSURE $finish is present/not-present before commenting/un-commenting this *******

//--------------------------SECOND TIME -------------------------------------------------
//Check that: 	1. operation is happening correctly for the second time.
//		2. ram to rom copying doens't happen at all irrespective of input.
//		3.
//-------------data input and collection on stdout---------------------------------------
initial
begin
	#45000 //first operation is completed and the unit is stalling, doing nothing.
	//$finish;
	fout = $fopen("results_second.list");
	i_read_rom_ram <= 1;	//Change this to 0 and insert initialization values in BRAMS. 20080831 Theja.
	io_fft_data_r 	<= 0;
	#3
	i_fft_start 	<= 1;
	//--------------------------
	
	is_input 	<= 1;
	#2
	i_fft_start 	<= 0; 	
	for(i=0;i<`TOP_NN2;i=i+1)
	begin
		#2 io_fft_data_r <= ip_data_mem[i];	//reading the same data again.
	end
	#2 is_input <= 0;
end

initial
begin
	j1=0;
	j2=0;
	
	//#28527			//time required from start of sim. full 2dfft output with proper bit reversing
	#73393				//45000 + 28393 (since some cycles are removed from ROM to RAM copying.)

        j1 = -1;
        #2
	$monitoron;
	#16382				//to monitor all 64 rows of complex data
		
	$fclose(fout);
	$finish;
end
//-------------data collection on stdout---------------------------------------



endmodule
