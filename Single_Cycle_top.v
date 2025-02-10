module Single_Cycle_top(clk,rst);

    input rst,clk;

    wire[31:0] PC_Top;
    wire RegWrite;
    wire[31:0] RD_Instr,RD1_Top,Imm_Ext_Top,ALUResult,ReadData,PCPlus4;
    wire[2:0] ALUControl_Top;

    pc pc_instan(.clk(clk),
                .rst(rst),
                .PC(PC_Top),
                .PC_Next(PCPlus4)
            );
            PC_Adder PC_Adder_instan(.a(PC_Top),
                                    .b(32'd4),
                                    .c(PCPlus4)

            );

    instr_mem instruction_memory_instan(.rst(rst),
                                        .A(PC_Top),
                                        .RD(RD_Instr));
    reg_file reg_instan(
                            .clk(clk),.rst(rst),
                            .we3(RegWrite),
                            .wd3(ReadData),
                            .A1(RD_Instr[19:15]),
                            .A2(RD_Instr[24:20]),
                            .A3(RD_Instr[11:7]).
                            .rd1(RD1_Top),
                            .rd2(RD2_Top)
    );

    se se_instan(.In(RD_Instr),
                .Imm_Ext(Imm_Ext_Top)); //Extend Block Instantiated

    alu alu_instan(
                .A(RD1_Top),
                .B(Imm_Ext_Top),
                .ALUcontrol(ALUControl_Top),
                .Result(ALUResult),
                .Z_F(),
                .N_F(),
                .V_F(),
                .C_F()
    );

    Control_Unit_Top Control_Unit_Top_instan(
                            .Op(RD_Instr[6:0]),
                            .RegWrite(RegWrite),
                            .ImmSrc(ImmSrc),
                            .ALUSrc(ALUSrc),
                            .MemWrite(MemWrite),
                            .ResultSrc(ResultSrc),
                            .Branch(),
                            .funct3(RD_Instr[14:12]),
                            .funct7(RD_Instr[6:0]),
                            .ALUControl(ALUControl_Top)
    );

        Data_Memory Data_Memory_instan(
                        .clk(clk),
                        .rst(rst),
                        .we(MemWrite),
                        .wd(RD2_Top),
                        .A(ALUResult),
                        .rd(ReadData)
    );

    Mux Mux_DataMemory_to_Register_instan(
                            .a(ALUResult),
                            .b(ReadData),
                            .s(ResultSrc),
                            .c(Result)
    );

endmodule