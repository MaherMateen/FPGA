`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 09:13:38 PM
// Design Name: 
// Module Name: x7Seg_Counter_Controlled
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


module x7Seg_Counter_Controlled(
                                 input en,
                                 input clk,
                                 input clr,
                                 output reg [6:0] a_to_g,
                                 output reg [7:0] AN,
                                 output wire DP
                                );
                                
                                parameter incrRate = 50000000;        // Made to only increment digit every 1/2 second
                                parameter refreshRate = 6250;         // Rate at which we change from one 7-seg display to the next (1/16 ms)
                                
                                reg [2:0] select;
                                wire [7:0] AN_en;
                                reg [26:0] count;
                                reg [12:0] refreshCount;
                                reg [3:0] digit;
                                reg [31:0] x;
                                
                                assign DP = 1'b1;               // Turn off decimal point
                                assign AN_en = 8'b11111111;
                                
                                // Counter to update digit
                                always @ (posedge clk or posedge clr)
                                begin
                                    if (clr)
                                    begin
                                        x[3:0] <= 0;
                                        x[31:28] <= 0;
                                        count <= 0;
                                    end
                                    else
                                        if (en)
                                        begin
                                            count <=  count + 1;
                                            if (count == incrRate)
                                            begin
                                                if (x[3:0] == 9 && x[31:28] == 9)
                                                begin
                                                    x[3:0] <= 0;
                                                    x[31:28] <= 0;
                                                end
                                                
                                                if (x[3:0] == 9 && x[31:28] != 9)
                                                begin
                                                    x[3:0] <= 0;
                                                    x[31:28] <= x[31:28] + 1;
                                                end
                                                
                                                if (x[3:0] != 9)
                                                    x[3:0] <= x[3:0] + 1;
                                                    
                                                count <= 0;
                                            end

                                        end
                                        else
                                        begin
                                            x[3:0] <= x[3:0];
                                            x[31:28] <= x[31:28];
                                        end
                                end
                                
                                // Mux to choose which display the digit to output to
                                always @ (posedge clk)
                                begin
                                    case (select)
                                        0: digit <= x[3:0];     // Outputs the 'ones' digit to display AN[0]
                                        1: digit <= x[7:4];     // Outputs zero to displays AN[1] to AN[6]
                                        2: digit <= x[11:8];
                                        3: digit <= x[15:12];
                                        4: digit <= x[19:16];
                                        5: digit <= x[23:20];
                                        6: digit <= x[27:24];
                                        7: digit <= x[31:28];   // Outputs the 'tens' digit to display AN[7]
                                        default: digit <= x[3:0];
                                    endcase
                                end
                                
                                // Truth table for 7-seg display
                                always @ (digit)
                                begin
                                    case (digit)
                                        0:a_to_g = 7'b0000001;
                                        1:a_to_g = 7'b1001111;
                                        2:a_to_g = 7'b0010010;
                                        3:a_to_g = 7'b0000110;
                                        4:a_to_g = 7'b1001100;
                                        5:a_to_g = 7'b0100100;
                                        6:a_to_g = 7'b0100000;
                                        7:a_to_g = 7'b0001111;
                                        8:a_to_g = 7'b0000000;
                                        9:a_to_g = 7'b0000100;
                                        'hA:a_to_g = 7'b0001000;    // Hex A to F are provided but never used
                                        'hB:a_to_g = 7'b1100000;
                                        'hC:a_to_g = 7'b0110001;
                                        'hD:a_to_g = 7'b1000010;
                                        'hE:a_to_g = 7'b0110000;
                                        'hF:a_to_g = 7'b0111000;
                                        default: a_to_g = 7'b0000001;
                                    endcase
                                end
                                
                                // Choose which displays to turn on and when
                                always @(*)
                                begin
                                    AN=8'b11111111;
                                    if(AN_en[select] == 1 && (select == 0 || select == 7))
                                        AN[select] = 0;
                                end
                                
                                // Updates 'select' every 1/16 ms
                                always @(posedge clk)
                                begin
                                    refreshCount = refreshCount + 1;
                                    if (refreshCount == refreshRate)
                                        select = select + 1;
                                end
                                
endmodule
