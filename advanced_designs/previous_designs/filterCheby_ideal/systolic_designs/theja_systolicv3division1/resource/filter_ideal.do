set PROJECT_BASE  	./

quit -sim
cd $PROJECT_BASE

vlib work
vmap work work

vlog -work work $PROJECT_BASE/filter_ideal.v
vlog -work work $PROJECT_BASE/mult.v
vlog -work work $PROJECT_BASE/multALU.v

#################
vlog -work work $PROJECT_BASE/detailed_testbench.v

vsim -t ns work.detailed_testbench

#add wave -r /*
add wave sim:/detailed_testbench/clk30x
add wave sim:/detailed_testbench/rst
add wave sim:/detailed_testbench/i
add wave sim:/detailed_testbench/xin
add wave sim:/detailed_testbench/read_element32
add wave sim:/detailed_testbench/f001/count
add wave sim:/detailed_testbench/f001/start_mult
add wave sim:/detailed_testbench/f001/busy_coeff


run -all

