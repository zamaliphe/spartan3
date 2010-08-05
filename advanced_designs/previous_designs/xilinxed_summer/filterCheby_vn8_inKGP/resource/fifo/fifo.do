set PROJECT_BASE  	./

quit -sim
cd $PROJECT_BASE

vlib work
vmap work work

vlog -work work $PROJECT_BASE/syncFifo.v
vlog -work work $PROJECT_BASE/syncFifo_ram.v

#################
vlog -work work $PROJECT_BASE/detailed_testbench.v

vsim -t ps work.detailed_testbench

#add wave -r /*
add wave sim:/detailed_testbench/clk30x
add wave sim:/detailed_testbench/rst
add wave sim:/detailed_testbench/xin
add wave sim:/detailed_testbench/yout
add wave sim:/detailed_testbench/read_element32
add wave sim:/detailed_testbench/wr_cs
add wave sim:/detailed_testbench/rd_cs
add wave sim:/detailed_testbench/wr_en
add wave sim:/detailed_testbench/rd_en
run -all