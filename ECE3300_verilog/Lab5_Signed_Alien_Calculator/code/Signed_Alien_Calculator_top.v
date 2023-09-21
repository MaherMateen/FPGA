`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 09:31:57 PM
// Design Name: 
// Module Name: Signed_Alien_Calculator_top
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


module Signed_Alien_Calculator_top(
                                    input clk,
                                    input [4:0] portA,
                                    input [4:0] portB,
                                    input [5:0] MODE,
                                    output wire [6:0] a_to_g,
                                    output wire DP,
                                    output reg [7:0] AN
                                   );
                                   
                                   parameter refreshRate = 6250;         // Rate at which we change from one 7-seg display to the next (1/16 ms)
                                   
                                   wire [7:0] AN_en;
                                   wire [8:0] value;
                                   reg [2:0] select;
                                   reg [12:0] refreshCount;
                                   reg [3:0] digit;
                                   reg [2:0] sign;
                                   
                                   assign DP = 1'b1;               // Turn off decimal point
                                   assign AN_en = 8'b11111111;
                                   
                                   always @ (portA or portB or value)
                                   begin
                                        sign[0] = portA[4];
                                        sign[1] = portB[4];
                                        sign[2] = value[8];
                                   end
                                   // Mux to choose which display the digit to output to
                                   always @ (posedge clk)
                                   begin
                                       case (select)
                                           0: digit <= portA[3:0];     
                                           1: digit <= sign[0];     
                                           2: digit <= portB[3:0];
                                           3: digit <= sign[1];
                                           4: digit <= 0;
                                           5: digit <= value[3:0];
                                           6: digit <= value[7:4];
                                           7: digit <= sign[2];   
                                           default: digit <= 0;
                                       endcase
                                   end
                                   
                                   Operation U1(.A(portA),
                                                .B(portB),
                                                .mode(MODE),
                                                .val(value)
                                                );
                                   
                                   Binary2BCD U2(.dig(digit),
                                                .sel(select),
                                                .A_to_G(a_to_g)
                                                );
                                   
                                   // Choose which displays to turn on and when
                                   always @(*)
                                   begin
                                       AN=8'b11111111;
                                       if(AN_en[select] == 1 && (select != 4))
                                           AN[select] = 0;
                                   end
                                   
                                   // Updates 'select' every 1/16 ms
                                   always @(posedge clk)
                                   begin
                                       refreshCount = refreshCount + 1;
                                       if (refreshCount == refreshRate)
                                           select = select + 1;
                                   end
endmodule
