set PROJECT_BASE  	./

quit -sim
cd $PROJECT_BASE

vlib work
vmap work work

vlib XilinxCoreLib
vmap XilinxCoreLib XilinxCoreLib

vcom -93 -explicit -work XilinxCoreLib $PROJECT_BASE/blkmemdp_pkg_v6_3.vhd
vcom -93 -explicit -work XilinxCoreLib $PROJECT_BASE/ul_utils.vhd
vcom -93 -explicit -work XilinxCoreLib $PROJECT_BASE/blkmemdp_mem_init_file_pack_v6_3.vhd
vcom -93 -explicit -work XilinxCoreLib $PROJECT_BASE/blkmemdp_v6_3.vhd

vcom -93 -explicit -work work $PROJECT_BASE/txt_util.vhd
vcom -93 -explicit -work work $PROJECT_BASE/singlebram.vhd
vcom -93 -explicit -work work $PROJECT_BASE/fftbrams.vhd

vlog -work work $PROJECT_BASE/00defines.v

vlog -work work $PROJECT_BASE/Butterfly_Mult.v
vlog -work work $PROJECT_BASE/Butterfly.v

vlog -work work $PROJECT_BASE/AGUwSequencer.v
vlog -work work $PROJECT_BASE/AGUabSequencer.v
vlog -work work $PROJECT_BASE/AGU.v

vlog -work work $PROJECT_BASE/Controller.v
vlog -work work $PROJECT_BASE/IO.v
vlog -work work $PROJECT_BASE/unit_1DFFT.v

vlog -work work $PROJECT_BASE/FFTARRAY_Controller.v

vlog -work work $PROJECT_BASE/FFTARRAY.v


#################
vlog -work work $PROJECT_BASE/detailed_testbench.v

vsim -t ps work.detailed_testbench

#add wave -r /*
add wave sim:/detailed_testbench/FFT_dataa
add wave sim:/detailed_testbench/FFT_datab
add wave sim:/detailed_testbench/FFT_addra_aux
add wave sim:/detailed_testbench/FFT_addrb_aux
#add wave sim:/detailed_testbench/FFT_wea_aux
add wave sim:/detailed_testbench/FFT_rea_aux	
add wave sim:/detailed_testbench/FFT_web_aux
#add wave sim:/detailed_testbench/FFT_reb_aux
add wave sim:/detailed_testbench/FFT_busyflag
#add wave sim:/detailed_testbench/fftarraycore/f31/c01/stage
#add wave sim:/detailed_testbench/fftarraycore/f31/c01/state
#add wave sim:/detailed_testbench/fftarraycore/fftarray_c01/master_counter
#add wave sim:/detailed_testbench/fftarraycore/f31/ram0_add
#add wave sim:/detailed_testbench/fftarraycore/f31/ram0_bus
#add wave sim:/detailed_testbench/fftarraycore/f31/ram1_add
#add wave sim:/detailed_testbench/fftarraycore/f31/ram1_bus
#add wave sim:/detailed_testbench/fftarraycore/f31/butter_start
#run -all

