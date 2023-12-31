`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2023 12:36:37 PM
// Design Name: 
// Module Name: rising_edge_detect_mealy
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


module rising_edge_detect_mealy   
    (
        input logic clk, reset,
        input logic level,
        output logic tick
    );
    
    // fsm state type
    typedef enum {zero, one} state_type;
    
    // signal declaration
    state_type state_reg, state_next;
    
    // [1] State register
    always_ff @(posedge clk, posedge reset)
    begin
        if(reset)
            state_reg <= zero;
        else
            state_reg <= state_next;
    end
    
    // [2] next-state logic & output logic (Mealy)
    always_comb
    begin
        tick = 1'b0;
        state_next = zero;
        case(state_reg)
            zero:
                if(level)
                begin
                    tick = 1'b1;
                    state_next = one;
                end
            one:
                if(level)
                begin
                    state_next = one;
                end
            default: state_next = zero;
        endcase
    end
endmodule