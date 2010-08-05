set PROJECT_BASE  	./
quit -sim
cd $PROJECT_BASE
vlib work
vmap work work


vlog -work work $PROJECT_BASE/mult.v
vlog -work work $PROJECT_BASE/multALU.v

#vlog -work work $PROJECT_BASE/mult_TOP3.v
#vsim -t ps work.mult_TOP3

vlog -work work $PROJECT_BASE/mult_TOPsingle.v
vsim -t ps work.mult_TOPsingle

#add wave -r /*
add wave sim:/mult_TOPsingle/theja/wClk
add wave sim:/mult_TOPsingle/theja/start
add wave sim:/mult_TOPsingle/theja/count
add wave sim:/mult_TOPsingle/theja/xProd

run -all

