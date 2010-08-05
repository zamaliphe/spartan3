`timescale 1ns/100ps
`define TOP_NN2 8192	//N*N*2 (representing the total number of writes or data bytes)
`define TOP_DATA_WIDTH 16//Data width is the same
//IMPORTANT: HARDCODED DATA COLLECTOR
module detailed_2DTOP;

wire [`TOP_DATA_WIDTH-1:0] 	io_fft_data	;
reg  [`TOP_DATA_WIDTH-1:0] 	io_fft_data_r	;
reg 				i_fft_reset	;
reg 				i_fft_start	;
reg 				i_fft_base_clock;
wire 				o_TIP		;
wire 				o_busy		;

 
//Internal Registers           
reg 		is_input;
integer 	i	;
reg [`TOP_DATA_WIDTH-1:0] ip_data_mem[0:`TOP_NN2-1];  
integer j2;
reg [6:0]j1;

//Instantiation of the CUT
FFT2D fft2dtheja(
io_fft_data	,
i_fft_reset	,
i_fft_start	,
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
initial
begin
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
	for(i=0;i<`TOP_NN2;i=i+1)
	begin
		#2 io_fft_data_r <= ip_data_mem[i];
	end
	#2 is_input <= 0;
	
	//--------------------------
	//--------------------------
	//#4000 $finish; //Needs to be uncommented depending on the below block
	//--------------------------
end


//-------------data collection on stdout---------------------------------------
always #2 j1=j1+1;
always #2 j2 = {(io_fft_data[`TOP_DATA_WIDTH-1]==1)?16'b1111_1111_1111_1111:0,io_fft_data};
initial
begin
	//Only fft and write
	//	#19631 #19887	: One string: diff=256ns=128 cycles = 64 complex values
	//	#19631 #36015	:16384ns=8192cycles=64 rows of 64 complex values

	j1=0;
	j2=0;
        //#16549	//read followed by write
	//#17683	//read -> transpose -> write
	//#17311	//read -> semitranspose -> write
	//#26949	//full op
	//#19631	//Only fft and write
	//#20765	//only fft->transpose->write
		//	#19631 #19887	: One string: diff=256ns=128 cycles = 64 complex values
		//	#19631 #36015	:16384ns=8192cycles=64 rows of 64 complex values

	//#19631	//Only fft and write
	#28527		//full output with proper bit reversing
	//#22345		//fft+trans+bitrev+write

        j1 = -1;
        #2
        //$monitor("%d",j2);	//To disable indexing
        $monitor("%d %d",j2, j1);//To view indexing
        //#254 //for one	monitoring only 1 row.
	#16382	//to monitor all 64 rows of complex data
        $finish;
end
//-------------data collection on stdout---------------------------------------

/*
initial
begin
#20000 $finish;
end
*/

endmodule
