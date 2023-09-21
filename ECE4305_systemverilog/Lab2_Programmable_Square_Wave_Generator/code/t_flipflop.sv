`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2023 06:58:12 PM
// Design Name: 
// Module Name: t_flipflop
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


module t_flipflop 
    (
    input logic clk,     
    input logic rst,     
    input logic tog,      
    output logic q       
    );

  always @(posedge clk or posedge rst) begin
    if (rst) 
      q <= 1'b0;  
    else if (tog)
      q <= ~q;
  end

endmodule
