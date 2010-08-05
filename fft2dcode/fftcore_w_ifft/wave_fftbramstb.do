onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /detailed_testbench/inst_fftbrams/clk
add wave -noupdate -format Literal /detailed_testbench/inst_fftbrams/fft_dataa
add wave -noupdate -format Literal /detailed_testbench/inst_fftbrams/fft_datab
add wave -noupdate -format Literal /detailed_testbench/inst_fftbrams/fft_addra
add wave -noupdate -format Literal /detailed_testbench/inst_fftbrams/fft_addrb
add wave -noupdate -format Literal /detailed_testbench/inst_fftbrams/fft_wea
add wave -noupdate -format Literal /detailed_testbench/inst_fftbrams/fft_web
add wave -noupdate -format Literal /detailed_testbench/inst_fftbrams/fft_rea
add wave -noupdate -format Literal /detailed_testbench/inst_fftbrams/fft_reb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
update
WaveRestoreZoom {0 ps} {16 ps}
