setPreference -pref AutoSignature:FALSE
setPreference -pref KeepSVF:FALSE
setPreference -pref ConcurrentMode:FALSE
setPreference -pref UseHighz:FALSE
setPreference -pref svfUseTime:FALSE
loadProjectFile -file "D:/embedded_lab/test/filter_v2_test/filter_v2_test/filter_v2_test.ipf"
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
assignFile -p 1 -file "D:/embedded_lab/test/filter_v2_test/filter_v2_test/filter.bit"
Program -p 1 -defaultVersion 0 
Identify
identifyMPM
assignFile -p 1 -file "D:/embedded_lab/test/filter_v2_test/filter_v2_test/filter.bit"
Program -p 1 -defaultVersion 0 
assignFile -p 1 -file "D:/embedded_lab/test/filter_v2_test/filter_v2_test/filter.bit"
Program -p 1 -defaultVersion 0 
Program -p 1 -defaultVersion 0 
Program -p 1 -defaultVersion 0 
Program -p 1 -defaultVersion 0 
Program -p 1 -defaultVersion 0 
Program -p 1 -defaultVersion 0 
Program -p 1 -defaultVersion 0 
Program -p 1 -defaultVersion 0 
Program -p 1 -defaultVersion 0 
saveProjectFile -file "D:/embedded_lab/test/filter_v2_test/filter_v2_test/filter_v2_test.ipf"
