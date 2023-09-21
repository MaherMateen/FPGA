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

module Full_Adder_With_Demux
                             # (parameter size = 16)
                                (
                                 input wire [size-1:0] in,
                                 input wire D_Sel,
                                 input wire Cin,
                                 input wire En,
                                 output Cout,
                                 output [size-1:0] Sum
                                 );
                                 
                    wire [size:0] wire_RCA;
                    wire [size-1:0] inputA, inputB;
                    
                    Demux_1x2 DM(.in1(in),
                                 .sel(D_Sel),
                                 .outputA(inputA),
                                 .outputB(inputB)
                                 );
                    
                    assign wire_RCA[0] = Cin;
                    genvar i;
                    for (i = 0; i < size; i = i+1)
                    begin
                        Full_Adder FA(.inA(inputA[i]),
                                      .inB(inputB[i]),
                                      .CI(wire_RCA[i]),
                                      .EN(En),
                                      .SUM(Sum[i]),
                                      .CO(wire_RCA[i+1])
                                      );
                    
                    end
                    
                    assign Cout = wire_RCA[size];
                   
endmodule