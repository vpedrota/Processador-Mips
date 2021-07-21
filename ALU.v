module ALU(ctr,A,B,Zero,result);//ALU is a combinational logic circuit
 input [3:0] ctr;
 input [31:0] A,B;
 output Zero;
 output reg [31:0] result;
 
 always @ (A,B,ctr)
 begin
    case(ctr)
  4'd0: result <= A&B;
  4'd1: result <= A|B;
  4'd2: result <= A+B;
  4'd3: result <= (A!=B) ? 0: 1;
  4'd4: result <= (A>B) ? 0: 1;
  4'd4: result <= (A<B) ? 0: 1;
  4'd6: result <= A-B;
  4'd7: result <= A<B ? 1:0;
  4'd12:result <= ~(A|B);
  default: result <= 0;
  endcase
 end
 
 assign Zero = (result==0);
endmodule