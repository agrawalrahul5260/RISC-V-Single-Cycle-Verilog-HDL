`timescale 1ns / 1ps

module ALU(
    input [31:0] A,
    input [31:0] B,
    input [2:0] Control,
    output reg [31:0] Result,
    output Z,
    output N,
    output C,
    output V
    );
	
	wire [31:0] A_or_B;
	wire [31:0] A_and_B;
	wire [31:0] A_xor_B;
	wire [31:0] not_B;
	wire [31:0] B_aux;
	wire [31:0]  Sum;
	wire [31:0] slt;
	wire Cout;
	
	assign A_or_B = A | B;
	assign A_and_B = A & B;
	assign A_xor_B = A ^ B;
	assign not_B = ~B;
	assign B_aux = Control[0] ? not_B : B;
	assign {Cout,Sum} = A + B_aux + Control[0];
	assign slt = {31'b0,Sum[31]};
	
	always@* begin
		case(Control)
			000 : Result = Sum;
			001 : Result = Sum;
			010 : Result = A_and_B;
			011 : Result = A_or_B;
			100 : Result = A_xor_B;
			101 : Result = slt;
			default Result = 0;
        endcase     
	end
	
	assign Z = &(~Sum);
	assign N = Sum[31];
	assign C = (~Control[1]) & Cout;
	assign V = (~(Control[0] ^ A[31] ^ B[31])) & (A[31] ^ Sum[31]) & (~Control[1]);
endmodule
