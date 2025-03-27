#define __cdecl
#define __declspec(restrict, noalias)
#define HEAP_ZERO_MEMORY 0

#define STD_INPUT_HANDLE	0
#define STD_ERROR_HANDLE	1

#define GENERIC_WRITE		1
#define CREATE_ALWAYS		2
#define GENERIC_READ		4
#define OPEN_EXISTING		8

#define INVALID_HANDLE_VALUE 0

#define FILE_BEGIN			1
#define FILE_CURRENT		2
#define FILE_END			4

//#define __declspec(noalias)

#ifndef _SIZE_T
#define _SIZE_T
  typedef unsigned long size_t;
#endif

typedef unsigned char TCHAR;
typedef unsigned long DWORD;

void *GetProcessHeap(void);
void *HeapReAlloc(void *, size_t, void *, size_t);
void *HeapAlloc(void *, size_t, size_t);

TCHAR *GetCommandLine(void);
int lstrlen(TCHAR *);