`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 10:04:18 PM
// Design Name: 
// Module Name: Demux_1x8
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


module Demux_1x8(
                  input [3:0] inp,
                  input [2:0] D_sel,
                  output reg [31:0] oup,
                  output reg [7:0] selected
                 );
                 
                 reg [3:0] newInp;
                 always @ (inp or D_sel)
                 begin
                    selected = 8'b00000000;
                    
                    newInp = inp;
                    selected[D_sel] = 1;
                    if (newInp > 9) // Cap 4-bit input to 4'd9 to prevent mixing Hex and BCD on 7-seg display
                        newInp = 9;
                 
                    case (D_sel)
                        0: oup[3:0] = newInp; 
                        1: oup[7:4] = newInp;
                        2: oup[11:8] = newInp;
                        3: oup[15:12] = newInp;
                        4: oup[19:16] = newInp;
                        5: oup[23:20] = newInp;
                        6: oup[27:24] = newInp;
                        7: oup[31:28] = newInp;
                        default: oup[3:0] = newInp;
                    endcase
                 end
endmodule
