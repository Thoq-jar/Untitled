#include <stdio.h>
#include <stdlib.h>

// This may cause problems, I am not responsible for any damage caused by this code.

int main() {
    printf("Crashing the system...\n");
    system("echo c > /proc/sysrq-trigger");
    system("sysctl debug.kdb.panic=1");
    return 0;
}
