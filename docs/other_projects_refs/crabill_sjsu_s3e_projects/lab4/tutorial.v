// File: tutorial.v
// This is the top level design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator timestep should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module tutorial
  (
  input  wire        clk,
  input  wire        rst,
  input  wire  [3:0] switches,
  output reg   [7:0] leds,
  output reg         lcd_e,
  output reg         lcd_rs,
  output reg         lcd_rw,
  output reg   [7:4] lcd_db,
  output wire [23:0] flash_address,
  input  wire  [7:0] flash_data,
  output wire        flash_oe_n,
  output wire        flash_ce_n,
  output wire        flash_we_n,
  output wire        flash_be_n,
  output wire        xcf_flash_oe,
  output wire        spi_rom_cs_n,
  output wire        spi_adc_conv,
  output wire        spi_dac_cs_n,
  output wire        pwm_audio_out
  );

  //******************************************************************//
  // Instantiate PicoBlaze and the Instruction ROM.                   //
  //******************************************************************//

  wire    [9:0] address;
  wire   [17:0] instruction;
  wire    [7:0] port_id;
  wire    [7:0] out_port;
  reg     [7:0] in_port;
  wire          write_strobe;
  wire          read_strobe;
  wire          interrupt;
  wire          interrupt_ack;

  kcpsm3 kcpsm3_inst (
    .address(address),
    .instruction(instruction),
    .port_id(port_id),
    .write_strobe(write_strobe),
    .out_port(out_port),
    .read_strobe(read_strobe),
    .in_port(in_port),
    .interrupt(interrupt),
    .interrupt_ack(interrupt_ack),
    .reset(reset),
    .clk(clk));

  software software_inst (
    .address(address),
    .instruction(instruction),
    .reset(reset),
    .rst(rst),
    .clk(clk));

  assign interrupt = 1'b0;

  //******************************************************************//
  // Implement output ports.                                          //
  // 00h: LCD data output port                                        //
  // 01h: LCD control output port                                     //
  // 02h: LED data output port                                        //
  // 03h: Reserved output port                                        //
  // 04h: Narrator output port                                        //
  //******************************************************************//

  wire          narrator_write;

  always @(posedge clk)
    begin
    if (write_strobe)
    begin
      if (port_id == 8'h00) lcd_db[7:4] <= out_port[7:4];
      if (port_id == 8'h01) {lcd_rs,lcd_rw,lcd_e} <= out_port[2:0];
      if (port_id == 8'h02) leds <= out_port;
    end
  end

  assign narrator_write = write_strobe && (port_id ==8'h04);

  //******************************************************************//
  // Instantiate the Narrator module.                                 //
  //******************************************************************//

  wire          narrator_busy;

  narrator narrator_inst (
    .pico_data(out_port),
    .pico_write(narrator_write),
    .pico_busy(narrator_busy),
    .pico_reset(reset),
    .pico_clk(clk),
    .flash_address(flash_address),
    .flash_data(flash_data),
    .pwm_audio_out(pwm_audio_out));

  assign flash_oe_n = 1'b0; // assert output enable
  assign flash_ce_n = 1'b0; // assert chip enable
  assign flash_we_n = 1'b1; // deassert write enable
  assign flash_be_n = 1'b0; // assert byte mode
  
  // The LSB of the data bus from the flash device
  // is connected to many components.  The other
  // components which share this connection must
  // be disabled to prevent any electrical conflict.

  assign xcf_flash_oe = 1'b0;
  assign spi_rom_cs_n = 1'b1;
  assign spi_adc_conv = 1'b0;
  assign spi_dac_cs_n = 1'b1;
						
  //******************************************************************//
  // Implement input ports.                                           //
  // 00h: LCD data output port readback                               //
  // 01h: LCD control output port readback                            //
  // 02h: LED data output port readback                               //
  // 03h: Switch data input port                                      //
  // 04h: Narrator status input port                                  //
  //******************************************************************//

  always @*
  begin
    case (port_id)
      8'h00: in_port <= {lcd_db[7:4],4'b0000};
      8'h01: in_port <= {5'b00000,lcd_rs,lcd_rw,lcd_e};
      8'h02: in_port <= leds;
      8'h03: in_port <= {4'b0000,switches};
      8'h04: in_port <= {7'b0000000,narrator_busy};
      default: in_port <= 8'h00;
    endcase
  end

  //******************************************************************//
  //                                                                  //
  //******************************************************************//

endmodule