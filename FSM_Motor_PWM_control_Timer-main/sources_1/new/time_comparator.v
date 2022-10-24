`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/15 15:50:35
// Design Name: 
// Module Name: time_comparator
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


module time_comparator(
    input [4:0] i_counter,
    input [4:0] i_timeState,
    input i_reset, i_clk,
    output [4:0] o_time
    );

    reg [4:0] r_sec;
    assign o_time = r_sec;
    
    always @(*) begin
        if(i_counter < i_timeState) begin
            r_sec <= i_timeState - i_counter;
        end
        else if(i_counter == i_timeState) begin
            r_sec <= 0;
        end
    end
endmodule
