#include <ctype.h>

#define __islower_ascii islower

int __islower_ascii ( int ch );
int __islower_ascii ( int ch ) {
    return (unsigned int) (ch - 'a') < 26u;
}

int islower ( int ch ) __attribute__((weak,alias("__islower_ascii")));
