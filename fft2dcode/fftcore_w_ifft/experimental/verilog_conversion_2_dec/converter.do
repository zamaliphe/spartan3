set PROJECT_BASE  	./

quit -sim
cd $PROJECT_BASE

vlib work
vmap work work

vlog -work work $PROJECT_BASE/converter.v

vsim -t ps work.converter

add wave -r /*

#run -all
