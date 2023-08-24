`timescale 1ns / 1ps

module regFile(
    input clk,
    input writeEn,
    input rstn,
    input [4:0] readReg1,
    input [4:0] readReg2,
    input [4:0] writeReg,
    input [31:0] dataWrite,
    output [31:0] read1,
    output [31:0] read2
    );
    
    reg [31:0] register [31:0];
    
    assign read1 = rstn ? register[readReg1] : 0;
    assign read2 = rstn ? register[readReg2] : 0;
    
    always@(posedge clk) begin
        if(writeEn)
            register[writeReg] <= dataWrite;          
    end
endmodule
