`timescale 1ns / 1ps

module LED(
        input[2:0] i_led_state,
        output[3:0] o_led  
    );

    // assign o_led = i_led_state;

    parameter   S_LED_0 = 3'b000,
                S_LED_1 = 3'b001,
                S_LED_2 = 3'b010,
                S_LED_3 = 3'b011,
                S_LED_4 = 3'b100;

    reg[3:0] r_led = 4'b0000;
    assign o_led = r_led;

    always @(*) begin
        case (i_led_state)
            S_LED_0 : r_led <= 4'b0000;
            S_LED_1 : r_led <= 4'b0001; 
            S_LED_2 : r_led <= 4'b0011; 
            S_LED_3 : r_led <= 4'b0111; 
            S_LED_4 : r_led <= 4'b1111; 
            default: r_led <= 4'b0000;
        endcase
   end 
endmodule
