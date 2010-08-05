#include<stdio.h>
#include<math.h>
#include <stdlib.h>

printDoubleArr(double * a,double * b, int n)
{
	int i = 0;
	//printf("--------------------------------------\n");
	for(i=0;i<n;i++)
	{
		//printf("Xr[%d],Xi[%d] = (%4.2f,%4.2f)\n",i,i,a[i],b[i]);
		printf("%4d) %6.2f %6.2f\n",i/2,a[i],b[i]);
	}
	//printf("--------------------------------------\n");
	return;
}


fft(int n,int m,double * x,double * y)
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
		//printf("j = %5d, and offsetted j = %5d\n",j,j+256);
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
	for (i=0; i < m; i++)			//for each stage fro 0 to 7
	//for (i=0; i < 2; i++)			//for each stage fro 0 to 7
	{
		n1 = n2;			//the difference between the array elements  is increasing as a factor of 2
		n2 = 2*n2;			
		e = -6.283185307179586/n2;
		a = 0.0;
		for (j=0; j < n1; j++)
		{
			c = cos(a);
			s = sin(a);
			a = a + e;
			for (k=j; k < n; k=k+n2)	//increment K by n2 units till you reach 256..starting from j.
			{
				t1 = c*x[k+n1] - s*y[k+n1];	//complex mult. Pr..check the index..its K+n1
				t2 = s*x[k+n1] + c*y[k+n1];	//		Pi
				//----------------------------------------------------------------------------
				/*
				if(i<2)
				{
					printf("br(x[%3d])= %6.0f, wr=  %6.0f, bi= %6.0f, wi= %6.0f, ar(x[%3d])= %6.0f, ai= %6.0f\n",k+n1,x[k+n1],c,y[k+n1],s,k,x[k],y[k]);
				}
				*/
				//----------------------------------------------------------------------------
				x[k+n1] = (x[k] - t1)/2;		//inplace... k+n1 is updated with A-BW
				y[k+n1] = (y[k] - t2)/2;
				x[k] = (x[k] + t1)/2;		//inplace k is updated with A+BW
				y[k] = (y[k] + t2)/2;
				//--------Explanation-------------
				//br = x[k+n1]; 	bi = y[k+n1];
				//wr = cos(a);		wi = sin(a);
				//ar = x[k];		ai = y[k];
				//--------Explanation Ends--------
				//printf("br= %6.2f, wr=  %6.2f, bi= %6.2f, wi= %6.2f, ar= %6.2f, ai= %6.2f\n",);
			}
		}
		//printDoubleArr(x,y,256);
	}
	return;
}



int main()
{

	double arrx[256], arry[256];
	int i=0;
	char tempo[5];
	
	//printf("hi: this is a c program which does FFT\n");
	
	//filling up the arrays
	for (i=0;i<256;i++)
	{
		//---------------------------
		//arrx[i] = cos((3.1416/2)*i);
		//arry[i] = sin((3.1416/2)*i);
		//---------------------------
        	scanf("%s",tempo);
		arrx[i] = atoi(tempo);
		scanf("%s",tempo);
		arry[i] = atoi(tempo);
		//---------------------------
		//arrx[i] = arrx[i]/128.0;
		//arry[i] = arry[i]/128.0;
		//printf("inputted %4f and %4f\n",arrx[i],arry[i]);
	}
	
	fft(256,8,arrx,arry);

	printDoubleArr(arrx,arry,256);
	
	return 0;
}
