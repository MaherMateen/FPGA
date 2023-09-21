`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 10:06:55 PM
// Design Name: 
// Module Name: clk_divider
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


`define const 100000000     // Half period is 1 second by default

module clk_divider(
                    input clk,
                    input rst,
                    input [4:0] clk_speed,
                    output reg clk_div
                   );
                   
                   reg [31:0] count;
                   
                   always @ (posedge clk or posedge rst)
                   begin
                        if (rst == 1'b1)
                        begin
                            count <= 32'b0;
                        end
                        else if (count >= `const - 1)
                        begin
                            count <= 32'b0;
                        end
                        else
                        begin
                            count <= count + 1 + clk_speed;
                        end
                   end
                   
                   always @ (posedge clk or posedge rst)
                   begin
                        if (rst == 1'b1)
                        begin
                            clk_div <= 1'b0;
                        end
                        else if (count >= `const - 1)
                        begin
                            clk_div <= ~clk_div;
                        end
                        else
                        begin
                            clk_div <= clk_div;
                        end
                   end
                   
endmodule
