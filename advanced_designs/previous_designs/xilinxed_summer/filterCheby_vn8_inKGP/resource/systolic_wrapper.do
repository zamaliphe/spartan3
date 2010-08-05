set PROJECT_BASE  	./

quit -sim
cd $PROJECT_BASE

vlib work
vmap work work

vlog -work work $PROJECT_BASE/systolic_wrapper.v
vlog -work work $PROJECT_BASE/systolic_PE1.v
vlog -work work $PROJECT_BASE/systolic_PE2.v
vlog -work work $PROJECT_BASE/systolic_PE3.v
vlog -work work $PROJECT_BASE/systolic_PE4.v
vlog -work work $PROJECT_BASE/systolic_PE5.v
vlog -work work $PROJECT_BASE/systolic_PE6.v
vlog -work work $PROJECT_BASE/systolic_PE7.v
vlog -work work $PROJECT_BASE/systolic_PE8.v
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
add wave sim:/detailed_testbench/array/donext
add wave sim:/detailed_testbench/array/wordIndex
add wave sim:/detailed_testbench/array/outputword
add wave sim:/detailed_testbench/array/outputword_pe
add wave sim:/detailed_testbench/array/pe1/wordIndex
add wave sim:/detailed_testbench/array/pe1/start_mult
add wave sim:/detailed_testbench/array/pe1/multBusyFlag
add wave sim:/detailed_testbench/array/pe1/inputword
add wave sim:/detailed_testbench/array/pe1/chosen_coeff
add wave sim:/detailed_testbench/array/pe1/outputword
add wave sim:/detailed_testbench/array/pe2/inputword
add wave sim:/detailed_testbench/array/pe2/chosen_coeff
add wave sim:/detailed_testbench/array/pe2/outputword
add wave sim:/detailed_testbench/array/pe2/intermediate

run -all

