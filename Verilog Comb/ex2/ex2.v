// ===================================================
// EXERCISE 2: Logic Gates & De Morgan's Theorems
// ===================================================
module logic_gates_demorgan (
    input wire a,
    input wire b,
    
    // Basic outputs
    output wire out_and,
    output wire out_or,
    output wire out_xor,
    output wire out_nand,
    output wire out_nor,
    
    // De Morgan outputs
    output wire out_nand_demorgan,
    output wire out_nor_demorgan
);

    // 1. Basic Logic Gates
    assign out_and  = a & b;
    assign out_or   = a | b;
    assign out_xor  = a ^ b;
    assign out_nand = ~(a & b);
    assign out_nor  = ~(a | b);

    // 2. De Morgan's Theorems
    // Theorem 1: The complement of a product is the sum of the complements
    assign out_nand_demorgan = (~a) | (~b); 
    
    // Theorem 2: The complement of a sum is the product of the complements
    assign out_nor_demorgan  = (~a) & (~b); 

endmodule