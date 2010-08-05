
`timescale 1ns/10ps

module detailed_TOP;

parameter N = 64;
parameter DATA_WIDTH=16;
parameter K = 6;	//log2(N)
parameter STAGE_WIDTH = 3;




wire [DATA_WIDTH-1:0] 	io_fft_data	;
reg  [DATA_WIDTH-1:0] 	io_fft_data_r	;
reg 			i_fft_reset	;
reg 			i_fft_start	;
reg 			i_fft_base_clock;
wire 			o_TIP		;
wire 			o_busy		;
wire [DATA_WIDTH-1:0] 	input_butter	;
wire [DATA_WIDTH-1:0] 	output_butter	;
wire [K-1:0] 		opCount		;
wire [STAGE_WIDTH-1:0] 	stage		; 


 
//Internal Registers           
reg 		is_input		;
integer 	i			;
reg 	[DATA_WIDTH-1:0] 	ip_data_mem [0:2*N-1] 	;  //Rom's internal fixed memory cells (8bit * 512 locations)
integer 	j			;
integer 	k			;
integer		n			;
integer 	br			;
integer 	bi			;
integer 	br_wr			;
integer 	bi_wr			;
integer 	br_wi			;
integer 	bi_wi			;
integer 	ar			;
integer 	ai			;
integer 	pr			;
integer 	pi			;
integer 	r1r			;
integer 	r1i			;
integer 	r2r			;
integer 	r2i			;
integer 	wr			;
integer 	wi			;
integer 	j1			;
integer 	j2			;
reg [DATA_WIDTH-1:0] temp		;
reg 		error			;
integer 	diff			;


FFT1d_complete fft01(
io_fft_data,
i_fft_reset,
i_fft_start,
i_fft_base_clock,
o_TIP,
o_busy,
input_butter,
output_butter,
stage,
opCount
);



initial begin
  $readmemb("ip_data.list", ip_data_mem); // memory_list is memory file
end


always #2 i_fft_base_clock = ~i_fft_base_clock;


assign io_fft_data = (is_input)?io_fft_data_r:16'bz;	//HARDCODED
initial
begin
        $recordfile("wave.trn");
        $recordvars();
end
initial
begin
	i_fft_reset 	<= 1;
	i_fft_start 	<= 0;
	i_fft_base_clock<= 0;
	io_fft_data_r 	<= 0;
	is_input 	<= 1;
	#5
	i_fft_reset 	<= 0;
	i_fft_start 	<= 1;
	#4 	
	for(i=0;i<2*N;i=i+1)
	begin
		#4 io_fft_data_r <= ip_data_mem[i];
	end
	#4 is_input <= 0;
end


//------------------one group---------------------------------------

always #4 j1=j1+1;
always #4 j2 = {(io_fft_data[15]==1)?16'b1111_1111_1111_1111:0,io_fft_data};	//HARDCODED
initial				//COMMENT AFTER UNCOMMENTING $FINISH ABOVE
begin
//	#79930	//This is for 512	//HARDCODED
	#6970	//This is for 256	//HARDCODED
	j1 = 0;
	#4
	$monitor("%d %d",j2, j1);
//	#4092	//This is for 512	//HARDCODED
	#508	//This is for 256 	//HARDCODED
	$finish;
end
//------------------one group---------------------------------------
							


endmodule
