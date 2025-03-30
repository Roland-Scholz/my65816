// string.cpp

// based on:
// LIBCTINY - Matt Pietrek 2001
// MSDN Magazine, January 2001

// 08/12/06 (mv)
// 03/24/07 (mv)	fix strnicmp function

#include <windows.h>
#include <stdlib.h>
#include <string.h>
#include <tchar.h>
#include "libct.h"

BEGIN_EXTERN_C
char *lstrcatA(char *, const char *);

int strcmpi(char *s1, char *s2)
{
    return lstrcmpiA(s1, s2);
}

/*
int stricmp(const char *s1, const char *s2) {return _stricmp(s1, s2);}
int _stricmp(const char *s1, const char *s2)
{
    return lstrcmpiA(s1, s2);
}
*/

int strcmp(const char *s1, const char *s2)
{
	int i;
	
	while (*s1 && *s2){
		i = s2 - s1;
		if (i) break;
	}
	
	return i;
}
/*
int strncmp(const char *s1, const char *s2, size_t n)
{
	const unsigned char *p1;
	const unsigned char *p2;
	size_t i;
	
	if (!n)
		return 0;

	p1 = (const unsigned char*)s1;
	p2 = (const unsigned char*)s2;

	for (i = 0; i < n; i++)
	{
		if (!p1[i] || p1[i] != p2[i])
			return p1[i] - p2[i];
	}

	return 0;
}
*/

/*
int strnicmp(const char *s1, const char *s2, size_t n)
{
	return CompareStringA(LOCALE_SYSTEM_DEFAULT, NORM_IGNORECASE, s1, n, s2, n) - CSTR_EQUAL;
}
*/

char *strdup(char *src)
{
	char *dst;
	
	if (!src)
		return 0;

	dst = (char*) malloc( strlen( src ) + 1 ) ;
	strcpy(dst, src);
	return dst;
}

char *_strdup(char *src)
{
	return strdup(src);
}

char *strcpy(char *dest, const char *src)
{
	size_t len;
	len = strlen( src );
	memcpy(dest, src, len + 1);
	
	return dest;
}

char *strncpy(char *dest, const char *src, size_t n)
{
	size_t len;
	
	memcpy(dest, src, n);
	len = strlen(src);
	if (n > len)
		memset(&dest[len], 0, n-len);
	return dest;
}

size_t strlen(const char *str)
{
	size_t len = 0;
	while(*str++) {
		len++;
	}
	return len;
}

char *strchr(const char *str, int ch)
{
	while (*str)
	{
		if (*str == ch)
			return (char *)str;
		str++;
	}
	return 0;
}

char *strrchr(const char *str, int ch)
{
	const char *end = str + strlen(str) + 1;
	while (end != str)
	{
		end--;
		if (*end == ch)
			return (char *)end;
	}
	return 0;
}

char *strcat(char *dst, const char *src)
{
	size_t lenDst, lenSrc;
	
	lenDst = strlen(dst);
	
	return strcpy(&(dst[lenDst]), src );
}

char *strstr(const char *str, const char *substr)
{
	int str_len = strlen(str);
	int substr_len = strlen(substr);
	int i;
	
	if (substr_len == 0)
		return (char *)str;
	if (str_len < substr_len)
		return 0;
	for (i = 0; i < (int)(str_len-substr_len+1); i++)
	{
		if (!strcmp(&str[i], substr))
			return (char *)(&str[i]);
	}
	return 0;
}

END_EXTERN_C