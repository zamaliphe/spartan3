#include<stdio.h>
#include<stdlib.h>
#include<math.h>
//Function declarations
void twiddle(void);

int main()
{
  twiddle();
  return 0;
}// main function close

void twiddle()
{

//Variables
int i=0;
int j=0;
int romDataWidth=8;
int romAddWidth=8;
int binLength = 8;
int precisionN = 128; 
int N = 256;
FILE *fout;
float tempValue = 0.0;
float c = 2*3.1416/256;

//Initializations
fout = fopen("twiddles.ifft","w");
printf("Enter the number of binary digits you want to represent(eg. 8, 16 etc):");
scanf("%d",&binLength);
printf("The entered number was: %d\n",binLength);
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
	tempValue = (float)cos((double)c*i);
	tempValue = (tempValue > ((precisionN-1)*1.0)/precisionN)?((precisionN-1)*1.0)/precisionN:tempValue;
	fprintf(fout,"%x\n",(int)(tempValue*precisionN));
	tempValue = (float)(1*sin((double)c*i));
	tempValue = (tempValue > ((precisionN-1)*1.0)/precisionN)?((precisionN-1)*1.0)/precisionN:tempValue;
	fprintf(fout,"%x\n",(int)(tempValue*precisionN));
}
//Closing the file pointers
fclose(fout);
return;
}//close function




