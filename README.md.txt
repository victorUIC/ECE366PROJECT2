# ECE 366 - Project 2: Progress Report 1 (Fibonacci)

## Team Information
* **Name:** Victor Munoz
* **NetID:** 659531649[Insert Your UIC NetID]
* **Contribution:** 100% (Solo submission — implemented `fibonacci.asm`, verified edge cases in MARS, and wrote documentation)
* **GitHub Repository:** [Paste Your GitHub Repo URL]

## How to Run the Program (MIPS MARS Simulator)
1. Open the **MARS MIPS Simulator** (`Mars4_5.jar`).
2. Go to **File > Open...** and select `fibonacci.asm`.
3. *(Optional)* To test a different input value for $n$, modify the `.word` value assigned to `n` under the `.data` section (line 5). Ensure n is a nonnegative integer.
4. Assemble the code by pressing **F3** (or clicking **Run > Assemble**).
5. Execute the program by pressing **F5** (or clicking **Run > Go**).
6. **Viewing the Result:**
   * Look at the **Data Segment** panel at the bottom of the Execute tab.
   * Address `0x10010000` holds the input value `n`.
   * Address `0x10010004` (`result`) holds the computed Fibonacci number 