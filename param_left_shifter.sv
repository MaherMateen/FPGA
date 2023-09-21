`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/03/2023 12:08:50 PM
// Design Name: 
// Module Name: param_left_shifter
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



module param_left_shifter
    #(parameter N = 10)
    (
    input logic [N-1:0] in,
    input logic [$clog2(N)-1:0] amt,
    output logic [N-1:0] out
    );
    logic [N-1:0] temp [0:$clog2(N)-1];
    genvar i;
    assign temp[0]= amt[0] ? {in[N-2:0], in[N-1]} : in;
   generate
    for(i=1;i<$clog2(N);i=i+1)
        begin
           assign temp[i] = amt[i] ? {temp[i-1][N-(2**i+1):0], temp[i-1][N-1:N-(2**i)]} : temp[i-1];
        end
    endgenerate
    assign out = temp[$clog2(N)-1];
 
endmodule