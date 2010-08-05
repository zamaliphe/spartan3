/* log by theja, theja@mit.edu

On 1st June: figuring out how to time the internal units.
using the concept of donext

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
-- Design provided and tested on the Spartan-3E Starter Kit (Revision C)
-- Ken Chapman - Xilinx Ltd - 15th November 2005
-- The JTAG loader utility is also available for rapid program development.
-- The design is set up for a 50MHz system clock.
-- Measurements from the VINA input are amplified and displayed on the LCD display.
-- North and South press buttons are used to change the amplifier gain.
-- One measurement is made every second.
-- The simple LEDs and J4 connector are utilised for development and monitoring.
-- The switches and remaining press buttons are connected just for fun!
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
wire[17:0]	instruction;	//          : std_logic_vector(17 downto 0);
wire [7:0] 	port_id;		//          : std_logic_vector(7 downto 0);
wire [7:0] 	out_port;		//          : std_logic_vector(7 downto 0);
reg  [7:0] 	in_port;		//          : std_logic_vector(7 downto 0);
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
wire   [15:0] 		yout					;
reg    [15:0]		xin						;
reg 				flaga					;
reg 				flagb					;
wire 				chebyshevInterruptWire	;
reg 	[3:0]		interruptIndex			;
wire [32-1:0] 		timing[0:15]			;
wire 				interruptType[0:15]		;
reg 				donextSystolic			;
reg 				donextCiti				;
wire   [15:0] 		youtInterpol			;
wire   [15:0] 		xinViaSystolic			;
reg					firstCycleDone			;
wire   [15:0]		intermediate1			;
wire   [15:0]		intermediate2			;
reg					f_wr_cs					;
reg					f_wr_en					;
reg					f_rd_cs					;
wire				f_rd_en					;	//update: this has become wre..
wire				f_empty					;
wire				f_full					;
reg 	[5:0]		tempReg1				;
reg 				tempReg2				;


//Instantiations

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
adda_ctr adda_ctrl_001(.address(address),.instruction(instruction),.clk(clk));
// theja's inserted 'special' reconstruction filter.
//citi iirsummer(intermediate2,youtInterpol,clk, donextCiti, switch[0]);//the reconstruction modules start once the foremost sample comes.
//systolic_wrapper array(xin,intermediate1,xinViaSystolic,clk, donextSystolic, switch[0]);

syncFifoCG fifo(
clk30x   	, // Clock input
xin			,//intermediate1,// Data input
f_rd_en    	, // Read enable
switch[0]	, // Active high reset
f_wr_en    	, // Write Enable
youtInterpol,//intermediate2,// Data Output
f_empty    	, // FIFO empty
f_full        // FIFO full
);
/*
syncFifo fifo(
clk30x   	, // Clock input
switch[0]	, // Active high reset
f_wr_cs    	, // Write chip select
f_rd_cs    	, // Read chip select
intermediate1,// Data input
f_rd_en    	, // Read enable
f_wr_en    	, // Write Enable
intermediate2,// Data Output
f_empty    	, // FIFO empty
f_full        // FIFO full
);
*/

//Assignments

//Disable unused components  
assign  strataflash_oe 	= 1'b1;	//StrataFLASH must be disabled. period.
assign  strataflash_ce 	= 1'b1;
assign  strataflash_we 	= 1'b1;
assign  platformflash_oe= 1'b0; //Platform FLASH must be disabled. period.

assign timing[0] = 32'h00001E05;
assign timing[1] = 32'h000052A4;
assign timing[2] = 32'h00002201;
assign timing[3] = 32'h0000A14D;
assign timing[4] = 32'h0000363D;
assign timing[5] = 32'h00008D11;
assign timing[6] = 32'h00008C8D;
assign timing[7] = 32'h000036C1;
assign timing[8] = 32'h0000C34F;
assign timing[9] = 32'h000036C1;
assign timing[10] = 32'h00008C8D;
assign timing[11] = 32'h00008D11;
assign timing[12] = 32'h0000363D;
assign timing[13] = 32'h0000A14D;
assign timing[14] = 32'h00002201;
assign timing[15] = 32'h000052A4;

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

assign chebyshevInterruptWire =(interruptIndex==01+00)?interruptType[00]:(interruptIndex==01+01)?interruptType[01]:
							(interruptIndex==01+02)?interruptType[02]:(interruptIndex==01+03)?interruptType[03]:
							(interruptIndex==01+04)?interruptType[04]:(interruptIndex==01+05)?interruptType[05]:
							(interruptIndex==01+06)?interruptType[06]:(interruptIndex==01+07)?interruptType[07]:
							(interruptIndex==01+08)?interruptType[08]:(interruptIndex==01+09)?interruptType[09]:
							(interruptIndex==01+10)?interruptType[10]:(interruptIndex==01+11)?interruptType[11]:
							(interruptIndex==01+12)?interruptType[12]:(interruptIndex==01+13)?interruptType[13]:
							(interruptIndex==01+14)?interruptType[14]:interruptType[15];


//assign f_rd_en = ~chebyshevInterruptWire&firstCycleDone&read_strobe&~port_id[1]&~port_id[0];
assign f_rd_en = 0;
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
		interruptIndex		<= 0;
		donextSystolic		<= 0;
		donextCiti			<= 0;
		firstCycleDone		<= 0;
		f_wr_cs				<= 1;
		f_wr_en				<= 0;
		f_rd_cs				<= 1;
		//f_rd_en				<= 0;		//update: have made this a wire!
		
		tempReg1			<= 0;
		tempReg2			<= 0;
	end
	else
	begin

//PART 1
//We will first interrupt the processor after various intervals of time, half of which will be for sendingout the interpolated data and half of which will be for getting the
//chebyshev sampled points for filtering purposes.	
		if (int_count==(timing[interruptIndex])<<14) //takes cycles to skip from the constants declared above.
		begin
			int_count <= 0;
			event_1hz <= 1'b1;
			interruptIndex <= interruptIndex + 1'b1;//take care, the if condition is sensitive to this assignment.
			if(interruptIndex==4'hF)
			begin
					firstCycleDone	<= 1'b1;
			end
		end
		else
		begin
		 int_count <= int_count + 1'b1;
		 event_1hz <= 1'b0;
		end
		// processor interrupt waits for an acknowledgement
		if 	(interrupt_ack==1'b1) begin
			interrupt 		<= 		1'b0;
		end
		else if (event_1hz==1'b1) begin
			interrupt 		<= 		1'b1;
		end
		else begin
			interrupt 		<= interrupt;
		end

//PART 2
//KCPSM3 input ports : we make use of this to send our processed signal values (our youts need to be connected to its input ports)
//The inputs connect via a pipelined multiplexer

	    case (port_id[1:0])
	        2'b00:	//read simple toggle switches and buttons at address 00 hex
			begin
				if(read_strobe==1'b1)
				begin
					flaga <= ~flaga;
				end
				case(flaga)
				1'b0: begin 
					in_port <= yout[7:0]; 	//Place where we are sending the processed values to the kcpsm3 module. Output of our filters.
				end
				1'b1: begin					//we are sending both nterpolated as well as delayed cheby signals throug this. hence twice the rate as 
					in_port <= yout[15:8];
				end
				default: ;
				endcase
			end
	        2'b01:	//Standard. Not to be meddled with.
			begin
				in_port <= {spi_sdo,spi_amp_sdo,6'b000000};
			end
	        2'b10:	//Standard. Not to be meddled with.
			begin
				in_port <= {lcd_d,4'b0000};
			end
			default://the 2'b11 case important for theja's systolic.
			begin
				if(read_strobe==1'b1)
				begin
					if(chebyshevInterruptWire==1'b1)
					begin
						in_port <= 8'h00;  
					end
					else
					begin
						in_port <= 8'hFF;
						/*
						//alternatively anded both the read_strobe and the chebyshevInterruptWire and firstCycleDone signals.
						if(firstCycleDone)
						begin
							f_rd_en					<= 1'b1;
						end
						*/
					end
				end	
			end
	    endcase

//KCPSM3 output ports  //we collect chebyshev samples through these lines... via the processor outputs..
//adding the output registers to the processor

	    if(write_strobe==1'b1)
		begin

	        if(port_id[7]==1'b1)
			begin
				led <= {f_empty,f_full,tempReg1};
				flagb <= ~flagb;
				case(flagb)
					1'b0: begin
							xin[7:0]  <= out_port;
						end
					1'b1: begin
							xin[15:8] <= out_port;
							if(donextSystolic==1'b0)
							begin
								donextSystolic	<=1'b1;
								f_wr_en			<=1'b1;
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
		
		if(donextSystolic==1'b1)
		begin
				donextSystolic 	<= 1'b0;
				f_wr_en			<= 1'b0;
				tempReg1		<= tempReg1 + 1'b1;
		end
		if(f_rd_en)
		begin
			donextCiti				<= 1'b1;
		end
		if(donextCiti==1'b1)
		begin
				donextCiti <= 1'b0;
		end
		
	end//the Non reset part terminates here.
end //process output_ports;


assign yout = (switch[1]==1'b1)?xin:(chebyshevInterruptWire==1'b1)?xinViaSystolic:youtInterpol;	//just to check if bounceback is working or not.

assign simple_io[09] = event_1hz	; //Test point
assign simple_io[10] = out_port[3]	; //--Test point is copy of amp_cs, dac_cs can be seen by out_port[5]
assign simple_io[11] = out_port[4]	; //--Test point is copy of adc_conv
assign simple_io[12] = interrupt	; // --Test point//in dac.vhd, this is at simpleio(10)

// LCD interface  
assign  lcd_rw = lcd_rw_control&lcd_drive;
assign  lcd_d  = (lcd_rw_control==1'b0 && lcd_drive==1'b1)?lcd_output_data:4'bZ;

endmodule

//To use this funda:
//mult m1(yout_coeff1,xin,coeff1,clk,busy_coeff1,(flagb==1'b0 && write_strobe==1'b1));


/*
assign timingChebyshevWire = (interruptIndex==00)?timing[00]:
							(interruptIndex==01||interruptIndex==02)?timing[01]+timing[02] + 1:
							(interruptIndex==03||interruptIndex==04)?timing[03]+timing[04] + 1:
							(interruptIndex==05||interruptIndex==06)?timing[05]+timing[06] + 1:
(interruptIndex==07||interruptIndex==08||interruptIndex==09)?timing[07]+timing[08]+timing[09] + 2:
							(interruptIndex==10||interruptIndex==11)?timing[10]+timing[11] + 1:
							(interruptIndex==12||interruptIndex==13)?timing[12]+timing[13] + 1:
							timing[14]+timing[15] + 1;

assign timingNormalWire = 
(interruptIndex==15||interruptIndex==00||interruptIndex==01)?timing[15]+timing[00]+ timing[01] + 2:
							(interruptIndex==02||interruptIndex==03)?timing[02]+timing[03] + 1:
							(interruptIndex==04||interruptIndex==05)?timing[04]+timing[05] + 1:
							(interruptIndex==06||interruptIndex==07)?timing[06]+timing[07] + 1:
							(interruptIndex==08)?timing[08]:
							(interruptIndex==9||interruptIndex==10)?timing[9]+timing[10] + 1:
							(interruptIndex==11||interruptIndex==12)?timing[11]+timing[12] + 1:
							timing[13]+timing[14] + 1;
*/




/*
assign interruptType[0] = 1;assign interruptType[1] = 1;assign interruptType[2] = 1;assign interruptType[3] = 1;assign interruptType[4] = 1;assign interruptType[5] = 1;
assign interruptType[6] = 1;assign interruptType[7] = 1;assign interruptType[8] = 1;assign interruptType[9] = 1;assign interruptType[10] = 1;assign interruptType[11] = 1;
assign interruptType[12] = 1;assign interruptType[13] = 1;assign interruptType[14] = 1;assign interruptType[15] = 1;
*/