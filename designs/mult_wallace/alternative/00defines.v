/*
Caution : Some defines are not specific to the concerned module only
*/


//AGU et al. Related			//Bitreversing is Hardcoded
`define NO_OF_POINTS      	64	//N point fft	//shared with controller	
`define NO_OF_POINTS_BY2  	32	//N point fft	
`define NO_BITS_LOG_N     	 3	//bits rqed. to represent logN stages (start from 0)
`define NO_OF_STAGES      	 6	//total number of stages 0,1,2,3 for STGMAX=4, 16ptFFT
`define NBY2_ADD_WIDTH    	 5	//for referencing N/2 base addresses 
`define AGU_AB_ADD_WIDTH  	 6	//corresponds to the AGU core's output: shoul be equal to logN
`define AGU_W_ADD_WIDTH   	 5	//corresponds to the WSEQ core's output: should be equal to log(N/2) 
`define AGU_ADD_APPEND    	 1	//RAM_ADD_WIDTH -NO_OF_STAGES -1  (check that NO_OF_STAGES==AGU_AB_ADD_WIDTH) 
`define AGU_WADD_APPEND   	 2	//RAM_ADD_WIDTH -AGU_W_ADD_WIDTH -1 


`define AGU_MODE_WIDTH    	 2	//unc
`define AGU_MODE_OP_RAM   	 0	//unc
`define AGU_MODE_ROM_RAM  	 1	//unc
`define AGU_MODE_BF_RAM   	 2	//unc
`define AGU_MODE_RAM_OP   	 3	//unc

//Butterfly et al. Related 		//Wallace tree is hardcoded: This cannot be changed
`define BF_MULT_BITS      	16	//unc
`define BF_COUNTERBITS    	 4	//unc


//Controller Related			//Some features are still hardcoded
`define BF_STAGE_COUNT           6
`define BF_STAGE_WIDTH           3	//bits to represent 'logN'	
`define BF_OPS_PER_STAGE       255	//8*N/2 - 1, 8 since 8 cycles for 1 OPS		
`define CONTROLLER_STATE_WIDTH   2	//unc
`define CONTROLLER_COUNTER_SIZE  8 	//(2+logN)  

//FFT1d_complete Related
`define FFT_DATA_WIDTH          16	//unc
`define FFT_ADD_WIDTH            8	//Same as ram add width: store N*2 values(re,img): Assume inplace rep:2*64 + 2*32
`define FFT_AGU_MODE_WIDTH       2	//unc

//IO Related
`define IO_DATA_WIDTH  		16	//unc//input output data width

//RAM related
`define RAM_DATA_WIDTH 		16	//unc//The precision of the contents of the RAM (8,8)=(re,img)
`define RAM_ADD_WIDTH  		 8 	//The size of the RAM is determined here: RAMDEPTH = 1 << RAM_ADD_WIDTH


//ROM Related
`define ROM_DATA_WIDTH 		16	//unc//Says about the precision of re and im parts of twiddle
`define ROM_ADD_WIDTH  		 6	//Says about the number of twiddles:eg 8 means (2^8=)256 (sum of real and img): hence 128 twiddles
