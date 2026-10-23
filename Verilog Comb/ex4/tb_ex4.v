// ---------------------------------------------------
// Module: Testbench for Multiplexer Versions
// ---------------------------------------------------
`timescale 1ns / 1ps

module tb_mux21();

    // Inputs (reg)
    reg t_in0, t_in1, t_sel;
    
    // Outputs (wire) for each version
    wire out_g, out_d, out_b;
    
    integer i;

    // Instantiate all three multiplexers
    mux21_gate       dut_gate      (.in0(t_in0), .in1(t_in1), .sel(t_sel), .out(out_g));
    mux21_dataflow   dut_dataflow  (.in0(t_in0), .in1(t_in1), .sel(t_sel), .out(out_d));
    mux21_behavioral dut_behavioral(.in0(t_in0), .in1(t_in1), .sel(t_sel), .out(out_b));

    initial begin
        $display("Time | Sel in1 in0 | Out_Gate | Out_Dataflow | Out_Behavioral");
        $display("---------------------------------------------------------------");
        
        // Loop to test all 8 combinations (000 to 111)
        for (i = 0; i < 8; i = i + 1) begin
            // Assign bits to signals
            // Note: Ordered as {sel, in1, in0} to make truth table intuitive
            {t_sel, t_in1, t_in0} = i[2:0];
            
            #10; // Delay
            
            $display("%0t\t |  %b   %b   %b  |    %b     |      %b       |       %b", 
                     $time, t_sel, t_in1, t_in0, out_g, out_d, out_b);
                     
            // Verification: Throw error if they don't match perfectly
            if ((out_g !== out_d) || (out_d !== out_b)) begin
                $display("ERROR: Mismatch detected at combination %b", i[2:0]);
            end
        end
        
        $display("Simulation completed.");
        $stop;
    end

endmodule