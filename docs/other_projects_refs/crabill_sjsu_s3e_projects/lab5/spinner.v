// File: spinner.v
// This is the knob processor for EE178 Lab #5.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator timestep should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module spinner
  (
  input  wire        sync_rot_a,
  input  wire        sync_rot_b,
  input  wire        clk,
  output reg         rot_event,
  output reg         rot_cwdir
  );

  //******************************************************************//
  // Implement rotary knob processing (borred from KC/PA design).     //
  //******************************************************************//

  reg                rotary_q1;
  reg                rotary_q2;
  reg                rotary_q1_dly;
  reg                rotary_q2_dly;

  always @(posedge clk)
  begin : filter
    case ({sync_rot_b, sync_rot_a})
      0: rotary_q1 <= 1'b0;
      1: rotary_q2 <= 1'b0;
      2: rotary_q2 <= 1'b1;
      3: rotary_q1 <= 1'b1;
    endcase
    rotary_q1_dly <= rotary_q1;
    rotary_q2_dly <= rotary_q2;
	 rot_event <= !rotary_q1_dly & rotary_q1;
	 rot_cwdir <= !rotary_q2_dly;
  end

  //******************************************************************//
  //                                                                  //
  //******************************************************************//

endmodule