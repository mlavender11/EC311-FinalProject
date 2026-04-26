`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2023 09:05:20 AM
// Design Name: 
// Module Name: counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module counter(
        input clock, // 100 MHz clock from the board
        output [6:0] cathode,
        output [7:0] anode
    );
    wire seconds_clock; // 1 Hz
	wire fsm_clock;     // 1 kHz
    reg [15:0] counter; // this is the number we want to display

    clock_divider clk_div(.in_clk(clock), .out_clk(seconds_clock));
    faster_clock_divider fast_clk_div(.in_clk(clock), .out_clk(fsm_clock));
	fsm fsm(.clock(fsm_clock), .sixteen_bit_number(counter), .cathode(cathode), .anode(anode));
    
    initial begin
        counter = 16'b0;
    end
    
    always @(posedge seconds_clock)
	begin
		counter = counter + 1;
	end
	
endmodule
