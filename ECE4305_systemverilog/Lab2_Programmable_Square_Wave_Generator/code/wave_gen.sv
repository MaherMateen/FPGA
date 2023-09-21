`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2023 11:40:24 AM
// Design Name: 
// Module Name: wave_gen
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


module wave_gen
#(parameter N = 4)
(
    input logic clk,
    input logic [N-1:0] count,
    input logic rst,
    input logic outq,
    output logic sq_wave,
    output logic max_tick
    );
    
  logic [(N*2):0] count_reg;

  always @(posedge clk or posedge rst)
   begin
        if (rst) 
            begin
              count_reg <= 0; 
            end 
        else 
            begin
              for(int i=0;i<count*10;i++)begin
                   if(count_reg == (count*10)-1)begin
                    count_reg <= 0;
                    max_tick <= 1;
                    end
                    else begin
                    count_reg <= count_reg+1;
                    max_tick <= 0;
                    end
                    
            end
    end
end
   
   assign sq_wave = outq;
    
    
endmodule
