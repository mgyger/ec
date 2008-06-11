#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#ifndef _WIN32
#  include <unistd.h>
#  ifndef O_BINARY
#    define O_BINARY 0
#  endif
#else
#  include <io.h>
#endif

static int status = EXIT_SUCCESS;

static void error(const char *fmt, const char *arg)
{
    fprintf(stderr, fmt, arg);
    exit(EXIT_FAILURE);
}

static int word(int fd)
{
    unsigned char buf[2];
    if (read(fd, buf, sizeof buf) != sizeof buf)
        error("read error\n", NULL);
    return buf[0] << 8 | buf[1];
}

static void print(int a, int o, int n)
{
    n = -n & 0xffff;
    printf("checksum at: 0x%05x\n"
           "  calculated: 0x%04x%s\n"
           "  stored:     0x%04x\n\n",
           a, n, (n != o ? " *" : ""), o);
    if (n != o) status = EXIT_FAILURE;
}

int main(int argc, char* argv[])
{
    int i, osum, sum, fd;
    if (argc != 2) error("usage: %s <ROM-image>\n", argv[0]);
    fd = open(argv[1], O_RDONLY | O_BINARY);
    if (fd < 0) error("cannot open '%s'\n", argv[1]);

    for (sum = 0, i = 0; i < 0x400 - 2; i += 2) sum += word(fd);
    print(i, word(fd), sum);

    osum = word(fd);
    for (sum = 0, i += 4; i < 0x1000; i += 2) sum += word(fd);
    print(0x400, osum, sum);

    for (sum = 0; i < 0x20000 - 2; i += 2) sum += word(fd);
    print(i, word(fd), sum);

    if (read(fd, &osum, 1) == 1) error("%s: incorrect length\n", argv[1]);
    if (status == EXIT_FAILURE) error("%s: incorrect checksum(s)\n", argv[1]);
    return status;
}
