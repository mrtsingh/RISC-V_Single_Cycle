module reg_file(A1,A2,A3,wd3,we3,rst,clk,rd1,rd2);

input[4:0] A1,A2,A3;
input [31:0] wd3;
output [31:0] rd1,rd2;
input clk;
input rst;
input we3;//write enable pin

//Creating temporary memory
reg[31:0] registers [31:0];

//read functionality
assign rd1 = (!rst) ? 32'h00000000 : registers[A1];
assign rd2 = (!rst) ? 32'h00000000 : registers[A2];

//write functionality
always @(posedge clk)
begin
    if(we3)
    begin
        registers[A3] <= wd3;
    end
end

endmodule