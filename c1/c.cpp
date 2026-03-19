#include <cerrno>
#include <cstdio>
#include <cstdlib>
#include <cstring>

// Extern "C" namespace prevents "name mangling" by the C++ compiler
extern "C"
{
    // asmMain is the assembly language code's "main program"
    void asmMain(void);

    /**
     * getTitle returns a pointer to a string of characters from the
     * assembly code that specifies the title of that program (that
     * makes this program generic and usable with a large number of sample
     * programs in "The Art of ARM Assembly Language"
     */
    char* getTitle(void);

    // C++ function that the assembly language program can call.
    int readLine(char* dest, int maxLen);
}

int readLine(char *dest, int maxLen)
{
    // NOTE: fgets() returns NULL if there was an error, otherwise
    // it returns a pointer to the string data read (which will be
    // the value of the dest pointer)
    char* result = fgets(dest, maxLen, stdin);
    if (result != NULL)
    {
        // Wipe out the newline character at the end of the string
        int len = strlen(result);
        if (len > 0)
        {
            dest[len - 1] = 0;
        }
        return len;
    }

    // This is only reached if an error has occurred.
    return -1;
}

int main()
{
    // Get the assembly language program's title:
    char* title = getTitle();

    printf("Calling: %s\n", title);
    asmMain();
    printf("%s terminated\n", title);
}
