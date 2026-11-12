`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.11.2026 20:59:12
// Design Name: 
// Module Name: IF_Stage
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module IF_Stage (
    input  logic        clk,
    input  logic        reset,              // Asynchronous, active high
    input  logic        stall,              // Hold the PC
    input  logic        and_out,            // 1 = take branch/jump target
    input  logic [31:0] pc_signed_offset,   // Branch / jump target address
    output logic [31:0] address,            // Current PC
    output logic [31:0] pc_new              // PC + 4
);

    logic [31:0] pc_next;

    assign pc_new = address + 4;

    always_comb begin 
        if (and_out)
            pc_next = pc_signed_offset;
        else
            pc_next = pc_new;
    end

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            address <= 32'h0000_0000;
        else if (!stall)
            address <= pc_next;
    end

endmodule
