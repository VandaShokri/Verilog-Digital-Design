# ⚡ Digital Electronics Laboratory: Verilog RTL Design

This repository contains Verilog HDL lab assignments focusing on the design, implementation, and simulation of combinatorial and sequential logic circuits. Each module includes a dedicated testbench to strictly verify circuit behavior and functionality.

### 🧩 Combinatorial Circuits (Lab EL02)

*   **Boolean Functions:** Modeled a 4-input, 1-output Boolean logic function that outputs a value of 1 only if at most two input bits are equal to 0. This behavior was implemented and simulated using both gate-level and dataflow descriptions.
*   **De Morgan's Theorem:** Designed modules to represent AND, OR, XOR, NAND, and NOR functions. This includes specialized implementations of a NAND gate utilizing OR and NOT logic, and a NOR gate utilizing AND and NOT logic to explicitly exploit De Morgan's theorem.
*   **Multiplexer Architecture:** Engineered a 4:1 Multiplexer (Mux 4:1) using three distinct modeling approaches: gate-level, dataflow, and behavioral.
*   **4-Bit Parallel Multiplier:** Constructed a 4-bit parallel multiplier by making appropriate use of multiple instances of a foundational base cell.

### 🔄 Sequential Circuits & FSMs (Lab EL03)

*   **Vending Machine FSM:** Designed a finite state machine modeling a vending machine that accepts four types of input coins (20c, 50c, €1, and €2) to dispense a single product priced at €2.50. The design process involved formalizing transitions, minimizing equivalent states, and encoding states using D flip-flops.
*   **Mealy & Moore Architectures:** Proposed and simulated Verilog implementations for both Mealy machines (where outputs are associated directly with the transition) and Moore machines (where outputs are associated with the state).
*   **Binary Sequence Arithmetic FSM:** Engineered Mealy and Moore state machines that take two binary strings as input, starting with the Most Significant Bit (MSB). The circuit produces an output of 1 if and only if the sum of the binary values received up to that moment is a multiple of 4, utilizing a finite number of states to process a potentially infinite input sequence.
