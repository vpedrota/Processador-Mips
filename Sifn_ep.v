module sign_ep(order,addr);
 input [15:0] order;
 output reg [31:0] addr;
 
 always @(order)
 begin
    if(order[15]==1) addr[31:16]=16'b1111111111111111;
  else addr[31:16]=16'b0000000000000000;
  addr[15:0]=order[15:0];
   end
endmodule