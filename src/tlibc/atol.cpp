// atol.cpp

// based on:
// LIBCTINY - Matt Pietrek 2001
// MSDN Magazine, January 2001

// 08/12/06 (mv)

#define BEGIN_EXTERN_C
#define END_EXTERN_C
#include <stdlib.h>
//#include <ctype.h>
//#include "libct.h"

#define wint_t wchar_t

BEGIN_EXTERN_C
	
long atol(const char *str)
{
	int cur, neg;
	long total;
	
    while (isspace(*str))			// skip whitespace
        ++str;

    cur = *str++;
    neg = cur;					// Save the negative sign, if it exists

    if (cur == '-' || cur == '+')
        cur = *str++;

    // While we have digits, add 'em up.

	total = 0;
    while (isdigit(cur))
    {
        total = 10*total + (cur-'0');			// Add this digit to the total.
        cur = *str++;							// Do the next character.
    }

    // If we have a negative sign, convert the value.
    if (neg == '-')
        return -total;
    else
        return total;
}

int atoi(const char *str)
{
    return (int)atol(str);
}



long wtol(const wchar_t *str)
{
	long total;
	wint_t cur, neg;
	
    while (iswspace(*str))			// skip whitespace
        ++str;

    cur = *str++;
    neg = cur;					// Save the negative sign, if it exists

    if (cur == L'-' || cur == L'+')
        cur = *str++;

    // While we have digits, add 'em up.

	total = 0;
    while (iswdigit(cur))
    {
        total = 10*total + (cur-L'0');			// Add this digit to the total.
        cur = *str++;							// Do the next character.
    }

    // If we have a negative sign, convert the value.
    if (neg == L'-')
        return -total;
    else
        return total;
}

int wtoi(const wchar_t *str)
{
    return (int)wtol(str);
}

END_EXTERN_C