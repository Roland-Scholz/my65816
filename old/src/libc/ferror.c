#include <dietstdio.h>
#define ferror_unlocked ferror

int ferror_unlocked(FILE*stream) {
  return (stream->flags&ERRORINDICATOR);
}
int ferror(FILE*stream)
__attribute__((weak,alias("ferror_unlocked")));
