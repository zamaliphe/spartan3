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
	tempValue = (float)(1*sin((double)c*i));
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
//vfile(romDataWidth,romAddWidth,N);

return;
}//close function

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





