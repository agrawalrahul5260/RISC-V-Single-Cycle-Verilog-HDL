`timescale 1ns / 1ps

module dataMem(
    input clk,
    input writeEn,
    input [31:0] addr,    
    input [31:0] dataWrite,
    output [31:0] dataRead
    );
    
    reg [31:0] memory [1023:0];
    
    assign dataRead = !writeEn ? memory[addr] : 0;
    
    always@(posedge clk) begin
        if(writeEn)
            memory[addr] <= dataWrite;
    end
endmodule
