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


module Full_Adder
                 (
                    input inA,
                    input inB,
                    input CI,
                    input EN,
                    output wire SUM,
                    output wire CO
                  );  
                                                   
              assign SUM = (inA ^ inB ^ CI)&EN;
              assign CO = ((inA&inB) | (inA&CI) | (inB&CI))&EN;
endmodule