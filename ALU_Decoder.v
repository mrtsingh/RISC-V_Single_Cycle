module alu_dec(ALUop,op5,funct3,fuct7,ALUcontrol);

    input op5,funct7; //here only 5th bit of funct 7 used
    input [2:0] funct3;
    output [2:0] ALUcontrol;

    wire[1:0] concat; // 2single bit numbers are concatinated

    assign concat = {op5,funct7};

    assign ALUcontrol = (ALUop == 2'b00) ? 3'b000 :
                        (ALUop == 2'b01) ? 3'b001 :
                        ((ALUop == 2'b10) & (funct3 == 3'b010)) ? 3'b101 :
                        ((ALUop == 2'b10) & (funct3 == 3'b110)) ? 3'b011 :
                        ((ALUop == 2'b10) & (funct3 == 3'b111)) ? 3'b010 :
                        ((ALUop == 2'b10) & (funct3 == 3'b000) & (concat == 2'b11)) ?  3'b001 :
                        ((ALUop == 2'b10) & (funct3 == 3'b000) & (concat != 2'b11)) ?  3'b000 : 3'b000;

                        


endmodule               