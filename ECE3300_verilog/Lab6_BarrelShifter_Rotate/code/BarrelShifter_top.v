`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 09:41:57 PM
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

module BarrelShifter_top
                      #(parameter WIDTH = 16)
                        (
                          input clk,
                          input [(WIDTH/2)-1:0] in,     // 8 bit input 
                          input [1:0] OP,               // Determines Shifting/Rotating Left/Right operation
                          input in_select,              // Used for Demux to combine 2 8-bit inputs into 16 bits from "in"
                          input mode,                   // Determines automatic/manual mode
                          input [3:0] sel,              // Manual mode/Load input
                          input load,                   // Determines whether to load bits or not
                          output wire [6:0] a_to_g,
                          output reg [7:0] AN,
                          output wire DP
                         );
                         
                         parameter refreshRate = 6250;              // Rate at which we change from one 7-seg display to the next (1/16 ms)
                                                         
                         reg [2:0] SELECT;                          // Selects which 7-seg display
                         wire [7:0] AN_en;
                         reg [3:0] digit;                           // Digit being displayed
                         reg [12:0] refreshCount;
                         wire [WIDTH-1:0] inputValue;                // 16 bit input  (before barrel shifter) as wire
                         wire [WIDTH-1:0] outputValue;               // 16 bit output (after barrel shifter) as wire
                         reg [WIDTH-1:0] inputVal;                   // 16 bit input  (before barrel shifter) as register
                         reg [WIDTH-1:0] outputVal;                  // 16 bit output (after barrel shifter) as register
                         wire [3:0] bitsShift_Rotate;                // Number of bits to shift/rotate by
                         
                         assign DP = 1'b1;                          // Turn off decimal point
                         assign AN_en = 8'b11111111;
                         
                         Demux_1x2 U1(.a(in),                       // Used to get 16 bit output from 8 bit input
                                      .select(in_select),
                                      .b(inputValue)
                                      ); 
                                          
                         // Mux to choose which display the digit to output to
                         always @ (posedge clk)
                         begin
                             case (SELECT)
                                 0: digit <= outputValue[3:0];     
                                 1: digit <= outputValue[7:4];     
                                 2: digit <= outputValue[11:8];
                                 3: digit <= outputValue[15:12];
                                 4: digit <= 0;
                                 5: digit <= 0;
                                 6: digit <= 0;
                                 7: digit <= 0;
                                 default: digit <= outputValue[3:0];
                             endcase
                         end
                         
                         x7Seg U2(.dig(digit),
                                  .A_to_G(a_to_g)
                                  );
                                  
                         bits_to_shift U3(.CLK(clk),                // Changes bits to shift by based on auto/manual mode and load signal
                                          .MODE(mode),
                                          .LOAD(load),
                                          .SEL(sel),
                                          .P(bitsShift_Rotate)
                                          );
                                  
                         BarrelShifter U4(.a(inputValue),
                                          .bits_to_S_R(bitsShift_Rotate),
                                          .operation(OP),
                                          .outp(outputValue)
                                          );
                                  
                         // Choose which displays to turn on and when
                         always @(*)
                         begin
                             AN=8'b11111111;
                             if(AN_en[SELECT] == 1 && SELECT <= 3)
                                 AN[SELECT] = 0;
                         end
                         
                         // Updates 'select' every 1/16 ms
                         always @(posedge clk)
                         begin
                             refreshCount <= refreshCount + 1;
                             if (refreshCount == refreshRate)
                             begin
                                 SELECT <= SELECT + 1;
                                 refreshCount <= 0;
                             end
                         end
                         
                         // For purposes of testbench simulation
                         always @ (inputValue or outputValue)
                         begin
                            inputVal = inputValue;
                            outputVal = outputValue;
                         end
endmodule