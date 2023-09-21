`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 08:40:21 PM
// Design Name: 
// Module Name: Decoder_4x16
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


module Decoder_4x16(
                    input wire [3:0] a,
                    input wire EN,
                    output wire [15:0] F
                    );
                    
              and(F[0], ~a[3], ~a[2], ~a[1], ~a[0], EN);
              and(F[1], ~a[3], ~a[2], ~a[1], a[0], EN);
              and(F[2], ~a[3], ~a[2], a[1], ~a[0], EN);
              and(F[3], ~a[3], ~a[2], a[1], a[0], EN);
              and(F[4], ~a[3], a[2], ~a[1], ~a[0], EN);
              and(F[5], ~a[3], a[2], ~a[1], a[0], EN);
              and(F[6], ~a[3], a[2], a[1], ~a[0], EN);
              and(F[7], ~a[3], a[2], a[1], a[0], EN);
              and(F[8], a[3], ~a[2], ~a[1], ~a[0], EN);
              and(F[9], a[3], ~a[2], ~a[1], a[0], EN);
              and(F[10], a[3], ~a[2], a[1], ~a[0], EN);
              and(F[11], a[3], ~a[2], a[1], a[0], EN);
              and(F[12], a[3], a[2], ~a[1], ~a[0], EN);
              and(F[13], a[3], a[2], ~a[1], a[0], EN);
              and(F[14], a[3], a[2], a[1], ~a[0], EN);
              and(F[15], a[3], a[2], a[1], a[0], EN);     
                  
endmodule
