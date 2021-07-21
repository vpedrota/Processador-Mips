module ClockManager 
#(parameter N_COUNT = 25000000) 
(input rst, clk, output reg clk_output);

initial

begin
	clk_output = 1;
end

integer count = 1;

always@(posedge clk)
	begin
		if (!rst)
		begin
			count <= 0;
			clk_output <= 0;
		end
		else
		begin		
			if (count<N_COUNT)
			begin
				count <= count + 1;
			end
			else begin
				count <= 0;
				clk_output <= ~clk_output;
			end
		end
	end

endmodule