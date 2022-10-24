`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/15 16:54:32
// Design Name: 
// Module Name: FND_position_counter
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


module FND_position_counter(
    input i_clk, input i_reset,
    output [1:0] o_digit
    );

    reg [1:0] r_counter = 2'b00;
    assign o_digit = r_counter;

    always @(posedge i_clk or posedge i_reset) begin
        if(i_reset) begin
            r_counter <= 0;
        end
        else r_counter <= r_counter + 1;
    end
endmodule
