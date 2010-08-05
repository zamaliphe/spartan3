#include<stdio.h> //printf
#include<stdlib.h> // strings
#include<math.h> //use log, pow etc

#define ERROR 0;



int getData(int M, int binLength, short int ** arrayReal1,short int ** arrayImag1, short int ** arrayReal2,short int ** arrayImag2, short int ** arrayReal3,short int ** arrayImag3, short int ** arrayReal4,short int ** arrayImag4);
void dec2bin(long decimal, char *binary, int binLength);
int printDataMatrix(int N, short int ** arrayReal, short int ** arrayImag);
int getTwiddles(int N, int binLength, short int * twiddlesReal, short int * twiddlesImag);
int fft1d(int n,int m,double * x,double * y, int operationIFFT,int div);
int fftarray(int M,short int ** arrayReal,short int ** arrayImag, int operationIFFT);
int oddEven (int N, short int ** arrayReal1, short int ** arrayImag1,short int ** arrayReal2, short int ** arrayImag2);

//---------------------------------------------------------------------
//Function: This reads data from a file in the present folder containing the input matrix
//---------------------------------------------------------------------
int getData(int M, int binLength, short int ** arrayReal1,short int ** arrayImag1, short int ** arrayReal2,short int ** arrayImag2, short int ** arrayReal3,short int ** arrayImag3, short int ** arrayReal4,short int ** arrayImag4)
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
//printf("\nNote that the file 'ip_data_2_be_read.list' should have %d number of values for %d*%d complex FFT.\n",N*N*2,N,N);
//printf("Entries should be like: \"#data_value# \\newline \"only. \n");

//Writing the signal values into an NXN 2D array.
for (i=0;i<M;i++)
{
	for (j=0;j<M;j++)
	{
		fscanf(fp,"%s",s);	//Binary put to some other use here.
		arrayReal1[i][j] = atoi(s);
		for(k=0;k<=binLength;k++)
		{
			s[k] = 0;
		}
		fscanf(fp,"%s",s);	//Binary put to some other use here.
		arrayImag1[i][j] = atoi(s);
		for(k=0;k<=binLength;k++)
		{
			s[k] = 0;
		}
	}
	for (j=0;j<M;j++)
	{
		fscanf(fp,"%s",s);	//Binary put to some other use here.
		arrayReal2[i][j] = atoi(s);
		for(k=0;k<=binLength;k++)
		{
			s[k] = 0;
		}
		fscanf(fp,"%s",s);	//Binary put to some other use here.
		arrayImag2[i][j] = atoi(s);
		for(k=0;k<=binLength;k++)
		{
			s[k] = 0;
		}
	}	
}
//Filling 3 and 4
for (i=0;i<M;i++)
{
	for (j=0;j<M;j++)
	{
		fscanf(fp,"%s",s);	//Binary put to some other use here.
		arrayReal3[i][j] = atoi(s);
		for(k=0;k<=binLength;k++)
		{
			s[k] = 0;
		}
		fscanf(fp,"%s",s);	//Binary put to some other use here.
		arrayImag3[i][j] = atoi(s);
		for(k=0;k<=binLength;k++)
		{
			s[k] = 0;
		}
	}
	for (j=0;j<M;j++)
	{
		fscanf(fp,"%s",s);	//Binary put to some other use here.
		arrayReal4[i][j] = atoi(s);
		for(k=0;k<=binLength;k++)
		{
			s[k] = 0;
		}
		fscanf(fp,"%s",s);	//Binary put to some other use here.
		arrayImag4[i][j] = atoi(s);
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
return 1;
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


//---------------------------------------------------------------------
//Function: This writes the given matrix data to a file in the present folder
//---------------------------------------------------------------------
int printDataMatrix(int M, short int ** arrayReal, short int ** arrayImag)
{
	int i = 0;
	int j = 0;
	for(i=0;i<M;i++)
	{
		for (j=0;j<M;j++)
		{
			printf("%d\n",arrayReal[i][j]);
			printf("%d\n",arrayImag[i][j]);
		}
	}
	return 1;
}//close functon printDataArray


//---------------------------------------------------------------------
//Function: This generates the twiddles for fft and ifft
//---------------------------------------------------------------------
int getTwiddles(int N,int binLength, short int * twiddlesReal, short int * twiddlesImag)
{
	int precisionN = pow(2,binLength-1);
	int i = 0;
	float c = 0.0;
	float tempValue = 0.0;
	//Calculating and writing the twiddle values
	c = 2*3.1416/N; 
	for (i=0;i<N/2;i++)
	{
		tempValue = (float)cos((double)c*i);
		tempValue = (tempValue > ((precisionN-1)*1.0)/precisionN)?((precisionN-1)*1.0)/precisionN:tempValue;
		twiddlesReal[i] = (int)(tempValue*precisionN);
		twiddlesReal[i+N/2] = twiddlesReal[2*i];
		
		tempValue = (float)(-1*sin((double)c*i));
		tempValue = (tempValue > ((precisionN-1)*1.0)/precisionN)?((precisionN-1)*1.0)/precisionN:tempValue;
		twiddlesImag[i] = (int)(tempValue*precisionN);
		tempValue = (float)(1*sin((double)c*i));
		tempValue = (tempValue > ((precisionN-1)*1.0)/precisionN)?((precisionN-1)*1.0)/precisionN:tempValue;
		twiddlesImag[i+N/2] = (int)(tempValue*precisionN);
	}

return 1;

}// close function getTwiddles


//---------------------------------------------------------------------
//Function: This is the 1D FFT Function
//---------------------------------------------------------------------

int fft1d(int n,int m,double * x,double * y, int operationIFFT, int div)
{
	int i,j,k,n1,n2;
	double c,s,e,a,t1,t2;
	j = 0; /* bit-reverse */
	n2 = n/2;
	for (i = 1; i < n - 1; i++)
	{
		n1 = n2;
		while ( j >= n1 )
		{
			j = j - n1;
			n1 = n1/2;
		}
		j = j + n1;
		if (i < j)
		{
			t1   = x[i];
			x[i] = x[j];
			x[j] =   t1;
			t1   = y[i];
			y[i] = y[j];
			y[j] =   t1;
		}
	}
	n1 = 0; /* FFT */
	n2 = 1;
	for (i=0; i < m; i++)
	{
		n1 = n2;
		n2 = n2 + n2;
		e = -6.283185307179586/n2;
		a = 0.0;
		for (j=0; j < n1; j++)
		{
			c = cos(a);
			s = (operationIFFT==1)?-sin(a):sin(a);
			a = a + e;
			for (k=j; k < n; k=k+n2)
			{
				t1 = c*x[k+n1] - s*y[k+n1];
				t2 = s*x[k+n1] + c*y[k+n1];
				x[k+n1] = (x[k] - t1)/div;
				y[k+n1] = (y[k] - t2)/div;
				x[k] = (x[k] + t1)/div;
				y[k] = (y[k] + t2)/div;
			}
		}
	}
	return 1;
}


//---------------------------------------------------------------------
//Function: This is the FFTARRAY Function
//---------------------------------------------------------------------

int fftarray(int M,short int ** arrayReal,short int ** arrayImag, int operationIFFT)
{
	int div = 2;
	int i = 0;
	int j = 0;
	double tempReal[M], tempImag[M];
	/*
	tempReal = (double *)malloc(M*sizeof(double));
	tempImag = (double *)malloc(M*sizeof(double));
	*/
	for (i = 0; i< M; i++)
	{
		for (j = 0; j< M; j++)
		{	
			tempReal[j] = (double)arrayReal[i][j];
			tempImag[j] = (double)arrayImag[i][j];
		}
		fft1d(M,(int)(log10(M)/log10(2)),tempReal,tempImag, operationIFFT, div);
		for (j = 0; j< M; j++)
		{	
			arrayReal[i][j] = (short int)(tempReal[j]);
			arrayImag[i][j] = (short int)(tempImag[j]);
		}
	}
	
	//free(tempReal);
	//free(tempImag);

return 1;

}// close fftarray32


//---------------------------------------------------------------------
//Function: This is the oddEven function: splits data into odd and even points
//---------------------------------------------------------------------
int oddEven (int N, short int ** arrayReal1, short int ** arrayImag1,short int ** arrayReal2, short int ** arrayImag2)
{
	short int tempReal [N/2][N];
	short int tempImag [N/2][N];
	int i = 0;
	int j = 0;
	for(i=0;i<N/2;i++){
		for(j=0;j<N;j++){
			if(j<N/2){
				tempReal[i][j] = arrayReal1[i][j];
				tempImag[i][j] = arrayImag1[i][j];
			}
			else {
				tempReal[i][j] = arrayReal2[i][j-N/2];
				tempImag[i][j] = arrayImag2[i][j-N/2];
			}
			
		}
	}
	
	for(i=0;i<N/2;i++)
	{
		for(j=0;j<N/2;j++)
		{
			arrayReal1[i][j] = tempReal[i][2*j];
			arrayReal2[i][j] = tempReal[i][2*j+1];
			arrayImag1[i][j] = tempImag[i][2*j];
			arrayImag2[i][j] = tempImag[i][2*j+1];
		}
	}
	
return 1;
}// close function oddEven

//---------------------------------------------------------------------
//Function: This is the MAIN Function
//---------------------------------------------------------------------
int main()
{
	int operationIFFT = 1;
	int i = 0;
	int j = 0;
	int N = 64; 		//64*64 being processed using 32*32 array
	int M = N/2;
	int binLength = 16; 	//16 bit computing routine. 
	short int **arrayReal1;	//array to store the values
	short int **arrayReal2;	//array to store the values
	short int **arrayReal3;	//array to store the values
	short int **arrayReal4;	//array to store the values
	short int **arrayImag1;	//array to store the values
	short int **arrayImag2;	//array to store the values
	short int **arrayImag3;	//array to store the values
	short int **arrayImag4;	//array to store the values
	short int *twiddlesReal;//array to store twiddle factors
	short int *twiddlesImag;//array to store twiddle factors
	
	arrayReal1 = (short int **)malloc(M*sizeof(short int *));
	arrayImag1 = (short int **)malloc(M*sizeof(short int *));
	arrayReal2 = (short int **)malloc(M*sizeof(short int *));
	arrayImag2 = (short int **)malloc(M*sizeof(short int *));
	arrayReal3 = (short int **)malloc(M*sizeof(short int *));
	arrayImag3 = (short int **)malloc(M*sizeof(short int *));
	arrayReal4 = (short int **)malloc(M*sizeof(short int *));
	arrayImag4 = (short int **)malloc(M*sizeof(short int *));
	for (i=0;i<M;i++)
	{
		arrayReal1[i] = (short int *)malloc(M*sizeof(short int));
		arrayImag1[i] = (short int *)malloc(M*sizeof(short int));
		arrayReal2[i] = (short int *)malloc(M*sizeof(short int));
		arrayImag2[i] = (short int *)malloc(M*sizeof(short int));
		arrayReal3[i] = (short int *)malloc(M*sizeof(short int));
		arrayImag3[i] = (short int *)malloc(M*sizeof(short int));
		arrayReal4[i] = (short int *)malloc(M*sizeof(short int));
		arrayImag4[i] = (short int *)malloc(M*sizeof(short int));
	}
	twiddlesReal = (short int *)malloc(N*sizeof(short int)); //Will have both fft and ifft twiddles back to back.
	twiddlesImag = (short int *)malloc(N*sizeof(short int));	

//we assume 32 1D FFTs can be done as an atomic operation.

	getData(M,binLength,arrayReal1,arrayImag1,arrayReal2,arrayImag2,arrayReal3,arrayImag3,arrayReal4,arrayImag4);
/*	
	printDataMatrix(M,arrayReal1, arrayImag1);
	printDataMatrix(M,arrayReal2, arrayImag2);
	printDataMatrix(M,arrayReal3, arrayImag3);
	printDataMatrix(M,arrayReal4, arrayImag4);
	
*/	
	getTwiddles(N,binLength,twiddlesReal, twiddlesImag);

//Doing the 2DFFT 64*64 point in stages.

//Stage 1
	
	oddEven (N,arrayReal1,arrayImag1, arrayReal2, arrayImag2);
	oddEven (N,arrayReal3,arrayImag3, arrayReal4, arrayImag4);

	printDataMatrix(M,arrayReal1, arrayImag1);
	printDataMatrix(M,arrayReal2, arrayImag2);
	printDataMatrix(M,arrayReal3, arrayImag3);
	printDataMatrix(M,arrayReal4, arrayImag4);

	
	fftarray(32,arrayReal1,arrayImag1,operationIFFT);
	fftarray(32,arrayReal2,arrayImag2,operationIFFT);			
	fftarray(32,arrayReal3,arrayImag3,operationIFFT);
	fftarray(32,arrayReal4,arrayImag4,operationIFFT);
	

/*
	
	for(i=0;i<M;i++){
    		for (j=0;j<M;j++){
        		arrayReal1[i][j] = arrayReal1[i][j] + (twiddlesReal[i+operationIFFT*N/2]*arrayReal2[i][j] - twiddlesImag[i+operationIFFT*N/2]*arrayImag2[i][j]);
        		
        		arrayReal2[i][j] = arrayReal1[i][j] - (twiddlesReal[i+operationIFFT*N/2]*arrayReal2[i][j] - twiddlesImag[i+operationIFFT*N/2]*arrayImag2[i][j]);
        		
			arrayImag1[i][j] = arrayImag1[i][j] + (twiddlesImag[i+operationIFFT*N/2]*arrayReal2[i][j] + twiddlesReal[i+operationIFFT*N/2]*arrayImag2[i][j]);
			
			arrayImag2[i][j] = arrayImag1[i][j] + (twiddlesImag[i+operationIFFT*N/2]*arrayReal2[i][j] + twiddlesReal[i+operationIFFT*N/2]*arrayImag2[i][j]);
			
			arrayReal3[i][j] = arrayReal3[i][j] + (twiddlesReal[i+operationIFFT*N/2]*arrayReal4[i][j] - twiddlesImag[i+operationIFFT*N/2]*arrayImag4[i][j]);
        		
        		arrayReal4[i][j] = arrayReal3[i][j] - (twiddlesReal[i+operationIFFT*N/2]*arrayReal4[i][j] - twiddlesImag[i+operationIFFT*N/2]*arrayImag4[i][j]);
        		
			arrayImag3[i][j] = arrayImag3[i][j] + (twiddlesImag[i+operationIFFT*N/2]*arrayReal4[i][j] + twiddlesReal[i+operationIFFT*N/2]*arrayImag4[i][j]);
			
			arrayImag4[i][j] = arrayImag3[i][j] + (twiddlesImag[i+operationIFFT*N/2]*arrayReal4[i][j] + twiddlesReal[i+operationIFFT*N/2]*arrayImag4[i][j]);
	   	}
	}
*/	
//Stage 2	

	printDataMatrix(M,arrayReal1, arrayImag1);
	printDataMatrix(M,arrayReal2, arrayImag2);
	printDataMatrix(M,arrayReal3, arrayImag3);
	printDataMatrix(M,arrayReal4, arrayImag4);


free(twiddlesReal);
free(twiddlesImag);
free(arrayReal1);
free(arrayImag1);
free(arrayReal2);
free(arrayImag2);
free(arrayReal3);
free(arrayImag3);
free(arrayReal4);
free(arrayImag4);


return 0;
}
