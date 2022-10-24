`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/15 14:47:29
// Design Name: 
// Module Name: FSM_Time
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


module FSM_Time(
    input i_clk, i_reset,
    input [1:0] i_button,
    input i_offButton,
    input [2:0] i_pwm_state,
    output [4:0] o_timeState
    );

    parameter TRUE = 1'b1, FALSE = 1'b0;
    parameter TIME0 = 2'b00, TIME1 = 2'b01, TIME2 = 2'b10, TIME3 = 2'b11;
    reg [1:0] curState= TIME0, nextState;
    reg [4:0] r_timeState = 5'd0, time_curState, time_prevState = 0;
    assign o_timeState = r_timeState;

    always @(posedge i_clk or posedge i_reset) begin
        if(i_reset) begin
            curState <= TIME0;
        end
        else begin
            if(i_pwm_state == 0) begin
                curState <= TIME0;
            end
            else curState <= nextState;
        end
    end

    always @(curState or i_clk or i_button or i_offButton) begin
        case (curState)
            TIME0 :
            if(i_button[0] == TRUE) begin
                nextState <= TIME1;
            end
            else if(i_offButton == TRUE) begin
                nextState <= TIME0;
            end
            else nextState <= TIME0;

            TIME1 :
            if(i_button[0] == TRUE) begin
                nextState <= TIME2;
            end
            else if(i_button[1] == TRUE) begin
                nextState <= TIME0;
            end
            else if(i_offButton == TRUE) begin
                nextState <= TIME0;
            end
            else nextState <= TIME1;

            TIME2 :
            if(i_button[0] == TRUE) begin
                nextState <= TIME3;
            end
            else if(i_button[1] == TRUE) begin
                nextState <= TIME1;
            end
            else if(i_offButton == TRUE) begin
                nextState <= TIME0;
            end
            else nextState <= TIME2;

            TIME3 :
            if(i_button[0] == TRUE) begin
                nextState <= TIME3;
            end
            else if(i_button[1] == TRUE) begin
                nextState <= TIME2;
            end
            else if(i_offButton == TRUE) begin
                nextState <= TIME0;
            end
            else nextState <= TIME3;
            
            default: nextState <= TIME0;
        endcase
    end

    always @(curState) begin
        case(curState)
        TIME0 : r_timeState <= 5'd0;
        TIME1 : r_timeState <= 5'd10;
        TIME2 : r_timeState <= 5'd20;
        TIME3 : r_timeState <= 5'd30;
        endcase
    end
endmodule
