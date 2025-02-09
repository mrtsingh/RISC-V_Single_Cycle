//Making this as Combinational Circuit so that no concept of delay
module main_dec(op,zero,Regwri,Memwri,ResultSrc,ALUSrc,ImmSrc,ALUop,PCSrc);

    //Inputs, outputs
    input zero;
    input [6:0] op;
    output Regwri,Memwri,ResultSrc,ALUSrc,PCSrc;
    output [1:0] ImmSrc,ALUop;

    wire branch;

    assign Regwri = ((op == 7'b0000011) | (op == 7'b0110011)) ? 1'b1  : 1'b0;
    
    assign Memwri = (op == 7'b0100011) ? 1'b1  : 1'b0;

    assign ResultSrc = (op == 7'b0000011) ? 1'b1 : 1'b0;

    assign ALUSrc = ((op == 7'b0000011) | (op == 7'b0100011)) ? 1'b1: 1'b0;

    assign branch = (op == 7'b1100011)?1'b1:1'b0;

    assign ImmSrc = (op == 7'b0100011) ? 2'b01 : (op == 7'b1100011) ? 2'b10 : 2'b00;

    assign ALUop = (op == 7'b0110011) ? 2'b01 : (op == 7'b1100011) ? 2'b10 : 2'b00;

    assign PCSrc = zero & branch;
    
endmodule