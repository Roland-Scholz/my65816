#define THR0	(*(char *)0xFFFFE0)
#define LSR0	(*(char *)0xFFFFE5)

//#ifndef _SIZE_T
//#define _SIZE_T
//  typedef unsigned long size_t;
//#endif


/*
	Copyright 2001, 2002 Georges Menie (www.menie.org)
	stdarg version contributed by Christian Ettinger

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

/*
	putchar is the only external dependency for this file,
	if you have a working putchar, leave it commented out.
	If not, uncomment the define below and
	replace outbyte(c) by your own function call.
*/
//#define putchar(c) outbyte(c)


#include <stdlib.h>
#include <stdarg.h>


static void outbyte(int c) {
	while (!(LSR0 & 0x40));
	THR0 = c;
}

static void debugchar(char **str, int c)
{
	//extern void putchar(int c);
	
	if (str) {
		**str = c;
		++(*str);
	}
	else (void)outbyte(c);
}

#define PAD_RIGHT 1
#define PAD_ZERO 2

static int debugs(char **out, const char *string, int width, int pad)
{
	register int pc = 0, padchar = ' ';

	if (width > 0) {
		register int len = 0;
		register const char *ptr;
		for (ptr = string; *ptr; ++ptr) ++len;
		if (len >= width) width = 0;
		else width -= len;
		if (pad & PAD_ZERO) padchar = '0';
	}
	if (!(pad & PAD_RIGHT)) {
		for ( ; width > 0; --width) {
			debugchar (out, padchar);
			++pc;
		}
	}
	for ( ; *string ; ++string) {
		debugchar (out, *string);
		++pc;
	}
	for ( ; width > 0; --width) {
		debugchar (out, padchar);
		++pc;
	}

	return pc;
}

/* the following should be enough for 32 bit int */
#define PRINT_BUF_LEN 12

static int debugi(char **out, long i, int b, int sg, int width, int pad, int letbase)
{
	char print_buf[PRINT_BUF_LEN];
	/*register*/ char *s;
	/*register*/ unsigned int t, neg = 0, pc = 0;
	/*register*/ unsigned long u = i;

	if (i == 0) {
		print_buf[0] = '0';
		print_buf[1] = '\0';
		return debugs (out, print_buf, width, pad);
	}

	if (sg && b == 10 && i < 0) {
		neg = 1;
		u = -i;
	}

	s = print_buf + PRINT_BUF_LEN-1;
	*s = '\0';

	while (u) {
		t = u % b;
		if( t >= 10 )
			t += letbase - '0' - 10;
		*--s = t + '0';
		u /= b;
	}

	if (neg) {
		if( width && (pad & PAD_ZERO) ) {
			debugchar (out, '-');
			++pc;
			--width;
		}
		else {
			*--s = '-';
		}
	}

	return pc + debugs (out, s, width, pad);
}

static int debug( char **out, const char *format, va_list args )
{
	/*register*/ unsigned int width, pad;
	/*register*/ unsigned int pc = 0;
	char scr[2];

	for (; *format != 0; ++format) {
		if (*format == '%') {
			++format;
			width = pad = 0;
			if (*format == '\0') break;
			if (*format == '%') goto out;
			if (*format == '-') {
				++format;
				pad = PAD_RIGHT;
			}
			while (*format == '0') {
				++format;
				pad |= PAD_ZERO;
			}
			for ( ; *format >= '0' && *format <= '9'; ++format) {
				width *= 10;
				width += *format - '0';
			}
			if( *format == 's' ) {
				register char *s = (char *)va_arg( args, long );
				pc += debugs (out, s?s:"(null)", width, pad);
				continue;
			}
			if( *format == 'd' ) {
				pc += debugi (out, va_arg( args, long), 10, 1, width, pad, 'a');
				continue;
			}
			if( *format == 'x' ) {
				pc += debugi (out, va_arg( args, long), 16, 0, width, pad, 'a');
				continue;
			}
			if( *format == 'X' ) {
				pc += debugi (out, va_arg( args, long), 16, 0, width, pad, 'A');
				continue;
			}
			if( *format == 'u' ) {
				pc += debugi (out, va_arg( args, long), 10, 0, width, pad, 'a');
				continue;
			}
			if( *format == 'c' ) {
				/* char are converted to int then pushed on the stack */
				scr[0] = (char)va_arg( args, int );
				scr[1] = '\0';
				pc += debugs (out, scr, width, pad);
				continue;
			}
		}
		else {
		out:
			debugchar (out, *format);
			++pc;
		}
	}
	if (out) **out = '\0';
	va_end( args );
	
	return pc;
}

int debugf(const char *format, ...)
{	
        va_list args;
        
        va_start( args, format );
        return debug( 0, format, args );
}
/*
int sprintf(char *out, const char *format, ...)
{
        va_list args;
        
        va_start( args, format );
        return print( &out, format, args );
}


int snprintf( char *buf, unsigned int count, const char *format, ... )
{
        va_list args;
        
        ( void ) count;
        
        va_start( args, format );
        return print( &buf, format, args );
}
*/
