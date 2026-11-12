

.data
    n:      .word 10        
    result: .word 0        

.text
.globl main

main:
    # Load n from memory into $a0
    la   $t0, n             # Load address of n
    lw   $a0, 0($t0)        # $a0 = n

    # Call fibonacci(n)
    jal  fibonacci

    # Store returned result ($v0) into memory at 'result'
    la   $t1, result        # Load address of result
    sw   $v0, 0($t1)        # Memory[result] = fibonacci(n)

    # Exit program cleanly
    li   $v0, 10            # Syscall 10: exit
    syscall

# ------------------------------------------------------------------------------
# Function: fibonacci(n)
# Input:  $a0 = n (nonnegative integer)
# Output: $v0 = nth Fibonacci number
# Logic mirrors Figure 1:
#   if n <= 1: return n
#   a = 0, b = 1
#   for i in range(n - 1):
#       temp = b
#       b = a + b
#       a = temp
#   return b
# ------------------------------------------------------------------------------
fibonacci:
    
    li   $t0, 1
    ble  $a0, $t0, base_case

    # Initialize loop variables
    li   $t1, 0             # $t1 -> a = 0
    li   $t2, 1             # $t2 -> b = 1
    li   $t3, 0             # $t3 -> loop counter i = 0
    addi $t4, $a0, -1       # $t4 -> loop limit = n - 1

fib_loop:
    bge  $t3, $t4, end_loop # If i >= n - 1, exit loop
    move $t5, $t2           # temp = b ($t5 = temp)
    add  $t2, $t1, $t2      # b = a + b
    move $t1, $t5           # a = temp
    addi $t3, $t3, 1        # i = i + 1
    j    fib_loop

end_loop:
    move $v0, $t2           # Return b in $v0
    jr   $ra

base_case:
    move $v0, $a0           # Return n in $v0
    jr   $ra