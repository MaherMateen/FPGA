`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2023 06:40:19 PM
// Design Name: 
// Module Name: mux2x1
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


module mux2x1 
#(parameter N = 4)
(
    input logic [N-1:0] in1,       
    input logic [N-1:0] in0,       
    input logic selq,     
    output logic [N-1:0] y       
);

  assign y = (selq == 1'b1) ? in1 : in0;

endmodule
