setPreference -pref AutoSignature:FALSE
setPreference -pref KeepSVF:FALSE
setPreference -pref ConcurrentMode:FALSE
setPreference -pref UseHighz:FALSE
setPreference -pref svfUseTime:FALSE
loadProjectFile -file "D:/embedded_lab/test/filter_v4_test/filter_v4_test/filter_v4_test.ipf"
setMode -ss
setMode -sm
setMode -hw140
setMode -acecf
setMode -acempm
setMode -pff
setMode -bs
setMode -bs
setMode -bs
setCable -port auto
Identify
identifyMPM
Identify
identifyMPM
assignFile -p 1 -file "D:/Embedded_Filter_Assignment3/xilinx_implementation/embedded_filter_assignment.bit"
