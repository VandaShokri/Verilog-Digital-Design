// ===================================================
// EXERCISE 1: Boolean Function (At most two 0s)
// Equation: Y = AB + AC + AD + BC + BD + CD
// ===================================================

// ---------------------------------------------------
// Module: Gate-Level Implementation
// ---------------------------------------------------
module logic_func_gate (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire y
);

    // Internal wires for AND gate outputs
    wire w_ab, w_ac, w_ad, w_bc, w_bd, w_cd;

    // AND gate instantiations (output, input1, input2)
    and and1 (w_ab, a, b);
    and and2 (w_ac, a, c);
    and and3 (w_ad, a, d);
    and and4 (w_bc, b, c);
    and and5 (w_bd, b, d);
    and and6 (w_cd, c, d);

    // OR gate instantiation (multiple inputs allowed in Verilog)
    or or_final (y, w_ab, w_ac, w_ad, w_bc, w_bd, w_cd);

endmodule

// ---------------------------------------------------
// Module: Dataflow Implementation
// ---------------------------------------------------
module logic_func_dataflow (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire y
);

    // Continuous assignment using bitwise logic operators
    assign y = (a & b) | (a & c) | (a & d) | (b & c) | (b & d) | (c & d);

endmodule