
assign ram_exchange_bus[(0+1)*`FFT_DATA_WIDTH-1:(0)*`FFT_DATA_WIDTH] = 
(((delayed_j+0)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+0)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+0)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+0)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+0)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+0)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+0)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+0)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+0)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+0)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+0)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+0)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+0)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+0)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+0)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+0)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+0)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+0)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+0)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+0)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+0)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+0)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+0)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+0)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+0)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+0)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+0)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+0)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+0)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+0)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+0)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+0)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(1+1)*`FFT_DATA_WIDTH-1:(1)*`FFT_DATA_WIDTH] = 
(((delayed_j+1)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+1)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+1)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+1)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+1)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+1)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+1)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+1)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+1)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+1)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+1)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+1)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+1)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+1)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+1)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+1)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+1)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+1)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+1)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+1)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+1)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+1)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+1)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+1)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+1)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+1)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+1)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+1)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+1)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+1)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+1)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+1)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(2+1)*`FFT_DATA_WIDTH-1:(2)*`FFT_DATA_WIDTH] = 
(((delayed_j+2)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+2)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+2)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+2)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+2)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+2)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+2)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+2)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+2)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+2)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+2)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+2)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+2)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+2)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+2)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+2)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+2)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+2)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+2)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+2)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+2)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+2)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+2)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+2)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+2)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+2)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+2)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+2)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+2)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+2)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+2)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+2)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(3+1)*`FFT_DATA_WIDTH-1:(3)*`FFT_DATA_WIDTH] = 
(((delayed_j+3)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+3)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+3)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+3)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+3)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+3)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+3)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+3)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+3)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+3)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+3)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+3)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+3)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+3)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+3)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+3)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+3)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+3)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+3)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+3)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+3)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+3)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+3)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+3)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+3)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+3)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+3)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+3)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+3)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+3)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+3)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+3)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(4+1)*`FFT_DATA_WIDTH-1:(4)*`FFT_DATA_WIDTH] = 
(((delayed_j+4)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+4)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+4)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+4)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+4)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+4)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+4)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+4)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+4)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+4)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+4)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+4)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+4)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+4)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+4)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+4)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+4)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+4)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+4)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+4)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+4)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+4)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+4)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+4)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+4)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+4)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+4)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+4)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+4)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+4)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+4)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+4)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(5+1)*`FFT_DATA_WIDTH-1:(5)*`FFT_DATA_WIDTH] = 
(((delayed_j+5)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+5)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+5)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+5)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+5)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+5)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+5)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+5)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+5)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+5)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+5)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+5)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+5)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+5)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+5)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+5)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+5)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+5)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+5)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+5)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+5)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+5)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+5)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+5)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+5)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+5)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+5)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+5)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+5)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+5)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+5)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+5)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(6+1)*`FFT_DATA_WIDTH-1:(6)*`FFT_DATA_WIDTH] = 
(((delayed_j+6)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+6)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+6)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+6)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+6)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+6)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+6)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+6)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+6)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+6)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+6)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+6)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+6)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+6)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+6)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+6)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+6)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+6)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+6)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+6)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+6)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+6)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+6)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+6)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+6)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+6)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+6)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+6)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+6)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+6)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+6)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+6)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(7+1)*`FFT_DATA_WIDTH-1:(7)*`FFT_DATA_WIDTH] = 
(((delayed_j+7)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+7)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+7)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+7)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+7)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+7)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+7)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+7)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+7)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+7)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+7)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+7)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+7)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+7)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+7)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+7)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+7)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+7)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+7)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+7)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+7)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+7)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+7)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+7)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+7)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+7)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+7)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+7)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+7)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+7)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+7)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+7)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(8+1)*`FFT_DATA_WIDTH-1:(8)*`FFT_DATA_WIDTH] = 
(((delayed_j+8)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+8)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+8)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+8)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+8)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+8)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+8)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+8)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+8)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+8)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+8)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+8)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+8)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+8)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+8)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+8)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+8)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+8)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+8)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+8)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+8)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+8)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+8)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+8)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+8)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+8)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+8)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+8)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+8)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+8)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+8)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+8)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(9+1)*`FFT_DATA_WIDTH-1:(9)*`FFT_DATA_WIDTH] = 
(((delayed_j+9)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+9)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+9)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+9)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+9)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+9)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+9)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+9)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+9)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+9)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+9)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+9)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+9)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+9)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+9)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+9)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+9)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+9)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+9)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+9)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+9)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+9)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+9)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+9)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+9)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+9)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+9)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+9)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+9)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+9)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+9)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+9)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(10+1)*`FFT_DATA_WIDTH-1:(10)*`FFT_DATA_WIDTH] = 
(((delayed_j+10)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+10)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+10)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+10)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+10)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+10)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+10)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+10)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+10)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+10)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+10)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+10)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+10)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+10)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+10)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+10)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+10)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+10)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+10)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+10)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+10)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+10)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+10)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+10)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+10)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+10)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+10)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+10)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+10)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+10)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+10)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+10)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(11+1)*`FFT_DATA_WIDTH-1:(11)*`FFT_DATA_WIDTH] = 
(((delayed_j+11)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+11)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+11)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+11)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+11)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+11)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+11)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+11)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+11)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+11)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+11)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+11)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+11)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+11)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+11)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+11)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+11)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+11)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+11)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+11)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+11)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+11)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+11)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+11)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+11)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+11)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+11)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+11)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+11)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+11)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+11)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+11)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(12+1)*`FFT_DATA_WIDTH-1:(12)*`FFT_DATA_WIDTH] = 
(((delayed_j+12)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+12)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+12)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+12)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+12)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+12)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+12)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+12)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+12)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+12)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+12)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+12)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+12)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+12)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+12)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+12)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+12)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+12)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+12)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+12)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+12)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+12)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+12)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+12)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+12)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+12)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+12)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+12)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+12)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+12)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+12)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+12)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(13+1)*`FFT_DATA_WIDTH-1:(13)*`FFT_DATA_WIDTH] = 
(((delayed_j+13)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+13)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+13)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+13)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+13)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+13)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+13)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+13)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+13)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+13)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+13)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+13)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+13)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+13)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+13)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+13)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+13)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+13)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+13)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+13)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+13)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+13)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+13)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+13)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+13)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+13)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+13)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+13)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+13)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+13)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+13)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+13)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(14+1)*`FFT_DATA_WIDTH-1:(14)*`FFT_DATA_WIDTH] = 
(((delayed_j+14)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+14)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+14)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+14)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+14)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+14)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+14)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+14)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+14)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+14)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+14)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+14)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+14)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+14)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+14)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+14)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+14)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+14)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+14)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+14)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+14)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+14)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+14)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+14)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+14)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+14)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+14)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+14)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+14)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+14)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+14)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+14)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(15+1)*`FFT_DATA_WIDTH-1:(15)*`FFT_DATA_WIDTH] = 
(((delayed_j+15)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+15)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+15)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+15)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+15)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+15)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+15)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+15)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+15)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+15)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+15)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+15)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+15)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+15)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+15)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+15)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+15)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+15)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+15)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+15)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+15)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+15)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+15)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+15)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+15)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+15)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+15)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+15)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+15)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+15)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+15)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+15)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(16+1)*`FFT_DATA_WIDTH-1:(16)*`FFT_DATA_WIDTH] = 
(((delayed_j+16)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+16)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+16)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+16)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+16)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+16)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+16)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+16)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+16)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+16)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+16)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+16)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+16)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+16)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+16)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+16)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+16)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+16)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+16)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+16)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+16)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+16)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+16)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+16)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+16)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+16)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+16)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+16)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+16)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+16)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+16)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+16)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(17+1)*`FFT_DATA_WIDTH-1:(17)*`FFT_DATA_WIDTH] = 
(((delayed_j+17)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+17)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+17)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+17)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+17)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+17)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+17)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+17)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+17)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+17)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+17)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+17)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+17)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+17)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+17)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+17)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+17)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+17)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+17)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+17)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+17)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+17)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+17)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+17)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+17)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+17)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+17)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+17)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+17)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+17)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+17)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+17)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(18+1)*`FFT_DATA_WIDTH-1:(18)*`FFT_DATA_WIDTH] = 
(((delayed_j+18)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+18)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+18)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+18)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+18)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+18)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+18)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+18)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+18)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+18)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+18)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+18)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+18)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+18)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+18)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+18)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+18)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+18)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+18)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+18)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+18)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+18)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+18)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+18)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+18)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+18)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+18)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+18)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+18)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+18)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+18)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+18)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(19+1)*`FFT_DATA_WIDTH-1:(19)*`FFT_DATA_WIDTH] = 
(((delayed_j+19)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+19)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+19)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+19)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+19)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+19)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+19)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+19)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+19)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+19)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+19)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+19)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+19)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+19)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+19)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+19)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+19)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+19)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+19)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+19)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+19)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+19)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+19)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+19)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+19)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+19)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+19)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+19)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+19)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+19)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+19)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+19)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(20+1)*`FFT_DATA_WIDTH-1:(20)*`FFT_DATA_WIDTH] = 
(((delayed_j+20)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+20)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+20)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+20)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+20)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+20)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+20)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+20)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+20)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+20)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+20)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+20)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+20)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+20)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+20)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+20)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+20)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+20)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+20)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+20)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+20)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+20)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+20)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+20)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+20)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+20)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+20)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+20)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+20)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+20)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+20)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+20)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(21+1)*`FFT_DATA_WIDTH-1:(21)*`FFT_DATA_WIDTH] = 
(((delayed_j+21)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+21)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+21)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+21)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+21)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+21)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+21)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+21)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+21)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+21)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+21)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+21)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+21)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+21)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+21)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+21)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+21)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+21)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+21)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+21)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+21)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+21)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+21)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+21)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+21)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+21)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+21)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+21)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+21)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+21)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+21)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+21)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(22+1)*`FFT_DATA_WIDTH-1:(22)*`FFT_DATA_WIDTH] = 
(((delayed_j+22)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+22)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+22)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+22)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+22)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+22)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+22)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+22)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+22)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+22)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+22)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+22)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+22)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+22)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+22)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+22)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+22)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+22)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+22)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+22)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+22)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+22)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+22)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+22)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+22)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+22)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+22)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+22)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+22)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+22)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+22)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+22)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(23+1)*`FFT_DATA_WIDTH-1:(23)*`FFT_DATA_WIDTH] = 
(((delayed_j+23)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+23)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+23)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+23)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+23)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+23)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+23)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+23)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+23)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+23)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+23)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+23)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+23)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+23)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+23)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+23)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+23)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+23)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+23)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+23)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+23)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+23)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+23)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+23)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+23)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+23)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+23)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+23)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+23)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+23)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+23)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+23)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(24+1)*`FFT_DATA_WIDTH-1:(24)*`FFT_DATA_WIDTH] = 
(((delayed_j+24)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+24)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+24)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+24)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+24)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+24)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+24)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+24)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+24)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+24)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+24)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+24)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+24)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+24)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+24)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+24)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+24)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+24)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+24)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+24)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+24)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+24)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+24)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+24)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+24)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+24)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+24)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+24)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+24)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+24)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+24)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+24)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(25+1)*`FFT_DATA_WIDTH-1:(25)*`FFT_DATA_WIDTH] = 
(((delayed_j+25)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+25)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+25)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+25)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+25)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+25)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+25)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+25)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+25)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+25)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+25)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+25)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+25)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+25)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+25)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+25)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+25)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+25)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+25)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+25)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+25)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+25)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+25)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+25)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+25)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+25)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+25)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+25)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+25)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+25)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+25)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+25)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(26+1)*`FFT_DATA_WIDTH-1:(26)*`FFT_DATA_WIDTH] = 
(((delayed_j+26)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+26)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+26)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+26)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+26)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+26)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+26)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+26)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+26)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+26)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+26)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+26)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+26)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+26)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+26)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+26)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+26)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+26)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+26)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+26)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+26)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+26)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+26)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+26)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+26)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+26)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+26)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+26)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+26)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+26)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+26)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+26)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(27+1)*`FFT_DATA_WIDTH-1:(27)*`FFT_DATA_WIDTH] = 
(((delayed_j+27)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+27)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+27)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+27)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+27)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+27)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+27)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+27)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+27)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+27)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+27)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+27)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+27)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+27)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+27)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+27)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+27)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+27)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+27)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+27)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+27)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+27)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+27)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+27)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+27)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+27)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+27)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+27)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+27)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+27)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+27)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+27)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(28+1)*`FFT_DATA_WIDTH-1:(28)*`FFT_DATA_WIDTH] = 
(((delayed_j+28)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+28)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+28)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+28)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+28)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+28)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+28)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+28)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+28)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+28)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+28)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+28)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+28)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+28)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+28)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+28)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+28)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+28)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+28)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+28)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+28)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+28)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+28)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+28)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+28)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+28)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+28)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+28)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+28)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+28)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+28)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+28)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(29+1)*`FFT_DATA_WIDTH-1:(29)*`FFT_DATA_WIDTH] = 
(((delayed_j+29)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+29)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+29)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+29)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+29)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+29)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+29)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+29)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+29)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+29)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+29)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+29)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+29)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+29)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+29)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+29)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+29)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+29)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+29)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+29)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+29)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+29)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+29)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+29)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+29)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+29)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+29)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+29)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+29)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+29)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+29)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+29)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(30+1)*`FFT_DATA_WIDTH-1:(30)*`FFT_DATA_WIDTH] = 
(((delayed_j+30)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+30)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+30)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+30)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+30)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+30)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+30)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+30)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+30)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+30)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+30)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+30)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+30)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+30)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+30)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+30)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+30)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+30)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+30)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+30)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+30)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+30)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+30)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+30)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+30)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+30)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+30)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+30)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+30)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+30)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+30)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+30)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

assign ram_exchange_bus[(31+1)*`FFT_DATA_WIDTH-1:(31)*`FFT_DATA_WIDTH] = 
(((delayed_j+31)% `NO_OF_UNITS)==31)?ram31_port1_bus:(((delayed_j+31)% `NO_OF_UNITS)==30)?ram30_port1_bus:(((delayed_j+31)% `NO_OF_UNITS)==29)?ram29_port1_bus:
(((delayed_j+31)% `NO_OF_UNITS)==28)?ram28_port1_bus:(((delayed_j+31)% `NO_OF_UNITS)==27)?ram27_port1_bus:(((delayed_j+31)% `NO_OF_UNITS)==26)?ram26_port1_bus:
(((delayed_j+31)% `NO_OF_UNITS)==25)?ram25_port1_bus:(((delayed_j+31)% `NO_OF_UNITS)==24)?ram24_port1_bus:(((delayed_j+31)% `NO_OF_UNITS)==23)?ram23_port1_bus:
(((delayed_j+31)% `NO_OF_UNITS)==22)?ram22_port1_bus:(((delayed_j+31)% `NO_OF_UNITS)==21)?ram21_port1_bus:(((delayed_j+31)% `NO_OF_UNITS)==20)?ram20_port1_bus:
(((delayed_j+31)% `NO_OF_UNITS)==19)?ram19_port1_bus:(((delayed_j+31)% `NO_OF_UNITS)==18)?ram18_port1_bus:(((delayed_j+31)% `NO_OF_UNITS)==17)?ram17_port1_bus:
(((delayed_j+31)% `NO_OF_UNITS)==16)?ram16_port1_bus:(((delayed_j+31)% `NO_OF_UNITS)==15)?ram15_port1_bus:(((delayed_j+31)% `NO_OF_UNITS)==14)?ram14_port1_bus:
(((delayed_j+31)% `NO_OF_UNITS)==13)?ram13_port1_bus:(((delayed_j+31)% `NO_OF_UNITS)==12)?ram12_port1_bus:(((delayed_j+31)% `NO_OF_UNITS)==11)?ram11_port1_bus:
(((delayed_j+31)% `NO_OF_UNITS)==10)?ram10_port1_bus:(((delayed_j+31)% `NO_OF_UNITS)==09)?ram09_port1_bus:(((delayed_j+31)% `NO_OF_UNITS)==08)?ram08_port1_bus:
(((delayed_j+31)% `NO_OF_UNITS)==07)?ram07_port1_bus:(((delayed_j+31)% `NO_OF_UNITS)==06)?ram06_port1_bus:(((delayed_j+31)% `NO_OF_UNITS)==05)?ram05_port1_bus:
(((delayed_j+31)% `NO_OF_UNITS)==04)?ram04_port1_bus:(((delayed_j+31)% `NO_OF_UNITS)==03)?ram03_port1_bus:(((delayed_j+31)% `NO_OF_UNITS)==02)?ram02_port1_bus:
(((delayed_j+31)% `NO_OF_UNITS)==01)?ram01_port1_bus:(((delayed_j+31)% `NO_OF_UNITS)==00)?ram00_port1_bus:`FFT_DATA_WIDTH'bz;

