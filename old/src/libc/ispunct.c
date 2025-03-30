#include <ctype.h>

#define __ispunct_ascii ispunct

int __ispunct_ascii ( int ch );
int __ispunct_ascii ( int ch ) 
{
    return isprint (ch)  &&  !isalnum (ch)  &&  !isspace (ch);
}

int ispunct ( int ch ) __attribute__((weak,alias("__ispunct_ascii")));
