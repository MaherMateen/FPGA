`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 10:08:31 PM
// Design Name: 
// Module Name: x7Seg
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


module x7Seg(
              input wire [3:0] dig,
              output reg [6:0] A_to_G
             );
                  
              // Truth table for 7-seg display (BCD)
              always @ (dig)
              begin
                    case (dig)
                        0:A_to_G = 7'b0000001;
                        1:A_to_G = 7'b1001111;
                        2:A_to_G = 7'b0010010;
                        3:A_to_G = 7'b0000110;
                        4:A_to_G = 7'b1001100;
                        5:A_to_G = 7'b0100100;
                        6:A_to_G = 7'b0100000;
                        7:A_to_G = 7'b0001111;
                        8:A_to_G = 7'b0000000;
                        9:A_to_G = 7'b0000100;
                        default: A_to_G = 7'b1111111;
                    endcase
              end
endmodule
