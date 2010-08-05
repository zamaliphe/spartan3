// File: tutorial.v
// This is the top level design for EE178 Lab #5.

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
  input  wire        rot_a,
  input  wire        rot_b,
  output wire        vcc,
  output wire  [7:0] leds,
  output reg         lcd_e,
  output reg         lcd_rs,
  output reg         lcd_rw,
  output reg   [7:4] lcd_db
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
  reg           interrupt;
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

  assign vcc = 1'b1;

  //******************************************************************//
  // This is making my head spin!                                     //
  //******************************************************************//

  wire        sync_rot_b;
  synchro #(.INITIALIZE("LOGIC1"))
  synchro_rot_b (.async(rot_b),.sync(sync_rot_b),.clk(clk));

  wire        sync_rot_a;
  synchro #(.INITIALIZE("LOGIC1"))
  synchro_rot_a (.async(rot_a),.sync(sync_rot_a),.clk(clk));

  wire        rot_event;
  wire        rot_cwdir;
  reg         rot_cwsts;

  spinner spinner_inst (
    .sync_rot_a(sync_rot_a),
    .sync_rot_b(sync_rot_b),
    .rot_event(rot_event),
    .rot_cwdir(rot_cwdir),
    .clk(clk));
 
  always @(posedge clk)
  begin
    // capture the direction status in a flip flop
    if (rot_event) rot_cwsts <= rot_cwdir;
	 // implement the interrupt flag for picoblaze
    if (rot_event) interrupt <= 1'b1;
    else if (interrupt_ack) interrupt <= 1'b0;
  end

  //******************************************************************//
  // Implement output ports.                                          //
  // 00h: LCD data output port                                        //
  // 01h: LCD control output port                                     //
  // 02h: LED data output port                                        //
  // 03h: Reserved                                                    //
  // 04h: Reserved                                                    //
  //******************************************************************//

  reg     [7:0] led_pwm_value;
  wire          led_pwm;

  always @(posedge clk)
    begin
    if (write_strobe)
    begin
      if (port_id == 8'h00) lcd_db[7:4] <= out_port[7:4];
      if (port_id == 8'h01) {lcd_rs,lcd_rw,lcd_e} <= out_port[2:0];
      if (port_id == 8'h02) led_pwm_value <= out_port;
    end
  end

  pwm pwm_inst (
    .sample(led_pwm_value),
    .analog(led_pwm),
    .reset(reset),
    .clk(clk));

  assign leds = {8{led_pwm}};

  //******************************************************************//
  // Implement input ports.                                           //
  // 00h: LCD data output port readback                               //
  // 01h: LCD control output port readback                            //
  // 02h: LED data output port readback                               //
  // 03h: Switch data input port                                      //
  // 04h: Rotary knob direction                                       //
  //******************************************************************//

  always @*
  begin
    case (port_id)
      8'h00: in_port <= {lcd_db[7:4],4'b0000};
      8'h01: in_port <= {5'b00000,lcd_rs,lcd_rw,lcd_e};
      8'h02: in_port <= led_pwm_value;
      8'h03: in_port <= {4'b0000,switches};
		8'h04: in_port <= {7'b0000000,rot_cwsts};
      default: in_port <= 8'h00;
    endcase
  end

  //******************************************************************//
  //                                                                  //
  //******************************************************************//

endmodule