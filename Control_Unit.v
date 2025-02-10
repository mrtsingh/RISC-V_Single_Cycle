module Control_Unit_Top(Op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,funct3,funct7,ALUControl);

    input [6:0]Op,funct7;
    input [2:0]funct3;
    output RegWrite,ALUSrc,MemWrite,ResultSrc,Branch;
    output [1:0]ImmSrc;
    output [2:0]ALUControl;

    wire [1:0]ALUOp;

    main_dec main_dec_instan(
                .op(Op),
                .Regwri(RegWrite),
                .ImmSrc(ImmSrc),
                .Memwri(MemWrite),
                .ResultSrc(ResultSrc),
                .branch(Branch),
                .ALUSrc(ALUSrc),
                .ALUOp(ALUOp)
    );

    alu_dec alu_dec_instan(
                            .ALUop(ALUOp),
                            .funct3(funct3),
                            .funct7(funct7),
                            .op5(Op),
                            .ALUControl(ALUControl)
    );


endmodule