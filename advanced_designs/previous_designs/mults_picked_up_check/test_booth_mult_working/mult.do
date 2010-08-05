set PROJECT_BASE  	./

quit -sim
cd $PROJECT_BASE

vlib work
vmap work work

vlog -work work $PROJECT_BASE/mult.v
vlog -work work $PROJECT_BASE/alu.v
#################
vlog -work work $PROJECT_BASE/mult_TOP3.v

vsim -t ps work.mult_TOP3

#add wave -r /*
#add wave sim:/mult_TOP/extendedA

run -all

