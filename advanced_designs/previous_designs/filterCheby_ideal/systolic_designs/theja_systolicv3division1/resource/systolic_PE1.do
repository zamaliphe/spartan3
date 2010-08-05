set PROJECT_BASE  	./

quit -sim
cd $PROJECT_BASE

vlib work
vmap work work

vlog -work work $PROJECT_BASE/systolic_PE1.v
vlog -work work $PROJECT_BASE/mult.v
vlog -work work $PROJECT_BASE/multALU.v

#################
vlog -work work $PROJECT_BASE/detailed_testbench.v

vsim -t ps work.detailed_testbench

#add wave -r /*
add wave sim:/detailed_testbench/clk30x
add wave sim:/detailed_testbench/rst
add wave sim:/detailed_testbench/xin
add wave sim:/detailed_testbench/yout
add wave sim:/detailed_testbench/read_element32
add wave sim:/detailed_testbench/pe1/count
add wave sim:/detailed_testbench/pe1/wordIndex
add wave sim:/detailed_testbench/pe1/start_mult
add wave sim:/detailed_testbench/pe1/multBusyFlag
add wave sim:/detailed_testbench/pe1/chosen_coeff
#add wave sim:/detailed_testbench/pe1/previousOutputword

run -all

