`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2023 08:07:49 PM
// Design Name: 
// Module Name: multi_barrel_shifter_reverser
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


module multi_barrel_shifter_reverser #(parameter N = 10)(
    input logic [N-1:0] in,
    input logic [$clog2(N)-1:0] amt, 
    input logic lr, 
    output logic [N-1:0] out
);

    logic [N-1:0] prerev;
    logic [N-1:0] postrev;
    logic temp;
    logic [N-1:0] out_left;
    logic [N-1:0] out_right;


   /* param_right_shifter #(N) right_shifter (
        .in(in),
        .amt(amt),
        .out(out_right)
    );*/

   
    always_comb begin
        if (lr == 0) begin
            prerev = in; 
            for (int i = 0; i < N/2; i = i + 1) begin
                temp = in[i];
                prerev[i] = prerev[N-1-i];
                prerev[N-1-i] = temp;
            end
        end else begin
            prerev = in; 
        end
    end

   
    param_right_shifter #(N) reverse_right_shifter (
        .in(prerev),
        .amt(amt),
        .out(out_right)
    );

   
    always_comb begin
        if (lr == 0) begin
            postrev = out_right;
            for (int j = 0; j < N/2; j = j + 1) begin
                temp = postrev[j];
                postrev[j] = postrev[N-1-j];
                postrev[N-1-j] = temp;
            end
            end else begin
           // out_right = pos; trev
        end
    end

   
    always_comb begin
        case (lr)
            0: out = postrev; 
            1: out = out_right; 
            default: out = 0; 
        endcase
    end
endmodule