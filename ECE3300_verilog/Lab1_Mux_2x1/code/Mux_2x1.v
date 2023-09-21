`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 08:28:05 PM
// Design Name: 
// Module Name: Mux_2x1
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


module Mux_2x1(
                input wire [3:0] a,
                input wire [3:0] b,
                input wire Sel,
                output reg [3:0] c
               );
               
           always @(a or b or Sel)
           begin
                if (Sel) 
                c = b;
                else 
                c = a;
           end
           
endmodule
