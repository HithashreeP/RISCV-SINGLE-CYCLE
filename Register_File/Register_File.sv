`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.11.2026 21:12:59
// Design Name: 
// Module Name: Register_File
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

module register_file(
    input  logic [4:0]  rs1_sel, rs2_sel,   // read addresses
    input  logic        reg_write,          // write enable
    input  logic        clk,
    input  logic        reset,              // Asynchronous, active high
    input  logic [31:0] wb_data,            // write data
    input  logic [4:0]  rd_sel,             // write address
    output logic [31:0] rs1_data, rs2_data  // read data
);

    logic [31:0] register [31:0];

    always_comb begin
        rs1_data = (rs1_sel == 5'b0) ? 32'b0 : register[rs1_sel];
        rs2_data = (rs2_sel == 5'b0) ? 32'b0 : register[rs2_sel];
    end

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            register <= '{default:0};
        end else begin
            if ((rd_sel != 0) & reg_write)
                register[rd_sel] <= wb_data;
        end
    end

endmodule
