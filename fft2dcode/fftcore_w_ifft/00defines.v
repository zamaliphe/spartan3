/*
Caution : Some defines are not specific to the concerned module only
*/


`define NO_OF_POINTS            64	//N point fft	//shared with controller	
`define NO_OF_POINTS_BY2        32	//N point fft	
`define NO_BITS_LOG_N       	 3	//bits rqed. to represent logN stages (start from 0)
`define LOG_N		       	 6	//Log2(N)
`define LOG_NBY2	     	 5	//for referencing N/2 base addresses 
`define AGU_AB_ADD_WIDTH         6	//abSequencer's output: should be equal to log2(N)
`define AGU_W_ADD_WIDTH          5	//wSequencer's  output: should be equal to log2(N/2) 
`define AGU_ADD_APPEND           1	//RAM_ADD_WIDTH -AGU_AB_ADD_WIDTH -1
`define AGU_WADD_APPEND          1	//RAM_ADD_WIDTH -AGU_W_ADD_WIDTH -1 


`define AGU_MODE_WIDTH           2	//unc
`define AGU_MODE_OP_RAM      2'b00	//unc
`define AGU_MODE_ROM_RAM     2'b01	//unc
`define AGU_MODE_BF_RAM      2'b10	//unc
`define AGU_MODE_RAM_OP      2'b11	//unc

//`define BF_MULT_MBITS           12	//unc Commented 1st March 08
//`define BF_MULT_NBITS            8	//unc Commented 1st March 08
`define BF_MULT_BITS            16	//unc Added 1st March 08
`define BF_COUNTERBITS           4	//unc
//`define BF_REDUCEBITS            4	//unc Commented 1st March 08
//`define BF_RESULTBITS            8	//unc Commented 1st March 08
//`define BF_HALF_MARK_RESULT    128	//unc Commented 1st March 08


`define BF_STAGE_COUNT           6	//to be equal to logN
`define BF_STAGE_WIDTH           3	//bits to represent 'logN'	

`define FFT_DATA_WIDTH          16	//unc Modified on 1st March 08
`define FFT_AGU_ADD_WIDTH        8	//Redundant. ==LOG_N + 2

`define RAM_DATA_WIDTH          16	//unc//The precision of the contents of the RAM (8,8)=(re,img) 1Mar08
`define RAM_ADD_WIDTH            8 	//logN +1 + 1 (1 for re,im and 1 extra to accomodate twiddles)

`define ROM_DATA_WIDTH 		16	//Necessary for ROM.v to function. ==FFT_DATA_WIDTH 1st March 08
`define ROM_ADD_WIDTH  		 6	//Says about the number of twiddles:eg 8 means (2^8=)256 (sum of real and img): hence 128 twiddles

`define FIFO_ADD_WIDTH 		12	//4K lines

`define FFT2D_C_RAM_ADD_BITS     1	//log2(rows per ram block)
`define MAX_ELEMENTS          8192	//256*256*2
`define LOG_MAX_ELEMENTS        13	//log2(256*256*2)
`define MAX_RAM_ROWS	         2
`define LOG_M_R_R 		 1	//log2(MAX_RAM_ROWS) //Same as FFT2D_C_RAM_ADD_BITS : 20081011
`define SEQUENCE_MODE_LENGTH     4
`define NO_OF_UNITS		32
`define LOG_NO_OF_UNITS		 5
`define RAM_COMMAND_WIDTH 	 3
