`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:28:31 11/27/2017 
// Design Name: 
// Module Name:    Cloc_divider 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module faster_clock_divider(
    input in_clk, 
    output reg out_clk);
	
	reg[15:0] count;

	initial begin
		count <= 33'b0;
		out_clk <= 1'b0;
	end
	
	always @(negedge in_clk)
	begin
		// increment count by one (use blocking assignment)

		count = count + 1;
		
		// if count equals to some big number (that you need to calculate),
		//     (Think: how many input clock cycles do you need to see 
		//     for it to be half a second)

		if (count == 16'd50_000) begin
			out_clk <= ~out_clk;
			count <= 16'b0;
			
		end
		
		//     then flip the output clock,   (use non-blocking assignment)
		//     and reset count to zero.      (use non-blocking assignment)
	end


endmodule