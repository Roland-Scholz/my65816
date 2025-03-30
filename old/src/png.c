#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <errno.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/stat.h>

#include "freeRTOS.h"
#include "task.h"
#include <homebrew.h>
//#include "tinf.h"
//#include "puff.h"

int inflate(char *, char *, unsigned long *);

struct image {
	char *data;
	unsigned long width;
	unsigned long height;
	char palette[256];
	unsigned int depth;
	unsigned int colorType;
	unsigned long dataLength; 
	unsigned int bytesPerPixel;
	unsigned int bytesPerScanline;
};	
typedef struct image t_image;

struct header {
	char png[4];
	char txt[4];
};
typedef struct header t_header;

struct chunk {
	unsigned long len;
	char name[4];
};
typedef struct chunk t_chunk;

struct chunkIDAT {
	unsigned long len;
	char name[4];
	unsigned long width;
	unsigned long height;
	char depth;
	char colorType;
	char compression;
	char filter;
	char interlace;
	unsigned long crc;
};
typedef struct chunkIDAT t_chunkIDAT;


//FILE *stdin, *stdout, *stderr;
t_image image;

	
size_t swapLong(size_t in) {
	size_t out;
	char *s, *d;

	s = (char *)&in;
	d = (char *)&out;
	
	d[0] = s[3];
	d[1] = s[2];
	d[2] = s[1];
	d[3] = s[0];
	
	return out;
}

unsigned int computeBytesPerScanline(unsigned int bytesPerPixel, unsigned int imageWidth) {
	
	unsigned int bytesPerScanline;
	
	bytesPerScanline = imageWidth * bytesPerPixel;
	
	switch(image.depth) {
	case 1:
		bytesPerScanline >>= 3;
		break;		
	case 2:
		bytesPerScanline >>= 2;
		break;		
	case 4:
		bytesPerScanline >>= 1;
		if (imageWidth & 0x1) bytesPerScanline++;
		break;		
	case 16:
		bytesPerScanline <<= 1;
		break;
	}

	return bytesPerScanline;
}


unsigned int computeBytesPerPixel(unsigned int colorType) {
	
	unsigned int bytesPerPixel;
	
	bytesPerPixel = 1;
	
	switch(colorType) {
	//depth: 1,2,4,8,16  Each pixel is a grayscale sample.
	//case 0:
	//	break;
	//depth: 8,16        Each pixel is an R,G,B triple.
	case 2:
		bytesPerPixel = 3;
		break;
	//depth: 1,2,4,8     Each pixel is a palette index;
	//case 3:
	//	break;
	//depth: 8,16        Each pixel is a grayscale sample, followed by an alpha sample.	
	case 4:
		bytesPerPixel = 2;
		break;
	//depth: 8,16        Each pixel is an R,G,B triple, followed by an alpha sample.
	case 6:
		bytesPerPixel = 4;
		break;
	default:
		break;
	}
	
	if (image.depth == 16)
		bytesPerPixel <<= 1;
	
	return bytesPerPixel;
}

void standardPalette() {
	unsigned int *palette;
	unsigned int i, c;

	palette	= (unsigned int *)PALETTE;
	
	for (i = 0; i < 256; i++) {
		c = i << 1;
		c &= 0xff80;
		c |= i & 0x3f;
		*palette = c;
		palette++;
	}
}

int doPNG(char *buf, size_t len) {
	t_header *header;
	t_chunk *chunk;
	t_chunkIDAT *idat;
	char name[5], *plte, *compressedData, *palette;
	unsigned long chunklen, imageLen;
	unsigned int x, y, xp;
	int rc;
	
	header = (t_header *) buf;
	name[4] = 0;
	compressedData = NULL;
	imageLen = 0;
	palette = (char *)PALETTE;
	
	standardPalette();
	
	if (!(header->png[0] == 0x89 &&
		header->png[1] == 'P' &&
		header->png[2] == 'N' &&
		header->png[3] == 'G')) {
			
		printf("no PNG file!\n");
		return -1;
	}
	
	buf += sizeof(t_header);
	
	for(;;) {
		chunk = (t_chunk *) buf;
		if (!memcmp(chunk->name, "IHDR", 4)) {
			idat = (t_chunkIDAT *) chunk;
			image.width = swapLong(idat->width);
			image.height = swapLong(idat->height);
			image.depth = idat->depth;
			image.colorType = idat->colorType;
			image.bytesPerPixel = computeBytesPerPixel(image.colorType);
			image.bytesPerScanline = computeBytesPerScanline(image.bytesPerPixel, image.width);

			printf("width: %lu, height: %lu, depth: %d, colType: %d, bpP: %d, bpS: %d\n", 
					image.width, image.height, image.depth, image.colorType, image.bytesPerPixel, image.bytesPerScanline);
					
			buf += sizeof(t_chunkIDAT);
			continue;
		}
	
		memcpy(name, chunk->name, 4);
		chunklen = swapLong(chunk->len);
		
		//printf("chunk: %s, len: %lu\n", name, chunklen);
		
		if (!memcmp(chunk->name, "IDAT", 4)) {
			
			image.dataLength = (image.width * image.bytesPerPixel + 1) * image.height;
			
			if (imageLen == 0) {
				imageLen = chunklen - 2;	//subtract zlib header
				compressedData = malloc(imageLen);
				memcpy(compressedData, buf + sizeof(t_chunk) + 2, imageLen);
			} else {
				compressedData = realloc(compressedData, imageLen + chunklen);
				memcpy(compressedData + imageLen, buf + sizeof(t_chunk), chunklen);
				imageLen  += chunklen;
			}
			
			if (!compressedData) {
				return -1;
			}

		}
		
		if (!memcmp(chunk->name, "PLTE", 4)) {
			plte = buf + sizeof(t_chunk);
			
			y = chunklen / 3;
			
			printf("doing palette, colors: %d\n", y);
			
			
			//asm {sei; wdm 7;};
			for(x = 0, xp = 0; x < y; x++, xp++) {
				palette[xp] = *plte >> 5;
				plte++;
				palette[xp] |= ((*plte >> 2) & 0x38);
				plte++;
				palette[xp] |= ((*plte << 1) & 0xC0);
				//printf("%p:%02X ", palette+xp, palette[xp]);
				xp++;
				palette[xp] = *plte >> 7;
				plte++;
				//printf("%02X\n", palette[xp]);
			}
			//asm {wdm 6; cli;};

		}
		
		//getchar();
		
		if (!memcmp(chunk->name, "IEND", 4)) {
			image.data = malloc(image.dataLength);
			printf("datain: %p, dataout: %p, len: %lu\n", compressedData, image.data, image.dataLength);
			
			imageLen -= 4;
			//asm{wdm 1;}
			//rc = puff(image.data, &image.dataLength, compressedData, &imageLen);
			//asm{wdm 2;}
			asm{wdm 1;}
			rc = inflate(compressedData, image.data, &image.dataLength);
			asm{wdm 2;}

			printf("rc: %d, len: %lu\n", rc, image.dataLength);

			//if (rc != 0) return -1;
			break;
		}
		
		buf += sizeof(t_chunk) + chunklen + sizeof(long);

	}
}



void reconcile(char *scanLine, char *scanLineOld, char *imageData, unsigned int bytesPerPixel) {
	unsigned int x0, a, b, c, r, x, filter;
	int p, xprev, pa, pb, pc;
	
	filter = *imageData;
	imageData++;
	
	
	if (filter == 0) {
		memcpy(scanLine, imageData, image.bytesPerScanline);
		return;
	}
	
	for (x = 0, xprev = -bytesPerPixel; x < image.bytesPerScanline; x++, xprev++) {
		
		//none
		/*
		if (filter == 0) {
			scanLine[x] = imageData[x];
			continue;
		}*/ 
		
		//sub
		if (filter == 1) {
			if (xprev >= 0) {
				scanLine[x] = imageData[x] + scanLine[xprev];
			} else {
				scanLine[x] = imageData[x];
			}
			continue;
		}
		
		//up
		if (filter == 2) {
			scanLine[x] = imageData[x] + scanLineOld[x];
			continue;
		}
		
		if (filter == 3) {
			r = scanLineOld[x];
			if (xprev >= 0) {
				r += scanLine[xprev];
			}
			r >>= 1;
			scanLine[x] = r + imageData[x];
			continue;
		}
		
		if (filter == 4) {
			b = p = scanLineOld[x];		//b			

			if (xprev >= 0) {
				a = scanLine[xprev];
				c = scanLineOld[xprev];

				p += a - c;
				pa = p - a;
				pc = p - c;
				if (pa < 0) pa = -pa;
				if (pc < 0) pc = -pc;
			} else {
				a = c = 0;
				pa = p;
				if (pa < 0) pa = -pa;
				pc = pa;
			}
			pb = p - b;
			if (pb < 0) pb = -pb;
						
			if ((unsigned int)pa <= (unsigned int)pb & (unsigned int)pa <= (unsigned int)pc) {				
				scanLine[x] =  imageData[x] + (char)a;
				continue;
			}
			
			if ((unsigned int)pb <= (unsigned int)pc) {
				scanLine[x] = imageData[x] + (char)b;
				continue;
			}
			
			scanLine[x] = imageData[x] + (char)c;
		}		
	}
}

void display(char *scanLine, unsigned int y) {
	unsigned int x, g;
	char *graph;

	if (y >= 200) return;
	
	graph = (char *)0x7F0000 + y * 320;
	
	for (x = 0, g = 0; x < image.bytesPerScanline; x += image.bytesPerPixel) {
		if (g >= 320) return;
		if (image.bytesPerPixel == 1) {
			switch (image.depth) {
			case 4:
				*graph = scanLine[x] >> 4;
				graph++;				
				*graph = scanLine[x] & 0x0f;
				break;								
			case 8:
				*graph = scanLine[x];
				break;
			default:
				break;
			}
	
		} else {
			if (image.depth == 8) {
				*graph 	= (scanLine[x] >> 5);
				asm {iny;}
				*graph |= (scanLine[x] >> 2) & 0x38;
				asm {iny;}
				*graph |= scanLine[x] & 0xc0;
			}
		}
		
		graph++;
		g++;
	}
}

int bitstream() {
	unsigned long rc;
	FILE *fin;
	unsigned int y;
	char *scanLineOld, *scanLine, *imageData, *graph;
			
	imageData = image.data;
	graph = (char *)0x7F0000;
	memset(graph, 0, 0xf800);
	//getchar();
	
	
	scanLine = calloc(image.bytesPerScanline, 1);
	scanLineOld = NULL;
	
	//if (image.bytesPerPixel != 1) {
	//	CONTROL |= 0x08;
	//}
	
	for (y = 0; y < image.height; y++) {
		free(scanLineOld);
		scanLineOld = scanLine;
		scanLine = malloc(image.bytesPerScanline);
		
		reconcile(scanLine, scanLineOld, imageData, image.bytesPerPixel);
		display(scanLine, y);
		
		imageData += image.bytesPerScanline + 1;
	}
	
	//asm {WDM 2;}
}

int main(int argc, char **argv) {
	FILE *fin;
	char *graph, *buf, *vbuf, *fname, hi, bank;
	size_t flen;
	struct stat st;
	int fd;
	
	if (argc < 2) {
		fname = adjustFilename("bu*.*", 0);
		//printf("png <filename.png>\n");
		//return 0;
	} else {
		fname = adjustFilename(argv[1], 0);
	}
	
	if (stat(fname, &st) == -1) {
		return 0;
	}
	
	fin = fopen(fname, "rb");
	
	if (fin == NULL) {
		printf("can't read file %s\n", fname);
		return 0;
	}
	
	//vbuf = malloc(2048);
	//setvbuf(fin, vbuf, _IOFBF, 2048);
	
	buf = malloc(st.st_size);
	printf("loading %s, length: %lu\n", fname, st.st_size);
	
	//asm{wdm 1;}
	//flen = fread(buf, 1, st.st_size, fin);
	fd = fileno(fin);
	flen = read(fd, buf, st.st_size);
	//asm{wdm 2;}
	
	printf("%lu bytes loaded\n", flen);
	
	fclose(fin);
	
	if (flen != st.st_size) return 0;
	if (doPNG(buf, flen) < 0) return 0;
	
	
	CONTROL = 2;
	hi = SCREENBASEHI;
	bank = SCREENBASEBANK;
	SCREENBASEHI = 0x80;
	SCREENBASEBANK = 0x3F;

	bitstream();
	
	getchar();
	
	CONTROL = 4;
	SCREENBASEHI = hi;
	SCREENBASEBANK = bank;
	
	standardPalette();
	printf("%c", CLS);
}
