module data_mem(A,wd,clk,we,rd);

    input[31:0] A,wd;
    input clk,rst,we;

    output[31:0] rd;

    reg[31:0] data_memory[1023:0];

    //Read functionality
    assign rd = (we == 1'b0) ? data_memory[A] : 32'h00000000;

    //Write functionality
    always @ (posedge clk)
    begin
        if(we)
        begin
            data_memory[A] <= wd;
        end
    end
endmodule