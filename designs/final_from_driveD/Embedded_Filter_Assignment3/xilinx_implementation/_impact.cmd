setPreference -pref AutoSignature:FALSE
setPreference -pref KeepSVF:FALSE
setPreference -pref ConcurrentMode:FALSE
setPreference -pref UseHighz:FALSE
setPreference -pref svfUseTime:FALSE
setMode -bs
setMode -bs
setCable -port auto
Identify
identifyMPM
assignFile -p 1 -file "D:/Embedded_Filter_Assignment3/xilinx_implementation/embedded_filter_assignment.bit"
Program -p 1 -defaultVersion 0 
assignFile -p 1 -file "Y:/theja/embedded_lab/test/filter_v4_test/filter_v4_test/filter.bit"
Program -p 1 -defaultVersion 0 
assignFile -p 1 -file "D:/Embedded_Filter_Assignment3/xilinx_implementation/embedded_filter_assignment.bit"
Program -p 1 -defaultVersion 0 
saveProjectFile -file "D:/Embedded_Filter_Assignment3/xilinx_implementation/xilinx_implementation.ipf"
