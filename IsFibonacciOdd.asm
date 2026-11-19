

.data
    n:      .word 10        # Input: nonnegative integer n (change value here to test)
    result: .word 0         # Output: 1 if True (nth Fibonacci is odd), 0 if False (even)

.text
.globl main

main:
    # Load n from memory into $a0
    la   $t0, n             # Load address of n
    lw   $a0, 0($t0)        # $a0 = n

    # Call IsFibonacciOdd(n)
    jal  IsFibonacciOdd

    # Store returned result ($v0) into memory at 'result'
    la   $t1, result        # Load address of result
    sw   $v0, 0($t1)        # Memory[result] = IsFibonacciOdd(n)

    # Exit program cleanly
    li   $v0, 10            # Syscall 10: exit
    syscall

# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
IsFibonacciOdd:
    # Save $ra on stack before calling helper functions
    addi $sp, $sp, -4
    sw   $ra, 0($sp)

    # Step 1: Compute nth Fibonacci number
    jal  fibonacci          # $v0 = Fibonacci(n)

    # Step 2: Check if Fibonacci(n) is odd
    move $a0, $v0           # Pass Fibonacci(n) as argument m to IsOdd(m)
    jal  IsOdd              # $v0 = 1 if odd, 0 if even

    # Restore $ra and return
    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra

# ------------------------------------------------------------------------------

fibonacci:
    # Base case: if n <= 1, return n
    li   $t0, 1
    ble  $a0, $t0, base_case

    # Initialize loop variables
    li   $t1, 0             # $t1 -> a = 0
    li   $t2, 1             # $t2 -> b = 1
    li   $t3, 0             # $t3 -> loop counter i = 0
    addi $t4, $a0, -1       # $t4 -> loop limit = n - 1

fib_loop:
    bge  $t3, $t4, end_loop # If i >= n - 1, exit loop
    move $t5, $t2           # temp = b
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

# ------------------------------------------------------------------------------

IsOdd:
    # Save return address ($ra) on stack since we call division(x, y)
    addi $sp, $sp, -4
    sw   $ra, 0($sp)

    # Set up arguments for division(m, 2)
    li   $a1, 2             # $a1 = 2 (y)
    jal  division           # Returns remainder in $v0

    # Check if remainder == 0
    beq  $v0, $zero, is_even

is_odd:
    li   $v0, 1             # Return True (1)
    j    end_IsOdd

is_even:
    li   $v0, 0             # Return False (0)

end_IsOdd:
    # Restore $ra and clean up stack
    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra

# ------------------------------------------------------------------------------
# Function: division(x, y) - Division by Repeated Subtractions (DRS)

division:
    li   $t0, 0             # $t0 -> quotient = 0

div_loop:
    blt  $a0, $a1, end_div  # While x >= y (exit if x < y)
    sub  $a0, $a0, $a1      # x = x - y
    addi $t0, $t0, 1        # quotient = quotient + 1
    j    div_loop

end_div:
    move $v0, $a0           # Return remainder x in $v0
    jr   $ra
