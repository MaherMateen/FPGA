`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 10:07:52 PM
// Design Name: 
// Module Name: counter_BCD
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


module counter_BCD(
                   input clk,
                   input reset,
                   input load,
                   input EN_in,
                   input upDown,
                   input Select,
                   input [3:0] ip,
                   output reg [3:0] op,
                   output reg EN_out
                   );
                   
                   always @ (posedge clk or posedge reset)
                   begin
                        if (reset)
                        begin
                            if (upDown == 1)
                                op <= 4'd9;
                            else
                                op <= 4'd0;
                        end
                        else if (load == 1 && Select == 1)
                                op <= ip;
                        else
                        begin
                            if (EN_in == 1 && load != 1)
                            begin
                                if (upDown == 1)    // Down counter
                                begin
                                    if (op > 0)
                                        op <= op - 1;
                                    else
                                        op <= 4'd9;
                                end
                                else                // Up counter
                                begin
                                    if (op < 9)
                                        op <= op + 1;
                                    else
                                        op <= 4'd0;
                                end
                            end
                        end
                   end
                   
                   always @ (op or EN_in or upDown)
                   begin
                        if (op == 4'd9 && EN_in == 1 && upDown == 0)
                            EN_out <= 1;
                        else if (op == 4'd0 && EN_in == 1 && upDown == 1)
                            EN_out <= 1;
                        else
                            EN_out <= 0;
                   end
                   
endmodule
