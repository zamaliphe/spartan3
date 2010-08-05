
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


reg [15:0] yout;
reg [15:0] xin;
reg flaga;
reg flagb;
wire [16-1:0] coeff [0:32];//33 in total for a 32 order filter
wire [16-1:0] intermediate[0:32];
reg [16-1:0] interreg[1:32];


//declaration of KCPSM3
/*
kcpsm3 kcpsm3_001
    (      address,
            instruction,
                port_id,
           write_strobe,
               out_port,
            read_strobe,
                in_port,
              interrupt,
          interrupt_ack,
                  reset,
                    clk);
*/
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

//filter related

multiplier m00 (xin,coeff[00],intermediate[00]);
multiplier m01 (xin,coeff[01],intermediate[01]);
multiplier m02 (xin,coeff[02],intermediate[02]);
multiplier m03 (xin,coeff[03],intermediate[03]);
multiplier m04 (xin,coeff[04],intermediate[04]);
multiplier m05 (xin,coeff[05],intermediate[05]);
multiplier m06 (xin,coeff[06],intermediate[06]);
multiplier m07 (xin,coeff[07],intermediate[07]);
multiplier m08 (xin,coeff[08],intermediate[08]);
multiplier m09 (xin,coeff[09],intermediate[09]);
multiplier m10 (xin,coeff[10],intermediate[10]);
multiplier m11 (xin,coeff[11],intermediate[11]);
multiplier m12 (xin,coeff[12],intermediate[12]);
multiplier m13 (xin,coeff[13],intermediate[13]);
multiplier m14 (xin,coeff[14],intermediate[14]);
multiplier m15 (xin,coeff[15],intermediate[15]);
multiplier m16 (xin,coeff[16],intermediate[16]);
multiplier m17 (xin,coeff[17],intermediate[17]);
multiplier m18 (xin,coeff[18],intermediate[18]);
multiplier m19 (xin,coeff[19],intermediate[19]);
multiplier m20 (xin,coeff[20],intermediate[20]);
multiplier m21 (xin,coeff[21],intermediate[21]);
multiplier m22 (xin,coeff[22],intermediate[22]);
multiplier m23 (xin,coeff[23],intermediate[23]);
multiplier m24 (xin,coeff[24],intermediate[24]);
multiplier m25 (xin,coeff[25],intermediate[25]);
multiplier m26 (xin,coeff[26],intermediate[26]);
multiplier m27 (xin,coeff[27],intermediate[27]);
multiplier m28 (xin,coeff[28],intermediate[28]);
multiplier m29 (xin,coeff[29],intermediate[29]);
multiplier m30 (xin,coeff[30],intermediate[30]);
multiplier m31 (xin,coeff[31],intermediate[31]);
multiplier m32 (xin,coeff[32],intermediate[32]);


assign coeff[0] = 16'h03EB;
assign coeff[1] = 16'h0000;
assign coeff[2] = 16'hFB85;
assign coeff[3] = 16'hFB2D;
assign coeff[4] = 16'hFEC4;
assign coeff[5] = 16'h0158;
assign coeff[6] = 16'h0000;
assign coeff[7] = 16'hFE5B;
assign coeff[8] = 16'h01D9;
assign coeff[9] = 16'h08F5;
assign coeff[10] = 16'h0A73;
assign coeff[11] = 16'h0000;
assign coeff[12] = 16'hF053;
assign coeff[13] = 16'hEB1A;
assign coeff[14] = 16'hF899;
assign coeff[15] = 16'h0ECC;
assign coeff[16] = 16'h1999;
assign coeff[17] = 16'h0ECC;
assign coeff[18] = 16'hF899;
assign coeff[19] = 16'hEB1A;
assign coeff[20] = 16'hF053;
assign coeff[21] = 16'h0000;
assign coeff[22] = 16'h0A73;
assign coeff[23] = 16'h08F5;
assign coeff[24] = 16'h01D9;
assign coeff[25] = 16'hFE5B;
assign coeff[26] = 16'h0000;
assign coeff[27] = 16'h0158;
assign coeff[28] = 16'hFEC4;
assign coeff[29] = 16'hFB2D;
assign coeff[30] = 16'hFB85;
assign coeff[31] = 16'h0000;
assign coeff[32] = 16'h03EB;

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
	if (switch[0]==1)
	begin
		flaga <= 0;
		flagb <= 0;
		int_count <= 0;
		interrupt <= 0;
		led <= 8'h22;
		yout <=16'h0000;
		xin <= 16'h0000;
		interreg[01] <= 0;interreg[02] <= 0;interreg[03] <= 0;interreg[04] <= 0;
		interreg[05] <= 0;interreg[06] <= 0;interreg[07] <= 0;interreg[08] <= 0;interreg[09] <= 0;
		interreg[10] <= 0;interreg[11] <= 0;interreg[12] <= 0;interreg[13] <= 0;interreg[14] <= 0;
		interreg[15] <= 0;interreg[16] <= 0;interreg[17] <= 0;interreg[18] <= 0;interreg[19] <= 0;
		interreg[20] <= 0;interreg[21] <= 0;interreg[22] <= 0;interreg[23] <= 0;interreg[24] <= 0;
		interreg[25] <= 0;interreg[26] <= 0;interreg[27] <= 0;interreg[28] <= 0;interreg[29] <= 0;
		interreg[30] <= 0;interreg[31] <= 0;interreg[32] <= 0;
	end
	else
	begin
		//divide 50MHz by 50,000,0000 to form 1Hz pulses
		//if (int_count==49999999)
		if (int_count==49999) //1k
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
				//led <= out_port;
				led <= interreg[11];
				
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
			yout <= (switch[3:1]*xin)>>3;// + intermediate[0]; //testing phase, just bounce back....
		/*
			yout <= intermediate[0] + interreg[1];
			interreg[1] <= intermediate[1] + interreg[2];
			interreg[2] <= intermediate[2] + interreg[3];
			interreg[3] <= intermediate[3] + interreg[4];
			interreg[4] <= intermediate[4] + interreg[5];
			interreg[5] <= intermediate[5] + interreg[6];
			interreg[6] <= intermediate[6] + interreg[7];
			interreg[7] <= intermediate[7] + interreg[8];
			interreg[8] <= intermediate[8] + interreg[9];
			interreg[9] <= intermediate[9] + interreg[10];
			interreg[10] <= intermediate[10] + interreg[11];
			interreg[11] <= intermediate[11] + interreg[12];
			interreg[12] <= intermediate[12] + interreg[13];
			interreg[13] <= intermediate[13] + interreg[14];
			interreg[14] <= intermediate[14] + interreg[15];
			interreg[15] <= intermediate[15] + interreg[16];
			interreg[16] <= intermediate[16] + interreg[17];
			interreg[17] <= intermediate[17] + interreg[18];
			interreg[18] <= intermediate[18] + interreg[19];
			interreg[19] <= intermediate[19] + interreg[20];
			interreg[20] <= intermediate[20] + interreg[21];
			interreg[21] <= intermediate[21] + interreg[22];
			interreg[22] <= intermediate[22] + interreg[23];
			interreg[23] <= intermediate[23] + interreg[24];
			interreg[24] <= intermediate[24] + interreg[25];
			interreg[25] <= intermediate[25] + interreg[26];
			interreg[26] <= intermediate[26] + interreg[27];
			interreg[27] <= intermediate[27] + interreg[28];
			interreg[28] <= intermediate[28] + interreg[29];
			interreg[29] <= intermediate[29] + interreg[30];
			interreg[30] <= intermediate[30] + interreg[31];
			interreg[31] <= intermediate[31] + interreg[32];		
			interreg[32] <= intermediate[32];
		*/
		end
		
	end
end //process output_ports;

/*
assign  simple_io[12] = interrupt; // --Test point//in dac.vhd, this is at simpleio(10)
// in dac.vhd, event_8khz (== event_1hz) is also output on simple_io pin...
assign simple_io[10] = out_port[3];  //--Test point is copy of amp_cs, dac_cs can be seen by out_port[5]
assign simple_io[11] = out_port[4];  //--Test point is copy of adc_conv
assign  simple_io[9] = spi_amp_sdo;   //Test point
*/
assign simple_io = yout[12:9];

// LCD interface  
//The 4-bit data port is bidirectional.
//lcd_rw is '1' for read and '0' for write 
//lcd_drive is like a master enable signal which prevents either the 
//FPGA outputs or the LCD display driving the data lines.
//Control of read and write signal
assign  lcd_rw = lcd_rw_control&lcd_drive;
//--use read/write control to enable output buffers.
assign  lcd_d = (lcd_rw_control==1'b0 && lcd_drive==1'b1)?lcd_output_data:4'bZ;

endmodule