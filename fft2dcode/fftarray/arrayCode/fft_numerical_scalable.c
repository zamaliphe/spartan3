#include<stdio.h>
#include<math.h>
#include <stdlib.h>


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
			s = sin(a);
			a = a + e;
			for (k=j; k < n; k=k+n2)
			{
				t1 = c*x[k+n1] - s*y[k+n1];
				t2 = s*x[k+n1] + c*y[k+n1];
				x[k+n1] = x[k] - t1;
				y[k+n1] = y[k] - t2;
				x[k] = x[k] + t1;
				y[k] = y[k] + t2;
			}
		}
	}
	return;
}

printDoubleArr(double * a,double * b, int n)
{
	int i = 0;
	//printf("--------------------------------------\n");
	for(i=0;i<n;i++)
	{
		printf("%4.2f %4.2f\n",a[i],b[i]);
	}
	//printf("--------------------------------------\n");
	return;
}

printDoubleArrLine(double * a,double * b, int n)
{
	int i = 0;
	for(i=0;i<n;i++)
	{
		printf("%8.0f\t%5d\n%8.0f\t%5d\n",a[i],2*i+1,b[i],2*i+2);
	}
	return;
}

int main()
{

	double *arrx,*arry;
	int i=0;
	int N= 256;
	float spikePoint = 0.5;
	printf("hi: this is a c program which does FFT\n Enter the Number of points:");
	scanf("%d",&N);
	
	//filling up the arrays
	arrx = (double*)malloc(N*sizeof(double));
	arry = (double*)malloc(N*sizeof(double));
	printf("At what frequency(normalized wrt pi) do you want a spike:");
	scanf("%f",&spikePoint);

	for (i=0;i<N;i++)
	{
		arrx[i] = 0.5*cos(spikePoint*3.1416*i);
		arry[i] = 0.5*sin(spikePoint*3.1416*i);		
	}
	
	fft(N,(int)(log10(N)/log10(2)),arrx,arry);

	printDoubleArrLine(arrx,arry,N);

	//Free dynamically allocated memory
	free(arrx);
	free(arry);	
	return 0;
}
