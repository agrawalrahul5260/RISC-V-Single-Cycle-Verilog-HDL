`timescale 1ns / 1ps

module top(
    input clk,
    input rstn
    );
    wire [31:0] instr_temp;
    pc pc0(.clk(cllk),
           .rstn(rstn),
           .pcNext(pcNext),
           .pc(pc)
           );
    pcAdder pcAdd(.in1(pc),
                  .in2(32'd4),
                  .out(pcNext)
                  );
    instrMem i_0(.rstn(rstn),
                 .addr(pc_1),
                 .instr(instr)
                 );
                 
    assign instr_temp = instr;
    regFile rf_0(.clk(clk),
                 .writeEn(regWrite),
                 .rstn(rstn),
                 .readReg1(instr_temp[19:15]),
                 .readReg2(instr_temp[24:20]),
                 .writeReg(instr_temp[11:7]),
                 .dataWrite(dataMem_fin),
                 .read1(aluInput1),
                 .read2(aluInput2)
                 );
    
    controlUnit cu_0(.zero(zero),
                    .instr(instr),
                    .regWrite(regWrite),
                    .memWrite(memWrite),
                    .resultSrc(resultSrc),
                    .aluSrc(aluSrc),
                    .pcSrc(pcSrc),
                    .immSrc(immSrc),
                    .aluControl(aluControl)
                    );
                    
    signExtend se_0(.in(instr),
                    .immSrc(immSrc),
                    .out(imm)
                    );
    
    mux2_1 mux_alu(.i0(aluInput2),
                   .i1(imm),
                   .sel(aluSrc),
                   .y(aluIp2_mux)
                   );
    
    ALU alu_0(.A(read1),
              .B(aluIp2_mux),
              .Control(aluControl),
              .Result(aluResult),
              .Z(zero),
              .N(),
              .C(),
              .V()
              );
              
    dataMem(.clk(clk),
            .writeEn(memWrite),
            .addr(aluResult),    
            .dataWrite(),
            .dataRead(dataRead)
    );
    
    mux2_1 mux_mem(.i0(aluResult),
                   .i1(dataRead),
                   .sel(resultSrc),
                   .y(dataMem_fin)
                   );
     
endmodule
