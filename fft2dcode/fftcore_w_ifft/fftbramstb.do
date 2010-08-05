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
vcom -93 -explicit -work work $PROJECT_BASE/fftbramstb.vhd
#vlog -work work $PROJECT_BASE/fftbrams_wrapper.v

vsim -t ps work.fftbramstb
#vsim -t ps work.fftbrams_wrapper

do wave_fftbramstb.do
