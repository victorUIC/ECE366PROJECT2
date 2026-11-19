# ECE366PROJECT2

# ECE 366 - Project 2: Final Report (is fibonacci odd)

## Team Information
* **Name:** Victor Munoz
* **NetID:** 659531649
* **Contribution:** 100% (Solo submission — implemented `fibonacci.asm`, `isOdd.asm`, and `IsFibonacciOdd.asm`, verified edge cases in MARS, and wrote documentation)
* **GitHub Repository:** https://github.com/victorUIC/ECE366PROJECT2

## Repository Contents
* `IsFibonacciOdd.asm` — Top-level MIPS program that computes the $n^{\text{th}}$ Fibonacci number and checks whether it is odd using Division by Repeated Subtractions (DRS).
* `fibonacci.asm` — Part 1 standalone MIPS implementation of iterative `Fibonacci(n)`.
* `isOdd.asm` — Part 2 standalone MIPS implementation of `IsOdd(m)` using `division(m, 2)` via repeated subtractions.

## How to Run the Program (MIPS MARS Simulator)
1. Open the MARS MIPS Simulator.
2. Go to **File > Open...** and select `IsFibonacciOdd.asm`.
3. *(Optional)* To test a different input value for $n$, modify the `.word` value assigned to `n` under the `.data` section (line 7). Ensure $n$ is a nonnegative integer.
4. Assemble the code by pressing **F3** (or clicking **Run > Assemble**).
5. Execute the program by pressing **F5** (or clicking **Run > Go**).
6. **Viewing the Result:**
   * Look at the **Data Segment** panel at the bottom of the Execute tab (uncheck **Hexadecimal Values** to view in decimal).
   * Address `0x10010000` holds the input value `n`.
   * Address `0x10010004` (`result`) holds `1` (`True`) if the $n^{\text{th}}$ Fibonacci number is odd, or `0` (`False`) if it is even.
