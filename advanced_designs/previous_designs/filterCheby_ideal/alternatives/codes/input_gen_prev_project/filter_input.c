/*
This Program generates the input to be fed to the filter
*/

#include<stdio.h>
#include<stdlib.h>
#include<math.h>

//Function declarations
void genInput(void);
void dec2bin(long decimal, char *binary, int binLength);

//---------------------------------------------------------------------
//Function: Main
//---------------------------------------------------------------------
int main()
{
  genInput();
  return 0;
}// main function close


//---------------------------------------------------------------------
//---------------------------------------------------------------------
void genInput()
{

//Variables
int i=0;
int j=0;
int k=0;
char *binary;
int binLength = 16;
int precisionN = 32768; //(number can vary from -128 to 127)
int N = 4096; 
FILE *fp1,*fp2;
float tempValue = 0.0;
float totalMag = 0.0;
float c = 3.1416;
float mag[20], freq[20]; 
//Initializations
fp1 = fopen("ip_data.list","w");
fp2 = fopen("ip_data_readable.list","w");

//printf("Enter the number of binary digits you want to represent(eg. 8, 16 etc):");
//scanf("%d",&binLength);
printf("The entered number was: %d\n",binLength);
binary = (char *)(malloc((binLength+1)*sizeof(char)));
precisionN = pow(2,binLength-1);
//printf("\nEnter the number of points(N):");
//scanf("%d",&N);
printf("The entered number was: %d\n",N);

printf("Now enter the components of the input signal :\n");
k = 0 ;
do
{
	printf("Enter the magnitude(between[0,1]) and frequency(between[0,1]pi) with a space in between. Or -1 to terminate:");
	scanf("%f",&(mag[k]));
	if(mag[k]==-1)
	{
		break;
	}
	scanf("%f",&(freq[k]));
	totalMag = totalMag + mag[k];
	k++;
}
while(1);
//printf("the total magnitude was : %f\n",totalMag);
//Calculating and writing the signal values
for (i=0;i<N;i++)
{
	tempValue = 0;
	for(j=0;j<k;j++)
	{
		tempValue = tempValue + mag[j]*((float)cos((double)freq[j]*c*i));
	}
	if(totalMag > 1){
		tempValue = tempValue/totalMag;
	}
	tempValue = (tempValue > ((precisionN-1)*1.0)/precisionN)?((precisionN-1)*1.0)/precisionN:tempValue;
	dec2bin((int)(tempValue*precisionN), binary,binLength);
	fprintf(fp1,"%s\n",binary);
	fprintf(fp2,"%4d\n",(int)(tempValue*precisionN));
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





