#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main() {
	int i,j;
	FILE *fin, *fout;
	char s[500];
	unsigned short int data[8192];
	//read twiddle factors file
	fin=fopen("op2d_singlefreq","r");
	fout= fopen("data_set2.h","w");
	fprintf(fout,"const unsigned short int data_set[8192] = {\n");
	for(i=0;i<8192;i++){
		fscanf(fin,"%s",&s);
		data[i] = atoi(s);
		fprintf(fout,"0x%x, //%d\n",data[i],i);
		//fprintf(fout,"%d\n",data[i]);
		//fscanf(fin,"%s",&s);
	}
	fclose(fin);
	fclose(fout);
return 0;
}
