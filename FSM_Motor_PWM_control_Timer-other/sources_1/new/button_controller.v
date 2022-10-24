`timescale 1ns / 1ps

module button_controller(
        input i_clk,
        input i_reset,
        input i_btn,
        output o_btn
    );

    parameter   PUSHED      = 1'b1,
                RELEASED    = 1'b0,
                TRUE        = 1'b1,
                FALSE       = 1'b0;

    parameter   DEBOUNCE    = 500_000; //10ms(100Mhz)

    reg r_prevState = RELEASED;
    reg r_btn;

    reg[31:0] r_counter = 0;

    assign o_btn = r_btn;

    always @(posedge i_clk or posedge i_reset) begin
        if(i_reset)begin
            r_btn <= FALSE;
            r_prevState <= RELEASED;
            r_counter <= 0;
        end
        else begin
            if((i_btn == PUSHED) && (r_prevState == RELEASED) && (r_counter < DEBOUNCE))
            begin
                r_counter <= r_counter + 1;
                r_btn <= FALSE;
            end
            else if((i_btn == PUSHED) && (r_prevState == RELEASED) && (r_counter == DEBOUNCE))
            begin
                r_counter <= 0;
                r_prevState <= PUSHED;
                r_btn <= FALSE;
            end

            else if((i_btn == RELEASED) && (r_prevState == PUSHED) && (r_counter < DEBOUNCE))
            begin
                r_counter <= r_counter + 1;
                r_btn <= FALSE;
            end

            else if((i_btn == RELEASED) && (r_prevState == PUSHED) && (r_counter == DEBOUNCE))
            begin
                r_counter <= 0;
                r_prevState <= PUSHED;
                r_btn <= TRUE;
            end

            else begin
                r_btn <= FALSE;
            end
        end
        
    end
endmodule