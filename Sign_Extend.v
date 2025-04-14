`timescale 1ns /1ps


module Sign_Extend (In,
                    Imm_Ext,
                    ImmSrc);

    input [31:0]In;
  input ImmSrc; //When immediate src is 1 means that the extend block will extend instruction according to S type and when 0 then will extend according to I type
    output [31:0]Imm_Ext;

    assign Imm_Ext = (ImmSrc == 1'b1) ? ({{20{In[31]}},In[31:25],In[11:7]}):
                                        {{20{In[31]}},In[31:20]};
                                
endmodule
