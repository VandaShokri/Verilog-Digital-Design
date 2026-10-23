// ---------------------------------------------------
// MODULE: Testbench for Advanced Vending Machine
// ---------------------------------------------------
`timescale 1ns / 1ps

module tb_vending_machine_v2();

    // Inputs
    reg tb_clk;
    reg tb_rst;
    reg tb_coin_20;
    reg tb_coin_50;
    reg tb_coin_100;
    reg tb_coin_200;
    
    // Output
    wire tb_open;

    // Instantiate DUT
    vending_machine_v2 dut (
        .clk(tb_clk),
        .rst(tb_rst),
        .coin_20(tb_coin_20),
        .coin_50(tb_coin_50),
        .coin_100(tb_coin_100),
        .coin_200(tb_coin_200),
        .open_dispenser(tb_open)
    );

    // 1. Clock Generation (10ns period)
    initial tb_clk = 0;
    always #5 tb_clk = ~tb_clk;

    // Macro task to easily insert coins and save lines of code
    task insert_coin;
        input [2:0] coin_type; // 1=20c, 2=50c, 3=100c, 4=200c
        begin
            @(negedge tb_clk);
            if (coin_type == 1) tb_coin_20 = 1'b1;
            if (coin_type == 2) tb_coin_50 = 1'b1;
            if (coin_type == 3) tb_coin_100 = 1'b1;
            if (coin_type == 4) tb_coin_200 = 1'b1;
            
            @(negedge tb_clk); // Hold for 1 cycle
            tb_coin_20 = 0; tb_coin_50 = 0; tb_coin_100 = 0; tb_coin_200 = 0;
            
            @(negedge tb_clk); // Wait 1 cycle before next coin
        end
    endtask

    // 2. Stimulus Block
    initial begin
        $display("Starting Advanced Vending Machine Simulation...");
        
        // Initialize inputs
        tb_rst = 1'b1;
        tb_coin_20 = 0; tb_coin_50 = 0; tb_coin_100 = 0; tb_coin_200 = 0;
        
        // Hold reset for two cycles, then release
        repeat(2) @(negedge tb_clk);
        tb_rst = 1'b0;
        
        // --------------------------------------------
        // SCENARIO A: Exact Change (50c + 200c = 250c)
        // --------------------------------------------
        $display("\n--- Scenario A: Exact Change (0.50 + 2.00) ---");
        insert_coin(2); // Insert 50c
        insert_coin(4); // Insert 2Euros
        repeat(3) @(negedge tb_clk); // Observe Dispense and Reset
        
        // --------------------------------------------
        // SCENARIO B: Overpayment (100c + 200c = 300c)
        // --------------------------------------------
        $display("\n--- Scenario B: Overpayment (1.00 + 2.00) ---");
        insert_coin(3); // Insert 1Euro
        insert_coin(4); // Insert 2Euros
        repeat(3) @(negedge tb_clk); // Observe Dispense and Reset
        
        // --------------------------------------------
        // SCENARIO C: Many Small Coins (20c x 13 = 260c)
        // --------------------------------------------
        $display("\n--- Scenario C: Spamming 20c coins ---");
        repeat(13) begin
            insert_coin(1); // Insert 20c
        end
        repeat(3) @(negedge tb_clk);

        $display("\nSimulation Complete.");
        $stop;
    end

endmodule