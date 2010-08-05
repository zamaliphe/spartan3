`include "00defines.v"

/*00defines.v has a define for this module
*/

module IO(
ext_bidir_port,
data_2b_input, 
data_2b_output,
c_tri_data_2b_output,
c_tri_data_2b_input,
c_chip_select,
c_ext_write,
io_clock,
reset
);


inout  [`FFT_DATA_WIDTH -1:0] ext_bidir_port;
output [`FFT_DATA_WIDTH -1:0]  data_2b_input;	//Ext. Input is passed to mod here.
input  [`FFT_DATA_WIDTH -1:0] data_2b_output;	//transformed data is given to mod here.
input c_tri_data_2b_output; 			//control input for tristating
input c_tri_data_2b_input;			//control input for tristating
input c_chip_select;				//control to switch this mod on.
input c_ext_write;				//1 implies write. 0 implies read
input io_clock;					//input clock
input reset;

wire [`FFT_DATA_WIDTH -1:0]  data_2b_input;	
wire [`FFT_DATA_WIDTH -1:0] data_2b_output;  
wire c_tri_data_2b_output; 
wire c_tri_data_2b_input;	
wire c_chip_select;
wire c_ext_write;	
wire io_clock;
wire reset;

//internal registers
reg [`FFT_DATA_WIDTH-1:0] data_reg_io_internal;
reg op_tristate_reg;

assign data_2b_input = (~c_tri_data_2b_input)?data_reg_io_internal:`FFT_DATA_WIDTH'bz;
assign ext_bidir_port = (~c_tri_data_2b_output&~op_tristate_reg)?data_reg_io_internal:`FFT_DATA_WIDTH'bz;


always @ (posedge io_clock or posedge reset)
begin
	if(reset)
	begin
		data_reg_io_internal <= 0;
		op_tristate_reg <= 1;
	end
	else
	begin
		op_tristate_reg <= c_tri_data_2b_output;
		//has to be floated onto the external port
		if(c_chip_select&c_ext_write)
		begin
			data_reg_io_internal <= data_2b_output;
		end
		//has to be floated onto the internal bus
		if(c_chip_select&~c_ext_write)
		begin
			data_reg_io_internal <= ext_bidir_port;
		end
	end
end
endmodule
