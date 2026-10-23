// ---------------------------------------------------
// Module: Exhaustive Testbench for Multiplier
// ---------------------------------------------------
`timescale 1ns / 1ps

module tb_mult_3x3();

    reg [2:0] test_a;
    reg [2:0] test_b;
    wire [5:0] test_p;
    
    // Integer variables for loops
    integer i, j;
    integer errors; // Error counter

    // Instantiate the multiplier
    mult_3x3 dut (
        .a(test_a), 
        .b(test_b), 
        .p(test_p)
    );

    initial begin
        errors = 0;
        $display("Starting exhaustive test for 3x3 Multiplier...");
        
        // Loop for A (0 to 7)
        for (i = 0; i < 8; i = i + 1) begin
            // Loop for B (0 to 7)
            for (j = 0; j < 8; j = j + 1) begin
                test_a = i;
                test_b = j;
                
                #10; // Wait for signal propagation
                
                // Mathematical self-verification
                if (test_p !== (test_a * test_b)) begin
                    $display("ERROR: %d x %d = %d (Expected: %d)", test_a, test_b, test_p, test_a * test_b);
                    errors = errors + 1;
                end
            end
        end
        
        if (errors == 0) begin
            $display("SUCCESS! All 64 multiplications are correct. (e.g., 7x7=%d)", test_p);
        end else begin
            $display("Simulation failed with %d errors.", errors);
        end
        
        $stop;
    end

endmodule