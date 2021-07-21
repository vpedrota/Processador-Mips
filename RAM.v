module RAM 
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=32)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] addr,
	input MemWrite, MemRead, clk,
	output [(DATA_WIDTH-1):0] q
);
	
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	reg [ADDR_WIDTH-1:0] addr_reg;

	always @ (posedge clk)
	begin
		
		if (MemWrite & ~MemRead)
			ram[addr[6:2]] <= data;

		addr_reg <= addr;
		
	end
	assign q = ram[addr_reg[6:2]];

endmodule
