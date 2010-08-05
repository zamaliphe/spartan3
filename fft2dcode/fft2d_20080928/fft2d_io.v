`include "00defines.v"

module FFT2D_IO(
ext_bidir_port,
data_for_units,
/*
data_for_00   ,
data_for_01   ,
data_for_02   ,
data_for_03   ,
data_for_04   ,
data_for_05   ,
data_for_06   ,
data_for_07   ,
data_for_08   ,
data_for_09   ,
data_for_10   ,
data_for_11   ,
data_for_12   ,
data_for_13   ,
data_for_14   ,
data_for_15   ,
data_for_16   ,
data_for_17   ,
data_for_18   ,
data_for_19   ,
data_for_20   ,
data_for_21   ,
data_for_22   ,
data_for_23   ,
data_for_24   ,
data_for_25   ,
data_for_26   ,
data_for_27   ,
data_for_28   ,
data_for_29   ,
data_for_30   ,
data_for_31   ,
*/
wr_cs	      ,
rd_cs	      ,
rd_en	      ,
wr_en	      ,
empty	      ,
full	      ,
clk	      ,
reset
);

inout [`FFT_DATA_WIDTH - 1:0] ext_bidir_port	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_units   	;
input wr_cs	      	;
input rd_cs	      	;
input rd_en	      	;
input wr_en	      	;
output empty	      	;
output full	      	;
input clk	      	;
input reset		;
/*
inout [`FFT_DATA_WIDTH - 1:0] data_for_00   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_01   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_02   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_03   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_04   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_05   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_06   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_07   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_08   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_09   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_10   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_11   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_12   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_13   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_14   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_15  	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_16   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_17   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_18   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_19   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_20   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_21   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_22   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_23   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_24   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_25   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_26   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_27   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_28   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_29   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_30   	;
inout [`FFT_DATA_WIDTH - 1:0] data_for_31   	;
*/


wire [`FFT_DATA_WIDTH - 1:0] ext_bidir_port	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_units   	;
wire wr_cs	      	;
wire rd_cs	      	;
wire rd_en	      	;
wire wr_en	      	;
wire empty	      	;
wire full	      	;
wire clk	      	;
wire reset		;
/*
wire [`FFT_DATA_WIDTH - 1:0] data_for_00   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_01   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_02   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_03   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_04   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_05   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_06   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_07   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_08   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_09   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_10   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_11   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_12   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_13   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_14   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_15  		;
wire [`FFT_DATA_WIDTH - 1:0] data_for_16   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_17   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_18   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_19   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_20   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_21   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_22   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_23   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_24   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_25   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_26   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_27   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_28   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_29   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_30   	;
wire [`FFT_DATA_WIDTH - 1:0] data_for_31   	;
*/


//Local wires and Registers
wire [`FFT_DATA_WIDTH - 1:0] data_fifo_out;
reg delayed_rd_en;

//Instantiations
SFifo fifo01(
clk      , 	// Clock input
reset    , 	// Active high reset
wr_cs    , 	// Write chip select
rd_cs    , 	// Read chip select
ext_bidir_port, // Data input
rd_en    , 	// Read enable
wr_en    , 	// Write Enable
data_fifo_out ,	// Data Output
empty    , 	// FIFO empty
full       	// FIFO full
); 

//When FIFO not in use, shor the ext-bidir_port with data_for_units
assign ext_bidir_port = (~wr_cs&~rd_cs)?data_for_units:`FFT_DATA_WIDTH'bz;
//assign data_for_units = (rd_cs&rd_en|delayed_rd_en)?data_fifo_out:`FFT_DATA_WIDTH'bz;
assign data_for_units = (rd_cs&rd_en)?data_fifo_out:`FFT_DATA_WIDTH'bz;

always @ (posedge clk)
begin
	if(reset)
	begin
		delayed_rd_en <= 0;
	end
	else
	begin
		delayed_rd_en <= rd_cs&rd_en;
	end
end


endmodule
