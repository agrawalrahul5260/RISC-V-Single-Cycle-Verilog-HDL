`timescale 1ns / 1ps

module controlUnit(
    input zero,
    input [31:0] instr,
    output regWrite, //write enable signal for register file
    output memWrite, //write ensble signal for data memory
    output resultSrc, //muxed signal from data memeory
    output aluSrc,   //control signal to select b/w immediate value & read2 signal from reg file
    output pcSrc,
    output [1:0] immSrc, 
    output [2:0] aluControl
    );
    
    wire [2:0] func3;
    wire [6:0] func7; //for R type instruction
    wire [6:0] op;    
    wire [2:0] aluOp;
    wire branch;
    wire [2:0] opFunc7;
    
    assign op_func7 = {op[5],func7[5]};
    assign op = instr[6:0];
    assign func7 = instr[31:25];
    assign func3 = instr[14:12];
    
    assign regWrite = (op == 7'b0110011 || op == 7'b0000011) ? 1 : 0;
    assign memWrite = (op == 7'b0100011) ? 1 : 0;
    assign resultSrc = (op == 7'b0000011) ? 1 : 0;
    assign aluSrc = (op == 7'b0100011 || op == 7'b0000011) ? 1 : 0; 
    assign branch = (op == 7'b1100011) ? 1 : 0;
    assign immSrc = (op == 7'b0100011 ? 2'b01 : op == 7'b1100011) ? 2'b10 : 2'b00;
    assign pcSrc = zero & branch;
    
    assign aluOp = (op == 7'b1100011) ? 2'b01 : (op == 7'b0110011) ? 2'b10 : 2'b00;
    
    assign aluControl = (aluOp == 2'b00) ? 3'b000 : 
                        (aluOp == 2'b01) ? 3'b001 :
                        (aluOp == 2'b10 && func3 == 3'b000 && (opFunc7 == 2'b00 || opFunc7 == 2'b01 || opFunc7 == 2'b10)) ? 3'b000 :
                        (aluOp == 2'b10 && func3 == 3'b000 && opFunc7 == 2'b11) ? 3'b001 :
                        (aluOp == 2'b10 && func3 == 3'b010) ? 3'b101 :
                        (aluOp == 2'b10 && func3 == 3'b110) ? 3'b011 :
                        (aluOp == 2'b10 && func3 == 3'b111) ? 3'b010 : 3'b000;
                         
endmodule