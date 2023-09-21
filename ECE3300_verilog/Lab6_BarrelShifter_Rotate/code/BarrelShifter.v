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

module BarrelShifter
                   #(parameter WIDTH = 16)
                    (
                      input [WIDTH-1:0] a,
                      input [3:0] bits_to_S_R,
                      input [1:0] operation,
                      output wire [WIDTH-1:0] outp
                     );
                     
                     reg [WIDTH-1:0] temp1, temp2;
                     
                     always @ (*)
                     begin
                        temp2 = a;
                        
                        case (operation)
                            2'b00: temp1 = (temp2 << bits_to_S_R) | (temp2 >> (WIDTH-bits_to_S_R));      // Rotate Left
                            2'b01: temp1 = (temp2 >> bits_to_S_R) | (temp2 << (WIDTH-bits_to_S_R));      // Rotate Right
                            2'b10: temp1 = temp2 << bits_to_S_R;                                         // Shift Left
                            2'b11: temp1 = temp2 >> bits_to_S_R;                                         // Shift Right
                            default: temp1 = (temp2 << bits_to_S_R) | (temp2 >> (WIDTH-bits_to_S_R));    // Rotate Left by default
                        endcase
                     end
                     
                     assign outp = temp1;
endmodule