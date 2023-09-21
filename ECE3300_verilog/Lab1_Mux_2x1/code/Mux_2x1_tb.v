`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 08:29:34 PM
// Design Name: 
// Module Name: Mux_2x1_tb
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


module Mux_2x1_tb(
    
                  );
    
              reg [3:0] a_tb;
              reg [3:0] b_tb;
              reg Sel_tb;
              wire [3:0] c_tb;
                  
              Mux_2x1 X (
                         .a(a_tb),
                         .b(b_tb),
                         .Sel(Sel_tb),
                         .c(c_tb)
                         );
                  
              initial
                   begin
                        a_tb = 4'b0100;
                        b_tb = 4'b1001;
                        Sel_tb = 1'b0;
                        #10
                        Sel_tb = 1'b0;
                        #10
                        Sel_tb = 1'b1;
                        #100
                        $finish;
                   end
endmodule
