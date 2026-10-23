// ===================================================
// EXERCISE 4: 2-to-1 Multiplexer (3 Abstraction Levels)
// ===================================================

// ---------------------------------------------------
// 1. Gate Level
// Describes the physical connections between gates.
// Equation: Y = (in0 AND NOT sel) OR (in1 AND sel)
// ---------------------------------------------------
module mux21_gate (
    input wire in0,
    input wire in1,
    input wire sel,
    output wire out
);
    wire not_sel, and0_out, and1_out;

    not u_not (not_sel, sel);
    and u_and0 (and0_out, in0, not_sel);
    and u_and1 (and1_out, in1, sel);
    or  u_or   (out, and0_out, and1_out);

endmodule

// ---------------------------------------------------
// 2. Dataflow Level
// Describes the logic flow using conditional operators.
// ---------------------------------------------------
module mux21_dataflow (
    input wire in0,
    input wire in1,
    input wire sel,
    output wire out
);
    // Ternary operator: If sel is 1, pass in1; if 0, pass in0.
    assign out = sel ? in1 : in0; 

endmodule

// ---------------------------------------------------
// 3. Behavioral Level
// Describes WHAT the circuit does, not HOW it is built.
// Reads like C or Python code.
// ---------------------------------------------------
module mux21_behavioral (
    input wire in0,
    input wire in1,
    input wire sel,
    output reg out  // IMPORTANT: Outputs assigned inside 'always' blocks must be 'reg'
);
    // The block evaluates every time in0, in1, or sel change their value
    always @(*) begin
        if (sel == 1'b1) begin
            out = in1;
        end else begin
            out = in0;
        end
    end

endmodule