#include<stdio.h> //printf
#include<stdlib.h> // strings
//#include<math.h> //use log, pow etc

int getData(int N, int binLength, short int ** array);
void dec2bin(long decimal, char *binary, int binLength);


//---------------------------------------------------------------------
//Function: This reads data from a file in the present folder containing the input matrix
//---------------------------------------------------------------------
int getData(int N, int binLength, short int ** array)
{
//Variables
short int i=0;
short int j=0;
short int k=0;
char *s;
FILE *fp;

//Initializations
fp = fopen("ip_data_2_be_read.list","r");
s = (char *)(malloc((binLength+1)*sizeof(char)));

//Some Warnings.
printf("\nNote that the file 'ip_data_2_be_read.list' should have %d number of values for %d*%d complex FFT.\n",N*N*2,N,N);
printf("Entries should be like: \"#data_value# \\newline \"only. \n");

//Writing the signal values into an NXN 2D array.
for (i=0;i<N;i++)
{
	for (j=0;j<N;j++)
	{
		fscanf(fp,"%s",s);	//Binary put to some other use here.
		array[i][j] = atoi(s);
		for(k=0;k<=binLength;k++)
		{
			s[k] = 0;
		}
	}
}
//freeing the malloc call.
free(s);
//Closing the file pointers
fclose(fp);
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






int main(){

int N = 512; //512*512 eing processed using 64*64 cores
int binLength = 16; //16 bit computing routine. 
short int array[N][N];

//we assume 64*64 point FFT operation can be done as an atomic operation.




getData(N, binLength, array);

//getTwiddles();

return 0;
}
