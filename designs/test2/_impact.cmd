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
assignFile -p 1 -file "D:/embedded_lab/test/test2/audi.bit"
Program -p 1 -defaultVersion 0 
saveProjectFile -file "D:/embedded_lab/test/test2/test2.ipf"