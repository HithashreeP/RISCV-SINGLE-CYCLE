`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.11.2026 21:27:48
// Design Name: 
// Module Name: WB_Stage
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

module wb_stage(
    input  logic [31:0] mem_out,
    input  logic [31:0] alu_out,
    input  logic [31:0] return_addr,
    input  logic [31:0] imm_out,
    input  logic [31:0] pc_signed_offset,
    input  logic [1:0]  memtoreg,
    input  logic [6:0]  opcode_out_d,
    output logic [31:0] wb_data
);

    always_comb begin
        case (memtoreg)
            2'b00:   wb_data = alu_out;
            2'b01:   wb_data = mem_out;
            2'b10: begin
                if (opcode_out_d == 7'b0110111)
                    wb_data = imm_out;
                else if (opcode_out_d == 7'b0010111)
                    wb_data = pc_signed_offset;
                else
                    wb_data = return_addr;
            end
            2'b11:   wb_data = mem_out;
            default: wb_data = alu_out;
        endcase
    end

endmodule