module Registers(Read_registers1,Read_registers2,Write_registers,Write_Data,Read_Data1,Read_Data2,RegWire,CLK);//Register file
 input [4:0] Read_registers1,Read_registers2,Write_registers;
 input [31:0] Write_Data;
 input RegWire,CLK;
 output [31:0] Read_Data1,Read_Data2;
 reg [31:0] register[31:0] /*synthesis ram_init_file="Mif2.mif" */;
 
 assign Read_Data1 = register[Read_registers1];
 assign Read_Data2 = register[Read_registers2];
 //The rising edge of the write signal arrives
 always @(posedge CLK)
 begin
  //When the RegWire signal is valid, write operation
    if(RegWire) register[Write_registers] <= Write_Data;
 end
endmodule