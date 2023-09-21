`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 08:56:01 PM
// Design Name: 
// Module Name: Full_Adder_With_Demux_tb
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


module Full_Adder_With_Demux_tb
                              #(parameter size = 16)
                               (

                                );
                  
                  
                  reg [size-1:0] in_tb;
                  reg D_Sel_tb, Cin_tb, En_tb;
                  wire Cout_tb;
                  wire [size-1:0] Sum_tb;
                  
                  Full_Adder_With_Demux X(.in(in_tb),
                                          .D_Sel(D_Sel_tb),
                                          .Cin(Cin_tb),
                                          .En(En_tb),
                                          .Cout(Cout_tb),
                                          .Sum(Sum_tb)
                                          );
                  
                  integer j, k;
                  initial
                     begin
                        En_tb = 0;
                        Cin_tb = 0;
                        D_Sel_tb = 1'b1;
                        in_tb = 16'h0000;
                        #1
                        D_Sel_tb = 1'b0;
                        #1
                        for (j = 0; j < 2; j = j+1)
                        begin
                            for (k = 0; k < 35000; k = k+1000)
                            begin
                                if (k > 15000 && En_tb != 1) begin
                                    k = 0;
                                    En_tb = 1;
                                end
                                in_tb = k;
                                #5
                                Cin_tb = 0;
                                #5
                                Cin_tb = 1;;
                            end
                            D_Sel_tb = 1'b1;  
                        end
                   $finish;
                   end      
endmodule
