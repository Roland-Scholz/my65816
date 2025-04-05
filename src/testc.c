//#pragma clang section rodata="code"

#include <stdio.h>
#include <stdlib.h>

int _Stub_close(int fd) {
    return 0;
}

long _Stub_lseek(int fd, long offset, int whence) {
    return 0;
}

void _write(char c) {
    __asm (
        " rep #0x20\n"
        " sta 0xD800\n"
        " sep #0x20"
    ); 
}
size_t _Stub_write(int fd, const void *buf, size_t count) {
    char *b = (char *)buf;  
    for(;count > 0; count--) {
        _write(*b);
        b++;
    }
   return 0;
}


int main (int argc, char** argv) {
    printf("Hallo Welt mit Calypsi!\n");
    return 0;
}
