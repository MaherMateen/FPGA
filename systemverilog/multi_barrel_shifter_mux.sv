`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2023 04:34:22 PM
// Design Name: 
// Module Name: multi_barrel_shifter_mux
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


module multi_barrel_shifter_mux
    #(parameter N = 10)
    (
    input logic [N-1:0] in,          
    input logic [$clog2(N)-1:0] amt, 
    input logic lr, 
    output logic [N-1:0] out
    );
    
param_left_shifter #(N) left_shifter 
    (
        .in(in),
        .amt(amt),
        .out(out_left)
    );
    
param_right_shifter #(N) right_shifter 
    (
        .in(in),
        .amt(amt),
        .out(out_right)
    );
    

    logic [N-1:0] out_left;
    logic [N-1:0] out_right;
    
    always_comb begin
        case (lr)
            0: out = out_left;
            1: out = out_right;
            default: out = 0;
        endcase
    end
     
endmodule
