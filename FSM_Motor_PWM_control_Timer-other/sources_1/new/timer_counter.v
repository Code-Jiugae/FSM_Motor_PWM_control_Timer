`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/14 15:13:42
// Design Name: 
// Module Name: timer_counter
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


module timer_counter(
        input i_clk,
        input i_reset,
        input[1:0] i_sw,
        output [5:0] o_sec,
        output [6:0] o_msec,
        output o_state
    );

    reg r_state = 0;
    reg[1:0] r_state_change = 0;
    reg[5:0] r_sec = 0;
    reg[9:0] r_msec = 0;

    assign o_sec = r_sec;
    assign o_msec = r_msec / 10;
    assign o_state = r_state;

    always @(posedge i_clk or posedge i_reset) begin
        if(i_sw != r_state_change) begin
            r_sec <= 0;
            r_msec <= 0;
            r_state <= 0;
        end

        if(i_reset) begin
            r_sec <= 0;
            r_msec <= 0;
            r_state <= 0;
            r_state_change = 0;
        end
        else begin
            if(r_msec == 999) begin
                r_msec <= 0;
                case (i_sw)
                    2'b00 : begin
                        r_state_change <= 0;
                        if(r_sec >= 59) begin
                            r_sec <= 0;
                            r_state <= 0;
                        end
                        else begin
                            r_sec <= r_sec + 1;
                            r_state <= 0;
                        end
                    end
                    2'b01 : begin
                        r_state_change <= 1;
                        if(r_sec >= 10 -1) begin
                            r_sec <= 10;
                            r_state <= 1;
                        end
                        else begin
                            r_sec <= r_sec + 1;
                            r_state <= 0;
                        end
                    end
                    2'b10 : begin
                        r_state_change <= 2;
                        if(r_sec >= 20 -1) begin
                            r_sec <= 20;
                            r_state <= 1;
                        end
                        else begin
                            r_sec <= r_sec + 1;
                            r_state <= 0;
                        end
                    end
                    2'b11 : begin
                        r_state_change <= 3;
                        if(r_sec >= 30 -1) begin
                            r_sec <= 30;
                            r_state <= 1;
                        end
                        else begin
                            r_sec <= r_sec + 1;
                            r_state <= 0;
                        end
                    end
                    // default : r_sec <= r_sec + 1;
                    
                endcase
            end

            else begin
                r_msec <= r_msec + 1;
            end
                
        end
            

    end
        
endmodule
