// This file uses the 8080 emulator to run the test suite (roms in cpu_tests
// directory). It uses a simple array as memory.

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "i8080.h"
#include "homebrew.h"


// memory callbacks
#define MEMORY_SIZE 0x10000
#define DISK_SIZE 256256

static uint8_t* memory = NULL;
static uint8_t* disk = NULL;
static size_t disk_size;


static bool test_finished = 0;
static bool debug = 0;

#include "i8080.c"

static uint8_t rb(void* userdata, uint16_t addr) {
  return memory[addr];
}

static void wb(void* userdata, uint16_t addr, uint8_t val) {
  memory[addr] = val;
}

static uint8_t port_in(void* userdata, uint8_t port) {
	
  uint8_t *srcp, *dstp;
  unsigned int offset;
  unsigned long diskoff;
  
  if (debug) debugf("port_in $%02X\n", (long)port);
  
#define TRACK 0xFB4B

  switch (port) {
  case 1:
    return getchar();
	break;
  case 2:
	if (debug) debugf("read  disk:%d track:%d sec:%d dma:%02X%02X\n", (long)memory[TRACK+6], (long)memory[TRACK], (long)memory[TRACK+2], (long)memory[TRACK+5], (long)memory[TRACK+4]);
  
  diskoff = ((long)memory[TRACK] * 26 + (long)memory[TRACK+2]) << 7;
  if (debug) debugf("disk offset: %08X\n", diskoff);
  
  srcp = &disk[diskoff];
  
  offset = (memory[TRACK+5] << 8) + memory[TRACK+4];
  dstp = (uint8_t*) &memory[offset];
 
  if (debug) debugf("srcp: %08X, dstp: %08X\n", srcp, dstp);
  memcpy(dstp, srcp, 128);
/*
FB65		track:	ds	2		;two bytes for expansion
FB67		sector:	ds	2		;two bytes for expansion
FB69		dmaad:	ds	2		;direct memory address
FB6B		diskno:	ds	1		;disk number 0-15
*/
	break;

  default:
	return 0x00;
  }
}

static void cpm_port_out(void* userdata, uint8_t port, uint8_t value) {
  uint8_t *srcp, *dstp;
  unsigned int offset;
  unsigned long diskoff;
  i8080* const c = (i8080*) userdata;
  
   
  /*if (debug)*/ debugf("port_out $%02X, data %02X, PC: %04X\n", (long)port, (long)value, (long)c->pc);
  
  switch (port) {
  case 0:
	break;
  case 1:
	if (value != 0x0d && value != 0x07) printf("%c", value);
	//fflush(stdout);
	break;
  case 2:
	if (debug) debugf("write disk:%d track:%d sec:%d dma:%02X%02X\n", (long)memory[TRACK+6], (long)memory[TRACK], (long)memory[TRACK+2], (long)memory[TRACK+5], (long)memory[TRACK+4]);
  
	diskoff = ((long)memory[TRACK] * 26 + (long)memory[TRACK+2]) << 7;
	debugf("disk offset: %08X\n", diskoff);
	
	dstp = &disk[diskoff];
	
	offset = (memory[TRACK+5] << 8) + memory[TRACK+4];
	srcp = (uint8_t*) &memory[offset];
	
	if (debug) debugf("srcp: %08X, dstp: %08X\n", srcp, dstp);
	memcpy(dstp, srcp, 128);
	break;
  case 0xff:
	//printf("exit called\n");
	test_finished = 1;
	break;
  default:
	break;
  }
  
  /*
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
  }*/
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
  fflush(stdout);
}

uint8_t *load_disk(const char* filename) {
  FILE* f;
  
  printf("loading disk: %s ", filename);
  f = fopen(filename, "rb");
  if (f == NULL) {
    printf("error: can't open file '%s'.\n", filename);
    return NULL;
  }

  disk = (uint8_t *)malloc(DISK_SIZE);
  if (!disk) {
    printf("can't alloc disk memory\n");
	return NULL;
  }
  
  disk_size = read(fileno(f), disk, 0xffffff);
  printf("loaded %lu bytes at %p\n", disk_size, disk); 
  fclose(f);
  
  return disk;
}

void save_disk(const char* filename) {
  FILE* f;
  
  printf("saving %s size: %lu ", filename, disk_size);
  f = fopen(filename, "wb");
  if (f == NULL) {
    printf("error: can't open file '%s'.\n", filename);
    return;
  }
  
  disk_size = fwrite(disk, 1, disk_size, f);
  
  printf("saved %lu bytes from %p\n", disk_size, disk); 
  fclose(f);
  
  return;
}


int load_file(const char* filename, uint16_t addr) {
  size_t result;
  FILE* f;
  size_t file_size;
  
  printf("loading cpm: %s\n", filename);
  
  f = fopen(filename, "rb");
  if (f == NULL) {
    fprintf(stderr, "error: can't open file '%s'.\n", filename);
    return 1;
  }

  result = read(fileno(f), &memory[addr], 0x10000);

  //result = fread(&memory[addr], sizeof(uint8_t), 0xffff/*file_size*/, f);

  printf("loaded %lu bytes at %p\n", result, &memory[addr]); 
  fclose(f);
  
  return 0;
}

void run_test(i8080* const c, const char* filename, char *diskname) {
	  
  //long nb_instructions;		
  //long diff;
  
  //printf("r_t 1\n");
  
  i8080_init(c);
  c->userdata = c;
  c->read_byte = rb;
  c->write_byte = wb;
  c->port_in = port_in;
  c->port_out = cpm_port_out;
  memset(memory, 0, MEMORY_SIZE);

  if (load_file(filename, 0x000) != 0) {
    return;
  }

  if (load_disk(diskname) == NULL) {
	  return;
  }
  
  c->pc = 0x000;

  //nb_instructions = 0;

  test_finished = 0;
  //debug = 1;
  while (!test_finished) {
    //nb_instructions += 1;

    // uncomment following line to have a debug output of machine state
    // warning: will output multiple GB of data for the whole test suite
    //if (debug) i8080_debug_output(c, true);
    i8080_step(c);
	
	//if (c->pc == 0x0100) debug = 1; 
  }

/*
  long long diff = cyc_expected - c->cyc;
  diff = cyc_expected - c->cyc;
  printf("\n*** %lu instructions executed on %lu cycles"
         " (expected=%lu, diff=%lld)\n\n",
      nb_instructions, c->cyc, cyc_expected, diff);
*/

  save_disk(diskname);
  printf("*** Test finished ***\n");
  
  
}

int main(int argc, char**argv) {
  i8080 cpu;
  char fname[20];
  
  if (argc >1) {
	  strcpy(fname, argv[1]);
  } else {
	  strcpy(fname, "d:disk0.dsk");
  }
  
  memory = malloc(MEMORY_SIZE);
  if (memory == NULL) {
	printf("can't allocate memory!\n");
    return 1;
  }

  
  run_test(&cpu, "D:CPM22.SYS", fname);
 
  free(memory);
  free(disk);

  return 0;
}