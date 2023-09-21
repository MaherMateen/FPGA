`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 10:05:25 PM
// Design Name: 
// Module Name: BCD_Up_Down_Counter_top
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


module BCD_Up_Down_Counter_top(
                                input clk,
                                input reset,
                                input load,
                                input [3:0] in,
                                input [2:0] sel,
                                input [4:0] speed,
                                input upDown,
                                input en,
                                output reg [7:0] AN,
                                output wire [6:0] a_to_g,
                                output wire DP
                               );
                               
                                parameter refreshRate = 6250;              // Rate at which we change from one 7-seg display to the next (1/16 ms)
                                                                                       
                                reg [2:0] SELECT;                          // Selects which 7-seg display
                                wire [7:0] AN_en;
                                reg [3:0] digit;                           // Digit being displayed
                                reg [12:0] refreshCount;                               
                                wire [31:0] outputValue;
                                wire clk_out;
                                
                                assign DP = 1'b1;                          // Turn off decimal point
                                assign AN_en = 8'b11111111;
                                
                                BCD_32 U1 (.CLK(clk_out),
                                           .rst(reset),
                                           .load(load),
                                           .EN(en),
                                           .upDown(upDown),
                                           .D_Sel(sel),
                                           .Inp(in),
                                           .outp(outputValue)
                                           );
                                           
                                // Mux to choose which display the digit to output to
                                always @ (posedge clk)
                                begin
                                    case (SELECT)
                                        0: digit <= outputValue[3:0];     
                                        1: digit <= outputValue[7:4];     
                                        2: digit <= outputValue[11:8];
                                        3: digit <= outputValue[15:12];
                                        4: digit <= outputValue[19:16];
                                        5: digit <= outputValue[23:20];
                                        6: digit <= outputValue[27:24];
                                        7: digit <= outputValue[31:28];
                                        default: digit <= outputValue[3:0];
                                    endcase
                                end
                                
                                x7Seg U2 (.dig(digit),
                                          .A_to_G(a_to_g)
                                          );
                                          
                                clk_divider U3 (.clk(clk),
                                                .rst(reset),
                                                .clk_speed(speed),
                                                .clk_div(clk_out)
                                                );
                                          
                                // Choose which displays to turn on and when
                                always @(*)
                                begin
                                    AN=8'b11111111;
                                    if(AN_en[SELECT] == 1)
                                        AN[SELECT] = 0;
                                end
                                
                                // Updates 'select' every 1/16 ms
                                always @(posedge clk)
                                begin
                                    refreshCount <= refreshCount + 1;
                                    if (refreshCount == refreshRate)
                                    begin
                                        SELECT <= SELECT + 1;
                                        refreshCount <= 0;
                                    end
                                end
endmodule
