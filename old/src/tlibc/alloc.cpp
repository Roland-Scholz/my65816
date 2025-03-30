// alloc.cpp

// based on:
// LIBCTINY - Matt Pietrek 2001
// MSDN Magazine, January 2001

// 08/12/06 (mv)

#include <windows.h>
#include <malloc.h>
#include "libct.h"

BEGIN_EXTERN_C
/*
__declspec(restrict, noalias) void *malloc(size_t size)
{
    return HeapAlloc(GetProcessHeap(), 0, size);
}

__declspec(noalias, noalias) void free(void *p)
{
    HeapFree(GetProcessHeap(), 0, p);
}
*/
void *realloc(void *p, size_t size)
{
	void *ptr;
	
    if (p) {
		ptr = malloc( size );
        return ptr;
	}
    else {
        return malloc( size );
	}
}

void *calloc(size_t nitems, size_t size)
{
	void *p;
	
	p = malloc( nitems * size );
	memset(p, 0, size * size);
    return p;
}

/*
void *_calloc_crt(size_t nitems, size_t size)
{
	return calloc(nitems, size);
}


void *_nh_malloc(size_t size, int nhFlag)
{
	nhFlag;
    return HeapAlloc(GetProcessHeap(), 0, size);
}

size_t _msize(void *p)
{
    return HeapSize(GetProcessHeap(), 0, p);
}
*/
END_EXTERN_C