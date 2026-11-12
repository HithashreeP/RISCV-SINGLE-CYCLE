`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.11.2026 21:11:07
// Design Name: 
// Module Name: Immediate_Generator
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
module imm_generator (
    input  logic [11:0] imm_input,       // decoder `imm`
    input  logic [2:0]  fn3,
    input  logic [6:0]  opcode,
    input  logic [19:0] imm_input_uj,    // decoder `imm_uj`
    output logic [31:0] imm_output
);

    always_comb begin
        imm_output = 32'b0;
        case (opcode)
            7'b0010011,
            7'b0000011,
            7'b1100111: begin
                imm_output = {{20{imm_input[11]}}, imm_input};
            end

            7'b0100011: begin
                imm_output = {{20{imm_input[11]}}, imm_input};
            end

            7'b1100011: begin
                imm_output = {{19{imm_input_uj[12]}}, imm_input_uj[12:1], 1'b0};
            end

            7'b0110111,
            7'b0010111: begin
                imm_output = {imm_input_uj[19:0], 12'b0};
            end

            7'b1101111: begin
                imm_output = {{11{imm_input_uj[19]}}, imm_input_uj[19:1], 1'b0};
            end

            default: begin
                imm_output = 32'b0;
            end
        endcase
    end

endmodule