/*
29th Dec: Problems while converting ) into binary. Will give a warning/error
This Program generates the contents of the ROM.
It doesn't generate the v file. 
But it generates the files needed by the v-file generator.
It generates sine only, cosine only and twiddle factors as desired
*/

#include<stdio.h>
#include<stdlib.h>
#include<math.h>

//Function declarations
void twiddle(void);
void vfile(int romDataWidth, int romAddWidth, int N);
void dec2bin(long decimal, char *binary, int binLength);


//---------------------------------------------------------------------
//Function: Main
//---------------------------------------------------------------------
int main()
{
  twiddle();
  return 0;
}// main function close

//---------------------------------------------------------------------
//Function: Twiddle factor generator of arbitrary length
//---------------------------------------------------------------------
void twiddle()
{

//Variables
int i=0;
int j=0;
int romDataWidth=8;
int romAddWidth=8;
char *binary;
int binLength = 8;
int precisionN = 128; 
int N = 256;
FILE *fp1,*fp2;
float tempValue = 0.0;
float c = 2*3.1416/256;

//Initializations
fp1 = fopen("rom_memory_readable.list","w");
fp2 = fopen("rom_memory.list","w");
printf("Enter the number of binary digits you want to represent(eg. 8, 16 etc):");
scanf("%d",&binLength);
printf("The entered number was: %d\n",binLength);
binary = (char *)(malloc((binLength+1)*sizeof(char)));
precisionN = pow(2,binLength-1);
printf("\nEnter the number of points(N) of the FFT (for which twiddles of N/2 will be generated):");
scanf("%d",&N);
printf("The entered number was: %d\n",N);

//Calculating Log2(N)
romAddWidth = (int)(log10(N)/log10(2)); //256 values:128 twiddles (real and imag)
romDataWidth = binLength;
printf("INFORMATION: Computed Address width: %d and Data width: %d\n",romAddWidth,romDataWidth);

//Calculating and writing the twiddle values
c = 2*3.1416/N; 
for (i=0;i<N/2;i++)
{
	fprintf(fp1,"W(%d) = cos(2*pi*%d/%d) - j*sin(2*pi*%d/%d) = ( ",i,i,N,i,N);
	tempValue = (float)cos((double)c*i);
	tempValue = (tempValue > ((precisionN-1)*1.0)/precisionN)?((precisionN-1)*1.0)/precisionN:tempValue;
	fprintf(fp1,"%4d , ",(int)(tempValue*precisionN));
	dec2bin((int)(tempValue*precisionN), binary,binLength);
	fprintf(fp2,"%s\n",binary);
	for(j=0;j<=binLength;j++)
	{
		binary[j] = 0;
	}
	tempValue = (float)(-1*sin((double)c*i));
	tempValue = (tempValue > ((precisionN-1)*1.0)/precisionN)?((precisionN-1)*1.0)/precisionN:tempValue;
	fprintf(fp1,"%4d )\n ",(int)(tempValue*precisionN));
	dec2bin((int)(tempValue*precisionN), binary,binLength);
	fprintf(fp2,"%s\n",binary);
	for(j=0;j<=binLength;j++)
	{
		binary[j] = 0;
	}
}


//Freeing up memory
free(binary);

//Closing the file pointers
fclose(fp1);
fclose(fp2);

//Write a Vfile called ROM.v
vfile(romDataWidth,romAddWidth,N);

return;
}//close function

//---------------------------------------------------------------------
//Function: Generates a verilog file named ROM.v taking rom_memory.list as the input
//---------------------------------------------------------------------
void vfile(int romDataWidth,int romAddWidth, int N)
{

//Variables
int i;
char temp1[romDataWidth+1],temp2[romAddWidth+1];
FILE *fp1,*fp2;

//Instantiation
fp1 = fopen("ROM.v","w");
fp2 = fopen("rom_memory.list","r");

//Warning to the user
printf("WARNING: ROM: Data and address widths are defined in #defines. But the program computes them too. So check for disparity!\n");

//Writing the vfile
fprintf(fp1,"
/*Defines have been used to specify address and data widths. use 00defines.v with this.
Twiddle factors of size DATA_WIDTH are stored in ADD_WIDTH locations.
This is a hardcoded file since this is specific to N=%d
The ROM_Generator Program might help. Infact, check whether the addwidths and datawidths are matching with the defines and the program!
*/
module ROM (
i_rom_address , // Address input(input)
o_rom_data    , // Data output  (output)
c_rom_read_en , // Read Enable  (control)
c_rom_ce      , // Chip Enable  (control)
c_rom_tri_output//tristate cotrol
);

input [`ROM_ADD_WIDTH - 1:0] i_rom_address;
input c_rom_read_en; 
input c_rom_ce;
input c_rom_tri_output;
output [`ROM_DATA_WIDTH - 1:0] o_rom_data;

wire [`ROM_ADD_WIDTH - 1:0] i_rom_address;
wire c_rom_read_en;
wire c_rom_ce;
wire c_rom_tri_output;
wire [`ROM_DATA_WIDTH -1:0] o_rom_data; //CAUTION: Output wired!!

reg [`ROM_DATA_WIDTH -1:0] rom_mem_reg;

assign o_rom_data = (~c_rom_tri_output) ? rom_mem_reg : `ROM_DATA_WIDTH'bz;

always @ (c_rom_read_en or i_rom_address or c_rom_ce)
begin
	if(~c_rom_ce)
		rom_mem_reg <= `ROM_DATA_WIDTH'bz;
	else case(i_rom_address)
",N);

for(i=0;i<N;i++)
{
	fscanf(fp2,"%s",&temp1);
	dec2bin(i,temp2,romAddWidth);
	fprintf(fp1,"		`ROM_ADD_WIDTH'b%s:\trom_mem_reg <= `ROM_DATA_WIDTH'b%s;\n",temp2,temp1);	
}

fprintf(fp1,"
	endcase
end

endmodule

");
	

return;
}//function close





//---------------------------------------------------------------------
//Function: Accepts a decimal integer and returns a binary coded string
//---------------------------------------------------------------------
void dec2bin(long decimal, char *binary, int binLength)
{
  int  k = 0, n = 0;
  int  neg_flag = 0;
  int  remain;
  int  first_one_encountered =0;
  char temp[binLength+1];

  //STEP1: take care of negative input
  if (decimal < 0)
  {      
  	decimal = -decimal;
  	neg_flag = 1;
  }
  
  //STEP2: Generate a spelling	
  do 
  {
	remain    = decimal % 2;
	// whittle down the decimal number
	decimal   = decimal / 2;
	// converts digit 0 or 1 to character '0' or '1'
	temp[k++] = remain + '0';
  } while (decimal > 0);
  
  for(;k<=binLength-1;k++)
  {
	temp[k] = '0';
  }


  //STEP3: Reverse the spelling
  while (k >= 0)
  {
  	binary[n++] = temp[--k];
  }

  binary[n-1] = 0;// end with NULL


  //STEP4: Convert to 2's complement notation based on sign
  if(neg_flag)
  {
	for(k = binLength-1 ;k >= 0; k--)
	{
		if(first_one_encountered == 0)
		{ 
			if(binary[k] == '1')
				first_one_encountered = 1;
		}
		else
		{
			if(binary[k] == '1') binary[k] = '0';
			else binary[k] = '1';
		}
	}
  }
}//close function





