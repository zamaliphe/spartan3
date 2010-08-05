#include<stdio.h>

int main()
{
int i=0;
int j=0;
int a[128];
int c;
int nn = 64;
int m = 0;

for(i=0;i<2*nn;i++)
{
	a[i] = i/2;
	//printf("hi");
}
/*
printf("nn= %d\n",nn);
printf("done1\n");
*/
j=1;
for(i=1;i<128;i+=2)
{
	if(j>i)
	{
		printf("%d being swapped with %d \t",a[i-1],a[j-1]);
		printf("%d being swapped with %d \n",a[i],a[j]);
		c = a[i-1];
		a[i-1] = a[j-1];
		a[j-1] = c;
		c = a[i];
		a[i] = a[j];
		a[j] = c;
	
	}
	m = nn;
	while(m>=2 && j>m)
	{
		j-=m;
		m>>=1;
	}
	j+=m;
}
/*
printf("done2\n");
i=0;
printf("nn=%d and i=%d\n",nn,i);
for(i=0;i<128;i++)
{
	if(i%2==0){
		printf("%d<-->%d\n",i/2,a[i]);
	}
//printf("done3\n");
}
//printf("done3\n");
*/
}//end main
