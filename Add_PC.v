module Add_PC(adr,n_adr);
 input [31:0] adr;
 output [31:0] n_adr;
 assign n_adr = adr + 32'd4;
endmodule