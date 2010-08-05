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
assignFile -p 1 -file "D:/embedded_lab/test/adc_control_v0/adc_control_v0/picoblaze_amp_adc_control.bit"
Program -p 1 -defaultVersion 0 
