module fftbrams_wrapper();

wire clk;
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

//The less significant bits correspond to the BRAM0 (with rows 0 and 32), 
//and the MS bits correspond to the BRAM31 (with rows 31 and 63)
//for example: FFT_addrab[8:0] is the address of port A BRAM0, and FFT_addrab[17:9] correspond to BRAM1, etc...
//for the enables it is 1bit for each BRAM

//------------------Instantiations----------------

//fftbrams
/*
fftbrams inst_fftbrams(
clk,
MB_is_acting,
MB_addr,
MB_din,
MB_dout,
MB_we,
FFT_dataa,
FFT_datab,
FFT_addra,
FFT_addrb,
FFT_wea,
FFT_web,
FFT_rea,
FFT_reb
);
*/

//connect to the clk
assign clk = 0;

//do not change the MB_* assign
assign MB_is_acting = 0;
assign MB_addr = 12'b0;
assign MB_din = 32'b0;
assign MB_we = 0;

//change this to fit the core
assign FFT_dataa = 512'bZ;
assign FFT_datab = 512'bZ;
assign FFT_addra = 288'b0;
assign FFT_addrb = 288'b0;
assign FFT_wea = 32'b0;
assign FFT_web = 32'b0;
assign FFT_rea = 32'b0;
assign FFT_reb = 32'b0;

endmodule		
