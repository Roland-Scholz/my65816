// file.cpp

// file routine overrides

// 08/20/05 (mv)

#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include "libct.h"

#define get_handle() _buff

/* FILE, as defined in stdio.h
struct _iobuf {
        char *_ptr;
        int   _cnt;
        char *_base;				Used to store HANDLE
        int   _flag;
        int   _file;
        int   _charbuf;
        int   _bufsiz;
        char *_tmpfname;
        };
typedef struct _iobuf FILE;
*/

typedef FILE _FILE;
typedef long HANDLE;
	
//_flag values (not the ones used by the normal CRT
#define _FILE_TEXT		0x0001
#define _FILE_EOF		0x0002
#define _FILE_ERROR		0x0004

/*
struct _FILE : public FILE
{
	void set_handle(HANDLE h) {_base = (char*)h;};
	HANDLE get_handle() const {return (HANDLE)_base;};
};
*/
//void set_handle(_FILE* iob, HANDLE h);


// used directly by the stdin, stdout, and stderr macros
FILE __iob[3];
FILE *__iob_func() {return (FILE*)__iob;}

void set_handle(_FILE *__iob, HANDLE h) {
	__iob->_buff = (char *) h;
}

void _init_file()
{
	// STDIN
	set_handle(&(__iob[0]), GetStdHandle(STD_INPUT_HANDLE));
	//__iob[0].set_handle(GetStdHandle(STD_INPUT_HANDLE));
	__iob[0]._flags = _FILE_TEXT;

	// STDOUT
	set_handle(&(__iob[1]), GetStdHandle(STD_INPUT_HANDLE));
	//__iob[1].set_handle(GetStdHandle(STD_OUTPUT_HANDLE));
	__iob[1]._flags = _FILE_TEXT;

	// STDERR
	set_handle(&(__iob[2]), GetStdHandle(STD_ERROR_HANDLE));
	//__iob[2].set_handle(GetStdHandle(STD_ERROR_HANDLE));
	__iob[2]._flags = _FILE_TEXT;
}


BEGIN_EXTERN_C

/*int _fileno(FILE *fp)
{
	return (int)fp;			// FIXME:  This doesn't work under Win64
}

HANDLE _get_osfhandle(int i)
{
	return (HANDLE)i;		// FIXME:  This doesn't work under Win64
}*/

FILE *fopen(const char *path, const char *attrs)
{
	DWORD access, disp;
	HANDLE hFile;
	_FILE *file;
	
	if (strchr(attrs, 'w'))
	{
		access = GENERIC_WRITE;
		disp = CREATE_ALWAYS;
	}
	else
	{
		access = GENERIC_READ;
		disp = OPEN_EXISTING;
	}

	hFile = CreateFileA(path, access, 0, 0, disp, 0, 0);
	if (hFile == INVALID_HANDLE_VALUE)
		return 0;

	file = (_FILE *) malloc(sizeof(_FILE));
	memset(file, 0, sizeof(_FILE));
	//file->set_handle(hFile);
	set_handle(file, hFile);
	if (strchr(attrs, 't'))
		file->_flags |= _FILE_TEXT;

	return file;
}

/*
FILE *_wfopen(const wchar_t *path, const wchar_t *attrs)
{
	DWORD access, disp;
	HANDLE hFile;
	_FILE *file;
	
	if (wcschr(attrs, L'w'))
	{
		access = GENERIC_WRITE;
		disp = CREATE_ALWAYS;
	}
	else
	{
		access = GENERIC_READ;
		disp = OPEN_EXISTING;
	}

	hFile = CreateFileW(path, access, 0, 0, disp, 0, 0);
	if (hFile == INVALID_HANDLE_VALUE)
		return 0;

	//_FILE *file = new _FILE;
	file = (_FILE *) malloc(sizeof(_FILE));
	memset(file, 0, sizeof(_FILE));
	
	//file->set_handle(hFile);
	set_handle(file, hFile);
	
	if (wcschr(attrs, L't'))
		file->_flags |= _FILE_TEXT;

	return file;
}
*/

int fprintf(FILE *fp, const char *s, ...)
{
	va_list args;
	static char bfr[1024];
	int len;
	
	va_start(args, s);

	len = wvsprintfA(bfr, s, args);
	va_end(args);

	fwrite(bfr, len+1, sizeof(char), fp);
	return len;
}

/*
int fwprintf(FILE *fp, const wchar_t *s, ...)
{
	va_list args;
	static wchar_t bfr[1024];
	static char ansibfr[1024];
	int len;
	
	va_start(args, s);

	len = wvsprintfW(bfr, s, args);

	va_end(args);

	WideCharToMultiByte(CP_ACP, 0, bfr, -1, ansibfr, sizeof(ansibfr), 0, 0);

	fwrite(ansibfr, len+1, sizeof(char), fp);
	return len;
}
*/

int fclose(FILE *fp)
{
	CloseHandle(((_FILE *)fp)->get_handle());
	free(fp);
	return 0;
}

/*
int feof(FILE *fp) {
	return 0;
//	return (fp->_flags & _FILE_EOF) ? 1 : 0;
}
*/

int fseek(FILE *str, long offset, int origin)
{
	DWORD meth = FILE_BEGIN;
	if (origin == SEEK_CUR)
		meth = FILE_CURRENT;
	else if (origin == SEEK_END)
		meth = FILE_END;
	SetFilePointer(((_FILE*)str)->get_handle(), offset, 0, meth);
	((_FILE*)str)->_flags &= ~_FILE_EOF;
	return 0;
}

long ftell(FILE *fp)
{
	return SetFilePointer(((_FILE*)fp)->get_handle(), 0, 0, FILE_CURRENT);
}

size_t fread(void *buffer, size_t size, size_t count, FILE *str)
{
	HANDLE hFile;
	int textMode;
	DWORD br;
	char *dst;
	char *src;
	DWORD i;
	
	if (size*count == 0)
		return 0;
	if (feof(str))
		return 0;

	hFile = (HANDLE)(((_FILE*)str)->get_handle());
	textMode = ((_FILE*)str)->_flags & _FILE_TEXT;

	if (textMode)
		src = (char*)malloc(size*count);
	else
		src = (char*)buffer;

	if (!ReadFile(hFile, src, (DWORD)(size*count), &br, 0))
		((_FILE*)str)->_flags |= _FILE_ERROR;
	else if (!br)		// nonzero return value and no bytes read = EOF
		((_FILE*)str)->_flags |= _FILE_EOF;

	if (!br)
		return 0;

	// Text-mode translation is always ANSI
	if (textMode)		// text mode: must translate CR -> LF
	{
		dst = (char*)buffer;
		for (i = 0; i < br; i++)
		{
			if (src[i] != '\r')
			{
				*dst++ = src[i];
				continue;
			}

			// If next char is LF -> convert CR to LF
			if (i+1 < br)
			{
				if (src[i+1] == '\n')
				{
					*dst++ = '\n';
					i++;
				}
				else
					*dst++ = src[i];
			}
			else if (br > 1)
			{
				// This is the hard part: must peek ahead one byte
				DWORD br2 = 0;
				char peekChar = 0;
				ReadFile(hFile, &peekChar, 1, &br2, 0);
				if (!br2)
					*dst++ = src[i];
				else if (peekChar == '\n')
					*dst++ = '\n';
				else
				{
					fseek(str, -1, SEEK_CUR);
					*dst++ = src[i];
				}
			}
			else
				*dst++ = src[i];
		}

		free(src);
	}

	return br/size;
}

size_t fwrite(const void *buffer, size_t size, size_t count, FILE *str)
{
	DWORD bw = 0, bw2 = 0;
	HANDLE hFile;
	int textMode;
	const char *src;
	size_t startpos; 
	size_t i;
	size_t sizeBycount;
	const char *crlf;
	sizeBycount = size * count;
	
	if (sizeBycount == 0)
		return 0;
	
	crlf = "\r\n";

	hFile = (HANDLE)(((_FILE*)str)->get_handle());
	textMode = ((_FILE*)str)->_flags & _FILE_TEXT;

	// Text-mode translation is always ANSI!
	if (textMode)			// text mode -> translate LF -> CRLF
	{
		src = (const char*)buffer;
		startpos = 0;
		//i = 0;
		for (i = 0; i < sizeBycount; i++)
		{
			if (src[i] != '\n')
				continue;
			if (i > 0 && src[i-1] == '\r')		// don't translate CRLF
				continue;

			if (i > startpos)
			{
				WriteFile(hFile, &src[startpos], i-startpos, &bw2, 0);
				bw += bw2;
			}

			WriteFile(hFile, crlf, 2, &bw2, 0);
			bw++;		// one '\n' written

			startpos = i+1;
		}

		if (i > startpos)
		{
			WriteFile(hFile, &src[startpos], i-startpos, &bw2, 0);
			bw += bw2;
		}
	}
	else
		WriteFile(hFile, buffer, (DWORD)(size*count), &bw, 0);
	return bw/size;
}

char *fgets(char *str, int n, FILE *s)
{
	int i;
	
	if (feof(s))
		return 0;

	for (i = 0; i < n-1; i++)
	{
		if (!fread(&str[i], 1, sizeof(char), s))
			break;
		if (str[i] == '\r')
		{
			i--;
			continue;
		}
		if (str[i] == '\n')
		{
			i++;
			break;
		}
	}

	str[i] = 0;
	return str;
}


/*
wchar_t *fgetws(wchar_t *str, int n, FILE *s)
{
	// Text-mode fgetws converts MBCS->Unicode
	if (((_FILE*)str)->_flags & _FILE_TEXT)
	{
		char *bfr = (char*)malloc(n);
		fgets(bfr, n, s);
		MultiByteToWideChar(CP_ACP, 0, bfr, -1, str, n);
		free(bfr);
		return str;
	}

	// Binary fgetws reads as Unicode

	if (feof(s))
		return 0;

	int i;
	for (i = 0; i < n-1; i++)
	{
		if (!fread(&str[i], 1, sizeof(wchar_t), s))
			break;
		if (str[i] == L'\r')
		{
			i--;
			continue;	// does i++
		}
		if (str[i] == L'\n')
		{
			i++;
			break;
		}
	}

	str[i] = 0;
	return str;
}
*/

int fgetc(FILE *s)
{
	char c;
	
	if (s == 0 || feof(s))
		return EOF;

	fread(&c, 1, sizeof(char), s);

	return (int)c;
}

/*
wint_t fgetwc(FILE *s)
{
	if (s == 0 || feof(s))
		return (wint_t)EOF;

	// text-mode fgetwc reads and converts MBCS
	if (((_FILE*)s)->_flags & _FILE_TEXT)
	{
		char ch = (char)fgetc(s);
		wint_t wch;
		MultiByteToWideChar(CP_ACP, 0, &ch, 1, (LPWSTR)&wch, 1);
		return wch;
	}

	// binary fgetwc reads unicode

	wint_t c;
	fread(&c, 1, sizeof(wint_t), s);

	return c;
}
*/

END_EXTERN_C