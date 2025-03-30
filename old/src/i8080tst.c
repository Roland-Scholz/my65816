// This file uses the 8080 emulator to run the test suite (roms in cpu_tests
// directory). It uses a simple array as memory.

void *heap_start = ( void * )0x10000;
void *heap_end = (void * )0xfffff;
extern unsigned char fd2iocb[8];


//#include <stdio.h>
#include <stdlib.h>
//#include <string.h>
//#include <time.h>

#include "i8080.h"
#include "homebrew.h"

// memory callbacks
#define MEMORY_SIZE 0xF000
static uint8_t* memory = NULL;
static bool test_finished = 0;

static uint8_t rb(void* userdata, uint16_t addr) {
  return memory[addr];
}

static void wb(void* userdata, uint16_t addr, uint8_t val) {
  memory[addr] = val;
}

static uint8_t port_in(void* userdata, uint8_t port) {
  return 0x00;
}

static void port_out(void* userdata, uint8_t port, uint8_t value) {
  i8080* const c = (i8080*) userdata;

  if (port == 0) {
    test_finished = 1;
  } else if (port == 1) {
    uint8_t operation = c->c;

    if (operation == 2) { // print a character stored in E
      printf("%c", c->e);
    } else if (operation == 9) { // print from memory at (DE) until '$' char
      uint16_t addr = (c->d << 8) | c->e;
      do {
        printf("%c", rb(c, addr++));
      } while (rb(c, addr) != '$');
    }
  }
  fflush(stdin);
}

int load_file(const char* filename, uint16_t addr) {
  size_t result;
  FILE* f;
  size_t file_size;
  
  f = fopen(filename, "rb");
  if (f == NULL) {
    fprintf(stderr, "error: can't open file '%s'.\n", filename);
    return 1;
  }

  // file size check:
  /*
  fseek(f, 0, SEEK_END);
  file_size = ftell(f);
  rewind(f);

  if (file_size + addr >= MEMORY_SIZE) {
    fprintf(stderr, "error: file %s can't fit in memory.\n", filename);
    return 1;
  }
*/

  // copying the bytes in memory:
  result = fread(&memory[addr], sizeof(uint8_t), 0xffff/*file_size*/, f);
  /*
  if (result != file_size) {
    fprintf(stderr, "error: while reading file '%s'\n", filename);
    return 1;
  }
*/
  //printf("site_t: %d, file len: %d\n", sizeof(size_t), result); 
  fclose(f);
  return 0;
}

void run_test(
    i8080* const c, const char* filename, unsigned long cyc_expected) {
  long nb_instructions;		
  long diff;
  
  //printf("r_t 1\n");
  
  i8080_init(c);
  c->userdata = c;
  c->read_byte = rb;
  c->write_byte = wb;
  c->port_in = port_in;
  c->port_out = port_out;
  memset(memory, 0, MEMORY_SIZE);

  //printf("r_t 2\n");
  if (load_file(filename, 0x100) != 0) {
    return;
  }
  printf("*** TEST: %s\n", filename);

  c->pc = 0x100;

  // inject "out 0,a" at 0x0000 (signal to stop the test)
  memory[0x0000] = 0xD3;
  memory[0x0001] = 0x00;

  // inject "out 1,a" at 0x0005 (signal to output some characters)
  memory[0x0005] = 0xD3;
  memory[0x0006] = 0x01;
  memory[0x0007] = 0xC9;

  nb_instructions = 0;

  test_finished = 0;
  while (!test_finished) {
    nb_instructions += 1;

    // uncomment following line to have a debug output of machine state
    // warning: will output multiple GB of data for the whole test suite
    //i8080_debug_output(c, true);

    i8080_step(c);
  }

/*
  long long diff = cyc_expected - c->cyc;
  diff = cyc_expected - c->cyc;
  printf("\n*** %lu instructions executed on %lu cycles"
         " (expected=%lu, diff=%lld)\n\n",
      nb_instructions, c->cyc, cyc_expected, diff);
*/
  printf("*** Test finished ***\n");
}

int main(int argc, char**argv) {
  i8080 cpu;
  
  fd2iocb[0] = 0;
  fd2iocb[1] = 0;
  fd2iocb[2] = 0;
  fd2iocb[3] = 0xff;
  fd2iocb[4] = 0xff;
  fd2iocb[5] = 0xff;
  fd2iocb[6] = 0xff;
  fd2iocb[7] = 0xff; 
  setvbuf(stdin, NULL, _IONBF, 1);

  memory = malloc(MEMORY_SIZE);
  if (memory == NULL) {
    return 1;
  }

  
  run_test(&cpu, "D:TST8080.COM", 4924LU);
  //run_test(&cpu, "D:CPUTEST.COM", 4924LU);
  /*
  run_test(&cpu, "cpu_tests/CPUTEST.COM", 255653383LU);
  run_test(&cpu, "cpu_tests/8080PRE.COM", 7817LU);
  run_test(&cpu, "cpu_tests/8080EXM.COM", 23803381171LU);
  */
  free(memory);

  return 0;
}