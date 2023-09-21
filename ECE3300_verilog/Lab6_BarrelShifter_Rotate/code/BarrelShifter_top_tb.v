`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 09:44:26 PM
// Design Name: 
// Module Name: BarrelShifter_top_tb
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


module BarrelShifter_top_tb
                        #(parameter WIDTH = 16)
                           (

                            );
                            reg clk_tb = 0; 
                            reg mode_tb, in_select_tb, load_tb;
                            reg [(WIDTH/2)-1:0] in_tb;
                            reg [1:0] OP_tb;
                            reg [3:0] sel_tb;
                            
                            wire [6:0] a_to_g_tb;
                            wire [7:0] AN_tb;
                            wire DP_tb;
                            
                            BarrelShifter_top UUT(.clk(clk_tb),
                                                  .mode(mode_tb),
                                                  .in_select(in_select_tb),
                                                  .load(load_tb),
                                                  .in(in_tb),
                                                  .OP(OP_tb),
                                                  .sel(sel_tb),
                                                  .a_to_g(a_to_g_tb),
                                                  .AN(AN_tb),
                                                  .DP(DP_tb)
                                                  );
                                                  
                            always
                            begin
                            #1
                                clk_tb = ~clk_tb;
                            end
                            
                            integer i, j;
                            // Not testing Automatic Mode since counter increments every 1 second (timescale is in ns)
                            initial
                            begin;
                               load_tb = 0;
                               OP_tb = 2'b00;           // Rotate Left
                               mode_tb = 0;             // Manual Mode
                               in_select_tb = 1'b1;
                               in_tb = 8'h7F;
                               sel_tb = 4'b0000;        // Initially Rotate Left 0 bits
                               #10
                               in_select_tb = 1'b0;     // Original is 0x7FFF (0111 1111 1111 1111)
                               in_tb = 8'hFF;
                               #10
                               sel_tb = 4'b0001;        // Rotate original Left 1 bit    Output should be 0xFFFE (1111 1111 1111 1110)                    
                               #20                     
                               OP_tb = 2'b01;           // Rotate original Right 1 bit   Output should be 0xBFFF (1011 1111 1111 1111)
                               #1
                               for (i = 2; i <=3 ; i=i+1)   // First iteration, Shift Left
                               begin                        // Second iteration, Shift Right
                                    OP_tb = i;
                                    #1
                                    for (j = 1; j <= 15; j=j+1)
                                    begin
                                        #40
                                        sel_tb = j;
                                    end
                               end
                               #40
                               load_tb = 0;
                               sel_tb = 4'b0101;
                               #20
                               load_tb = 1;         // Load 5
                               #20
                               load_tb = 0;
                               #10
                               $finish;
                            end                                      
endmodule