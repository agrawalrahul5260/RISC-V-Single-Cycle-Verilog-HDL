`timescale 1ns / 1ps

module signExtend(
    input [31:0] in,
    input [1:0] immSrc,
    output [31:0] out
    );
    
    assign out = (immSrc==2'b01) ? {{20{in[31]}},in[31:25],in[11:7]} : {{20{in[31]}},in[31:20]};
endmodule
