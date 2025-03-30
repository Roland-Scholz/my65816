#define _GNU_SOURCE
#include <stdlib.h>
#include <stdio.h>
#include "dietfeatures.h"
#include <errno.h>
#include "dietwarning.h"

ssize_t getdelim(char **lineptr, size_t *n, int delim, FILE *stream) {
  size_t i;
  int x;
  size_t tmp;
  char* new;
  
  if (!lineptr || !n) {
    errno = EINVAL;
    return -1;
  }
  
  //fprintf(stderr, "p: %08lX, *p: %08lX  \n", lineptr, *lineptr);
  
  if (!*lineptr) *n = 0;
  
  for (i = 0; ; ) {
    if (i >= *n) {
      tmp = *n + 100ul;
      new = realloc(*lineptr, tmp);
      if (!new) return -1;
      *lineptr = new; 
	  *n = tmp;
    }
    x = fgetc(stream);
	
    if (x == EOF) { 
		if (!i) return -1; 
		(*lineptr)[i] = 0; 
		
		//fprintf(stderr, "i: %08lX, p: %08lX, *p: %08lX %s \n", i, lineptr, *lineptr, *lineptr);

		return i;
	}
	
    (*lineptr)[i] = x;
    ++i;
    if (x == delim || i >= *n) break;
  }
  (*lineptr)[i] = 0;
   
  return i;
}

link_warning("getdelim","warning: portable software should not use getdelim!")
