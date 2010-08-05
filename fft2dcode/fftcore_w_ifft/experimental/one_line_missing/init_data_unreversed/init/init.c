#include "data_set2.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

unsigned short twiddles[64];

unsigned short int reverse(unsigned short int in){
	unsigned short int result=0, refin=0x0001, refout=0x0020;
	int i;

	for(i=0;i<6;i++){
		if((in&refin)!=0)
			result^=refout;

		refin<<=1;
		refout>>=1;
	}

	return result;
}

void convert_mif(char *s, unsigned short in){
	unsigned int ref=0x8000;
	int i;

	for(i=0;i<16;i++){
		if((ref&(unsigned int)in)!=0)
			s[i]='1';
		else
			s[i]='0';
		ref>>=1;
	}

	s[i]='\0';
	return;
}

int main (void) {	
	int i,j;
	FILE *fin, *fout;
	char s[500];
	unsigned short int data_set_ordered[256];

	//read twiddle factors file
	fin=fopen("twiddles.fft","r");
	for(i=0;i<64;i++){
		fgets(s,499,fin);
		sscanf(s,"%hx",&twiddles[i]);
	}
	fclose(fin);

	for(i=0;i<32;i++){
		//sprintf(s,"fft_%02i.mif",i);
		sprintf(s,"fft_%i.mif",i);
		fout = fopen(s,"w");
		for(j=0;j<64;j++){
			convert_mif(s, twiddles[j]);
			fprintf(fout,"%s\n",s);
		}

		for(j=64;j<255;j++){
			convert_mif(s, 0);
			fprintf(fout,"%s\n",s);
		}

		for(j=0;j<128;j++){
			data_set_ordered[j]=data_set[i*128+j];

		}
		for(j=0;j<128;j++){
			data_set_ordered[j+128]=data_set[i*128+j+4096];

		}

		for(j=0;j<64;j++){
			convert_mif(s, data_set_ordered[0x000|(reverse(j)<<1)|0x000]);
			//convert_mif(s, data_set_ordered[0x000|(j<<1)|0x000]);
			fprintf(fout,"%s\n",s);
			convert_mif(s, data_set_ordered[0x000|(reverse(j)<<1)|0x001]);
			//convert_mif(s, data_set_ordered[0x000|(j<<1)|0x001]);
			fprintf(fout,"%s\n",s);
		}

		for(j=0;j<64;j++){
			convert_mif(s, data_set_ordered[0x080|(reverse(j)<<1)|0x000]);
			//convert_mif(s, data_set_ordered[0x080|(j<<1)|0x000]);
			fprintf(fout,"%s\n",s);
			convert_mif(s, data_set_ordered[0x080|(reverse(j)<<1)|0x001]);
			//convert_mif(s, data_set_ordered[0x080|(j<<1)|0x001]);
			fprintf(fout,"%s\n",s);
		}

		
		fclose(fout);
	}
	//printf("%x,%x\n",52,reverse(52));

	return 0;
}
