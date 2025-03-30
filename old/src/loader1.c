#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include "homebrew.h"

//c2iocb c2iocb[20];

struct r816Header {
	unsigned long magic;
	unsigned long mainOffset;
	unsigned long codeLen;
	unsigned long dataLen;
	unsigned long uDataLen;
	unsigned long numReloc;	
};

struct r816Reloc{
	unsigned int targetType;
	unsigned long targetOffset;
	unsigned int length;
	unsigned int type;
	unsigned long SectionOffset;
};

typedef struct r816Header t_r816Header;
typedef struct r816Reloc t_r816Reloc;

static char s[80];
static char filename[] = "D:TEST816.EXE";
static t_r816Header header;
static t_r816Reloc reloc;

/*
char* type2section(unsigned int type) {
	switch(type) {
	case 1:	return "CODE";
	case 3:	return "DATA";
	case 4:	return "UDATA";
	default: return "UNKOWN";
	}
}
*/

	
// 0001 0118 : 65816 (magic number)
// ee ee ee ee : offset to __main (entry)
// cc cc cc cc : length of CODE section
// dd dd dd dd : length of DATA section
// ud ud ud ud : length of UDATA section
// rl rl rl rl : #entries of reloc table

// of of of of : offset in code
// le le : length of relocinfo in code (2-4 bytes)
// os os os os : offset in SECTION
// st st : section type (1:CODE, 3:DATA; 4:UDATA)
// code : aligned at 2-byte boundary
// data : aligned at 2-byte boundary
// (udata) : aligned at 2-byte boundary

void formatLine(char* dest, char* text, unsigned long data) {
/*
	strcpy(dest, text);
	dest[14] = ':';
	dest[15] = ' ';
	hex8(dest+16, data);
	dest[24] = '\n';
	
	putrec(0, dest);
*/
//	printf("%s: %08X\n", text, data);
}

int loadExec(char *filename) {
	
	int iorc;
	unsigned long cnt;
	unsigned long dataBase;
	unsigned long uDataBase;
	char *ptr;
	long sectionOffset;
	unsigned int i;
	
	FILE *fin;

//	Open the file in the current directory	
//
//	fin = fopen(filename, "rb");
	if (fin == NULL) return BRKABT;
		
//	Read header bytes and check for "R816", if not, error
//
	iorc = fread (&header, 1, sizeof(t_r816Header), fin);
//	if (iorc != SUCCES) return iorc;
	if (header.magic != 0x36313852) return BRKABT;

	dataBase = MODBASE + header.codeLen;
	uDataBase = dataBase + header.dataLen;

//	printf("R816 loader\n");

	formatLine(s, "Module base   ", MODBASE);
	formatLine(s, "Data base     ", dataBase);
	formatLine(s, "UData base    ", uDataBase);
	formatLine(s, "Offset to main", header.mainOffset);
	formatLine(s, "Code length   ", header.codeLen);
	formatLine(s, "Data length   ", header.dataLen);
	formatLine(s, "UData length  ", header.uDataLen);
	formatLine(s, "#relocs       ", header.numReloc);

	goto ende;
//	sprintf(s, "#relocs       : %d\n", header.numReloc*size);
//	putrec(0, s);
	
//	sprintf(s, "MODBASE: %04X \n", MODBASE);
//	putrec(0,s);
	
//	iorc = getchr(1, (char *)(MODBASE), (int) (header.codeLen + header.dataLen));
	
//	sprintf(s, "MODBASE: %04X\n", MODBASE);
//	putrec(0,s);
		
//	getrec(0, FNAME);

	
// of of of of : offset in code
// le le : length of relocinfo in code (2-4 bytes)
// os os os os : offset in SECTION
// st st : section type (1:CODE, 3:DATA; 4:UDATA)

	for (cnt = 0; cnt < header.numReloc; cnt++) {
		
		iorc = getchr(1, (char *)&reloc, (int) (sizeof(t_r816Reloc)));

		switch (reloc.targetType) {
			case 1:
				ptr = (char *) (MODBASE + (unsigned int) (reloc.targetOffset));
				break;
			case 3:
				ptr = (char *) (dataBase + (unsigned int) (reloc.targetOffset));
				break;
			default:
				break;
		}
		
		switch (reloc.type) {
			case 1:
				sectionOffset = MODBASE + reloc.SectionOffset;
				break;
			case 3:
				sectionOffset = dataBase + reloc.SectionOffset;
				break;
			case 4:
				sectionOffset = uDataBase + reloc.SectionOffset;
				break;
			default:
				reloc.length = 0;
				break;
		}

/*		
		sprintf(s, "Reloc #%d\n", cnt);
		putrec(0, s);
		sprintf(s, "CodeOffset    : %08X\n", reloc.CodeOffset);
		putrec(0, s);
		sprintf(s, "#Bytes        : %04X\n", reloc.length);
		putrec(0, s);
		sprintf(s, "SectionOffset : %08X\n", reloc.SectionOffset);
		putrec(0, s);
		sprintf(s, "Type          : %s\n", type2section(reloc.type));
		putrec(0, s);
		
		sprintf(s, "Modebase %04X codePtr: %04X, sectionPtr: %04X \n", MODBASE, codePtr, (int)(sectionOffset));
		putrec(0, s);
		
		getrec(0, FNAME);
*/			
		for (i = 0; i < reloc.length; i++) {
			
			ptr[i] = ((char *)(&sectionOffset))[i]; 
		}
		
		
	}		

ende:
//	fclose(fin);

	return iorc;
}

int main(int argc, char **argv) {
	char iorc;
		
	iorc = loadExec(filename);

	formatLine(s, "rc            ", (long)iorc);
}