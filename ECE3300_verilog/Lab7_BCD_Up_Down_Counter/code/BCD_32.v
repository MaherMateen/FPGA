`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 10:03:35 PM
// Design Name: 
// Module Name: BCD_32
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


module BCD_32(
                input CLK,
                input rst,
                input load,
                input EN,
                input upDown,
                input [2:0] D_Sel,
                input [3:0] Inp,
                output wire [31:0] outp
              );
              
              wire [7:0] temp;
              wire [2:0] index;
              wire [31:0] inVal;
              wire [7:0] select;
              
              assign temp[0] = EN;
              
              Demux_1x8 X (.inp(Inp),
                           .D_sel(D_Sel),
                           .oup(inVal),
                           .selected(select)
                           );                           
              
              genvar i;
              generate
              for (i = 0; i < 8; i = i + 1)
              begin
                    assign index = index + 1;
                    counter_BCD UNIT (.clk(CLK),
                                      .reset(rst),
                                      .load(load),
                                      .EN_in(temp[i]),
                                      .upDown(upDown),
                                      .ip(inVal[4*(i+1)-1:4*i]),
                                      .Select(select[i]),
                                      .op(outp[4*(i+1)-1:4*i]),
                                      .EN_out(temp[i+1])
                                      );
              end
              endgenerate
endmodule
