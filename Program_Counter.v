module PC(CLK,Address_in,Address_out,rst);
 input CLK,rst;
 input [31:0] Address_in;
 output reg [31:0] Address_out;
 
 always@(posedge CLK,negedge rst)
 begin
    if(!rst) Address_out<=32'd0;
  else Address_out<=Address_in;
 end
endmodule