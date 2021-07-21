module mipsProcessor(CLK, clock_in, clock_output, rst,out_ALU,Read_Data1,Read_Data2,Address_in_PC,Address_out_PC,Address_Add_PC,instruction,Read_Data_Mem,instruction_Left, RegWrite, MemWrite, MemRead);
 
 input CLK;
 output clock_in, clock_output;
 input rst;
 
 assign clock_in = ~CLK;
 wire clock_in, clock_output;
 output [31:0] out_ALU;
 
 output [31:0] Read_Data1,Read_Data2,Address_in_PC,Address_out_PC,Address_Add_PC,instruction,Read_Data_Mem,instruction_Left;
 wire [31:0] Read_Data1;
 wire [31:0] Read_Data2;
 wire [31:0] Address_in_PC,Address_out_PC;
 wire [31:0] Address_Add_PC;
 wire [31:0] instruction;
 wire RegDst,Jump,Branch,MemtoReg,ALUSrc,RegWrite,MemWrite,MemRead;
 wire [1:0] ALUop;
 wire [5:0] Write_register;
 wire [31:0] Write_Data; 
 wire [31:0] sign,out_sign,ALU1,out_ALU;
 wire [31:0] ALU_Add_32_out,Branch_or_normal;
 wire [3:0] ALU_ctr;
 wire [31:0] Read_Data_Mem;
 wire [31:0] instruction_Left;
 wire zero,Mux32_EN;
 
 output RegWrite, MemWrite, MemRead;
 //Determina a velocidade do clock para possíveis teste no futuro
 //Clock do sistema é de 25Mhz
 //Sem parametro ou igual a 25x(10^6), o tempo para cada instrção será de 1s.
 ClockManager #(0) clock(rst, clock_in, clock_output); 
 PC program_counter(clock_output,Address_in_PC,Address_out_PC,rst);
 Add_PC NextAdress(Address_out_PC,Address_Add_PC);
 ROM Instruction_memory(Address_out_PC[6:2], clock_output, instruction);
 Control_Unit UC(instruction[31:26],RegDst,Jump,Branch,MemRead,MemtoReg,ALUop,MemWrite,ALUSrc,RegWrite);
 MUX #(6) Rgst(instruction[20:16],instruction[15:11],RegDst,Write_register);
 Registers(instruction[25:21],instruction[20:16],Write_register,Write_Data,Read_Data1,Read_Data2,RegWrite,clock_output);
 sign_ep SignalExtend(instruction[15:0],sign);
 MUX #(32) Alu_in (Read_Data2,sign,ALUSrc,ALU1);
 ALU_Control ALUc(ALUop,instruction[5:0],ALU_ctr);
 ALU ULA(ALU_ctr,Read_Data1,ALU1,zero,out_ALU);
 RAM DataMemory(out_ALU,Read_Data2,clock_output,MemWrite,MemRead, Read_Data_Mem);
 MUX #(32) AluOut(out_ALU,Read_Data_Mem,MemtoReg,Write_Data);
 Left2(sign,out_sign);
 ALU_Add_32 FinalAdress(Address_Add_PC,out_sign,ALU_Add_32_out);
 and(Mux32_EN,Branch,zero);
 MUX #(32) Branchs(Address_Add_PC,ALU_Add_32_out,Mux32_EN,Branch_or_normal);
 Left2_26(instruction[25:0],Address_Add_PC[31:28],instruction_Left);
 MUX #(32) jump(Branch_or_normal,instruction_Left,Jump,Address_in_PC);
 
 
endmodule

