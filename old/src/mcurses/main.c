#include "mcurses.h"

int main ()
{
    initscr ();

    mvaddstr (9, 10, "Hello, World!");

    while (1)
    {
        ;
    }

    endwin ();
    return 0;
}
