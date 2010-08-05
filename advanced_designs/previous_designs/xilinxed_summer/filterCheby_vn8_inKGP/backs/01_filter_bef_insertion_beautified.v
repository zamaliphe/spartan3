/*
log by theja, theja@mit.edu

on 29th May 2009:

stages of this module will be made, with each stage, the systolic design will be integrated into this.


 added a register bit which tells the microprocessor whether the interrupt is of the chebyshev type or the normal equidistant type.
 checking if nonequal sampling works for the same filter.


on 27th May 2009: the Low pass filter is working.

The bit file is generated.
this is being handled in version ise 10.1
resource usage is like 15-20%.

just double click theja_batch in the xilinx folder with the spartan kit connected to dump the bit file onto the device.
keep the switch 0 in reset position for this filter to work.

also give input only in the range of 0-500hz (sampling at 1khz, thats why!)

follow the adc/dac examples on the xilinx website to edit the files!!!


on 26th May :

            neg_AD: XOR s6, FF                          ;complement [s7,s6] to make positive
                    XOR s7, FF
                    ADD s6, 01
                    ADDCY s7, 00

h
the output of the ADC is a 14 bit 2's complement value of the input-Vref(=1.65V). I only need to add this back (properly scaled to the 12 bit magnitude format...). And at all other times, ignore this.


-- KCPSM3 reference design - PicoBlaze controlling the two channel programmable 
-- amplifier type LTC6912-1 and two channel A/D converter type LTC1407A-1 from 
-- Linear Technology.
--
-- Design provided and tested on the Spartan-3E Starter Kit (Revision C)
--
-- Ken Chapman - Xilinx Ltd - 15th November 2005
--
-- The JTAG loader utility is also available for rapid program development.
--
-- The design is set up for a 50MHz system clock.
-- Measurements from the VINA input are amplified and displayed on the LCD display.
-- North and South press buttons are used to change the amplifier gain.
-- One measurement is made every second.
--
-- The simple LEDs and J4 connector are utilised for development and monitoring.
-- The switches and remaining press buttons are connected just for fun!
--  
------------------------------------------------------------------------------------
*/
module filter
    (         	   spi_sck,
                   spi_sdo,
                   spi_sdi,
                spi_rom_cs,
                spi_amp_cs,
              spi_adc_conv,
                spi_dac_cs,
              spi_amp_shdn,
               spi_amp_sdo,
               spi_dac_clr,
            strataflash_oe,
            strataflash_ce,
            strataflash_we,
          platformflash_oe,
                 simple_io,
                       led,
                    switch,
                 btn_north,
                  btn_east,
                 btn_south,
                  btn_west,
                     lcd_d,
                    lcd_rs,
                    lcd_rw,
                     lcd_e,
                       clk);
output 		spi_sck;
input		spi_sdo;
output 		spi_sdi;
output 		spi_rom_cs;
output 		spi_amp_cs;
output 		spi_adc_conv;
output 		spi_dac_cs;
output 		spi_amp_shdn;
input 		spi_amp_sdo;
output		spi_dac_clr;
output 		strataflash_oe;
output 		strataflash_ce;
output 		strataflash_we;
output 		platformflash_oe;
output[12:9]simple_io;
output [7:0]led;
input  [3:0]switch;
input 		btn_north;
input 		btn_east;
input 		btn_south;
input 		btn_west;
inout  [7:4]lcd_d;
output 		lcd_rs;
output 		lcd_rw;
output 		lcd_e;
input 		clk;


reg 		spi_sck;
reg 		spi_sdi;
reg 		spi_rom_cs;
reg 		spi_amp_cs;
reg 		spi_adc_conv;
reg 		spi_dac_cs;
reg 		spi_amp_shdn;
reg 		spi_dac_clr;
wire 		strataflash_oe;
wire 		strataflash_ce;
wire 		strataflash_we;
wire 		platformflash_oe;
wire [12:9] simple_io;
reg   [7:0] led;
wire  [7:4] lcd_d;
reg 		lcd_rs;
wire 		lcd_rw;
reg 		lcd_e;


//Signals used to connect KCPSM3 to program ROM and I/O logic
wire [9:0] 	address;		//          : std_logic_vector(9 downto 0);
wire [17:0] instruction;	//          : std_logic_vector(17 downto 0);
wire [7:0] 	port_id;		//          : std_logic_vector(7 downto 0);
wire [7:0] 	out_port;		//          : std_logic_vector(7 downto 0);
reg [7:0] 	in_port;		//          : std_logic_vector(7 downto 0);
wire 		write_strobe;	//          : std_logic;
wire 		read_strobe;	//          : std_logic;
reg 		interrupt;		//          : std_logic :='0'; THEJA
wire		interrupt_ack;	//          : std_logic;
wire 		kcpsm3_reset;	//          : std_logic;

// Signals used to generate interrupt 
reg [32-1:0] 	int_count;	//          : integer range 0 to 49999999 :=0; THEJA, this should be adjusted for faster speed.
reg 			event_1hz;	//          : std_logic; THEJA, name is misnomer in general..... says working at 1hz sampling...  it is just a flag. see logic below.

// Signals for LCD operation. read the example picoblazed based adc/dac templates provided by Ken chapman.
reg   		lcd_rw_control;	// : std_logic;
reg [7:4]  	lcd_output_data;// : std_logic_vector(7 downto 4);
reg        	lcd_drive;		// : std_logic; THEJA

// Signals added by theja
wire [15:0] 		yout;
reg [15:0] 			xin;
reg 				flaga;
reg 				flagb;
reg  signed [15:0] 	output_register; // sfix16_En16

reg 				do_filter;
reg 				chebyshev_interrupt;
reg 	[3:0]		interruptIndex;
wire [32-1:0] 		timing[0:15];
wire 				interruptType[0:15];

//declaration of KCPSM3

kcpsm3 processor(	
		.address(address),
		.instruction(instruction),
		.port_id(port_id),
		.write_strobe(write_strobe),
		.out_port(out_port),
		.read_strobe(read_strobe),
		.in_port(in_port),
		.interrupt(interrupt),
		.interrupt_ack(interrupt_ack),
		.reset(kcpsm3_reset),
		.clk(clk)
		);					

// declaration of program (ROM generated by the assembler)

adda_ctr adda_ctrl_001
    (      .address(address),
            .instruction(instruction),
             //.proc_reset(kcpsm3_reset),
                    .clk(clk));



//Assignments

//Disable unused components  
assign  strataflash_oe 	= 1'b1;	//StrataFLASH must be disabled. period.
assign  strataflash_ce 	= 1'b1;
assign  strataflash_we 	= 1'b1;
assign  platformflash_oe= 1'b0; //Platform FLASH must be disabled. period.

assign timing[0] = 32'h00001E06;
assign timing[1] = 32'h000052A5;
assign timing[2] = 32'h00002202;
assign timing[3] = 32'h0000A14E;
assign timing[4] = 32'h0000363E;
assign timing[5] = 32'h00008D12;
assign timing[6] = 32'h00008C8E;
assign timing[7] = 32'h000036C2;
assign timing[8] = 32'h0000C350;
assign timing[9] = 32'h000036C2;
assign timing[10] = 32'h00008C8E;
assign timing[11] = 32'h00008D12;
assign timing[12] = 32'h0000363E;
assign timing[13] = 32'h0000A14E;
assign timing[14] = 32'h00002202;
assign timing[15] = 32'h000052A5;
//assign timing[0] = 49999;

assign interruptType[0] = 1;
assign interruptType[1] = 0;
assign interruptType[2] = 1;
assign interruptType[3] = 0;
assign interruptType[4] = 1;
assign interruptType[5] = 0;
assign interruptType[6] = 1;
assign interruptType[7] = 0;
assign interruptType[8] = 0;
assign interruptType[9] = 1;
assign interruptType[10] = 0;
assign interruptType[11] = 1;
assign interruptType[12] = 0;
assign interruptType[13] = 1;
assign interruptType[14] = 0;
assign interruptType[15] = 1;
/*
assign interruptType[0] = 1;
assign interruptType[1] = 1;
assign interruptType[2] = 1;
assign interruptType[3] = 1;
assign interruptType[4] = 1;
assign interruptType[5] = 1;
assign interruptType[6] = 1;
assign interruptType[7] = 1;
assign interruptType[8] = 1;
assign interruptType[9] = 1;
assign interruptType[10] = 1;
assign interruptType[11] = 1;
assign interruptType[12] = 1;
assign interruptType[13] = 1;
assign interruptType[14] = 1;
assign interruptType[15] = 1;
*/


//Logic

always @(posedge clk)
begin
	if (switch[0]==1)
	begin
		flaga 				<= 0;
		flagb 				<= 0;
		int_count 			<= 0;
		interrupt 			<= 0;
		led 				<= 8'h22;
		xin 				<= 16'h0000;
		output_register 	<= 0;
		do_filter 			<= 0;
		chebyshev_interrupt <=1'b1;
		interruptIndex		<= 0;
	end
	else
	begin
		if (int_count==timing[interruptIndex]) //takes cycles to skip from the constants declared above.
		begin
			int_count <= 0;
			event_1hz <= 1'b1;
			interruptIndex <= interruptIndex + 1'b1;
		end
		else
		begin
		 int_count <= int_count + 1'b1;
		 event_1hz <= 1'b0;
		end

		// processor interrupt waits for an acknowledgement
		if (interrupt_ack==1'b1)
		begin
			interrupt <= 1'b0;
		end
		else if (event_1hz==1'b1)
		begin
			interrupt <= 1'b1;
		end
		else
		begin
			interrupt <= interrupt;
		end

//KCPSM3 input ports 
//The inputs connect via a pipelined multiplexer

	    case (port_id[1:0])
	        //read simple toggle switches and buttons at address 00 hex
	        2'b00:
			begin
				if(read_strobe==1'b1)
				begin
					flaga <= ~flaga;
				end
				case(flaga)
				1'b0: begin 
					in_port <= yout[7:0]; 
					//in_port <= xin[7:0]; 
				end
				1'b1: begin
					in_port <= yout[15:8];
					//in_port <= xin[15:8];
				end
				default: ;
				endcase
			end
	        //read SPI data input SDO at address 01 hex
	        //called SDO because it connects to the data outputs of all the slave devices 
	        //Normal SDO data is bit7. 
	        //SDI data from the amplifier is at bit 6 because it is always driving and needs a separate pin.
	        2'b01:
			begin
				in_port <= {spi_sdo,spi_amp_sdo,6'b000000};
			end
	        //read LCD data at address 02 hex
	        2'b10:
			begin
				in_port <= {lcd_d,4'b0000};
			end
	        //important for theja's systolic.
			default://the 2'b11 case
			begin
				if(chebyshev_interrupt==1'b1)		//TO BE EDITED
				begin
					in_port <= 8'h00;  
				end
				else
				begin
					in_port <= 8'hFF;
				end
			end
	    endcase

//KCPSM3 output ports 
//adding the output registers to the processor

	    if(write_strobe==1'b1)
		begin

	        if(port_id[7]==1'b1)
			begin
				led <= out_port;
				flagb <= ~flagb;
				case(flagb)
					1'b0: begin
							xin[7:0]  <= out_port;
						end
					1'b1: begin
							xin[15:8] <= out_port;
							if(do_filter==1'b0)
							begin
								do_filter<=1'b1;
							end
						end
					default: ;
				endcase
				
	        end

			//    -- Write to SPI data output at address 04 hex.
			//    -- called SDI because it connects to the data inputs of all the slave devices
	        if(port_id[2]==1'b1)
			begin
	          spi_sdi <= out_port[7];
	        end

			//    -- Write to SPI control at address 08 hex.
	        if(port_id[3]==1'b1)
			begin
	          spi_sck 		<= out_port[0];
	          spi_rom_cs 	<= out_port[1];
	          spi_amp_cs 	<= out_port[3];
	          spi_adc_conv 	<= out_port[4];
	          spi_dac_cs 	<= out_port[5];
	          spi_amp_shdn 	<= out_port[6];
	          spi_dac_clr 	<= out_port[7];
	        end

			//    -- LCD data output and controls at address 40 hex.
	        if (port_id[6]==1'b1)
			begin
	          lcd_output_data 	<= out_port[7:4];
	          lcd_drive 		<= out_port[3];  
	          lcd_rs 			<= out_port[2];
	          lcd_rw_control 	<= out_port[1];
	          lcd_e 			<= out_port[0];
	        end

	    end
		
	end
	
	if(busy_coeff1==1'b0)
	begin
		if(do_filter==1'b1)
		begin
				do_filter <= 1'b0;
				output_register <= {xin[15],xin[15:1]};//divide by 2. trivial test operation. TO BE EDITED
		end
	end
end //process output_ports;


assign yout = (switch[1]==1'b1)?xin:output_register;

assign simple_io[09] = do_filter	; //Test point
assign simple_io[10] = out_port[3]	; //--Test point is copy of amp_cs, dac_cs can be seen by out_port[5]
assign simple_io[11] = out_port[4]	; //--Test point is copy of adc_conv
assign simple_io[12] = interrupt	; // --Test point//in dac.vhd, this is at simpleio(10)

// LCD interface  
assign  lcd_rw = lcd_rw_control&lcd_drive;
assign  lcd_d  = (lcd_rw_control==1'b0 && lcd_drive==1'b1)?lcd_output_data:4'bZ;


endmodule

//To use this funda:
//mult m1(yout_coeff1,xin,coeff1,clk,busy_coeff1,(flagb==1'b0 && write_strobe==1'b1));