/* SPDX-License-Identifier: (BSD-2-Clause AND libpng-2.0) */
#ifndef SPNG_H
#define SPNG_H

#define SPNG_DISABLE_OPT

#ifdef __cplusplus
extern "C" {
#endif

#if (defined(_WIN32) || defined(__CYGWIN__)) && !defined(SPNG_STATIC)
    #if defined(SPNG__BUILD)
        #define SPNG_API __declspec(dllexport)
    #else
        #define SPNG_API __declspec(dllimport)
    #endif
#else
    #define SPNG_API
#endif

#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

#define SPNG_VERSION_MAJOR 0
#define SPNG_VERSION_MINOR 6
#define SPNG_VERSION_PATCH 1

enum spng_errno
{
    SPNG_IO_ERROR = -2,
    SPNG_IO_EOF = -1,
    SPNG_OK = 0,
    SPNG_EINVAL,
    SPNG_EMEM,
    SPNG_EOVERFLOW,
    SPNG_ESIGNATURE,
    SPNG_EWIDTH,
    SPNG_EHEIGHT,
    SPNG_EUSER_WIDTH,
    SPNG_EUSER_HEIGHT,
    SPNG_EBIT_DEPTH,
    SPNG_ECOLOR_TYPE,
    SPNG_ECOMPRESSION_METHOD,
    SPNG_EFILTER_METHOD,
    SPNG_EINTERLACE_METHOD,
    SPNG_EIHDR_SIZE,
    SPNG_ENOIHDR,
    SPNG_ECHUNK_POS,
    SPNG_ECHUNK_SIZE,
    SPNG_ECHUNK_CRC,
    SPNG_ECHUNK_TYPE,
    SPNG_ECHUNK_UNKNOWN_CRITICAL,
    SPNG_EDUP_PLTE,
    SPNG_EDUP_CHRM,
    SPNG_EDUP_GAMA,
    SPNG_EDUP_ICCP,
    SPNG_EDUP_SBIT,
    SPNG_EDUP_SRGB,
    SPNG_EDUP_BKGD,
    SPNG_EDUP_HIST,
    SPNG_EDUP_TRNS,
    SPNG_EDUP_PHYS,
    SPNG_EDUP_TIME,
    SPNG_EDUP_OFFS,
    SPNG_EDUP_EXIF,
    SPNG_ECHRM,
    SPNG_EPLTE_IDX,
    SPNG_ETRNS_COLOR_TYPE,
    SPNG_ETRNS_NO_PLTE,
    SPNG_EGAMA,
    SPNG_EICCP_NAME,
    SPNG_EICCP_COMPRESSION_METHOD,
    SPNG_ESBIT,
    SPNG_ESRGB,
    SPNG_ETEXT,
    SPNG_ETEXT_KEYWORD,
    SPNG_EZTXT,
    SPNG_EZTXT_COMPRESSION_METHOD,
    SPNG_EITXT,
    SPNG_EITXT_COMPRESSION_FLAG,
    SPNG_EITXT_COMPRESSION_METHOD,
    SPNG_EITXT_LANG_TAG,
    SPNG_EITXT_TRANSLATED_KEY,
    SPNG_EBKGD_NO_PLTE,
    SPNG_EBKGD_PLTE_IDX,
    SPNG_EHIST_NO_PLTE,
    SPNG_EPHYS,
    SPNG_ESPLT_NAME,
    SPNG_ESPLT_DUP_NAME,
    SPNG_ESPLT_DEPTH,
    SPNG_ETIME,
    SPNG_EOFFS,
    SPNG_EEXIF,
    SPNG_EIDAT_TOO_SHORT,
    SPNG_EIDAT_STREAM,
    SPNG_EZLIB,
    SPNG_EFILTER,
    SPNG_EBUFSIZ,
    SPNG_EIO,
    SPNG_EOF,
    SPNG_EBUF_SET,
    SPNG_EBADSTATE,
    SPNG_EFMT,
    SPNG_EFLAGS,
    SPNG_ECHUNKAVAIL,
    SPNG_ENCODE_ONLY,
    SPNG_EOI,
    SPNG_ENOPLTE,
};

enum spng_text_type
{
    SPNG_TEXT = 1,
    SPNG_ZTXT = 2,
    SPNG_ITXT = 3
};

enum spng_color_type
{
    SPNG_COLOR_TYPE_GRAYSCALE = 0,
    SPNG_COLOR_TYPE_TRUECOLOR = 2,
    SPNG_COLOR_TYPE_INDEXED = 3,
    SPNG_COLOR_TYPE_GRAYSCALE_ALPHA = 4,
    SPNG_COLOR_TYPE_TRUECOLOR_ALPHA = 6
};

enum spng_filter
{
    SPNG_FILTER_NONE = 0,
    SPNG_FILTER_SUB = 1,
    SPNG_FILTER_UP = 2,
    SPNG_FILTER_AVERAGE = 3,
    SPNG_FILTER_PAETH = 4
};

enum spng_interlace_method
{
    SPNG_INTERLACE_NONE = 0,
    SPNG_INTERLACE_ADAM7 = 1
};

/* Channels are always in byte-order */
enum spng_format
{
    SPNG_FMT_RGBA8 = 1,
    SPNG_FMT_RGBA16 = 2,
    SPNG_FMT_RGB8 = 4,

    /* Partially implemented, see documentation */
    SPNG_FMT_GA8 = 16,
    SPNG_FMT_GA16 = 32,
    SPNG_FMT_G8 = 64,

    /* No conversion or scaling */
    SPNG_FMT_PNG = 256, /* host-endian */
    SPNG_FMT_RAW = 512  /* big-endian */
};

enum spng_ctx_flags
{
    SPNG_CTX_IGNORE_ADLER32 = 1 /* Ignore checksum in DEFLATE streams */
};

enum spng_decode_flags
{
    SPNG_DECODE_USE_TRNS = 1, /* Deprecated */
    SPNG_DECODE_USE_GAMA = 2, /* Deprecated */
    SPNG_DECODE_USE_SBIT = 8, /* Undocumented */

    SPNG_DECODE_TRNS = 1, /* Apply transparency */
    SPNG_DECODE_GAMMA = 2, /* Apply gamma correction */
    SPNG_DECODE_PROGRESSIVE = 256 /* Initialize for progressive reads */
};

enum spng_crc_action
{
    SPNG_CRC_ERROR = 0, /* Default */
    SPNG_CRC_DISCARD = 1, /* Discard chunk, invalid for critical chunks */
    SPNG_CRC_USE = 2 /* Ignore and don't calculate checksum */
};

struct spng_ihdr
{
    uint32_t width;
    uint32_t height;
    uint8_t bit_depth;
    uint8_t color_type;
    uint8_t compression_method;
    uint8_t filter_method;
    uint8_t interlace_method;
};

struct spng_plte_entry
{
    uint8_t red;
    uint8_t green;
    uint8_t blue;

    uint8_t alpha; /* Reserved for internal use */
};

struct spng_plte
{
    uint32_t n_entries;
    struct spng_plte_entry entries[256];
};

struct spng_trns
{
    uint16_t gray;

    uint16_t red;
    uint16_t green;
    uint16_t blue;

    uint32_t n_type3_entries;
    uint8_t type3_alpha[256];
};

struct spng_chrm_int
{
    uint32_t white_point_x;
    uint32_t white_point_y;
    uint32_t red_x;
    uint32_t red_y;
    uint32_t green_x;
    uint32_t green_y;
    uint32_t blue_x;
    uint32_t blue_y;
};

struct spng_chrm
{
    double white_point_x;
    double white_point_y;
    double red_x;
    double red_y;
    double green_x;
    double green_y;
    double blue_x;
    double blue_y;
};

struct spng_iccp
{
    char profile_name[80];
    size_t profile_len;
    char *profile;
};

struct spng_sbit
{
    uint8_t grayscale_bits;
    uint8_t red_bits;
    uint8_t green_bits;
    uint8_t blue_bits;
    uint8_t alpha_bits;
};

struct spng_text
{
    char keyword[80];
    int type;

    size_t length;
    char *text;

    uint8_t compression_flag; /* iTXt only */
    uint8_t compression_method; /* iTXt, ztXt only */
    char *language_tag; /* iTXt only */
    char *translated_keyword; /* iTXt only */
};

struct spng_bkgd
{
    uint16_t gray; /* Only for gray/gray alpha */
    uint16_t red;
    uint16_t green;
    uint16_t blue;
    uint16_t plte_index; /* Only for indexed color */
};

struct spng_hist
{
    uint16_t frequency[256];
};

struct spng_phys
{
    uint32_t ppu_x, ppu_y;
    uint8_t unit_specifier;
};

struct spng_splt_entry
{
    uint16_t red;
    uint16_t green;
    uint16_t blue;
    uint16_t alpha;
    uint16_t frequency;
};

struct spng_splt
{
    char name[80];
    uint8_t sample_depth;
    uint32_t n_entries;
    struct spng_splt_entry *entries;
};

struct spng_time
{
    uint16_t year;
    uint8_t month;
    uint8_t day;
    uint8_t hour;
    uint8_t minute;
    uint8_t second;
};

struct spng_offs
{
    int32_t x, y;
    uint8_t unit_specifier;
};

struct spng_exif
{
    size_t length;
    char *data;
};

struct spng_chunk
{
    size_t offset;
    uint32_t length;
    uint8_t type[4];
    uint32_t crc;
};

typedef void* spng_malloc_fn(size_t size);
typedef void* spng_realloc_fn(void* ptr, size_t size);
typedef void* spng_calloc_fn(size_t count, size_t size);
typedef void spng_free_fn(void* ptr);

struct spng_alloc
{
    spng_malloc_fn *malloc_fn;
    spng_realloc_fn *realloc_fn;
    spng_calloc_fn *calloc_fn;
    spng_free_fn *free_fn;
};

struct spng_row_info
{
    uint32_t scanline_idx;
    uint32_t row_num; /* deinterlaced row index */
    int pass;
    uint8_t filter;
};

typedef struct spng_ctx spng_ctx;

typedef int spng_read_fn(spng_ctx *ctx, void *user, void *dest, size_t length);

SPNG_API spng_ctx *spng_ctx_new(int flags);
SPNG_API spng_ctx *spng_ctx_new2(struct spng_alloc *alloc, int flags);
SPNG_API void spng_ctx_free(spng_ctx *ctx);

SPNG_API int spng_set_png_buffer(spng_ctx *ctx, const void *buf, size_t size);
SPNG_API int spng_set_png_stream(spng_ctx *ctx, spng_read_fn *read_fn, void *user);
SPNG_API int spng_set_png_file(spng_ctx *ctx, FILE *file);

SPNG_API int spng_set_image_limits(spng_ctx *ctx, uint32_t width, uint32_t height);
SPNG_API int spng_get_image_limits(spng_ctx *ctx, uint32_t *width, uint32_t *height);

SPNG_API int spng_set_chunk_limits(spng_ctx *ctx, size_t chunk_size, size_t cache_size);
SPNG_API int spng_get_chunk_limits(spng_ctx *ctx, size_t *chunk_size, size_t *cache_size);

SPNG_API int spng_set_crc_action(spng_ctx *ctx, int critical, int ancillary);

SPNG_API int spng_decoded_image_size(spng_ctx *ctx, int fmt, size_t *len);

/* Decode */
SPNG_API int spng_decode_image(spng_ctx *ctx, void *out, size_t len, int fmt, int flags);

/* Progressive decode */
SPNG_API int spng_decode_scanline(spng_ctx *ctx, void *out, size_t len);
SPNG_API int spng_decode_row(spng_ctx *ctx, void *out, size_t len);

SPNG_API int spng_get_row_info(spng_ctx *ctx, struct spng_row_info *row_info);

SPNG_API int spng_get_ihdr(spng_ctx *ctx, struct spng_ihdr *ihdr);
SPNG_API int spng_get_plte(spng_ctx *ctx, struct spng_plte *plte);
SPNG_API int spng_get_trns(spng_ctx *ctx, struct spng_trns *trns);
SPNG_API int spng_get_chrm(spng_ctx *ctx, struct spng_chrm *chrm);
SPNG_API int spng_get_chrm_int(spng_ctx *ctx, struct spng_chrm_int *chrm_int);
SPNG_API int spng_get_gama(spng_ctx *ctx, double *gamma);
SPNG_API int spng_get_iccp(spng_ctx *ctx, struct spng_iccp *iccp);
SPNG_API int spng_get_sbit(spng_ctx *ctx, struct spng_sbit *sbit);
SPNG_API int spng_get_srgb(spng_ctx *ctx, uint8_t *rendering_intent);
SPNG_API int spng_get_text(spng_ctx *ctx, struct spng_text *text, uint32_t *n_text);
SPNG_API int spng_get_bkgd(spng_ctx *ctx, struct spng_bkgd *bkgd);
SPNG_API int spng_get_hist(spng_ctx *ctx, struct spng_hist *hist);
SPNG_API int spng_get_phys(spng_ctx *ctx, struct spng_phys *phys);
SPNG_API int spng_get_splt(spng_ctx *ctx, struct spng_splt *splt, uint32_t *n_splt);
SPNG_API int spng_get_time(spng_ctx *ctx, struct spng_time *time);

/* Official extensions */
SPNG_API int spng_get_offs(spng_ctx *ctx, struct spng_offs *offs);
SPNG_API int spng_get_exif(spng_ctx *ctx, struct spng_exif *exif);


SPNG_API int spng_set_ihdr(spng_ctx *ctx, struct spng_ihdr *ihdr);
SPNG_API int spng_set_plte(spng_ctx *ctx, struct spng_plte *plte);
SPNG_API int spng_set_trns(spng_ctx *ctx, struct spng_trns *trns);
SPNG_API int spng_set_chrm(spng_ctx *ctx, struct spng_chrm *chrm);
SPNG_API int spng_set_chrm_int(spng_ctx *ctx, struct spng_chrm_int *chrm_int);
SPNG_API int spng_set_gama(spng_ctx *ctx, double gamma);
SPNG_API int spng_set_iccp(spng_ctx *ctx, struct spng_iccp *iccp);
SPNG_API int spng_set_sbit(spng_ctx *ctx, struct spng_sbit *sbit);
SPNG_API int spng_set_srgb(spng_ctx *ctx, uint8_t rendering_intent);
SPNG_API int spng_set_text(spng_ctx *ctx, struct spng_text *text, uint32_t n_text);
SPNG_API int spng_set_bkgd(spng_ctx *ctx, struct spng_bkgd *bkgd);
SPNG_API int spng_set_hist(spng_ctx *ctx, struct spng_hist *hist);
SPNG_API int spng_set_phys(spng_ctx *ctx, struct spng_phys *phys);
SPNG_API int spng_set_splt(spng_ctx *ctx, struct spng_splt *splt, uint32_t n_splt);
SPNG_API int spng_set_time(spng_ctx *ctx, struct spng_time *time);

/* Official extensions */
SPNG_API int spng_set_offs(spng_ctx *ctx, struct spng_offs *offs);
SPNG_API int spng_set_exif(spng_ctx *ctx, struct spng_exif *exif);

SPNG_API const char *spng_strerror(int err);
SPNG_API const char *spng_version_string(void);

#ifdef __cplusplus
}
#endif

#endif /* SPNG_H */
