module se(In,Imm_Ext);
    input[31:0] In;
    output[31:0] Imm_Ext;

    assign Imm_Ext = (In[31]) ? {{20{1'b1}},In[31:20]} : 
                                {{20{1'b0}},In[31:20]}; //To concatinate according to sign of the number (sign at 12th bit of number)

endmodule