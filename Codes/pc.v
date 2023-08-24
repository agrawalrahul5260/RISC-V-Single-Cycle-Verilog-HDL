`timescale 1ns / 1ps

module pc(
    input clk,
    input rstn,
    input [31:0] pcNext,
    output reg [31:0] pc 
    );
    
    always@(posedge clk) begin
        if(rstn  == 1'b0)
            pc <= 32'h0;
        else
            pc <= pcNext;
    end
    
endmodule
