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

module bits_to_shift(
                     input CLK,
                     input MODE,
                     input LOAD,
                     input [3:0] SEL,
                     output reg [3:0] P
                     );
                     
                     parameter incrRate = 100000000;            // Increments counter every 1 second
                     
                     reg [26:0] count;
                     
                     always @(posedge CLK)
                     begin
                        if (LOAD == 1)
                        begin
                            P = SEL;
                            count = 0;
                        end
                        else
                        begin
                            if (MODE == 1)                          // Automatic Mode
                            begin
                                count = count+1;
                                if (count == incrRate)
                                begin
                                    P = P+1;
                                    count = 0;
                                end
                            end
                            else                                    // Manual Mode
                                P = SEL;
                         end
                     end
endmodule