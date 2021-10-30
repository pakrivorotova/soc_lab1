.data
N: 
.word 4 #number of columns
M:
.word 3 #number of rows
matrix:
.word 1, 8, 3, 2
.word 4, 20, 5, 6
.word 6, 4, 2, 7

result:
.word -1, -1

.text 
main:
la t0, M        # t0 = addr M
lw t4, 0(t0)    # t4 = M
la t0, N        # t0 = addr N
lw t2, 0(t0)    # t2 = N 
mul a1, t4, t2  # a1 = size of matrix

la a2, matrix       # a2 = address of first matrix
addi a3, x0, 4      
mul a3, a3, a1
add a3, a3, a2      # a3 = address of the end of matrix 
call push_matrix    # function of pushing matrix to the stack
addi sp, sp, -4     # shift stack pointer
sw t2, 0(sp)        # push N in the stack
addi sp, sp, -4     # shift stack pointer
sw t4, 0(sp)        # push M in the stack

call find_index_of_max  #call function

la t0, result       # load addr of first memory address of result 
sw a0, 0(t0)        # store index x of max element
addi t0, t0, 4      # move to next memory address of result
sw a1, 0(t0)        # store index y of max element
addi a3, t0, -4     # a3 = address of first result value

call print          # function to print result
call exit           # function to exit program

#Functions

push_matrix:
addi, sp, sp, -4        # move stack pointer to next mem addr
lw t0, 0(a2)            # t0 = current element of matrix
sw t0, 0(sp)            # store element of matrix in stack
addi a2, a2, 4          # a2 = addr of next element of matrix
bne a2, a3, push_matrix # if a2 not in the end of matrix then contine
ret                     # back to main funct

find_index_of_max:
lw t0, 0(sp)    # t0 - counter of rows from M to 0
addi sp, sp, 4  # move stack pointer to next element
lw t6, 0(sp)    # t6 - counter of colunms from N to 0
add t2, x0, t6  # t2 = N (save N value to restore for each new column) 
addi sp, sp, 4  # move stack pointer to next element
    #at a0 and a1 will be resulted indexes x and y
addi a0, t0, -1  # a0 = M-1 - index_x of last matrix element
addi a1, t6, -1  # a1 = N-1 - index_y of last matrix element
addi t6, t6, -1  # t6 = N-1 - next column
beq x0, t6, next_row    # if colunm number is 0 than change row number

cycle_row:
lw t4, 0(sp)            # t4 = max value, sp on the same place
addi sp, sp, 4          # move stack pointer to next element
lw t5, 0(sp)            # t5 = current value
    #check if t5>t4
bge t5, t4, change_ind  # if current > max value, change index
sw t4, 0(sp)            # push max (t4)
addi t6, t6, -1         # t6 = next column 
bne x0, t6, cycle_row
next_row:
addi t0, t0, -1         # t0 = number of next row
add t6, t2, x0          # t6 = N
blt x0, t0, cycle_row   # if t > 0 continue  
ret

change_ind:
mv a0, t0               # a0 = current row
addi a0, a0, -1         # a0 = index of current row
mv a1, t6               # a1 = current column
addi a1, a1, -1         # a1 = index of current column
sw t5, 0(sp)            # push max (t5)
addi t6, t6, -1         # t6 = next column 
bne x0, t6, cycle_row   # if current column is not 0 than continue row
beq x0, t6, next_row    # if current column is 0 than move to next row

print:
addi a0, x0, 1  # print_int ecall
lw a1, 0(a3)    # load to a1 value from first address of result (index x)
ecall           # printing index x
addi a3, a3, 4  # move to the next address of result
lw a1, 0(a3)    # load to a1 index y
ecall           # printing
ret             # back to main function

exit:
addi a0, x0, 10 # exit ecall
ecall           # exit