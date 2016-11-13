ASM := nasm -f elf64
CC := gcc
CFLAGS := -Wall -Wextra --std=c99
CFLAGopt := -Wall -O3 -Wextra --std=c99
LINK := gcc -l


%.o: %.asm
	$(ASM) $< -o $@

%.o: %.c
	$(CC) -c $(CFLAGopt) $< -o $@
	
sha256: sha256.c process_block_c.o process_block_asm.o process_block_simd.o process_block_simd_stitch.o utils.o
	$(CC) $(CFLAGS) sha256.c process_block_c.o process_block_asm.o process_block_simd.o process_block_simd_stitch.o utils.o -o sha256

all: sha256

clean:
	rm *.o
