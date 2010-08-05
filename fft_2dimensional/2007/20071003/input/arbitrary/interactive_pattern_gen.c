//Theja 2nd October

//Theja 29th Sept: Generates input patterns
//28th Sept.. ther is round off problem... :( (at two places) 

#include<stdio.h>
#include<math.h>
#define N 256
typedef struct comp {
float r;
float i;
} complex, *pComplex;


//
// accepts a decimal integer and returns a binary coded string
//
void dec2bin(long decimal, char *binary)
{

  int  k = 0, n = 0;
  int  neg_flag = 0;
  int  remain;
  int  first_one_encountered =0;
  int  old_decimal;  // for test
  char temp[9];

  // take care of negative input
  if (decimal < 0)
  {      
  	decimal = -decimal;
  	neg_flag = 1;
  }
  	
  do 
  {
	old_decimal = decimal;   // for test
	remain    = decimal % 2;
	// whittle down the decimal number
	decimal   = decimal / 2;
	// this is a test to show the action
	//printf("%d/2 = %d  remainder = %d\n", old_decimal, decimal, remain);
	// converts digit 0 or 1 to character '0' or '1'
	temp[k++] = remain + '0';
  } while (decimal > 0);
  
  //printf("value of k = %d\n",k);
  //if(k>7) printf("k exceeded 7!\n");
  //printf("%s\n",temp);

  for(;k<=7;k++)
  {
	temp[k] = '0';
  }

  // reverse the spelling
  while (k >= 0)
  {
  	binary[n++] = temp[--k];
  }

  binary[n-1] = 0;         // end with NULL


  //conversion to 2's complement notation based on sign
  //n=n-2;
  //printf("value of n = %d\n",n);
  if(neg_flag)
  {
	for(k = 7 ;k >= 0; k--)
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

int main()
{


//VARIABLES
FILE *fp1,*fp2;
int i=0,j=0;
float c=3.1416;
int freq_comp;
float k[10],coeff[10];
complex a;
complex arr[N];
char binary[9];


//INITIALIATION
fp1 = fopen("ip_data_readable.list","w");
fp2 = fopen("ip_data.list","w");


printf("Enter the number of freq components(<10):");
scanf("%d",&freq_comp);
for(i=0;i<freq_comp;i++)
{
	printf("Enter the coeff(between[0,1]) and k value(between[0,1]) for component %d:",i+1);
	scanf("%f",&(coeff[i]));
	scanf("%f",&(k[i]));
}
//CALCULATION OF THE VALUES
for(i=0;i<N;i++)
{
	//print values in decimal in file
	arr[i].r = 0;
	for(j=0;j<freq_comp;j++)
	{
		arr[i].r = arr[i].r + coeff[j]*(float)cos((double)c*i*k[j]);
	}
	arr[i].r = (arr[i].r)/(freq_comp);

	//hack1
	if(arr[i].r > 0.9921875) arr[i].r = 0.9921875; 	//-128/128 to 127/128

	fprintf(fp1,"%d\n",(int)(arr[i].r*pow(2,7)));
	
	for(j=0;j<9;j++) binary[j] = 0;			//reinitialization
	dec2bin((int)(arr[i].r*pow(2,7)), binary);	//hard coded to get 8 bit form
	fprintf(fp2,"%s\n",binary);
	
	arr[i].i = 0;
	for(j=0;j<freq_comp;j++)
	{
		arr[i].i = arr[i].i + coeff[j]*(float)sin((double)c*i*k[j]);
	}
	arr[i].i = (arr[i].i)/(freq_comp);	
	
	//hack2
	if(arr[i].i > 0.9921875) arr[i].i = 0.9921875;
	
	fprintf(fp1,"%d\n",(int)(arr[i].i*pow(2,7)));
	
	for(j=0;j<9;j++) binary[j] = 0;			//reinitialization
	dec2bin((int)(arr[i].i*pow(2,7)), binary);	//hard coded to get 8 bit form
	fprintf(fp2,"%s\n",binary);
	
	printf("(arr[%d].r,arr[%d].i) = (%3.3f,%3.3f)\n",i,i,arr[i].r,arr[i].i);
}


/*
//testing dec2bin 
	char binary[9];
	int i = 127;
	int j = 0;
	for(;i>=-128;i--)
	{
		dec2bin(i,binary);
		printf("binary rep of %d is %s\n",i,binary);
		for(j=0;j<9;j++) binary[j] = 0;	//reinitialization
	}
//testing dec2bin over
*/
return 0;
}
