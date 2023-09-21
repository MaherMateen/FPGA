`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 08:43:37 PM
// Design Name: 
// Module Name: Decoder_4x16_tb
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


module Decoder_4x16_tb(
    
                       );
                       
                 reg [3:0] a_tb;
                 reg EN_tb;
                 wire [15:0] F_tb;
                 
                 Decoder_4x16 X(
                                .a(a_tb),
                                .EN(EN_tb),
                                .F(F_tb)
                                );
                                
                 initial
                      begin
                           EN_tb = 1'b0;        // First testing all 16 possible input combinations with enable OFF
                           a_tb = 4'b0000;
                           #10                  
                           a_tb = 4'b0000;
                           #10
                           a_tb = 4'b0001;
                           #10
                           a_tb = 4'b0010;
                           #10
                           a_tb = 4'b0011;
                           #10
                           a_tb = 4'b0100;
                           #10
                           a_tb = 4'b0101;
                           #10
                           a_tb = 4'b0110;
                           #10
                           a_tb = 4'b0111;
                           #10
                           a_tb = 4'b1000;
                           #10
                           a_tb = 4'b1001;
                           #10
                           a_tb = 4'b1010;
                           #10
                           a_tb = 4'b1011;
                           #10
                           a_tb = 4'b1100;
                           #10
                           a_tb = 4'b1101;
                           #10
                           a_tb = 4'b1110;
                           #10
                           a_tb = 4'b1111;
                           #10
                           EN_tb = 1'b1;        // Now testing all 16 possible input combinations with enable ON
                           a_tb = 4'b0000;
                           #10
                           a_tb = 4'b0001;
                           #10
                           a_tb = 4'b0010;
                           #10
                           a_tb = 4'b0011;
                           #10
                           a_tb = 4'b0100;
                           #10
                           a_tb = 4'b0101;
                           #10
                           a_tb = 4'b0110;
                           #10
                           a_tb = 4'b0111;
                           #10
                           a_tb = 4'b1000;
                           #10
                           a_tb = 4'b1001;
                           #10
                           a_tb = 4'b1010;
                           #10
                           a_tb = 4'b1011;
                           #10
                           a_tb = 4'b1100;
                           #10
                           a_tb = 4'b1101;
                           #10
                           a_tb = 4'b1110;
                           #10
                           a_tb = 4'b1111;
                           #100
                           $finish;
                      end  
endmodule
