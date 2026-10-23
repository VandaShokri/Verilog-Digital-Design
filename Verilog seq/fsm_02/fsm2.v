// ===================================================
// EXERCISE: Multiple of 4 Sequence Detector
// Input: Two bits arriving MSB first
// Output: 1 if the accumulated sum is a multiple of 4
// ===================================================

// ---------------------------------------------------
// 1. MOORE MACHINE
// The output depends ONLY on the current state.
// ---------------------------------------------------
module mult4_moore (
    input wire clk,
    input wire rst,
    input wire in1,
    input wire in2,
    output wire out
);

    // State encoding (representing the remainder: 0, 1, 2, or 3)
    localparam S0 = 2'd0; // Remainder 0 (Multiple of 4)
    localparam S1 = 2'd1; // Remainder 1
    localparam S2 = 2'd2; // Remainder 2
    localparam S3 = 2'd3; // Remainder 3

    reg [1:0] current_state, next_state;
    wire [1:0] in_sum;

    assign in_sum = in1 + in2; // The sum of the current incoming bits (0, 1, or 2)

    // State Register
    always @(posedge clk) begin
        if (rst) current_state <= S0;
        else     current_state <= next_state;
    end

    // Next State Logic: next_state = (2 * current_state + in_sum) % 4
    always @(*) begin
        case (current_state)
            S0: next_state = in_sum;                 // 2(0) + in_sum = in_sum
            S1: next_state = (2'd2 + in_sum);        // 2(1) + in_sum = 2 + in_sum
            S2: next_state = (in_sum);               // 2(2) + in_sum = 4 + in_sum = 0 + in_sum (mod 4)
            S3: next_state = (2'd2 + in_sum);        // 2(3) + in_sum = 6 + in_sum = 2 + in_sum (mod 4)
            default: next_state = S0;
        endcase
    end

    // Output Logic (MOORE: Depends ONLY on current state)
    // We output 1 only if we are currently sitting in State 0
    assign out = (current_state == S0);

endmodule

// ---------------------------------------------------
// 2. MEALY MACHINE
// The output depends on the current state AND the inputs.
// ---------------------------------------------------
module mult4_mealy (
    input wire clk,
    input wire rst,
    input wire in1,
    input wire in2,
    output wire out
);

    localparam S0 = 2'd0, S1 = 2'd1, S2 = 2'd2, S3 = 2'd3;

    reg [1:0] current_state, next_state;
    wire [1:0] in_sum;

    assign in_sum = in1 + in2;

    // State Register
    always @(posedge clk) begin
        if (rst) current_state <= S0;
        else     current_state <= next_state;
    end

    // Next State Logic (Identical to Moore)
    always @(*) begin
        case (current_state)
            S0: next_state = in_sum;                 
            S1: next_state = (2'd2 + in_sum);        
            S2: next_state = (in_sum);               
            S3: next_state = (2'd2 + in_sum);        
            default: next_state = S0;
        endcase
    end

    // Output Logic (MEALY: Depends on State + Inputs)
    // We output 1 if the NEXT state (calculated combinationally right now) is S0
    assign out = (next_state == S0);

endmodule