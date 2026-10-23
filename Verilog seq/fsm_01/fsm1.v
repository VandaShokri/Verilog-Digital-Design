// ===================================================
// MODULE: Advanced Vending Machine (Accumulator FSM)
// Target: 2.50 Euro (250 cents)
// ===================================================
module vending_machine_v2 (
    input wire clk,
    input wire rst,
    input wire coin_20,   // Pulse when 20 cents inserted
    input wire coin_50,   // Pulse when 50 cents inserted
    input wire coin_100,  // Pulse when 1 euro inserted
    input wire coin_200,  // Pulse when 2 euros inserted
    output reg open_dispenser
);

    // Target amount in cents
    localparam TARGET = 9'd250; 

    // State registers (9 bits to hold values up to 511)
    reg [8:0] current_amount;
    reg [8:0] next_amount;

    // ---------------------------------------------------
    // Block 1: State Register (Sequential)
    // ---------------------------------------------------
    always @(posedge clk) begin
        if (rst == 1'b1) begin
            current_amount <= 9'd0;
        end else begin
            current_amount <= next_amount;
        end
    end

    // ---------------------------------------------------
    // Block 2: Next State Logic (Combinational)
    // ---------------------------------------------------
    always @(*) begin
        // Default: hold current value
        next_amount = current_amount; 

        // If target reached, auto-reset to 0 on the next clock cycle
        if (current_amount >= TARGET) begin
            next_amount = 9'd0;
        end 
        // Otherwise, add the value of the inserted coin
        else begin
            if (coin_20)       next_amount = current_amount + 9'd20;
            else if (coin_50)  next_amount = current_amount + 9'd50;
            else if (coin_100) next_amount = current_amount + 9'd100;
            else if (coin_200) next_amount = current_amount + 9'd200;
        end
    end

    // ---------------------------------------------------
    // Block 3: Output Logic (Combinational)
    // ---------------------------------------------------
    always @(*) begin
        if (current_amount >= TARGET) begin
            open_dispenser = 1'b1;
        end else begin
            open_dispenser = 1'b0;
        end
    end

endmodule