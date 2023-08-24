`timescale 1ns / 1ps

module instrMem(
    input rstn,
    input [31:0] addr,
    output [31:0] instr
    );
    reg [31:0] mem [1023:0];
    assign instr = rstn == 0 ? 0 : mem[addr[31:2]];
endmodule
