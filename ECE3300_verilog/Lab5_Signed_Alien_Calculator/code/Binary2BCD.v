`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 09:29:12 PM
// Design Name: 
// Module Name: Binary2BCD
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


module Binary2BCD(
                    input wire [3:0] dig,
                    input wire [2:0] sel,
                    output reg [6:0] A_to_G
                  );
                  
                  // Truth table for 7-seg display
                  always @ (dig or sel)
                  begin
                    if (dig == 1 && (sel == 1 || sel == 3 || sel == 7))
                        A_to_G = 7'b1001110;        // Negative sign
                    else if (dig == 0 && (sel == 1 || sel == 3 || sel == 7))
                        A_to_G = 7'b0110010;        // Positive sign
                    else
                    begin
                        case (dig)
                            0:A_to_G = 7'b0000001;
                            1:A_to_G = 7'b1001111;
                            2:A_to_G = 7'b0010010;
                            3:A_to_G = 7'b0000110;
                            4:A_to_G = 7'b1001100;
                            5:A_to_G = 7'b0100100;
                            6:A_to_G = 7'b0100000;
                            7:A_to_G = 7'b0001111;
                            8:A_to_G = 7'b0000000;
                            9:A_to_G = 7'b0000100;
                            'hA:A_to_G = 7'b0001000;    
                            'hB:A_to_G = 7'b1100000;
                            'hC:A_to_G = 7'b0110001;
                            'hD:A_to_G = 7'b1000010;
                            'hE:A_to_G = 7'b0110000;
                            'hF:A_to_G = 7'b0111000;
                            default: A_to_G = 7'b1111111;
                        endcase
                     end
                  end
endmodule
