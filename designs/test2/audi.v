`timescale 1ns / 1ps

module audi (clk, reset, flag, start, theta_in, lcd, switch);
  
  input clk;
  input reset;
  input flag;
  input start;
  input [3:0] theta_in;
  
  output reg [7:0] lcd;
  output [3:0] switch;
  reg [7:0] in_port;
////////////////////////////////////////////////////////////
  wire  [7:0] theta;
  
  reg  [11:0] cvaluer;
  wire [11:0] cvalue;
  
  reg  [11:0] svaluer;
  wire [11:0] svalue;
  
  reg  [3:0] countr;
  wire [3:0] count;
  
  reg  [11:0] anglecoveredr;
  wire [11:0] anglecovered;
  
  reg rom_oe;
  
  wire [11:0] rom_data;
  wire [11:0] diff;
  wire done;
  wire done1;
  wire done2;
  wire [11:0] cosbcd;
  wire [11:0] sinbcd;
  reg re;
  reg ex;
  reg [3:0] sync;
  wire [7:0] out_port;
  wire write_strobe;
  wire read_strobe;
  reg [3:0] read_count;
  wire [3:0] read_count_w;
  reg inter;
  reg inter_ackr;
  wire inter_ack;
//  wire [7:0] theta_w;
//////////////////////////////////////////////////////////// 
  reg [3:0] theta_10;
  reg [3:0] theta_1;
  reg flagr;
  reg startr;

/*
always @(posedge clk) begin
  if(reset) begin
    theta_10 <= 4'b0000;
    theta_1  <= 4'b0000;
    flagr    <= 1'b0;
    startr   <= 1'b0;
  end
  
  if(flag) begin
    theta_10 <= theta_in;
    flagr <= 1'b1;
  end

  if(start) begin
    theta_1 <= theta_in;
    flagr <= 1'b0;
    startr <= 1'b1;
  end
end  
*/        


///////////////////////////////////////////////////////////
  assign switch = theta_in;
  assign theta = (theta_10 << 1) + (theta_10 << 3) + theta_1;
  assign diff = {theta,4'b0000} - anglecoveredr;
  assign count = countr[3:0] + 1'b1;
  assign anglecovered = diff[11] ? anglecoveredr - rom_data
                                : anglecoveredr + rom_data;
  assign cvalue = diff[11] ? cvaluer + (svaluer >> countr) 
                          : cvaluer - (svaluer >> countr);
  assign svalue = diff[11] ? svaluer - (cvaluer >> countr) 
                          : svaluer + (cvaluer >> countr);
  assign read_count_w = read_count[3:0] + 1'b1;
////////////////////////////////////////////////////////////
  embedded_kcpsm3 picb(
				.port_id(),
				.write_strobe(write_strobe),
				.read_strobe(read_strobe),
				.out_port(out_port),
				.in_port(in_port),
				.interrupt(inter),
				.interrupt_ack(inter_ack),
				.reset(reset),
				.clk(clk)
				);


          
 audi_rom ar(
  	       .i_rom_address(countr), 
			    .o_rom_data(rom_data),
			    .c_rom_read_en(rom_oe),
		      .c_rom_ce(rom_oe)			
			    );
	    
 binary_to_bcd b2bcd_cos(
          .clk_i(clk),
          .ce_i(1'b1),
          .rst_i(re),
          .start_i(ex),
          .dat_binary_i(cvaluer[9:0]),
          .dat_bcd_o(cosbcd),
          .done_o(done1)
          );
        
 binary_to_bcd b2bcd_sin(
          .clk_i(clk),
          .ce_i(1'b1),
          .rst_i(re),
          .start_i(ex),
          .dat_binary_i(svaluer[9:0]),
          .dat_bcd_o(sinbcd),
          .done_o(done2)
          );
///////////////////////////////////////////////////////////
always @(posedge clk) begin
  
  if(reset) begin
    cvaluer <= 10'b1001011111; //607
    svaluer <= 10'b0000000000;
    anglecoveredr <= 12'b000000000000;
    countr <= 4'b0000;
	 rom_oe <= 1'b1;
    re <= 1'b1;
    ex <= 1'b0;
    sync <= 4'b0000;
	 read_count <= 4'b0000;
	 inter_ackr <= 1'b0;
    inter <= 1'b0;
	 
	 theta_10 <= 4'b0000;
    theta_1  <= 4'b0000;
    flagr    <= 1'b0;
    startr   <= 1'b0;
	 in_port <= 8'b00000000;
  end
  
  else if(flag) begin
    theta_10 <= theta_in;
    flagr <= 1'b1;
  end
  
  else if(start & flagr) begin
	 cvaluer <= 10'b1001011111; //607
    svaluer <= 10'b0000000000;
    anglecoveredr <= 12'b000000000000;
    countr <= 4'b0000;
    re <= 1'b1;
    ex <= 1'b0;
    sync <= 4'b0000;
	 read_count <= 4'b0000;
	 inter_ackr <= 1'b0;
	 inter <= 1'b0;
	 
	 theta_1 <= theta_in;
    flagr <= 1'b0;
    startr <= 1'b1;
	 in_port <= 8'b00000000;
  end
   
  else if(startr & !flagr) begin
	  if(theta == 8'b00000000) begin
		 cvaluer <= 10'b1111100111;
		 countr <= 4'b1010;
	  end
	  else if((countr < 10) & (theta != anglecoveredr)) begin
		 countr <= count;
		 anglecoveredr <= anglecovered;
		 cvaluer <= cvalue;
		 svaluer <= svalue;
	  end
	  
	  if(((countr >= 10) | (theta == anglecoveredr))) begin
		 
			 if (sync == 1) begin
				re <= 1'b0;
				sync <= sync + 1'b1;
			 end
			 else if (sync == 2) begin
				ex <= 1'b1;
				sync <= sync + 1'b1;
			 end
			 else if (sync == 14) begin
				ex <= 1'b0;
				re <= 1'b0;
				if(done1 & done2) begin
					cvaluer <= cosbcd;
					svaluer <= sinbcd;
					sync <= 4'b1111;
				end
			 end		         
			 else if (sync == 4'b1111) begin
			 
				if(inter_ack) inter_ackr <= 1'b1;
				if(inter_ackr == 1'b0) inter <= 1'b1;
				else if(inter_ackr) begin
					inter <= 1'b0;
					if(read_strobe) read_count <= read_count_w;
				
					if(read_count == 0) in_port[7:0] <= {4'b0011,theta_10};
					else if(read_count == 1) in_port[7:0] <= {4'b0011,theta_1};	
					
					else if(read_count == 2) in_port[7:0] <= {4'b0011,svaluer[11:8]};							
					else if(read_count == 3) in_port[7:0] <= {4'b0011,svaluer[7:4]};
					else if(read_count == 4) in_port[7:0] <= {4'b0011,svaluer[3:0]};
								  
					else if(read_count == 5) in_port[7:0] <= {4'b0011,cvaluer[11:8]};
					else if(read_count == 6) in_port[7:0] <= {4'b0011,cvaluer[7:4]};
					else if(read_count == 7) begin
						in_port[7:0] <= {4'b0011,cvaluer[3:0]};
						startr <= 1'b0;				
					end  
				end
			end
			else sync <= sync + 1'b1;
	  end
  end
  if(write_strobe) lcd <= out_port;
end

endmodule
     