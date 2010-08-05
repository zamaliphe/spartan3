/*
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
output spi_sck;
input spi_sdo;
output spi_sdi;
output spi_rom_cs;
output spi_amp_cs;
output spi_adc_conv;
output spi_dac_cs;
output spi_amp_shdn;
input spi_amp_sdo;
output spi_dac_clr;
output strataflash_oe;
output strataflash_ce;
output strataflash_we;
output platformflash_oe;
output [12:9] simple_io;
output [7:0] led;
input [3:0] switch;
input btn_north;
input btn_east;
input btn_south;
input btn_west;
inout [7:4] lcd_d;
output lcd_rs;
output lcd_rw;
output lcd_e;
input clk;


reg spi_sck;
reg spi_sdi;
reg spi_rom_cs;
reg spi_amp_cs;
reg spi_adc_conv;
reg spi_dac_cs;
reg spi_amp_shdn;
reg spi_dac_clr;
wire strataflash_oe;
wire strataflash_ce;
wire strataflash_we;
wire platformflash_oe;
wire [12:9] simple_io;
reg [7:0] led;
wire [7:4] lcd_d;
reg lcd_rs;
wire lcd_rw;
reg lcd_e;


/*Signals used to connect KCPSM3 to program ROM and I/O logic*/
wire [9:0] address;//          : std_logic_vector(9 downto 0);
wire [17:0] instruction;//      : std_logic_vector(17 downto 0);
wire [7:0] port_id;//          : std_logic_vector(7 downto 0);
wire [7:0] out_port;//         : std_logic_vector(7 downto 0);
reg [7:0] in_port;//          : std_logic_vector(7 downto 0);
wire write_strobe;//     : std_logic;
wire read_strobe;//      : std_logic;
reg interrupt;//        : std_logic :='0'; THEJA
wire interrupt_ack;//    : std_logic;
wire kcpsm3_reset;//     : std_logic;
//wire proc_reset;
/* Signals used to generate interrupt */
reg [25:0] int_count;//        : integer range 0 to 49999999 :=0; THEJA, this should be adjusted for faster speed.
reg event_1hz ;//       : std_logic; THEJA, name is misnomer in general..... says working at 1hz sampling...  it is just a flag. see logic below.
/* Signals for LCD operation
-- Tri-state output requires internal signals
-- 'lcd_drive' is used to differentiate between LCD and StrataFLASH communications 
-- which share the same data bits.*/
reg   lcd_rw_control;// : std_logic;
reg [7:4]  lcd_output_data;// : std_logic_vector(7 downto 4);
reg        lcd_drive;// : std_logic; THEJA

// Type Definitions
// Constants
parameter signed [15:0] coeff1 = 16'b1111001101001010; //sfix16_En17
parameter signed [15:0] coeff2 = 16'b0001100001101101; //sfix16_En17
parameter signed [15:0] coeff3 = 16'b0010111000010110; //sfix16_En17
parameter signed [15:0] coeff4 = 16'b0100100100001000; //sfix16_En17
parameter signed [15:0] coeff5 = 16'b0101111010100000; //sfix16_En17
parameter signed [15:0] coeff6 = 16'b0110011011010100; //sfix16_En17
parameter signed [15:0] coeff7 = 16'b0101111010100000; //sfix16_En17
parameter signed [15:0] coeff8 = 16'b0100100100001000; //sfix16_En17
parameter signed [15:0] coeff9 = 16'b0010111000010110; //sfix16_En17
parameter signed [15:0] coeff10 = 16'b0001100001101101; //sfix16_En17
parameter signed [15:0] coeff11 = 16'b1111001101001010; //sfix16_En17
  
// Signals
wire [15:0] yout;
reg [15:0] xin;
reg flaga;
reg flagb;
reg  signed [15:0] delay_pipeline [0:10] ; // sfix16_En16
wire signed [15:0] product11; // sfix16_En16
wire signed [31:0] mul_temp; // sfix32_En33
wire signed [15:0] product10; // sfix16_En16
wire signed [31:0] mul_temp_1; // sfix32_En33
wire signed [15:0] product9; // sfix16_En16
wire signed [31:0] mul_temp_2; // sfix32_En33
wire signed [15:0] product8; // sfix16_En16
wire signed [31:0] mul_temp_3; // sfix32_En33
wire signed [15:0] product7; // sfix16_En16
wire signed [31:0] mul_temp_4; // sfix32_En33
wire signed [15:0] product6; // sfix16_En16
wire signed [31:0] mul_temp_5; // sfix32_En33
wire signed [15:0] product5; // sfix16_En16
wire signed [31:0] mul_temp_6; // sfix32_En33
wire signed [15:0] product4; // sfix16_En16
wire signed [31:0] mul_temp_7; // sfix32_En33
wire signed [15:0] product3; // sfix16_En16
wire signed [31:0] mul_temp_8; // sfix32_En33
wire signed [15:0] product2; // sfix16_En16
wire signed [31:0] mul_temp_9; // sfix32_En33
wire signed [15:0] product1; // sfix16_En16
wire signed [31:0] mul_temp_10; // sfix32_En33
wire signed [15:0] sum1; // sfix16_En16
wire signed [15:0] add_signext; // sfix16_En16
wire signed [15:0] add_signext_1; // sfix16_En16
wire signed [16:0] add_temp; // sfix17_En16
wire signed [15:0] sum2; // sfix16_En16
wire signed [15:0] add_signext_2; // sfix16_En16
wire signed [15:0] add_signext_3; // sfix16_En16
wire signed [16:0] add_temp_1; // sfix17_En16
wire signed [15:0] sum3; // sfix16_En16
wire signed [15:0] add_signext_4; // sfix16_En16
wire signed [15:0] add_signext_5; // sfix16_En16
wire signed [16:0] add_temp_2; // sfix17_En16
wire signed [15:0] sum4; // sfix16_En16
wire signed [15:0] add_signext_6; // sfix16_En16
wire signed [15:0] add_signext_7; // sfix16_En16
wire signed [16:0] add_temp_3; // sfix17_En16
wire signed [15:0] sum5; // sfix16_En16
wire signed [15:0] add_signext_8; // sfix16_En16
wire signed [15:0] add_signext_9; // sfix16_En16
wire signed [16:0] add_temp_4; // sfix17_En16
wire signed [15:0] sum6; // sfix16_En16
wire signed [15:0] add_signext_10; // sfix16_En16
wire signed [15:0] add_signext_11; // sfix16_En16
wire signed [16:0] add_temp_5; // sfix17_En16
wire signed [15:0] sum7; // sfix16_En16
wire signed [15:0] add_signext_12; // sfix16_En16
wire signed [15:0] add_signext_13; // sfix16_En16
wire signed [16:0] add_temp_6; // sfix17_En16
wire signed [15:0] sum8; // sfix16_En16
wire signed [15:0] add_signext_14; // sfix16_En16
wire signed [15:0] add_signext_15; // sfix16_En16
wire signed [16:0] add_temp_7; // sfix17_En16
wire signed [15:0] sum9; // sfix16_En16
wire signed [15:0] add_signext_16; // sfix16_En16
wire signed [15:0] add_signext_17; // sfix16_En16
wire signed [16:0] add_temp_8; // sfix17_En16
wire signed [15:0] sum10; // sfix16_En16
wire signed [15:0] add_signext_18; // sfix16_En16
wire signed [15:0] add_signext_19; // sfix16_En16
wire signed [16:0] add_temp_9; // sfix17_En16
reg  signed [15:0] output_register; // sfix16_En16


wire clk_2;
reg [2:0] count;

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
		.clk(clk_2)
		);					
// declaration of program (ROM generated by the assembler)
adda_ctr adda_ctrl_001
    (      .address(address),
            .instruction(instruction),
             //.proc_reset(kcpsm3_reset),
                    .clk(clk_2));

//filter related


//Disable unused components  
//StrataFLASH must be disabled to prevent it driving the SDI line with its D0 output
//or conflicting with the LCD display 
assign  strataflash_oe = 1'b1;
assign  strataflash_ce = 1'b1;
assign  strataflash_we = 1'b1;
//Platform FLASH must be disabled to prevent it driving the SDI line with its D0 output.
//Since the CE is via the 9500 device, the OE/RESET is the easier direct control (OE active high).
assign platformflash_oe = 1'b0;


// KCPSM3 and the program memory 
  
//assign reset = kcpsm3_reset;
//assign proc_reset = kcpsm3_reset;  



//Interrupt 
//Interrupt is used to set the 1 second sample rate which is typical of environment monitoring applications. 
//A simple binary counter is used to divide the 50MHz system clock and provide interrupt pulses.


always @(posedge clk)
begin
	if(switch[0]==1)
	begin
		count <= 0;
	end
	else
	begin
		if(count!=3'b100)
		begin
			count <= count + 1'b1;
		end
		else
		begin
			count <= 3'b0;
		end
	end
end

assign clk_2 = count[2]&~count[1]&~count[0];//divide by 5

always @(posedge clk_2)
begin
	if (switch[0]==1)
	begin
		flaga <= 0;
		flagb <= 0;
		int_count <= 0;
		interrupt <= 0;
		led <= 8'h22;
		//yout <=16'h0000;
		xin <= 16'h0000;
		delay_pipeline[0] <= 0;
        delay_pipeline[1] <= 0;
        delay_pipeline[2] <= 0;
        delay_pipeline[3] <= 0;
        delay_pipeline[4] <= 0;
        delay_pipeline[5] <= 0;
        delay_pipeline[6] <= 0;
        delay_pipeline[7] <= 0;
        delay_pipeline[8] <= 0;
        delay_pipeline[9] <= 0;
        delay_pipeline[10] <= 0;
		output_register <= 0;
	end
	else
	begin
		//divide 50MHz by 50,000,0000 to form 1Hz pulses
		//if (int_count==49999999)
		if (int_count==9999) //1k
		begin
			int_count <= 0;
			event_1hz <= 1'b1;
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
				//in_port <= {switch,btn_west,btn_south,btn_east,btn_north};
				
				if(read_strobe==1'b1)
				begin
					flaga <= ~flaga;
				end
				case(flaga)
				1'b0: begin 
					in_port <= yout[7:0]; 
				end
				1'b1: begin
					in_port <= yout[15:8];
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
	        //Don't care used for all other addresses to ensure minimum logic implementation
			default:
			begin
				in_port <= 8'bX;  
			end
	    endcase

//KCPSM3 output ports 
//adding the output registers to the processor

	    if(write_strobe==1'b1)
		begin

			//    -- Write to LEDs at address 80 hex.

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
			  //    --spare control <= out_port(2);
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
		
		if(flagb==1'b0 && write_strobe==1'b1)
		begin
				//output_register <= xin;
				
				output_register <= (switch[3:1]*xin)>>3; //testing phase, just bounce back.... Original. Working.
/*
				delay_pipeline[0] <= xin;
				delay_pipeline[1] <= delay_pipeline[0];
				delay_pipeline[2] <= delay_pipeline[1];
				delay_pipeline[3] <= delay_pipeline[2];
				delay_pipeline[4] <= delay_pipeline[3];
				delay_pipeline[5] <= delay_pipeline[4];
				delay_pipeline[6] <= delay_pipeline[5];
				delay_pipeline[7] <= delay_pipeline[6];
				delay_pipeline[8] <= delay_pipeline[7];
				delay_pipeline[9] <= delay_pipeline[8];
				delay_pipeline[10] <= delay_pipeline[9];
				output_register <= sum10;
*/				
				//output_register <= ({xin[15],xin[15],xin[15:2]} + {delay_pipeline[0][15],delay_pipeline[0][15],delay_pipeline[0][15:2]} + {delay_pipeline[1][15],delay_pipeline[1][15],delay_pipeline[1][15:2]} + {delay_pipeline[2][15],delay_pipeline[2][15],delay_pipeline[2][15:2]});
		end
		
	end
end //process output_ports;


assign  simple_io[12] = interrupt; // --Test point//in dac.vhd, this is at simpleio(10)
// in dac.vhd, event_8khz (== event_1hz) is also output on simple_io pin...

assign simple_io[10] = out_port[3];  //--Test point is copy of amp_cs, dac_cs can be seen by out_port[5]
assign simple_io[11] = out_port[4];  //--Test point is copy of adc_conv

// LCD interface  
//The 4-bit data port is bidirectional.
//lcd_rw is '1' for read and '0' for write 
//lcd_drive is like a master enable signal which prevents either the 
//FPGA outputs or the LCD display driving the data lines.
//Control of read and write signal
assign  lcd_rw = lcd_rw_control&lcd_drive;
//--use read/write control to enable output buffers.
assign  lcd_d = (lcd_rw_control==1'b0 && lcd_drive==1'b1)?lcd_output_data:4'bZ;

//assign  simple_io[9] = spi_amp_sdo;   //Test point
assign simple_io[9] =clk_2;


assign yout = output_register;


assign mul_temp = delay_pipeline[10] * coeff11;
assign product11 = ({{1{mul_temp[31]}}, mul_temp[31:0]} + {mul_temp[17], {16{~mul_temp[17]}}})>>>17;

assign mul_temp_1 = delay_pipeline[9] * coeff10;
assign product10 = ({{1{mul_temp_1[31]}}, mul_temp_1[31:0]} + {mul_temp_1[17], {16{~mul_temp_1[17]}}})>>>17;

assign mul_temp_2 = delay_pipeline[8] * coeff9;
assign product9 = ({{1{mul_temp_2[31]}}, mul_temp_2[31:0]} + {mul_temp_2[17], {16{~mul_temp_2[17]}}})>>>17;

assign mul_temp_3 = delay_pipeline[7] * coeff8;
assign product8 = ({{1{mul_temp_3[31]}}, mul_temp_3[31:0]} + {mul_temp_3[17], {16{~mul_temp_3[17]}}})>>>17;

assign mul_temp_4 = delay_pipeline[6] * coeff7;
assign product7 = ({{1{mul_temp_4[31]}}, mul_temp_4[31:0]} + {mul_temp_4[17], {16{~mul_temp_4[17]}}})>>>17;

assign mul_temp_5 = delay_pipeline[5] * coeff6;
assign product6 = ({{1{mul_temp_5[31]}}, mul_temp_5[31:0]} + {mul_temp_5[17], {16{~mul_temp_5[17]}}})>>>17;

assign mul_temp_6 = delay_pipeline[4] * coeff5;
assign product5 = ({{1{mul_temp_6[31]}}, mul_temp_6[31:0]} + {mul_temp_6[17], {16{~mul_temp_6[17]}}})>>>17;

assign mul_temp_7 = delay_pipeline[3] * coeff4;
assign product4 = ({{1{mul_temp_7[31]}}, mul_temp_7[31:0]} + {mul_temp_7[17], {16{~mul_temp_7[17]}}})>>>17;

assign mul_temp_8 = delay_pipeline[2] * coeff3;
assign product3 = ({{1{mul_temp_8[31]}}, mul_temp_8[31:0]} + {mul_temp_8[17], {16{~mul_temp_8[17]}}})>>>17;

assign mul_temp_9 = delay_pipeline[1] * coeff2;
assign product2 = ({{1{mul_temp_9[31]}}, mul_temp_9[31:0]} + {mul_temp_9[17], {16{~mul_temp_9[17]}}})>>>17;

assign mul_temp_10 = delay_pipeline[0] * coeff1;
assign product1 = ({{1{mul_temp_10[31]}}, mul_temp_10[31:0]} + {mul_temp_10[17], {16{~mul_temp_10[17]}}})>>>17;

assign add_signext = product1;
assign add_signext_1 = product2;
assign add_temp = add_signext + add_signext_1;
assign sum1 = add_temp[15:0];

assign add_signext_2 = sum1;
assign add_signext_3 = product3;
assign add_temp_1 = add_signext_2 + add_signext_3;
assign sum2 = add_temp_1[15:0];

assign add_signext_4 = sum2;
assign add_signext_5 = product4;
assign add_temp_2 = add_signext_4 + add_signext_5;
assign sum3 = add_temp_2[15:0];

assign add_signext_6 = sum3;
assign add_signext_7 = product5;
assign add_temp_3 = add_signext_6 + add_signext_7;
assign sum4 = add_temp_3[15:0];

assign add_signext_8 = sum4;
assign add_signext_9 = product6;
assign add_temp_4 = add_signext_8 + add_signext_9;
assign sum5 = add_temp_4[15:0];

assign add_signext_10 = sum5;
assign add_signext_11 = product7;
assign add_temp_5 = add_signext_10 + add_signext_11;
assign sum6 = add_temp_5[15:0];

assign add_signext_12 = sum6;
assign add_signext_13 = product8;
assign add_temp_6 = add_signext_12 + add_signext_13;
assign sum7 = add_temp_6[15:0];

assign add_signext_14 = sum7;
assign add_signext_15 = product9;
assign add_temp_7 = add_signext_14 + add_signext_15;
assign sum8 = add_temp_7[15:0];

assign add_signext_16 = sum8;
assign add_signext_17 = product10;
assign add_temp_8 = add_signext_16 + add_signext_17;
assign sum9 = add_temp_8[15:0];

assign add_signext_18 = sum9;
assign add_signext_19 = product11;
assign add_temp_9 = add_signext_18 + add_signext_19;
assign sum10 = add_temp_9[15:0];

endmodule