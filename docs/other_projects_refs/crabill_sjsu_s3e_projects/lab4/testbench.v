// File:  testbench.v
// This is the top level testbench for EE178 Lab #4.

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

  reg         clk;
  reg         rst;
  reg   [3:0] switches;
  wire  [7:0] leds;
  wire        lcd_e;
  wire        lcd_rs;
  wire        lcd_rw;
  wire  [7:4] lcd_db;
  wire [23:0] flash_address;
  wire  [7:0] flash_data;
  wire        flash_oe_n;
  wire        flash_ce_n;
  wire        flash_we_n;
  wire        flash_be_n;
  wire        xcf_flash_oe;
  wire        spi_rom_cs_n;
  wire        spi_adc_conv;
  wire        spi_dac_cs_n;
  wire        pwm_audio_out;

  tutorial tutorial_inst (
    .clk(clk),
    .rst(rst),
    .switches(switches),
    .leds(leds),
    .lcd_e(lcd_e),
    .lcd_rs(lcd_rs),
    .lcd_rw(lcd_rw),
    .lcd_db(lcd_db),
    .flash_address(flash_address),
    .flash_data(flash_data),
    .flash_oe_n(flash_oe_n),
    .flash_ce_n(flash_ce_n),
    .flash_we_n(flash_we_n),
    .flash_be_n(flash_be_n),
    .xcf_flash_oe(xcf_flash_oe),
    .spi_rom_cs_n(spi_rom_cs_n),
    .spi_adc_conv(spi_adc_conv),
    .spi_dac_cs_n(spi_dac_cs_n),
    .pwm_audio_out(pwm_audio_out)	 
  );

  // Instead of modeling the whole 65536
  // bytes worth of data storage in the 
  // parallel flash device, simply have
  // the low byte of the address returned
  // as data.

  assign flash_data = flash_address[7:0];

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