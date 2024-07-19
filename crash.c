#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("Crashing the system...\n");
    system("echo c > /proc/sysrq-trigger");
    return 0;
}
