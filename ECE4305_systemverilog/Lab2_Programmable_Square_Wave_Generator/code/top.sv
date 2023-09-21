`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2023 06:46:37 PM
// Design Name: 
// Module Name: top
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


module top 
    #(parameter N = 4)
(
    input logic clk,          
    input logic rst,          
    input logic [N-1:0] m,
    input logic [N-1:0] n,
    output logic sq_wave     
);
           
  
  logic multiq;           
  logic [N-1:0] countin;  
  logic maxtotog;
  
  
  t_flipflop tff (
    .clk(clk),
    .rst(rst),
    .tog(maxtotog),
    .q(multiq)
  );
  
  
  mux2x1 #(N) mux (
    .in1(m),
    .in0(n),
    .selq(multiq),
    .y(countin)
  );


  wave_gen #(N) counter(
    .clk(clk),
    .rst(rst),
    .outq(multiq),
    .count(countin),
    .max_tick(maxtotog),
    .sq_wave(sq_wave)
  );

  
endmodule