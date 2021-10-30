#include <stdio.h>
#include <stdlib.h>
const int M = 3;
const int N = 4;
#define STACK_MAX_SIZE 12
#define STACK_OVERFLOW  -100
#define STACK_UNDERFLOW -101



typedef struct Stack_tag {
    int data[STACK_MAX_SIZE];
    int size;
} Stack_t;
 
void push(Stack_t *stack, int value) {
    if (stack->size >= STACK_MAX_SIZE) {
        exit(STACK_OVERFLOW);
    }
    stack->data[stack->size] = value;
    stack->size++;
}

int pop(Stack_t *stack) {
    if (stack->size == 0) {
        exit(STACK_UNDERFLOW);
    }
    stack->size--;
    return stack->data[stack->size];
}

void find_max_ind (Stack_t stack, int N, int* max_x, int* max_y) {
	int count = stack.size;
	int max, temp;
	max = pop(&stack);
	*max_x = count-1;
	while (stack.size) {
		count--;
        temp = pop(&stack);
		if (temp > max) {
            max = temp;
            *max_x = count-1;
        }
	}
	*max_y = *max_x % N;
    *max_x = *max_x / N;
}

int main() {
	int max_x, max_y;
	int mass[] = 
	{1000, 8, 30, 20,
	400, 20, 15, 6,
	6, 40, 12, 7};
	Stack_t my_stack;

	printf("1 Program Start\n");
	
	for (int i=0; i<M; i++){
		for (int j=0; j<N; j++) {
			push (&my_stack, mass[i*N+j]);
		}
	}
	printf("2 Array was pushed in stack\n");
	
    find_max_ind (my_stack, N, &max_x, &max_y);
	printf("Max = %d\nIndex: (%d, %d)", mass[max_x*N+max_y],max_x, max_y);

	return 0;
}
