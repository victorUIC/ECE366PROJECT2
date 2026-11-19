# ECE 366: Computer Organization - Project 2 (Part 2: IsOdd)
# Computes whether a nonnegative integer m is odd using Division by Repeated Subtractions.
# Stores 1 (True) if odd, 0 (False) if even into memory.

.data
    m:      .word 34        # Input: nonnegative integer m (change value here to test)
    result: .word 0         # Output: 1 if True (odd), 0 if False (even)

.text
.globl main

main:
    # Load m from memory into $a0
    la   $t0, m             # Load address of m
    lw   $a0, 0($t0)        # $a0 = m

    # Call IsOdd(m)
    jal  IsOdd

    # Store returned result ($v0) into memory at 'result'
    la   $t1, result        # Load address of result
    sw   $v0, 0($t1)        # Memory[result] = IsOdd(m)

    # Exit program cleanly
    li   $v0, 10            # Syscall 10: exit
    syscall

# ------------------------------------------------------------------------------
# Function: IsOdd(m)
# Input:  $a0 = m (nonnegative integer)
# Output: $v0 = 1 if odd (True), 0 if even (False)
# Logic mirrors Figure 2:
#   remainder = 0
#   remainder = division(m, 2)
#   if remainder == 0: return False (0)
#   else: return True (1)
# ------------------------------------------------------------------------------
IsOdd:
    # Save return address ($ra) on stack since we call division(x, y)
    addi $sp, $sp, -4
    sw   $ra, 0($sp)

    # Set up arguments for division(m, 2)
    # $a0 already holds m (x)
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
# Input:  $a0 = x (dividend), $a1 = y (divisor)
# Output: $v0 = remainder (x % y)
# Logic mirrors Figure 3:
#   quotient = 0
#   while x >= y:
#       x = x - y
#       quotient = quotient + 1
#   return x
# ------------------------------------------------------------------------------
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
