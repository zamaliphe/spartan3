// File:  testbench.v
// This is the top level testbench for EE178 Lab #3.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator timestep should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module testbench;

  // Declare everything we want connected to the
  // top level tutorial design.  Generally, all
  // outputs from the tutorial must be connected
  // to wires, and we'll use regs for all inputs
  // to the tutorial, so that we can control them
  // procedurally in this testbench.

  reg        clk;
  reg        rst;
  reg  [3:0] switches;
  wire [7:0] leds;
  wire       vcc;
  wire       lcd_e;
  wire       lcd_rs;
  wire       lcd_rw;
  wire [7:4] lcd_db;

  tutorial tutorial_inst (
    .clk(clk),
    .rst(rst),
    .switches(switches),
    .leds(leds),
    .vcc(vcc),
    .lcd_e(lcd_e),
    .lcd_rs(lcd_rs),
    .lcd_rw(lcd_rw),
    .lcd_db(lcd_db)
  );

  // Generate a free running 50 MHz clock
  // signal to mimic what is on the board
  // provided for prototyping.

  always
  begin
    clk = 1'b1;
    #10;
    clk = 1'b0;
    #10;
  end

  // Task for waiting an arbitrary
  // number of clk clock cycles.

  task CYCLE_WAIT;
    input [31:0] cycles;
    integer cyc_cnt;
  begin
    cyc_cnt = cycles;
    while (cyc_cnt)
    begin
      cyc_cnt = cyc_cnt - 1;
      @(posedge clk);
    end
  end
  endtask

  // Now, generate a reset assertion that
  // takes place at time zero and then
  // deasserts 100 ns later.  In this block,
  // also include a mechanism to exercise
  // the design and then finally stop the
  // simulation.

  initial
  begin
    $display("Simulation starting...");
    rst = 1'b1;
    switches = 8'h00;
    #100;
    $display("Reset signal released.");
    rst = 1'b0;

    CYCLE_WAIT(1000);

    $display("Simulation finished.");
    $stop;
  end

endmodule