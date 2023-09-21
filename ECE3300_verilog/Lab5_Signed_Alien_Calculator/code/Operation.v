`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 09:29:12 PM
// Design Name: 
// Module Name: Operation
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


module Operation(
                    input wire [4:0] A,
                    input wire [4:0] B,
                    input wire [5:0] mode,
                    output reg signed [8:0] val
                 );
                 
                 reg [3:0] x,y;
                 reg [3:0] twosCompA, twosCompB;
                 
                 always @ (A or B or mode)
                 begin
                     x = A[3:0];
                     y = B[3:0];
                     twosCompA = -A;
                     twosCompB = -B;
                     if (mode == 3)         // Addition
                     begin
                        if (A[4] == 1 && B[4] == 1)         // Both negative
                        begin
                            val[4:0] = x+y;
                            val[8] = 1;
                        end
                        else if (A[4] == 1 && B[4] != 1)    // A negative, B positive
                        begin
                            if (x >= y)
                            begin
                                val[4:0] =  x-y;
                                val[8] = 1;                        
                            end
                            else
                            begin
                                val[4:0] = y-x;
                                val[8] = 0;
                            end
                        end
                        else if (A[4] != 1 && B[4] == 1)    // A positive, B negative
                        begin
                            if (x >= y)
                            begin
                                val[4:0] =  x-y;
                                val[8] = 0;                        
                            end
                            else
                            begin
                                val[4:0] = y-x;
                                val[8] = 1;
                            end
                        end
                        else                                // Both positive
                        begin
                            val[4:0] = x+y;
                            val[8] = 0;
                        end
                     end
                     else if (mode == 12)    // Subtraction
                     begin
                         if (A[4] == 1 && B[4] == 1)         // Both negative
                         begin
                             if (x >= y)
                             begin
                                 val[4:0] =  x-y;
                                 val[8] = 1;                        
                             end
                             else
                             begin
                                 val[4:0] = y-x;
                                 val[8] = 0;
                             end
                         end
                         else if (A[4] == 1 && B[4] != 1)    // A negative, B positive
                         begin
                             val[4:0] = x+y;
                             val[8] = 1;
                         end
                         else if (A[4] != 1 && B[4] == 1)    // A positive, B negative
                         begin
                             val[4:0] = x+y;
                             val[8] = 0;
                         end
                         else                                // Both positive
                         begin
                             if (x >= y)
                             begin
                                 val[4:0] =  x-y;
                                 val[8] = 0;                        
                             end
                             else
                             begin
                                 val[4:0] = y-x;
                                 val[8] = 1;
                             end
                         end
                     end
                     else if (mode == 48)    // Multiplication
                     begin
                        val = x*y;
                        if (A[4] == B[4])
                            val[8] = 0;
                        else
                            val[8] = 1;
                     end
                     else                   // Clear to 0 if no operation is taking place
                        val = 0;
                 end
                 
endmodule
