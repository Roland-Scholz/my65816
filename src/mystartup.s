/****************************************************************************
 *
 * Copyright Håkan Thörngren
 *
 * This file is part of the Calypsi C library.
 * Permission to use with the Calypsi tool chain is hereby granted.
 *
 ****************************************************************************/

;;; Startup variant, change attribute value if you make your own
              .rtmodel cstartup,"normal"

              .rtmodel version, "1"
              .rtmodel cpu, "*"

              .section stack
              .section cstack
              .section heap
              .section data_init_table

              .extern main, exit
              .extern _Dp, _Vfp
              .extern _DirectPageStart

#ifndef __CALYPSI_DATA_MODEL_SMALL__
              .extern _NearBaseAddress
#endif

#include "macros.h"

;;; ***************************************************************************
;;;
;;; The reset vector. This uses the entry point label __program_root_section
;;; which by default is what the linker will pull in first.
;;;
;;; ***************************************************************************

                 .section reset
                 .pubweak __program_root_section
__program_root_section:
                 .word   __program_start

;;; ***************************************************************************
;;;
;;; __program_start - actual start point of the program
;;;
;;; Set up CPU stack, initialize sections and call main().
;;; You can override this with your own routine, or tailor it as needed.
;;; The easiest way to make custom initialization is to provide your own
;;; __low_level_init which gets called after stacks have been initialized.
;;;
;;; ***************************************************************************

#ifdef __CALYPSI_CODE_MODEL_COMPACT__
              .section compactcode, noreorder
#else
              .section code, noreorder
#endif
              .pubweak __program_start
__program_start:
              clc
              xce                   ; native 16-bit mode
              rep     #0x38         ; 16-bit registers, no decimal mode
              ldx     ##.sectionEnd stack
              txs                   ; set stack
              lda     ##_DirectPageStart
              tcd                   ; set direct page
#ifdef __CALYPSI_DATA_MODEL_SMALL__
              lda     ##0
#else
              lda     ##.word2 _NearBaseAddress
#endif
              stz     dp:.tiny(_Vfp+2)
              xba                   ; A upper half = data bank
              pha
              plb                   ; pop 8 dummy
              plb                   ; set data bank

#ifdef  __CALYPSI_CODE_MODEL_COMPACT__
              jmp     long:_Trampoline_program_start
              .section compactcode, noreorder
_Trampoline_program_start:
#define CODE compactcode
#else
#define CODE code
#endif
              call    __low_level_init

;;; **** Initialize data sections if needed.
              .section CODE, noroot, noreorder
              .pubweak __data_initialization_needed
              .extern __initialize_sections
__data_initialization_needed:
              lda     ##.word2 (.sectionEnd data_init_table)
              sta     dp:.tiny(_Dp+6)
              lda     ##.word0 (.sectionEnd data_init_table)
              sta     dp:.tiny(_Dp+4)
              lda     ##.word2 (.sectionStart data_init_table)
              sta     dp:.tiny(_Dp+2)
              lda     ##.word0 (.sectionStart data_init_table)
              sta     dp:.tiny(_Dp+0)
              call    __initialize_sections

;;; **** Initialize streams if needed.
              .section CODE, noroot, noreorder
              .pubweak __call_initialize_global_streams
              .extern __initialize_global_streams
__call_initialize_global_streams:
              call    __initialize_global_streams

;;; **** Initialize heap if needed.
              .section CODE, noroot, noreorder
              .pubweak __call_heap_initialize
              .extern __heap_initialize, __default_heap
__call_heap_initialize:
#ifdef __CALYPSI_DATA_MODEL_SMALL__
              lda     ##.sectionSize heap
              sta     dp:.tiny(_Dp+2)
              lda     ##.sectionStart heap
              sta     dp:.tiny(_Dp+0)
              lda     ##__default_heap
#else
              lda     ##.word2 (.sectionStart heap)
              sta     dp:.tiny(_Dp+6)
              lda     ##.word0 (.sectionStart heap)
              sta     dp:.tiny(_Dp+4)
              lda     ##.word2 __default_heap
              sta     dp:.tiny(_Dp+2)
              lda     ##.word0 __default_heap
              sta     dp:.tiny(_Dp+0)
              ldx     ##.word2 (.sectionSize heap)
              lda     ##.word0 (.sectionSize heap)
#endif
              call    __heap_initialize

              .section CODE, root, noreorder
              lda     ##0           ; argc = 0
              call    main
              jump    exit

;;; ***************************************************************************
;;;
;;; __low_level_init - custom low level initialization
;;;
;;; This default routine just returns doing nothing. You can provide your own
;;; routine, either in C or assembly for doing custom low leve initialization.
;;;
;;; ***************************************************************************

              .section libcode
              .pubweak __low_level_init
__low_level_init:
              return
