module instr_mem(A,rst,RD);

    input[31:0] A; //input address to the instruction memory
    input rst;

    output[31:0] RD;

    //Created a memory here
    reg[31:0]mem[1023:0]; //1024 registers with each registers of size 32 bits


    assign RD = (rst == 1'b0) ? 32'h00000000 : mem[A[31:2]];

    initial
    begin
        mem[0] = 32'hFFC4A303;
    end


endmodule