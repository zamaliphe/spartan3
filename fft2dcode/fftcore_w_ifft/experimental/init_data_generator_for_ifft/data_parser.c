#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main() {
	int i,j;
	FILE *fin1,*fin2, *fout;
	char s[500];
	unsigned short int data;
	//read twiddle factors file
	fin1=fopen("ifft_data.list.real","r");
	fin2=fopen("ifft_data.list.imag","r");
	fout= fopen("data_set_ifft.h","w");
	fprintf(fout,"const unsigned short int data_set[8192] = {\n");
	for(i=0;i<4096;i++){
		fscanf(fin1,"%s",&s);
		data = atoi(s);
		fprintf(fout,"0x%x, //%d\n",data,2*i+1);
		fscanf(fin2,"%s",&s);
		data = atoi(s);
		fprintf(fout,"0x%x, //%d\n",data,2*(i+1));
	}	
	fclose(fin1);
	fclose(fin2);
	fclose(fout);
return 0;
}
