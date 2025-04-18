#ifndef _DIETFEATURES_H
#define _DIETFEATURES_H

/* feel free to comment some of these out to reduce code size */

/* On i386, BSD socket syscalls have traditionally been implemented via
 * a multiplexing syscall called "socketcall". But somewhere in the 3.x
 * cycle, Linux got real syscalls for socket(), accept() etc, and now
 * it would make sense to use those syscalls instead, if only to make
 * seccomp sandboxes more platform agnostic. However, if you plan on
 * running your program on an ancient kernel, you need the socketcall
 * version instead. */
//#define WANT_I386_SOCKETCALL

//#define WANT_FLOATING_POINT_IN_PRINTF
//#define WANT_FLOATING_POINT_IN_SCANF
//#define WANT_CHARACTER_CLASSES_IN_SCANF
#define WANT_NULL_PRINTF
/* #define WANT_ERROR_PRINTF */
//#define WANT_LONGLONG_PRINTF
//#define WANT_LONGLONG_SCANF

/* 128 or 2048 bytes buffer size? */
#define WANT_SMALL_STDIO_BUFS

/* want fread to read() directly if size of data is larger than buffer?
 * This costs a few bytes but is worth it if the application is already
 * buffering. */
//#define WANT_FREAD_OPTIMIZATION

/* this is only for meaningful for ttyname and sysconf_cpus so far */
#define SLASH_PROC_OK

/* use errno_location instead of errno; NEEDED FOR MULTI-THREADING! */
#define WANT_THREAD_SAFE

/* support __thread; NEEDED FOR MULTI-THREADING! */
//#define WANT_TLS

/* make the startcode, etc. dynamic aware ({con,de}structors) */
// #define WANT_DYNAMIC

/* GDB support in the dynamic linker */
//#define WANT_LD_SO_GDB_SUPPORT

/* do you want smaller or faster string routines? */
//#define WANT_FASTER_STRING_ROUTINES

/* define this to have strncpy and stpncpy zero-fill and not just
 * zero-terminate the destination string */
/* #define WANT_FULL_POSIX_COMPAT */

/* on i386, Linux has an alternate syscall method since 2002/12/16 */
/* on my Athlon XP, it is twice as fast, but it's only in kernel 2.5 */
/* 20040118: enabling this breaks User Mode Linux!  It's their fault. */
//#define WANT_SYSENTER

//#define WANT_LINKER_WARNINGS

/* you need to define this if you want to run your programs with large
 * file support on kernel 2.2 or 2.0 */
//#define WANT_LARGEFILE_BACKCOMPAT

/* do you want localtime(3) to read /etc/localtime?
 * Needed for daylight saving time etc. */
#define WANT_TZFILE_PARSER

/* do you want the DNS routines to parse and use "domain" and "search"
 * lines from /etc/resolv.conf?  Normally not used on boot floppies and
 * embedded environments. */
#define WANT_FULL_RESOLV_CONF

/* do you want IPv6 transport support in the DNS resolver? */
#define WANT_IPV6_DNS

/* do you want gethostbyname and friends to consult /etc/hosts? */
#define WANT_ETC_HOSTS

/* do you want gethostbyname to understand dotted decimal IP numbers
 * directly and not try to resolve them? */
#define WANT_INET_ADDR_DNS

/* do you want math functions high precision rather than fast/small? */
//#define WANT_HIGH_PRECISION_MATH

/* do you want support for matherr? */
//#define WANT_MATHERR

/* do you want crypt(3) to use MD5 if the salt starts with "$1$"? */
#define WANT_CRYPT_MD5

/* do you want crypt(3) to use SHA256 if the salt starts with "$5$? */
#define WANT_CRYPT_SHA256

/* do you want crypt(3) to use SHA512 if the salt starts with "$6$? */
#define WANT_CRYPT_SHA512

/* do you want diet to include a safeguard dependency to make linking
 * against glibc fail?  This may fail with older binutils. */
#define WANT_SAFEGUARD

/* This enables zeroconf DNS aka Rendezvous aka Bonjour. */
/* This code will try zeroconf DNS if you ask for host.local or if you
 * ask for an unqualified hostname */
//#define WANT_PLUGPLAY_DNS

/* This enables LLMNR, the MS variant of zeroconf DNS.  This only works
 * if you also enabled WANT_PLUGPLAY_DNS */
//#define WANT_LLMNR

/* Uncomment this if you want DNS lookups to fail if /etc/hosts contains
 * an entry but it's for a different record type */
/* #define WANT_HOSTS_GIVEUP_EARLY */

/* Do you want valgrind support?  If enabled, the startup code will
 * check for valgrind, and if detected, turn off optimized SIMD string
 * routines that cause false positives in valgrind.  This enlarges and
 * slightly slows down your code! */
//#define WANT_VALGRIND_SUPPORT

/* do you want that malloc(0) return a pointer to a "zero-length" object
 * that is realloc-able; means realloc(..,size) gives a NEW object (like a
 * call to malloc(size)).
 * WARNING: this violates C99 */
/* #define WANT_MALLOC_ZERO */

/* do you want free to overwrite freed data immediately, in the hope of
 * catching people accessing pointers after they were freed?  This does
 * a memset with 0x55 as a value. which is not NULL and not -1.  Please
 * note that this is the shotgun method for debugging, what you really
 * want is valgrind. */
/* #define WANT_FREE_OVERWRITE */

/* This enables a stack gap.  Basically, the start code does not run
 * main but stackgap, which then does alloca(random()) and calls main.
 * The effect is that buffer overflow exploits will no longer be able to
 * know the address of the buffer.  Cost: 62 bytes code on x86. */
/* WARNING: this appears to break with some binutils versions.  Works
 * for me with binutils 2.15.  The symptom is an error message that
 * `main' can not be found. */
/* #define WANT_STACKGAP */

/* For SSP initialization, dietlibc usually uses randomness given by the
 * kernel in the ELF auxvec. Some very old kernels do not pass this, and
 * for them dietlibc will open /dev/urandom to get randomness. Undef
 * this if you don't need that bloat. */
// #define WANT_URANDOM_SSP

/* #define this if you want GNU bloat like program_invocation_short_name
 * and program_invocation_name to be there.  This functionality is not
 * portable and adds useless bloat to libc.  Help stomp out code
 * depending on this!  util-linux, I'm looking at you here! */
//#define WANT_GNU_STARTUP_BLOAT

/* Include support for ProPolice/SSP, calls guard_setup */
/* ProPolice is part of gcc 4.1 and up, there were patches for earlier
 * versions.  To make use of this, compile your application with
 * -fstack-protector. */
/* If you compile dietlibc without WANT_SSP and then try to link code
 * compiled with -fstack-protector against it, the binary will segfault
 * when calling that code. */
#if (__GNUC__>4) || ((__GNUC__==4) && (__GNUC_MINOR__>=1))
#define WANT_SSP
#endif



/* stop uncommenting here ;-) */

/* Several 'syscalls' on x86_64 need vdso set... */
#if defined(__x86_64__) && ! defined(WANT_STACKGAP)
#define WANT_STACKGAP
#endif

#if defined(WANT_SSP) || defined(WANT_STACKGAP) || defined(WANT_TLS)
#define CALL_IN_STARTCODE stackgap
#define CALL_IN_STARTCODE_PIE stackgap_pie
#else
#define CALL_IN_STARTCODE main
#endif

#ifndef WANT_FASTER_STRING_ROUTINES
#define WANT_SMALL_STRING_ROUTINES
#endif

#ifdef __DYN_LIB
/* with shared libraries you MUST have a dynamic aware startcode */
#ifndef WANT_DYNAMIC
#define WANT_DYNAMIC
#endif
/* safeguard crashes with shared objects ... */
#ifdef WANT_SAFEGUARD
#undef WANT_SAFEGUARD
#endif
#endif

#if defined(__x86_64__) && defined(__ILP32__)
#undef WANT_LARGEFILE_BACKCOMPAT
#endif

#endif
