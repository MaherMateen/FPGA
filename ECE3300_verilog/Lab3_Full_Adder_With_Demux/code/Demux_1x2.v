`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 08:55:24 PM
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
                #(parameter size = 16)
                (
                    input wire [size-1:0] in1,
                    input wire sel,
                    output reg [size-1:0] outputA,
                    output reg [size-1:0] outputB
                 );
                 
                 always @ (in1 or sel)
                 begin
                      if (sel == 1)
                      outputB = in1;
                      else
                      outputA = in1;
                 end
endmodule
