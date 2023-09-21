`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 09:41:57 PM
// Design Name: 
// Module Name: Demux_1x2
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


module Demux_1x2
               #(parameter WIDTH = 16)
                (
                 input [(WIDTH/2)-1:0] a,
                 input select,
                 output reg [WIDTH-1:0] b
                 );
                 
                 always @ (a or select)
                 begin
                      if (select == 1)              // Store in upper 8 bits
                      b[WIDTH-1:(WIDTH/2)] = a;
                      else                          // Store in lower 8 bits
                      b[(WIDTH/2)-1:0] = a;
                 end
endmodule
