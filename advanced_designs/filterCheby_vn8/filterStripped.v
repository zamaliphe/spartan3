
//kcpsm3 related
wire [7:0] 	port_id;		//          : std_logic_vector(7 downto 0);
wire [7:0] 	out_port;		//          : std_logic_vector(7 downto 0);
reg  [7:0] 	in_port;		//          : std_logic_vector(7 downto 0);
wire 		write_strobe;	//          : std_logic;
wire 		read_strobe;	//          : std_logic;
reg 		interrupt;		//          : std_logic :='0'; THEJA
wire		interrupt_ack;	//          : std_logic;

// Signals used to generate interrupt 
reg [32-1:0] 	int_count;	//          : integer range 0 to 49999999 :=0; THEJA, this should be adjusted for faster speed.
reg 			event_1hz;	//          : std_logic; THEJA, name is misnomer in general..... says working at 1hz sampling...  it is just a flag. see logic below.

// Signals added by theja
wire   [15:0] 		yout					;
reg    [15:0]		xin						;
reg 				flaga					;
reg 				flagb					;
reg 	[3:0]		interruptIndex			;
wire [32-1:0] 		timing[0:15]			;
wire 				interruptType[0:15]		;
wire 				chebyshevInterruptWire	;
wire 				donextSystolic			;
wire 				donextCiti				;
wire   [15:0] 		youtInterpol			;
wire   [15:0] 		xinViaSystolic			;
reg					firstCycleDone			;
wire   [15:0]		intermediate1			;
wire   [15:0]		intermediate2			;
reg					f_wr_cs					;
reg					f_wr_en					;
reg					f_rd_cs					;
reg					f_rd_en					;
wire				f_empty					;
wire				f_full					;

//Instantiations
// theja's inserted 'special' reconstruction filter.
citi iirsummer(intermediate2,youtInterpol,clk, donextCiti, switch[0]);//the reconstruction modules start once the foremost sample comes.

systolic_wrapper array(xin,intermediate1,xinViaSystolic,clk, donextSystolic, switch[0]);

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



//Assignments

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

assign chebyshevInterruptWire = (interruptIndex==00)?interruptType[00]:(interruptIndex==01)?interruptType[01]:
								(interruptIndex==02)?interruptType[02]:(interruptIndex==03)?interruptType[03]:
								(interruptIndex==04)?interruptType[04]:(interruptIndex==05)?interruptType[05]:
								(interruptIndex==06)?interruptType[06]:(interruptIndex==07)?interruptType[07]:
								(interruptIndex==08)?interruptType[08]:(interruptIndex==09)?interruptType[09]:
								(interruptIndex==10)?interruptType[10]:(interruptIndex==11)?interruptType[11]:
								(interruptIndex==12)?interruptType[12]:(interruptIndex==13)?interruptType[13]:
								(interruptIndex==14)?interruptType[14]:interruptType[15];



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
		f_rd_en				<= 0;
	end
	else
	begin
		
//We will first interrupt the processor after various intervals of time, half of which will be for sendingout the interpolated data and half of which will be for getting the
//chebyshev sampled points for filtering purposes.	
		if (int_count==timing[interruptIndex]) //takes cycles to skip from the constants declared above.
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
					in_port <= yout[7:0]; 
			end
	        //important for theja's systolic.
			2'b11://the 2'b11 case
			begin
				if(chebyshevInterruptWire==1'b1)
				begin
					in_port <= 8'h00;  
					wasChebyshevInterrupt	<= 1'b1;
				end
				else
				begin
					in_port <= 8'hFF;
					wasChebyshevInterrupt	<= 1'b0;
					if(firstCycleDone)
					begin
						f_rd_en					<= 1'b1;
					end
				end
				interruptIndex <= interruptIndex + 1'b1;//take care, the if condition is sensitive to this assignment.
				if(interruptIndex==-1)
				begin
					firstCycleDone	<= 1'b1;
				end
			end
			default:	;
	    endcase

//KCPSM3 output ports 
//adding the output registers to the processor

	    if(write_strobe==1'b1)
		begin

	        if(port_id[7]==1'b1)
			begin
				led <= out_port;
				xin[7:0]  <= out_port;
				if(donextSystolic==1'b0)
				begin
					donextSystolic	<=1'b1;
					f_wr_en			<=1'b1;
				end
	        end
	    end
		
		if(donextSystolic==1'b1)
		begin
				donextSystolic 	<= 1'b0;
				f_wr_en			<= 1'b0;
		end
		if(f_rd_en)
		begin
			donextCiti				<= 1'b1;
			f_rd_en					<= 1'b0;
		end
		if(donextCiti==1'b1)
		begin
				donextCiti <= 1'b0;
		end
		
	end//the Non reset part terminates here.
end //process output_ports;

endmodule
