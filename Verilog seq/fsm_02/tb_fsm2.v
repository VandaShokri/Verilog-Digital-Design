// ---------------------------------------------------
// MODULE: Testbench for Mealy vs Moore
// ---------------------------------------------------
`timescale 1ns / 1ps

module tb_mult4();

    reg tb_clk;
    reg tb_rst;
    reg tb_in1;
    reg tb_in2;
    
    wire out_moore;
    wire out_mealy;

    // The test vectors from the exercise
    reg [5:0] seq1 = 6'b100100;
    reg [5:0] seq2 = 6'b100010;
    
    integer i;

    // Instantiate Moore
    mult4_moore dut_moore (
        .clk(tb_clk), .rst(tb_rst), .in1(tb_in1), .in2(tb_in2), .out(out_moore)
    );

    // Instantiate Mealy
    mult4_mealy dut_mealy (
        .clk(tb_clk), .rst(tb_rst), .in1(tb_in1), .in2(tb_in2), .out(out_mealy)
    );

    // Clock Generation
    initial tb_clk = 0;
    always #5 tb_clk = ~tb_clk;

    // Stimulus
    initial begin
        $display("Time | in1 in2 | Mealy Out | Moore Out");
        $display("--------------------------------------");
        
        // Reset the system
        tb_rst = 1'b1;
        tb_in1 = 0;
        tb_in2 = 0;
        @(negedge tb_clk);
        tb_rst = 1'b0;
        
        // Loop through the 6 bits of the sequence (MSB first -> Index 5 down to 0)
        for (i = 5; i >= 0; i = i - 1) begin
            // Apply inputs on the negative edge
            @(negedge tb_clk);
            tb_in1 = seq1[i];
            tb_in2 = seq2[i];
            
            // Wait a tiny bit for combinational logic (Mealy) to settle, then print
            #1; 
            $display("%0t\t |  %b   %b  |     %b     |     %b", $time, tb_in1, tb_in2, out_mealy, out_moore);
        end
        
        // Wait one more clock cycle to see the final Moore output propagate
        @(negedge tb_clk);
        $display("%0t\t |  -   -  |     -     |     %b (Delayed)", $time, out_moore);

        $display("Simulation Complete.");
        $stop;
    end

endmodule