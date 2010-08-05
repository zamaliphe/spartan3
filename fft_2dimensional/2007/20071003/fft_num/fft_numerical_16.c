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
		printf("j = %d\n",j);
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
		//printf("Xr[%d],Xi[%d] = (%4.2f,%4.2f)\n",i,i,a[i],b[i]);
		printf("%4.2f %4.2f\n",a[i],b[i]);
	}
	//printf("--------------------------------------\n");
	return;
}

int main()
{

	double arrx[256], arry[256];
	int i=0;
	char tempo[5];
	
	//printf("hi: this is a c program which does FFT\n");
	
	//filling up the arrays
	//for (i=0;i<256;i++)
	for (i=0;i<16;i++)
	{
		arrx[i] = cos((3.1416/2)*i);
		arry[i] = sin((3.1416/2)*i);
        	////scanf("%s",tempo);
		////arrx[i] = atoi(tempo);
		////scanf("%s",tempo);
		////arry[i] = atoi(tempo);
		//arrx[i] = arrx[i]/128.0;
		//arry[i] = arry[i]/128.0;
		//printf("inputted %4f and %4f\n",arrx[i],arry[i]);
		//arrx[i] = arrx[i]/128.0;
		//arry[i] = arry[i]/128.0;
	}
	
	fft(16,4,arrx,arry);

	printDoubleArr(arrx,arry,16);
	
	return 0;
}
