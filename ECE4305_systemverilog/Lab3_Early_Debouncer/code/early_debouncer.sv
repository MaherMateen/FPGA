`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2023 11:57:57 AM
// Design Name: 
// Module Name: early_debouncer
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


module early_debouncer(
        input logic sw,
        input logic reset,
        input logic clk, // genrally the 100MHz
        output logic db, sw_out
    );
    assign sw_out = sw;
    // 10 ms m_tick generator
    // assuming clk is 100 MHz (clock period is 10 ns)
    // 10 ms / 10 ns is 10e-3 / 10e-9 which is 1_000_000
    logic m_tick;
    mod_m_counter #(.M(2)) ticker (
                    .clk(clk),
                    .reset(reset),  
                    .q(),
                    .max_tick(m_tick)
    );
    
    
    // There is a bug somewhere here, if you click the switch many times and fast enough the output disappears
    typedef enum {zero, wait1_1, wait1_2, wait1_3, one, wait0_1, wait0_2, wait0_3} state_type;
    
    // signal declarations
    state_type state_reg, state_next;
    
    // state register
    always_ff @(posedge clk, posedge reset)
        if(reset)
            state_reg <= zero;
        else
            state_reg <= state_next;
            
    
    // next-state logic
    always_comb
    begin
        case(state_reg)
            zero:
                    
                    if(sw)
                    begin
                        state_next = wait1_1;
                       // db = 1'b1;
                    end
                    else
                    begin
                        state_next = zero;
                      //  db = 1'b0;
                    end
            wait1_1:
                        if(m_tick)
                        begin
                            state_next = wait1_2;
                           // db = 1'b1;
                        end
                        else
                            state_next = wait1_1;                
            wait1_2:
                     
                        if(m_tick)
                        begin      
                            state_next = wait1_3;
                           // db = 1'b1;
                        end
                        else
                            state_next = wait1_2;
                                   
            wait1_3:
                        if(m_tick)
                        begin
                            state_next = one;
                           // db = 1'b1;
                        end
                        else 
                            state_next = wait1_3;
                        
            one:
                    if(~sw)
                        begin
                        state_next = wait0_1;
                       // db = 1'b0;
                        end
                    else
                        state_next = one;
            wait0_1:
                  
                        if(m_tick)
                        begin
                            state_next = wait0_2;
                            //db = 1'b0;
                        end
                        else
                            state_next = wait0_1;         
            wait0_2:
                    
                        if(m_tick)
                        begin
                            state_next = wait0_3;
                           // db = 1'b0;
                        end
                        else 
                            state_next = wait0_2;
                                    
            wait0_3:
                    
                        if(m_tick)
                        begin
                            state_next = zero;
                           //db = 1'b0;
                        end
                        else
                            state_next = wait0_3;
    
            default: state_next = zero;
        endcase
    end
    
     assign db = (   (state_reg == one) || 
                    (state_reg == wait1_1) || 
                    (state_reg == wait1_2) || 
                    (state_reg == wait1_3));
    
endmodule