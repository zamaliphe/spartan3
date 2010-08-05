set PROJECT_BASE  	./

quit -sim
cd $PROJECT_BASE

vlib work
vmap work work

vlog -work work $PROJECT_BASE/Butterfly_Mult.v
#vlog -work work $PROJECT_BASE/Butterfly_Mult_Wallace.v
#vlog -work work $PROJECT_BASE/Butterfly_Mult_Wallace_Adder.v
#vlog -work work $PROJECT_BASE/Butterfly_Mult_CLA16.v
#vlog -work work $PROJECT_BASE/Butterfly_Mult_CLA4.v
#vlog -work work $PROJECT_BASE/Butterfly_Mult_FullAdder.v
#vlog -work work $PROJECT_BASE/Butterfly_Mult_HalfAdder.v

#################
vlog -work work $PROJECT_BASE/temp_MultTOP.v

vsim -t ps work.temp_MultTOP

#add wave -r /*
#add wave sim:/temp_MultTOP/extendedA

run -all

