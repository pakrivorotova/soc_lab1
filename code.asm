test_travel_zone@mail.com
.data
N: 
.word 3 #number of columns
M:
.word 1 #number of rows
matrix:
.word 1, 8, 3, 2
.word 4, 2, 5, 6
.word 6, 4, 2, 7

result:
.word 0
.text

main:
la t0, M
lw t4, 0(t0)    #t4 = M
la t0, N
lw t2, 0(t0)    #t2 = N 
mul a1, t4, t2  #a1 = size of matrix

la a2, matrix  
addi a3, x0, 4
mul a3, a3, a1
add a3, a3, a2 #addr of the end of matrix 
call push_matrix #function of pushing matrix to the stack
addi sp, sp, -4 #shift stack pointer
sw t2, 0(sp)    #push N in the stack
addi sp, sp, -4 #shift stack pointer
sw t4, 0(sp)    #push M in the stack


call find_index_of_max


call print
call exit

###################################
push_matrix:
addi, sp, sp, -4
lw t0, 0(a2)
sw t0, 0(sp)
addi a2, a2, 4
#lw a0, 0(sp)
bne a2, a3, push_matrix
ret

###################################

###################################
find_index_of_max:
lw t0, 0(sp)    #t0 = M
addi sp, sp, 4
lw t6, 0(sp)    #t6 = N
addi sp, sp, 4
###mul t3, t0, t1  #t3 = size of matrix
add a0, x0, t0  #a0 = index_x (number of row)
add a1, x0, t6  #a1 = index_y (number of column)

call cycle_row
ret

cycle_row:
addi t6, t6, -1  #N = N-1
bge x0, t6, next_row
lw t4, 0(sp)    #t4 = max value, sp on the same place
addi sp, sp, 4
lw t5, 0(sp)    #t5 = next value
#check if t5>t4
bge t5, t4, change_ind
sw t4, 0(sp)    #push max (t4)
jal cycle_row

change_ind:
mv a0, t0   #a0 = M
addi a0, a0, -1
mv a1, t6   #a1 = N
addi a1, a1, -1
sw t5, 0(sp)    #push max (t5)
jal cycle_row


next_row:
addi t0, t0, -1
blt x0, t6, cycle_row
ret
#jal cycle_row

###################################

print:
lw t1, 0(a2)

addi t2, x0, 0
print_cycle:
addi a0, x0, 1 # print_int ecall
lw a1, 0(a3)
ecall

addi a0, x0, 11 # print_char ecall
addi a1, x0, 32
ecall

addi t2, t2, 1
addi a3, a3, 4
blt t2, t1, print_cycle
ret

exit:
addi a0, x0, 10
ecall

process:
lw t1, 0(a2) # N
lw t2, 0(a3) # M

addi t4, x0, 0 # row pointer

init:
addi t5, x0, 0 # result to save
addi t3, x0, 0 # row element number

cycle:
lw t6, 0(a4) # load value from array
addi a4, a4, 4 # increment array pointer
add t5, t5, t6 # count sum
addi t3, t3, 1
blt t3, t1, cycle
sw t5, 0(a5) # save result to resulting array
addi a5, a5, 4
addi t4, t4, 1
blt t4, t2, init
ret