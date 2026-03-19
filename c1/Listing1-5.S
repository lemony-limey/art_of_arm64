        #include "aoaa.inc"

        .data

title:  .asciz  "Listing 1-5"
saveLR: .dword  0  // Save LR here.
hwStr:  .asciz  "Hello, world!\n"

        .text

// The getTitle function, needed by 1-4.cpp, returns
// the name of this program (from the "title" string).
// The title string must appear in the .text section.

        .align  2       // Code must be 4-byte aligned

getTitle:
        lea     x0, title
        ret

// The main function called by 1-4.cpp

asmMain:

// LR is *highly* volatile and will be wiped out
// when this code calls the printf() function.
//
// We need to save LR in memory somewhere so we
// can return back to the OS using its value.
//
// For now, save it in the saveLR global variable:

        lea     x0, saveLR
        str     lr, [x0]

// Set up printf parameter (format string) and
// call printf().
//
// The bl (branch and link) instruction will
// take the address of the next function to
// be executed and will create a new frame
// on the stack.

        lea     x0, hwStr
        bl      printf

// After printf() has finished executing and control
// has been returned here, restore LR with its
// original value so we can return to the OS.

        lea     x0, saveLR
        ldr     lr, [x0]

// Return control to the OS

        ret