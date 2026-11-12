`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.11.2026 21:25:15
// Design Name: 
// Module Name: EX_Stage
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

module ex_stage (
    input  logic [31:0] rs1_data,
    input  logic [31:0] rs2_data,
    input  logic [31:0] imm_out,
    input  logic [31:0] address,        // current PC
    input  logic        branch,
    input  logic        alu_src,        // 0 = rs2_data, 1 = imm_out
    input  logic        fn7_5,
    input  logic        mux_inp,        // 1 = JALR
    input  logic [2:0]  fn3,
    input  logic [6:0]  imm11_5,
    input  logic [2:0]  aluop,
    input  logic [6:0]  opcode,
    output logic        and_out_ex,     // branch / jump taken
    output logic [31:0] alu_out,
    output logic [31:0] pc_ex_out       // branch / jump target
);

    logic [4:0]  control_out;
    string       alu_operations;
    logic [31:0] alu_in2;
    logic        zero;
    logic        is_jump;

    alu_control u_alu_control (
        .alu_op         (aluop),
        .fn3            (fn3),
        .fn7_5          (fn7_5),
        .imm11_5        (imm11_5),
        .alu_operations (alu_operations),
        .control_out    (control_out)
    );

    assign alu_in2 = alu_src ? imm_out : rs2_data;

    alu u_alu (
        .alu_control (control_out),
        .rs1_data    (rs1_data),
        .rs2_data    (alu_in2),
        .alu_out     (alu_out),
        .zero        (zero)
    );

    assign pc_ex_out = mux_inp ? ((rs1_data + imm_out) & 32'hFFFF_FFFE) : (address + imm_out);

    assign is_jump = (opcode == 7'b1101111) || (opcode == 7'b1100111);
    assign and_out_ex = is_jump || (branch & alu_out[0]);

endmodule