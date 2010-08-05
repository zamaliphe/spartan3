setPreference -pref AutoSignature:FALSE
setPreference -pref KeepSVF:FALSE
setPreference -pref ConcurrentMode:FALSE
setPreference -pref UseHighz:FALSE
setPreference -pref svfUseTime:FALSE
loadProjectFile -file "D:/embedded_lab/test/adc_dac_v2_test/adc_dac_v2_test/adc_dac_v2_test.ipf"
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
assignFile -p 1 -file "D:/embedded_lab/test/adc_dac_v2_test/adc_dac_v2_test/picoblaze_adc_dac_control.bit"
Program -p 1 -defaultVersion 0 
saveProjectFile -file "D:/embedded_lab/test/adc_dac_v2_test/adc_dac_v2_test/adc_dac_v2_test.ipf"
