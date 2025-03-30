#include <ctype.h>

#define __isupper_ascii isupper

int __isupper_ascii ( int ch );
int __isupper_ascii ( int ch )
{
    return (unsigned int)(ch - 'A') < 26u;
}

int isupper ( int ch ) __attribute__((weak,alias("__isupper_ascii")));
