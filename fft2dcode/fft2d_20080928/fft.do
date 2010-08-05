set ANNAPOLIS_BASE	c:/annapolis
set PROJECT_BASE  	C:/FFT/FFT4/simulation
set WILDCARD4_BASE  $ANNAPOLIS_BASE/wildcard4

quit -sim
cd $PROJECT_BASE

vlib WORK
vmap WORK WORK
#vmap unisim 		$WILDCARD4_BASE/vhdl/unisim
#vmap simprim 		$WILDCARD4_BASE/vhdl/simprim
#vmap xilinxcorelib 	$WILDCARD4_BASE/vhdl/XilinxCoreLib

vlog -work WORK $PROJECT_BASE/00defines.v
vlog -work WORK $PROJECT_BASE/Butterfly_Mult_Wallace_Adder.v
vlog -work WORK $PROJECT_BASE/00defines.v
vlog -work WORK $PROJECT_BASE/Butterfly_Mult_Wallace.v
vlog -work WORK $PROJECT_BASE/Butterfly_Mult_HalfAdder.v
vlog -work WORK $PROJECT_BASE/Butterfly_Mult_FullAdder.v
vlog -work WORK $PROJECT_BASE/Butterfly_Mult_CLA16.v
vlog -work WORK $PROJECT_BASE/Butterfly_Mult_CLA4.v
vlog -work WORK $PROJECT_BASE/Butterfly_Mult.v
vlog -work WORK $PROJECT_BASE/Butterfly.v

vlog -work WORK $PROJECT_BASE/AGUwSequencer.v
vlog -work WORK $PROJECT_BASE/AGUabSequencer.v
vlog -work WORK $PROJECT_BASE/AGU.v

vlog -work WORK $PROJECT_BASE/Controller.v
vlog -work WORK $PROJECT_BASE/IO.v
vlog -work WORK $PROJECT_BASE/unit_1DFFT.v

vlog -work WORK $PROJECT_BASE/Transposer.v

vlog -work WORK $PROJECT_BASE/FFT2D_Controller.v

vlog -work WORK $PROJECT_BASE/RAM_SFifo.v
vlog -work WORK $PROJECT_BASE/FFT2D_RAM.v

vlog -work WORK $PROJECT_BASE/SFifo.v
vlog -work WORK $PROJECT_BASE/FFT2D_IO.v

vlog -work WORK $PROJECT_BASE/ROM.v

vlog -work WORK $PROJECT_BASE/FFT2D.v

#################
vlog -work WORK $PROJECT_BASE/detailed_2DTOP_times.v

vsim -t ps WORK.detailed_2DTOP