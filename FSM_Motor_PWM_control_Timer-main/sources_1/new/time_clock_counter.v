`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/15 15:34:58
// Design Name: 
// Module Name: time_clock_counter
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


module time_clock_counter(
    input i_clk, i_reset, i_timer_mode, i_offButton,
    input [4:0] i_timeState,
    output [4:0] o_counter
    );

    reg [9:0] r_counter = 0;
    reg [4:0] r_sec = 0;
    assign o_counter = r_sec;

    always @(posedge i_clk or posedge i_reset or posedge i_offButton) begin
        if(i_reset) begin
            r_counter <= 0;
            r_sec <= 0;
        end
        else if(i_offButton) begin
            r_counter <= 0;
            r_sec <= 0;
        end
        else if(i_timer_mode) begin
            if(r_counter == 999) begin
                r_counter <= 0;
                r_sec <= r_sec + 1;
            end
            else if(r_sec == i_timeState) begin
                r_counter <= 0;
            end
            else r_counter <= r_counter + 1;
        end
        else begin
            r_counter <= 0;
            r_sec <= 0;
        end
    end
endmodule
