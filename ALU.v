`timescale 1ns /1ps
module alu(A,B,ALUcontrol,Result,Z_F,N_F,V_F,C_F);
    //declaring inputs
    input [31:0] A,B;
    input [2:0] ALUcontrol;

    //declaring outputs
    output[31:0] Result;
    output Z_F,N_F,V_F,C_F; //Single Bit Flags(Zero flag, Negative Flag,Overflow Flag, Carry Flag)

    //declaring wires
    wire[31:0] a_and_b;
    wire[31:0] a_or_b;
    wire[31:0] not_b;
    wire[31:0] mux_1;
    wire[31:0] sum;
    wire[31:0] mux_2;
    wire[31:0] slt;

    wire cout;//To store carry information

    assign a_and_b = A & B;
    assign a_or_b = A | B;

    //not operation on b
    assign not_b = ~B;
    
    //Ternary operator for generating mux
    assign mux_1 = (ALUcontrol[0] == 1'b0) ? B : not_b;

    //Addition Subtraction

    assign {cout,sum} = A + mux_1 + ALUcontrol[0];

    //zero Extension for set less than

    assign slt = {31'b0000000000000000000000000000000,sum[30]}; //n-1 th bit of sum
    //designing 4 cross 1 mux
    assign mux_2 =  (ALUcontrol[2:0] == 2'b000) ? sum : 
                    (ALUcontrol[2:0] == 2'b001) ? sum :
                    (ALUcontrol[2:0] == 2'b010) ? a_and_b :
                    (ALUcontrol[2:0] == 2'b011) ? a_or_b :
                    (ALUcontrol[2:0] == 2'b101) ? slt : 32'h00000000;



    assign Result = mux_2;

    //Flags Assignment

    assign Z_F = &(~Result); //Zero Flag
    assign N_F = Result[31]; // Negative Flag
    assign C_F = cout & (~ALUcontrol[1]); // Carry Flag
    assign V_F = (ALUcontrol[1]) & (A[31] ^ sum[31]) & (~(A[31] ^ B[31] ^ ALUcontrol[0])); //Overflow Flag
endmodule
