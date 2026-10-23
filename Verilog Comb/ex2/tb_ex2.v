// ---------------------------------------------------
// Module: Testbench for Exercise 2
// ---------------------------------------------------
`timescale 1ns / 1ps

module tb_logic_gates_demorgan();

    // Stimulus signals
    reg test_a, test_b;
    
    // Observation wires
    wire w_and, w_or, w_xor, w_nand, w_nor;
    wire w_nand_dem, w_nor_dem;
    
    // Loop variable
    integer i;

    // Instantiate the DUT
    logic_gates_demorgan dut (
        .a(test_a), 
        .b(test_b),
        .out_and(w_and), 
        .out_or(w_or), 
        .out_xor(w_xor),
        .out_nand(w_nand), 
        .out_nor(w_nor),
        .out_nand_demorgan(w_nand_dem), 
        .out_nor_demorgan(w_nor_dem)
    );

    initial begin
        // Console header
        $display("Time | A B | AND OR XOR | NAND  NAND_DeM | NOR   NOR_DeM");
        $display("----------------------------------------------------------");
        
        // Loop to generate the 4 combinations (00, 01, 10, 11)
        for (i = 0; i < 4; i = i + 1) begin
            {test_a, test_b} = i[1:0];
            
            // 10ns delay
            #10;
            
            // Print results
            $display("%0t\t | %b %b |  %b   %b   %b  |  %b       %b     |  %b       %b", 
                     $time, test_a, test_b, w_and, w_or, w_xor, w_nand, w_nand_dem, w_nor, w_nor_dem);
                     
            // De Morgan automatic verification
            if (w_nand !== w_nand_dem) $display("ERROR: De Morgan failure in NAND (A=%b, B=%b)", test_a, test_b);
            if (w_nor !== w_nor_dem)   $display("ERROR: De Morgan failure in NOR (A=%b, B=%b)", test_a, test_b);
        end
        
        $display("Simulation completed.");
        $stop;
    end

endmodule