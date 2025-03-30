/* fast memcpy -- Copyright (C) 2003 Thomas M. Ogrisegg <tom@hi-tek.fnord.at> */

#include <string.h>
#include "dietfeatures.h"
#include "dietstring.h"

union uptr {
	struct {
		unsigned int wptr;
		unsigned char bptr;
		unsigned char dummy;
	} part;
	char *ptr;
};

typedef union uptr uptr_t;

void *memcpy (void *dst, const void *src, size_t count) {

	unsigned int isize;
	uptr_t pdst;
	uptr_t psrc;
	
	if (src == dst) return dst;

	psrc.ptr = (char *)src;
	pdst.ptr = (char *)dst;
	
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
	
	return dst;
}

/*
void *
memcpy (void *dst, const void *src, size_t n)
{
    void           *res = dst;
#ifdef WANT_SMALL_STRING_ROUTINES
    if (n & 1) {
	    *(char *)dst = *(char *)src;
	    ((char *)dst)++;
	    ((char *)src)++;
	    n--;
    }
    n >>= 1;
    while (n) {
	    *(int *)dst = *(int *)src;
	    ((char *)dst) += 2;
	    ((char *)src) += 2;
	    n--;
    }

//    c1 = (unsigned char *) dst;
//    c2 = (unsigned char *) src;
//    while (n--) *c1++ = *c2++;

    return (res);
#else
    unsigned char  *c1, *c2;
    int             tmp;
    unsigned long  *lx1 = NULL;
    const unsigned long *lx2 = NULL;

    if (!UNALIGNED(dst, src) && n > sizeof(unsigned long)) {

	if ((tmp = STRALIGN(dst))) {
	    c1 = (unsigned char *) dst;
	    c2 = (unsigned char *) src;
	    while (tmp-- && n--)
		*c1++ = *c2++;
	    if (n == (size_t) - 1)
		return (res);
	    dst = c1;
	    src = c2;
	}

	lx1 = (unsigned long *) dst;
	lx2 = (unsigned long *) src;

	for (; n >= sizeof(unsigned long); n -= sizeof(unsigned long))
	    *lx1++ = *lx2++;
    }

    if (n) {
	c1 = (unsigned char *) (lx1?lx1:dst);
	c2 = (unsigned char *) (lx1?lx2:src);
	while (n--)
	    *c1++ = *c2++;
    }

    return (res);
#endif
}
*/