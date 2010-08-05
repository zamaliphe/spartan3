set PROJECT_BASE  	./

quit -sim
cd $PROJECT_BASE

vlib work
vmap work work

vlog -work work $PROJECT_BASE/citi.v
vlog -work work $PROJECT_BASE/rom_T_x0.v
vlog -work work $PROJECT_BASE/rom_T_x1.v
vlog -work work $PROJECT_BASE/rom_T_x2.v
vlog -work work $PROJECT_BASE/rom_T_x3.v
vlog -work work $PROJECT_BASE/rom_T_x4.v
vlog -work work $PROJECT_BASE/rom_T_x5.v
vlog -work work $PROJECT_BASE/rom_T_x6.v
vlog -work work $PROJECT_BASE/rom_T_x7.v
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
add wave sim:/detailed_testbench/iirsummer/count
add wave sim:/detailed_testbench/iirsummer/wordIndex
add wave sim:/detailed_testbench/iirsummer/yout
add wave sim:/detailed_testbench/iirsummer/youtWire
add wave sim:/detailed_testbench/iirsummer/outputword_pe
add wave sim:/detailed_testbench/iirsummer/coeff
add wave sim:/detailed_testbench/iirsummer/xin_d
add wave sim:/detailed_testbench/iirsummer/start_mult
add wave sim:/detailed_testbench/iirsummer/intermediate
#add wave sim:/detailed_testbench/iirsummer/pe1/chosen_coeff
#add wave sim:/detailed_testbench/iirsummer/pe1/outputword
#add wave sim:/detailed_testbench/iirsummer/pe4/inputword
#add wave sim:/detailed_testbench/iirsummer/pe4/chosen_coeff
#add wave sim:/detailed_testbench/iirsummer/pe4/outputword

run -all