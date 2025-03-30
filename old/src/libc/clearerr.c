#include "dietstdio.h"
#define clearerr_unlocked clearerr

void clearerr_unlocked(FILE *stream) {
  stream->flags&=~(ERRORINDICATOR|EOFINDICATOR);
}

void clearerr(FILE *stream) __attribute__((weak,alias("clearerr_unlocked")));
