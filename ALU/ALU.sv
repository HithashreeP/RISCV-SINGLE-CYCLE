`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.11.2026 21:19:03
// Design Name: 
// Module Name: ALU
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
module alu #(parameter int DATA_WIDTH = 32)(
    input  logic [4:0]            alu_control,
    input  logic [DATA_WIDTH-1:0] rs1_data,
    input  logic [DATA_WIDTH-1:0] rs2_data,
    output logic [DATA_WIDTH-1:0] alu_out,
    output logic                  zero
);

always_comb begin
    alu_out = '0;
    case (alu_control)
        5'b00000: alu_out = rs1_data + rs2_data;
        5'b00001: alu_out = rs1_data - rs2_data;
        5'b00101: alu_out = rs1_data << rs2_data[4:0];
        5'b01000: alu_out = ($signed(rs1_data) < $signed(rs2_data)) ? 32'd1 : 32'd0;
        5'b01001: alu_out = (rs1_data < rs2_data) ? 32'd1 : 32'd0;
        5'b00010: alu_out = rs1_data ^ rs2_data;
        5'b00110: alu_out = rs1_data >> rs2_data[4:0];
        5'b00111: alu_out = $signed(rs1_data) >>> rs2_data[4:0];
        5'b00011: alu_out = rs1_data | rs2_data;
        5'b00100: alu_out = rs1_data & rs2_data;
        5'b01010: alu_out = (rs1_data == rs2_data) ? 32'd1 : 32'd0;
        5'b01011: alu_out = (rs1_data != rs2_data) ? 32'd1 : 32'd0;
        5'b01100: alu_out = ($signed(rs1_data) < $signed(rs2_data)) ? 32'd1 : 32'd0;
        5'b01101: alu_out = ($signed(rs1_data) >= $signed(rs2_data)) ? 32'd1 : 32'd0;
        5'b01110: alu_out = (rs1_data < rs2_data) ? 32'd1 : 32'd0;
        5'b01111: alu_out = (rs1_data >= rs2_data) ? 32'd1 : 32'd0;
        default:  alu_out = '0;
    endcase

    zero = (rs1_data == rs2_data);
end

endmodule