module ALU_Control(ALUop,FunctionCode,ALUctr);
 input [2:0] ALUop; //A two-digit control field
 input [5:0] FunctionCode; //A 6-digit function code
 output reg [3:0] ALUctr; //The output is a 4-bit ALU control signal
 
 always @(ALUop,FunctionCode)
 begin
    case(ALUop)
  3'b000: ALUctr <= 4'b0010;  //SQ
  3'b001: ALUctr <= 4'b0110; //BEQ
  3'b011: ALUctr <= 4'b0011; //BNE
  3'b111: ALUctr <= 4'b0100; //BGT
  3'b101: ALUctr <= 4'b0101; //BGT
  //R type
  3'b10:
  begin
   case(FunctionCode)
   6'b100000: ALUctr <= 4'b0010; //SOMA
   6'b100010: ALUctr <= 4'b0110; //SUBTRAÇÃO
   6'b100100: ALUctr <= 4'b0000; //AND
   6'b100101: ALUctr <= 4'b0001; //OR
   default: ALUctr <= 4'b1111;
   endcase
  end
  default: ALUctr <= 4'b1111;
  endcase
 end
endmodule