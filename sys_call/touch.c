#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <sys/stat.h>

/*
 * touch: A basic implementation of the 'touch' utility.
 *
 * This program creates a new, empty file if it doesn't exist.
 * If the file already exists, it simply opens and closes it, which
 * may update the access time on some systems.
 *
 * Usage:
 * ./touch <filename>
 *
 * The program expects exactly one command-line argument: the name of the file.
 * Supports -c flag to not create a file if it does not exist.
 */
int main(int argc, char *argv[])
{
    // 1. Check for correct number of arguments.
    // The program name is argv[0], so we expect one more argument (the filename).
    int no_create = 0;
    char *filepath;

    if (argc < 2 || argc > 3)
    {
        fprintf(stderr, "Usage: %s [-c] <filename>\n", argv[0]);
        return 1; // Return an error code.
    }

    // Handle -c flag
    if (argc == 3)
    {
        if (strcmp(argv[1], "-c") == 0)
        {
            no_create = 1;
            filepath = argv[2];
        }
        else
        {
            fprintf(stderr, "Unknown option: %s\n", argv[1]);
            return 1;
        }
    }
    else
    {
        filepath = argv[1];
    }

    int fd; // File descriptor

    // 2. Try to open the file.
    if (no_create)
    {
        // Check if file exists
        if (access(filepath, F_OK) != 0)
        {
            // File does not exist, do nothing
            printf("File '%s' does not exist, not created due to -c flag.\n", filepath);
            return 0;
        }
        fd = open(filepath, O_WRONLY | O_APPEND);
    }
    else
    {
        fd = open(filepath, O_WRONLY | O_CREAT | O_APPEND, 0644);
    }

    // 3. Check if the file opening was successful.
    if (fd == -1)
    {
        perror("Error opening file"); // perror prints the error message from the system.
        return 1;
    }

    // 4. Close the file descriptor as we are done with it.
    if (close(fd) == -1)
    {
        perror("Error closing file");
        return 1;
    }

    // 5. If everything was successful, print a success message.
    printf("Successfully touched '%s'\n", filepath);

    return 0; // Success!
}
