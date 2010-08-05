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
#vcom -93 -explicit -work work $PROJECT_BASE/fftbramstb.vhd

vlog -work work $PROJECT_BASE/00defines.v

#vlog -work work $PROJECT_BASE/Butterfly_Mult_Wallace_Adder.v
#vlog -work work $PROJECT_BASE/Butterfly_Mult_Wallace.v
#vlog -work work $PROJECT_BASE/Butterfly_Mult_HalfAdder.v
#vlog -work work $PROJECT_BASE/Butterfly_Mult_FullAdder.v
#vlog -work work $PROJECT_BASE/Butterfly_Mult_CLA16.v
#vlog -work work $PROJECT_BASE/Butterfly_Mult_CLA4.v
vlog -work work $PROJECT_BASE/Butterfly_Mult.v
vlog -work work $PROJECT_BASE/Butterfly.v

vlog -work work $PROJECT_BASE/AGUwSequencer.v
vlog -work work $PROJECT_BASE/AGUabSequencer.v
vlog -work work $PROJECT_BASE/AGU.v

vlog -work work $PROJECT_BASE/Controller.v
vlog -work work $PROJECT_BASE/IO.v
vlog -work work $PROJECT_BASE/unit_1DFFT.v

vlog -work work $PROJECT_BASE/Transposer.v

vlog -work work $PROJECT_BASE/FFT2D_Controller.v

vlog -work work $PROJECT_BASE/FFT2D.v

#vlog -work work $PROJECT_BASE/ram_model.v

#################
vlog -work work $PROJECT_BASE/detailed_testbench.v

vsim -t ps work.detailed_testbench

#do wave_fftbramstb.do
#add wave -r /*
#add wave sim:/detailed_testbench/read_element
#add wave sim:/detailed_testbench/FFT_dataa
#add wave sim:/detailed_testbench/FFT_datab
#add wave sim:/detailed_testbench/FFT_addra
#add wave sim:/detailed_testbench/FFT_addrb
#add wave sim:/detailed_testbench/FFT_wea
#add wave sim:/detailed_testbench/FFT_rea
#add wave sim:/detailed_testbench/FFT_web
#add wave sim:/detailed_testbench/FFT_reb
#add wave sim:/detailed_testbench/read_output
#add wave sim:/detailed_testbench/fft2dcore/f31/ram0_add
#add wave sim:/detailed_testbench/fft2dcore/f31/ram0_bus
#add wave sim:/detailed_testbench/fft2dcore/f31/ram1_add
#add wave sim:/detailed_testbench/fft2dcore/f31/ram1_bus
#add wave sim:/detailed_testbench/fft2dcore/f31/c01/ram_cs_0
#add wave sim:/detailed_testbench/fft2dcore/f31/c01/ram_we_0
#add wave sim:/detailed_testbench/fft2dcore/f31/c01/ram_oe_0
#add wave sim:/detailed_testbench/fft2dcore/f31/c01/ram_cs_1
#add wave sim:/detailed_testbench/fft2dcore/f31/c01/ram_we_1
#add wave sim:/detailed_testbench/fft2dcore/f31/c01/ram_oe_1
#add wave sim:/detailed_testbench/fft2dcore/f31/c01/agu_start
#add wave sim:/detailed_testbench/fft2dcore/f31/c01/stage
#add wave sim:/detailed_testbench/fft2dcore/present_ram_row
#add wave sim:/detailed_testbench/fft2dcore/fft2d_c01/master_counter
#add wave sim:/detailed_testbench/FFT_reset

#run -all

