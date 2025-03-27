#include <dietstdio.h>
#define fileno_unlocked fileno

int fileno_unlocked(FILE*stream) {
  return stream->fd;
}
int fileno(FILE*stream)
__attribute__((weak,alias("fileno_unlocked")));
