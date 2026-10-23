// ===================================================
// EXERCISE 3: Parallel Multiplier
// ===================================================

// ---------------------------------------------------
// Module 1: Multiplier Base Cell
// (AND Gate + Full Adder)
// ---------------------------------------------------
module mult_cell (
    input wire x,      // Multiplier bit
    input wire y,      // Multiplicand bit
    input wire sin,    // Sum from the upper row
    input wire cin,    // Carry from the right
    output wire sout,  // Sum to the lower row
    output wire cout   // Carry to the left
);

    wire p; // Partial product
    
    // Partial product generation (1 bit x 1 bit)
    assign p = x & y;
    
    // Full Adder logic
    assign {cout, sout} = p + sin + cin;

endmodule

// ---------------------------------------------------
// Module 2: 3x3 Parallel Multiplier (Top-Level)
// ---------------------------------------------------
module mult_3x3 (
    input wire [2:0] a, // Multiplicand (3 bits)
    input wire [2:0] b, // Multiplier (3 bits)
    output wire [5:0] p // Final product (6 bits)
);

    // Internal wires for cell interconnection
    // Naming convention: s(row)(col) and c(row)(col)
    wire s01, s02, s11, s12;
    wire c00, c01, c02, c10, c11, c12, c20, c21;

    // --- ROW 0 (Multiply by b[0]) ---
    // In the first row, there are no sums coming from above (sin = 0).
    mult_cell u00 (.x(a[0]), .y(b[0]), .sin(1'b0), .cin(1'b0), .sout(p[0]), .cout(c00));
    mult_cell u01 (.x(a[1]), .y(b[0]), .sin(1'b0), .cin(c00),  .sout(s01),  .cout(c01));
    mult_cell u02 (.x(a[2]), .y(b[0]), .sin(1'b0), .cin(c01),  .sout(s02),  .cout(c02));

    // --- ROW 1 (Multiply by b[1]) ---
    // Sum bits come diagonally from Row 0.
    mult_cell u10 (.x(a[0]), .y(b[1]), .sin(s01),  .cin(1'b0), .sout(p[1]), .cout(c10));
    mult_cell u11 (.x(a[1]), .y(b[1]), .sin(s02),  .cin(c10),  .sout(s11),  .cout(c11));
    mult_cell u12 (.x(a[2]), .y(b[1]), .sin(c02),  .cin(c11),  .sout(s12),  .cout(c12));

    // --- ROW 2 (Multiply by b[2]) ---
    // The remaining sum bits go directly to the output P.
    mult_cell u20 (.x(a[0]), .y(b[2]), .sin(s11),  .cin(1'b0), .sout(p[2]), .cout(c20));
    mult_cell u21 (.x(a[1]), .y(b[2]), .sin(s12),  .cin(c20),  .sout(p[3]), .cout(c21));
    mult_cell u22 (.x(a[2]), .y(b[2]), .sin(c12),  .cin(c21),  .sout(p[4]), .cout(p[5])); 
    // Note: The final carry (cout from u22) becomes the most significant bit (p[5]).

endmodule