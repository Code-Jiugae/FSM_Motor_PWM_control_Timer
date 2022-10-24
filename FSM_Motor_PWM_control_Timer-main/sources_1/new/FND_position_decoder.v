`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/14 13:00:40
// Design Name: 
// Module Name: FND_2x4_decoder
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


module FND_position_decoder(
    input [1:0] i_digit,
    output [3:0] o_position
    );

    reg [3:0] r_position;
    assign o_position = r_position;

    always @(*) begin
        case (i_digit)
            2'b00 : r_position <= 4'b1110; 
            2'b01 : r_position <= 4'b1101; 
            2'b10 : r_position <= 4'b1011; 
            2'b11 : r_position <= 4'b0111; 
        endcase
    end
endmodule
