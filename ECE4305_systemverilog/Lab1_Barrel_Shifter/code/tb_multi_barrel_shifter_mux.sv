`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2023 08:11:25 PM
// Design Name: 
// Module Name: tb_multi_barrel_shifter_mux
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


module tb_multi_barrel_shifter_mux;

    localparam N = 8;

    logic [N-1:0] in;
    logic [$clog2(N)-1:0] amt;
    logic lr;
    logic [N-1:0] out;

    multi_barrel_shifter_mux #(N) mux (
        .in(in),
        .amt(amt),
        .lr(lr),
        .out(out)
    );

    initial
     begin : TST2
        
        in = 8'b11110000;
        amt = 3'b011;
        lr = 0;
        #10
        in = 8'b11110000;
        amt = 3'b101;
        lr = 1;
        #1000
        $finish;
    end


endmodule
