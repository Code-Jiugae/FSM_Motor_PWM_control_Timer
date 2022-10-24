`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/15 16:46:54
// Design Name: 
// Module Name: digit_divider
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


module digit_divider(
    input [3:0] i_value,
    input [4:0] i_timeState,
    output [3:0] o_four, o_three, o_two, o_one
    );
    
    assign o_four = i_timeState/10%10;
    assign o_three = i_timeState%10;
    assign o_two = i_value/10%10;
    assign o_one = i_value%10;
endmodule
