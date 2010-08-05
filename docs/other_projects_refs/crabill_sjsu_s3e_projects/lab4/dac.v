// File: dac.v
// This is the DAC module for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator timestep should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module dac
  (
  input  wire  [7:0] sample,
  input  wire        silent,
  output wire        analog,
  input  wire        reset,
  input  wire        clk
  );

  //******************************************************************//
  // Implement the delta-sigma converter.                             //
  //******************************************************************//

  wire [7:0] UnsignedSample;
  wire [9:0] DeltaAdder;
  wire [9:0] SigmaAdder;
  wire [9:0] DeltaB;
  reg  [9:0] Sigma;

  assign UnsignedSample = (silent ? 8'h00 : sample) + 128;
  assign DeltaB = {Sigma[9], Sigma[9]} << 8;
  assign SigmaAdder = DeltaAdder + Sigma;
  assign DeltaAdder = UnsignedSample + DeltaB;

  always @(posedge clk)
  begin
    if (reset) Sigma <= 1'b1 << 8;
    else Sigma <= SigmaAdder;
  end

  assign analog = Sigma[9];

  //******************************************************************//
  //                                                                  //
  //******************************************************************//

endmodule