setMode -bscan                                                
setCable -p auto                                             
addDevice -position 1 -file .\picoblaze_amp_adc_control.bit  
addDevice -position 2 -part "xcf04s"                         
addDevice -position 2 -part "xcf04s"                         
ReadIdcode -p 1                                              
program -p 1                                                 
quit                                                         
