////memory contents: to be filled in later. hard code to test data for cp1. 
module memory_contents( input logic [14:0]	addr,
				  output logic [7:0]	data
					 );

	parameter ADDR_WIDTH = 15;
   parameter DATA_WIDTH =  8;
   logic [ADDR_WIDTH-1:0] addr_reg;

	parameter [0:2**ADDR_WIDTH-1][DATA_WIDTH-1:0] ROM = {32767{8'hEE}}; 
	assign data = ROM[addr];

endmodule  