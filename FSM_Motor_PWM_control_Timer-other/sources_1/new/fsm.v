`timescale 1ns / 1ps

module fsm(
        input i_clk, i_reset, i_state,
        input[4:0] i_btn,
        output[2:0] o_speed_state
    );

    parameter   S_SPEED_0 = 3'b000,
                S_SPEED_1 = 3'b001,
                S_SPEED_2 = 3'b010,
                S_SPEED_3 = 3'b011,
                S_SPEED_4 = 3'b100;

    reg[2:0] r_curState, r_nextState;
    reg[2:0] r_speed_state;

    assign o_speed_state = r_speed_state;

    always @(posedge i_clk or posedge i_reset) begin
        if(i_reset) r_curState <= S_SPEED_0;
        else r_curState <= r_nextState;
    end
    

    always @(r_curState or i_btn) begin
        case (r_curState)
            S_SPEED_0 : begin
                if(i_btn[1]) r_nextState <= S_SPEED_1;
                else if(i_btn[2]) r_nextState <= S_SPEED_2;
                else if(i_btn[3]) r_nextState <= S_SPEED_3;
                else if(i_btn[4]) r_nextState <= S_SPEED_4;
                else if(i_btn[0]) r_nextState <= S_SPEED_0;
                else r_nextState <= S_SPEED_0;
            end 

            S_SPEED_1 : begin
                if(i_btn[1]) r_nextState <= S_SPEED_1;
                else if(i_btn[2]) r_nextState <= S_SPEED_2;
                else if(i_btn[3]) r_nextState <= S_SPEED_3;
                else if(i_btn[4]) r_nextState <= S_SPEED_4;
                else if(i_btn[0]) r_nextState <= S_SPEED_0;
                else r_nextState <= S_SPEED_1;
            end 

            S_SPEED_2 : begin
                if(i_btn[1]) r_nextState <= S_SPEED_1;
                else if(i_btn[2]) r_nextState <= S_SPEED_2;
                else if(i_btn[3]) r_nextState <= S_SPEED_3;
                else if(i_btn[4]) r_nextState <= S_SPEED_4;
                else if(i_btn[0]) r_nextState <= S_SPEED_0;
                else r_nextState <= S_SPEED_2;
            end 

            S_SPEED_3 : begin
                if(i_btn[1]) r_nextState <= S_SPEED_1;
                else if(i_btn[2]) r_nextState <= S_SPEED_2;
                else if(i_btn[3]) r_nextState <= S_SPEED_3;
                else if(i_btn[4]) r_nextState <= S_SPEED_4;
                else if(i_btn[0]) r_nextState <= S_SPEED_0;
                else r_nextState <= S_SPEED_3;
            end 

            S_SPEED_4 : begin
                if(i_btn[1]) r_nextState <= S_SPEED_1;
                else if(i_btn[2]) r_nextState <= S_SPEED_2;
                else if(i_btn[3]) r_nextState <= S_SPEED_3;
                else if(i_btn[4]) r_nextState <= S_SPEED_4;
                else if(i_btn[0]) r_nextState <= S_SPEED_0;
                else r_nextState <= S_SPEED_4;
            end 
            default: r_nextState <= S_SPEED_0;
        endcase
    end

    always @(r_curState) begin
        r_speed_state <= 3'bxxx;
        if(i_state) begin
            r_speed_state <= S_SPEED_0;
        end
        else begin
            case (r_curState)
                S_SPEED_0 : r_speed_state <= S_SPEED_0; 
                S_SPEED_1 : r_speed_state <= S_SPEED_1;
                S_SPEED_2 : r_speed_state <= S_SPEED_2;
                S_SPEED_3 : r_speed_state <= S_SPEED_3;
                S_SPEED_4 : r_speed_state <= S_SPEED_4;
                default : r_speed_state <= S_SPEED_0;
            endcase
        end
        
        
    end
endmodule