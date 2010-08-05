`include "00defines.v"

module detailed_testbench;


reg clk;
reg read_output; //Finally reading the contents of the BRAMs for plotting etc.
reg FFT_reset;
wire FFT_busyflag;
wire FFT_chooseIFFT;

//do not change the MB_* signals
wire MB_is_acting;
wire [11:0] MB_addr;
wire [31:0] MB_din;
wire [31:0] MB_dout;
wire MB_we;

wire [511:0] FFT_dataa; //tristate data portA (32*16 bit)
wire [511:0] FFT_datab; //tristate data portB (32*16 bit)
wire [287:0] FFT_addra; //address portA (32*9 bit)
wire [287:0] FFT_addrb; //address portB (32*9 bit)
wire [31:0] FFT_wea; //write enable portA (32*1 bit)
wire [31:0] FFT_web; //write enable portB (32*1 bit)
wire [31:0] FFT_rea; //read (tri-state) enable portA (32*1 bit)
wire [31:0] FFT_reb; //read (tri-state) enable portB (32*1 bit)

wire [287:0] FFT_addra_aux; //address portA (32*9 bit)
wire [287:0] FFT_addrb_aux; //address portB (32*9 bit)
wire [31:0] FFT_wea_aux; //write enable portA (32*1 bit)
wire [31:0] FFT_web_aux; //write enable portB (32*1 bit)
wire [31:0] FFT_rea_aux; //read (tri-state) enable portA (32*1 bit)
wire [31:0] FFT_reb_aux; //read (tri-state) enable portB (32*1 bit)

reg [287:0] FFT_addra_test; //address portA (32*9 bit)
reg [31:0] FFT_wea_test; //write enable portA (32*1 bit)
reg [31:0] FFT_rea_test; //read (tri-state) enable portA (32*1 bit)

integer count;
integer fout;
reg [15:0] read_element;
integer i;
integer j;
integer k;
integer read_element32;//CHECK THIS

//The less significant bits correspond to the BRAM0 (with rows 0 and 32), 
//and the MS bits correspond to the BRAM31 (with rows 31 and 63)
//for example: FFT_addrab[8:0] is the address of port A BRAM0, and FFT_addrab[17:9] correspond to BRAM1, etc...
//for the enables it is 1bit for each BRAM

//------------------Instantiations----------------

//fftbrams
fftbrams inst_fftbrams(
clk,
MB_is_acting,
MB_addr,
MB_din,
MB_dout,
MB_we,
FFT_dataa,
FFT_datab,
FFT_addra_aux,
FFT_addrb_aux,
FFT_wea_aux,
FFT_web_aux,
FFT_rea_aux,
FFT_reb_aux
);



//change this to fit the core
FFT2D fft2dcore(
FFT_reset,	
clk,
FFT_busyflag,
FFT_chooseIFFT,
FFT_dataa, //tristate data portA (32*16 bit)
FFT_datab, //tristate data portB (32*16 bit)
FFT_addra, //address portA (32*9 bit)
FFT_addrb, //address portB (32*9 bit)
FFT_wea, //write enable portA (32*1 bit)
FFT_web, //write enable portB (32*1 bit)
FFT_rea, //read (tri-state) enable portA (32*1 bit)
FFT_reb //read (tri-state) enable portB (32*1 bit)
);


//------------------Assignments----------------

//connecting the clk
always #1 clk = ~clk;

//do not change the MB_* assign
assign MB_is_acting = 0;
assign MB_addr = 12'b0;
assign MB_din = 32'b0;
assign MB_we = 0;
//assign FFT_dataa = 512'bZ;
//assign FFT_datab = 512'bZ;

assign FFT_addra_aux = (FFT_reset==1)?{(read_output==1)?FFT_addra_test:0}:FFT_addra;
assign FFT_addrb_aux = (FFT_reset==1)?0:FFT_addrb;
assign FFT_wea_aux = (FFT_reset==1)?{(read_output==1)?FFT_wea_test:0}:FFT_wea;
assign FFT_web_aux = (FFT_reset==1)?0:FFT_web;
assign FFT_rea_aux = (FFT_reset==1)?{(read_output==1)?FFT_rea_test:0}:FFT_rea;
assign FFT_reb_aux = (FFT_reset==1)?0:FFT_reb;


assign FFT_chooseIFFT = 1'b1;

always #2 read_element32 = {(read_element[15]==1)?16'b1111_1111_1111_1111:0,read_element};

initial
begin
	FFT_reset 	<= 1;
	clk 		<= 0;
	read_output 	<= 0;
	#3 FFT_reset 	<= 0;	//NOTE: This signals START FOR THE fftcore
//	#6179 FFT_reset <= 1; //For only 1 stage operation.
	#15063 FFT_reset<= 1;
//	$finish;

	//read the data in each bram to a file for plotting in matlab.
	read_output 	<= 1;
	FFT_wea_test	<= 0;
	FFT_rea_test	<=-1;
	count 		<= 0;
	read_element	<= 0;
	fout = $fopen("results_first.list");
	$fmonitor(fout,"%d %d",read_element32, count);
	$monitoroff;
	for(i=0;i<2;i=i+1)//for each of the rows
	begin
		for(j=0;j<32;j=j+1)// for each of the brams
		begin
			for(k=0;k<128;k=k+1)//for each element
			begin
				FFT_addra_test <= 512'b0|((256 + i*128 + k)<<(j*9));
				#2 
				$monitoron;
				case(j)
					0: read_element <= FFT_dataa[1*16 -1: 0*16];
					1: read_element <= FFT_dataa[2*16 -1: 1*16];
					2: read_element <= FFT_dataa[3*16 -1: 2*16];
					3: read_element <= FFT_dataa[4*16 -1: 3*16];
					4: read_element <= FFT_dataa[5*16 -1: 4*16];
					5: read_element <= FFT_dataa[6*16 -1: 5*16];
					6: read_element <= FFT_dataa[7*16 -1: 6*16];
					7: read_element <= FFT_dataa[8*16 -1: 7*16];
					8: read_element <= FFT_dataa[9*16 -1: 8*16];
					9: read_element <= FFT_dataa[10*16 -1: 9*16];
					10: read_element <= FFT_dataa[11*16 -1: 10*16];
					11: read_element <= FFT_dataa[12*16 -1: 11*16];
					12: read_element <= FFT_dataa[13*16 -1: 12*16];
					13: read_element <= FFT_dataa[14*16 -1: 13*16];
					14: read_element <= FFT_dataa[15*16 -1: 14*16];
					15: read_element <= FFT_dataa[16*16 -1: 15*16];
					16: read_element <= FFT_dataa[17*16 -1: 16*16];
					17: read_element <= FFT_dataa[18*16 -1: 17*16];
					18: read_element <= FFT_dataa[19*16 -1: 18*16];
					19: read_element <= FFT_dataa[20*16 -1: 19*16];
					20: read_element <= FFT_dataa[21*16 -1: 20*16];
					21: read_element <= FFT_dataa[22*16 -1: 21*16];
					22: read_element <= FFT_dataa[23*16 -1: 22*16];
					23: read_element <= FFT_dataa[24*16 -1: 23*16];
					24: read_element <= FFT_dataa[25*16 -1: 24*16];
					25: read_element <= FFT_dataa[26*16 -1: 25*16];
					26: read_element <= FFT_dataa[27*16 -1: 26*16];
					27: read_element <= FFT_dataa[28*16 -1: 27*16];
					28: read_element <= FFT_dataa[29*16 -1: 28*16];
					29: read_element <= FFT_dataa[30*16 -1: 29*16];
					30: read_element <= FFT_dataa[31*16 -1: 30*16];
					31: read_element <= FFT_dataa[32*16 -1: 31*16];
				endcase
				count <= count + 1;
			end
		end
	end
	$fclose(fout);
	#2 $finish;

end
endmodule		
