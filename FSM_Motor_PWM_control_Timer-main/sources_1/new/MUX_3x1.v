`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/15 15:53:19
// Design Name: 
// Module Name: MUX_3x1
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


module MUX_3x1(
    input [2:0] i_time,
    input [1:0] i_time_state,
    output o_time
    );

    reg r_time;
    assign o_time = r_time;

    always @(*) begin
        case(i_time_state)
            2'b00 : r_time <= 1'b0;
            2'b01: r_time <= i_time[0];
            2'b10 : r_time <= i_time[1];
            2'b11 : r_time <= i_time[2];
        endcase
    end
endmodule
