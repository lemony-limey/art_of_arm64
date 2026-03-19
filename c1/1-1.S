// .text says that the statements following this directive go in the sections
// of memory reserved for machine instructions (code).
.text

// The main function, which is the entry point of this program.
// _main needed for macOS, but not for Linux.
// .global makes the _main symbol visible outside of this source file, which is necessary
// so that the linker can produce an executable.
.global _main, main

// .align 2 tells the assembler to align the following code to a 4 byte boundary (32 bits).
// The 2 here is for the power that 2 should be raised to (i.e., 2^2).
// If it was .align 4, is would be (2^4, which is 8, so would align to an 8-byte/64 bit boundary).
// ARM CPUs require instructions to be aligned on 4-byte/32-bit boundaries.
.align 2

// The actual main program, that simply returns control to the OS.
_main:
main:
    ret
