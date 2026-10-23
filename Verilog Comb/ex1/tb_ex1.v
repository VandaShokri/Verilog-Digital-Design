// ---------------------------------------------------
// Module: Testbench for Exercise 1
// ---------------------------------------------------
`timescale 1ns / 1ps

module tb_logic_func();

    // Stimulus variables (reg type because they are assigned in an initial block)
    reg test_a, test_b, test_c, test_d;
    
    // Observation wires
    wire out_gate, out_dataflow;
    
    // Loop variable
    integer i;

    // 1. Instantiate the Gate-Level module (Device Under Test)
    logic_func_gate dut_gate (
        .a(test_a), .b(test_b), .c(test_c), .d(test_d), 
        .y(out_gate)
    );

    // 2. Instantiate the Dataflow module (Device Under Test)
    logic_func_dataflow dut_dataflow (
        .a(test_a), .b(test_b), .c(test_c), .d(test_d), 
        .y(out_dataflow)
    );

    // 3. Stimulus block
    initial begin
        // Print header in the Questa console
        $display("Time\t A B C D | Out Gate | Out Dataflow");
        $display("-------------------------------------------");
        
        // Loop to test all 16 possible combinations (0 to 15)
        for (i = 0; i < 16; i = i + 1) begin
            // Extract individual bits from integer 'i'
            {test_a, test_b, test_c, test_d} = i[3:0];
            
            // Wait 10 time units for signal propagation
            #10;
            
            // Print current state to the console
            $display("%0t\t %b %b %b %b |    %b     |      %b", 
                     $time, test_a, test_b, test_c, test_d, out_gate, out_dataflow);
            
            // Automatic error checking
            if (out_gate !== out_dataflow) begin
                $display("ERROR: Mismatch detected at time %0t", $time);
            end
        end
        
        // Finish simulation
        $display("Simulation completed.");
        $stop;
    end

endmodule