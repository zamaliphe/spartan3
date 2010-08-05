`include "00defines.v"

/*Theja : Two alternate RAM models
00defines.v has the necessary defines
RAM_DEPTH is defined here
*/
module ram_model(
clk       , // Clock Input
address_0 , // address_0 Input
data_0    , // data_0 bi-directional
cs_0      , // Chip Select
we_0      , // Write Enable/Read Enable
oe_0      , // Output Enable
address_1 , // address_1 Input
data_1    , // data_1 bi-directional
cs_1      , // Chip Select
we_1      , // Write Enable/Read Enable
oe_1        // Output Enable
); 

parameter RAM_DEPTH = 1 << (`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH);

//--------------Input Ports----------------------- 
input clk  ;
input [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0] address_0 ;
input cs_0 ;
input we_0 ;
input oe_0 ; 
input [`FFT2D_C_RAM_ADD_BITS + `RAM_ADD_WIDTH-1:0] address_1 ;
input cs_1 ;
input we_1 ;
input oe_1 ; 

//--------------Inout Ports----------------------- 
inout [`FFT_DATA_WIDTH-1:0] data_0 ; 
inout [`FFT_DATA_WIDTH-1:0] data_1 ;

//---------------------------------common declaration ends--------------------------------------------------------

/*
//------------------------------------------Version 1 : Xilinx Core--------------------------------------------------
//internal wires and registers
wire [`FFT_DATA_WIDTH-1:0] dout0;
wire [`FFT_DATA_WIDTH-1:0] dout1;

//Assignments
assign data_0 = (oe_0&cs_0)?dout0:`FFT_DATA_WIDTH'bz;	
//only assigning the output of the internally instantiated ram
//when oe is enabled. This will allow data_X port to be free when oe is not HI.
assign data_1 = (oe_1&cs_1)?dout1:`FFT_DATA_WIDTH'bz;

 theja_dp_ram internal_ram001(
	address_0,
	address_1,
	clk,
	clk,
	data_0,
	data_1,
	dout0,
	dout1,
	cs_0,
	cs_1,
	we_0,
	we_1);

	
//------------------------------------------Version 1 : Xilinx Core--------------------------------------------------	
*/

//------------------------------------------Version 2 : Synchronous RAM (behave) using REGs--------------------------

//--------------Internal variables---------------- 
reg [`FFT_DATA_WIDTH-1:0] data_0_out ; 
reg [`FFT_DATA_WIDTH-1:0] data_1_out ;
reg [`FFT_DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];


initial begin
  $readmemb("fft_0.mif.copied", mem); 
end

//--------------Code Starts Here------------------ 
// Memory Write Block 
// Write Operation : When we_0 = 1, cs_0 = 1
always @ (posedge clk)
begin : MEM_WRITE
  if ( cs_0 && we_0 ) begin
     mem[address_0] <= data_0;
  end					//MAJOR EDITING: Theja 24th Jan 07: This is hazardous if simultaneous R&W@same loc. occur. 
  if (cs_1 && we_1) begin 
     mem[address_1] <= data_1;
  end
end

  

// Tri-State Buffer control 
// output : When we_0 = 0, oe_0 = 1, cs_0 = 1
assign data_0 = (cs_0 && oe_0 && !we_0) ? data_0_out : `FFT_DATA_WIDTH'bz; 

// Memory Read Block 
// Read Operation : When we_0 = 0, oe_0 = 1, cs_0 = 1
always @ (posedge clk)
begin : MEM_READ_0
  if (cs_0 && !we_0 && oe_0) begin
    data_0_out <= mem[address_0]; 
  end else begin
    data_0_out <= 0; 
  end  
end 

//Second Port of RAM
// Tri-State Buffer control 
// output : When we_0 = 0, oe_0 = 1, cs_0 = 1
assign data_1 = (cs_1 && oe_1 && !we_1) ? data_1_out : `FFT_DATA_WIDTH'bz; 
// Memory Read Block 1 
// Read Operation : When we_1 = 0, oe_1 = 1, cs_1 = 1
always @ (posedge clk)
begin : MEM_READ_1
  if (cs_1 && !we_1 && oe_1) begin
    data_1_out <= mem[address_1]; 
  end else begin
    data_1_out <= 0;
  end
end
//-------------------------------original version---------------------------------------------------------------

endmodule 
