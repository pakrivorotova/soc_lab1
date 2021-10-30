#include <stdio.h>
#include <stdlib.h>
const int M = 3;
const int N = 4;
#define STACK_MAX_SIZE 12
#define STACK_OVERFLOW  -100
#define STACK_UNDERFLOW -101

// Structure of stack
typedef struct Stack_tag {
    int data[STACK_MAX_SIZE];
    int size;
} Stack_t;

// Function for adding values to stack 
void push (Stack_t *stack, int value) {
    if (stack -> size >= STACK_MAX_SIZE) {
        exit (STACK_OVERFLOW);
    }
    stack -> data[stack -> size] = value;
    stack -> size++;
}

// Function for adding values to stack 
int pop(Stack_t *stack) {
    if (stack -> size == 0) {
        exit(STACK_UNDERFLOW);
    }
    stack -> size--;
    return stack -> data[stack -> size];
}

// Function for searching for indexes of max element of array
void find_max_ind (Stack_t stack, int N, int* max_x, int* max_y) {
	int count = stack.size;		// Count = number of last element of array in stack
	int max, temp;				// max value in array, temporary value
	max = pop (&stack);			// max = last element of array
	*max_x = count-1;			// max_x = index of max element in stack (not in array!)
	
	// cycle for all array elements in stack from last to the first elements of array:
	while (stack.size) {
		count--;			// number of next element in stack
        temp = pop(&stack);	// next element from stack
		if (temp > max) {	// if temporary element is bigger than max
            max = temp;		// save temp as max
            *max_x = count-1;	//save max index in stack as max_x 
        }
	}
	*max_y = *max_x % N;	// Count index y as remainder of division index in stack by N
    *max_x = *max_x / N;	// Count index y as rthe whole part of the division index in stack by N
}

int main() {
	int max_x, max_y;	// indexes x and y of max element
	int mass[] = 		// array with data
	{1, 8, 3, 2,
	4, 2, 5, 6,
	6, 4, 2, 7};
	Stack_t my_stack;	// Initiation of stack

	printf("1. Program Start\n");

	// Push array elements to stack (last element will be on the top of stack)
	for (int i=0; i<M; i++){
		for (int j=0; j<N; j++) {
			push (&my_stack, mass[i*N+j]);
		}
	}
	printf("2. Array was pushed in stack\n");
	
	// Call function to find indexes x and y of max element in array
    find_max_ind (my_stack, N, &max_x, &max_y);

	// Results output
	printf("Index of max element: (%d, %d)", max_x, max_y);

	return 0;
}
