
#define STACK_MAX_SIZE 4*3+2
typedef int T;


typedef struct Stack_tag {
    T data[STACK_MAX_SIZE];
    size_t size;
} Stack_t;

