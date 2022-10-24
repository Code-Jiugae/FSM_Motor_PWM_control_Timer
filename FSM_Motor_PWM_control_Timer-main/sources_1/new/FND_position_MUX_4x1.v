`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/15 17:06:31
// Design Name: 
// Module Name: FND_position_MUX_4x1
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


module FND_position_MUX_4x1(
    input [3:0] i_four, i_three, i_two, i_one,
    input [1:0] i_sel,
    output [3:0] o_value
    );

    reg [3:0] r_value;
    assign o_value = r_value;

    always @(i_sel) begin
        case (i_sel)
            2'b00 : r_value = i_one;
            2'b01 : r_value = i_two;
            2'b10 : r_value = i_three;
            2'b11 : r_value = i_four;
        endcase
    end
endmodule
