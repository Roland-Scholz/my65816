#define _POSIX_SOURCE
#define _XOPEN_SOURCE
#include <sys/types.h>
#include <string.h>

union uptr {
	struct {
		unsigned int wptr;
		unsigned char bptr;
		unsigned char dummy;
	} part;
	char *ptr;
};

typedef union uptr uptr_t;

void *memmove(void *dst, const void *src, size_t count) {

	unsigned int isize;
	uptr_t pdst;
	uptr_t psrc;
	
	if (src == dst) return dst;

	psrc.ptr = (char *)src;
	pdst.ptr = (char *)dst;
	
	if (src > dst) {
		while (count) {
			
			if (pdst.part.wptr > psrc.part.wptr) {
				isize = pdst.part.wptr ^ 0xffff;
			}
			else {
				isize = psrc.part.wptr ^ 0xffff;
			}
			isize++;
			
			if (count < isize) isize = (unsigned int) count;
			
			//printf("isize: %08lX, from: %08lX, to: %08lX\n", (size_t)isize, psrc.ptr, pdst.ptr); 
				
		#asm
			sep #$30
			lda <L3+psrc_1+2
			xba
			lda <L3+pdst_1+2
			rep #$30
			sta moveneg+1	
			lda <L3+isize_1
			dea
			ldx <L3+psrc_1
			ldy <L3+pdst_1
		
			phb
		moveneg:
			mvn $0,$0
			plb
		#endasm
			count -= isize;
			pdst.ptr += isize;
			psrc.ptr += isize;
		}
	} else {
		// src < dst!
		psrc.ptr += count - 1;
		pdst.ptr += count - 1;
		while (count) {
		
			if (pdst.part.wptr < psrc.part.wptr) {
				isize = pdst.part.wptr;
			}
			else {
				isize = psrc.part.wptr;
			}
			isize++;
	
			if (count < isize) isize = (unsigned int) count;
			
			//printf("src < dst isize: %08lX, from: %08lX, to: %08lX\n", (size_t)isize, psrc.ptr, pdst.ptr); 

		#asm
			sep #$30
			lda <L3+psrc_1+2
			xba
			lda <L3+pdst_1+2		
			rep #$30
			sta movepos+1	
			lda <L3+isize_1
			dea
			ldx <L3+psrc_1
			ldy <L3+pdst_1
		
			phb
		movepos:
			mvp $0,$0
			plb
		#endasm
	
			count -= isize;
			psrc.ptr -= isize;
			pdst.ptr -= isize;
		}
	}
	
	return dst;
}

