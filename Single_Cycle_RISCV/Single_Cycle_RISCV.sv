`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.11.2026 21:30:53
// Design Name: 
// Module Name: Single_Cycle_RISCV
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

module single_cycle_riscv (
    input  logic        clk,
    input  logic        reset,
    input  logic        stall,
    input  logic [31:0] instruction,
    input  logic [31:0] mem_out,
    output logic [31:0] rs2_data,
    output logic [31:0] alu_out,
    output logic        mem_write,
    output logic        mem_read,
    output logic [2:0]  fn3,
    output logic [6:0]  opcode,
    output logic [31:0] address
);

    logic [31:0] pc_new;
    logic [31:0] and_out_ex;
    logic [31:0] pc_ex_out;
    logic [31:0] wb_data;
    logic [31:0] rs1_data;
    logic [31:0] imm_out;
    logic [6:0]  imm11_5;
    logic [2:0]  fn3_out_d;
    logic        fn7_5;
    logic [2:0]  aluop;
    logic [1:0]  memtoreg;
    logic        branch;
    logic        mem_write_w;
    logic        mem_read_w;
    logic        alu_src;
    logic        mux_inp;
    logic [31:0] alu_out_w;

    assign mem_write = mem_write_w;
    assign mem_read  = mem_read_w;
    assign alu_out   = alu_out_w;

    if_stage u_if (
        .clk     (clk),
        .reset   (reset),
        .stall   (stall),
        .and_out (and_out_ex[0]),
        .PC_so   (pc_ex_out),
        .address (address),
        .PC_new  (pc_new)
    );

    id_stage u_id (
        .clk          (clk),
        .reset        (reset),
        .stall        (stall),
        .instruction  (instruction),
        .wb_data      (wb_data),
        .rs1_data     (rs1_data),
        .rs2_data     (rs2_data),
        .imm_out      (imm_out),
        .opcode_out_d (opcode),
        .imm11_5      (imm11_5),
        .fn3_out_d    (fn3_out_d),
        .fn7_5        (fn7_5),
        .aluop        (aluop),
        .memtoreg     (memtoreg),
        .branch       (branch),
        .mem_write    (mem_write_w),
        .mem_read     (mem_read_w),
        .alu_src      (alu_src),
        .mux_inp      (mux_inp)
    );

    assign fn3 = fn3_out_d;

    ex_stage u_ex (
        .rs1_data     (rs1_data),
        .rs2_data     (rs2_data),
        .imm_out      (imm_out),
        .address      (address),
        .branch       (branch),
        .alu_src      (alu_src),
        .fn7_5        (fn7_5),
        .mux_inp      (mux_inp),
        .fn3          (fn3_out_d),
        .imm11_5      (imm11_5),
        .aluop        (aluop),
        .opcode       (opcode),
        .and_out_ex   (and_out_ex[0]),
        .alu_out      (alu_out_w),
        .pc_ex_out    (pc_ex_out)
    );

    assign and_out_ex[31:1] = '0;

    wb_stage u_wb (
        .mem_out          (mem_out),
        .alu_out          (alu_out_w),
        .return_addr      (pc_new),
        .imm_out          (imm_out),
        .pc_signed_offset (pc_ex_out),
        .memtoreg         (memtoreg),
        .opcode_out_d     (opcode),
        .wb_data          (wb_data)
    );

endmodule