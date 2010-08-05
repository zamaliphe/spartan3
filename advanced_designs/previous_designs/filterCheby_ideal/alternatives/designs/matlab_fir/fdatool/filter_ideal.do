set PROJECT_BASE  	./

quit -sim
cd $PROJECT_BASE

vlib work
vmap work work

vlog -work work $PROJECT_BASE/filter_ideal.v
#vlog -work work $PROJECT_BASE/multiplier.v

#################
vlog -work work $PROJECT_BASE/detailed_testbench.v

vsim -t ps work.detailed_testbench

#add wave -r /*
#add wave sim:/detailed_testbench/read_element
#add wave sim:/detailed_testbench/FFT_dataa
#add wave sim:/detailed_testbench/FFT_datab
#add wave sim:/detailed_testbench/FFT_addra
#add wave sim:/detailed_testbench/FFT_addrb
#add wave sim:/detailed_testbench/FFT_wea
#add wave sim:/detailed_testbench/FFT_rea
#add wave sim:/detailed_testbench/FFT_web
#add wave sim:/detailed_testbench/FFT_reb
#add wave sim:/detailed_testbench/read_output
#add wave sim:/detailed_testbench/fft2dcore/f31/ram0_add
#add wave sim:/detailed_testbench/fft2dcore/f31/ram0_bus
#add wave sim:/detailed_testbench/fft2dcore/f31/ram1_add
#add wave sim:/detailed_testbench/fft2dcore/f31/ram1_bus
#add wave sim:/detailed_testbench/fft2dcore/f31/c01/ram_cs_0
#add wave sim:/detailed_testbench/fft2dcore/f31/c01/ram_we_0
#add wave sim:/detailed_testbench/fft2dcore/f31/c01/ram_oe_0
#add wave sim:/detailed_testbench/fft2dcore/f31/c01/ram_cs_1
#add wave sim:/detailed_testbench/fft2dcore/f31/c01/ram_we_1
#add wave sim:/detailed_testbench/fft2dcore/f31/c01/ram_oe_1
#add wave sim:/detailed_testbench/fft2dcore/f31/c01/agu_start
#add wave sim:/detailed_testbench/fft2dcore/f31/c01/stage
#add wave sim:/detailed_testbench/fft2dcore/present_ram_row
#add wave sim:/detailed_testbench/fft2dcore/fft2d_c01/master_counter
#add wave sim:/detailed_testbench/FFT_reset

run -all

