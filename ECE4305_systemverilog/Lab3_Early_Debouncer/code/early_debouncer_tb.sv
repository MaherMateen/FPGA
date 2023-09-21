`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 08:12:58 PM
// Design Name: 
// Module Name: early_debouncer_tb
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


module early_debouncer_tb;

    logic sw;
    logic reset;
    logic clk;
    logic db;

    
    earlydb uut (
        .sw(sw),
        .reset(reset),
        .clk(clk),
        .db(db)
    );

    // Clock generation
    logic clk_tb = 0;
    always #5 clk_tb = ~clk_tb; // Generate a 100 MHz clock (10 ns period)

    // Testbench stimulus
    initial begin
        // Initialize inputs
        sw = 0;
        reset = 0;
        clk = 0;

        // Apply reset
        reset = 1;
        #10 reset = 0;

     
        sw = 1;
        #20;
        sw = 1; 
        #200; 

    
        sw = 1;
        #20; 
        sw = 0; 
        #200; 
        
        sw = 1;
        #200; 
        sw = 0; 
        #200; 
      
        $finish;
    end

    // Clock generation
    always #5 clk = clk_tb;


endmodule