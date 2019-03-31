`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/03/2018 04:35:30 PM
// Design Name: 
// Module Name: scoreBoardd
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


module scoreBoardd( 
        input logic clk,
        input logic reset, newGame, 
        input logic lpScoreUp, lpScoreDown, rpScoreUp, rpScoreDown,
        input logic lWinner,
        inout logic rWinner,
        output a, b, c, d, e, f, g, dp,
        output [3:0] an
    );
    
        reg [3:0] d1, d2, d3, d4;
        
        initial begin
            d1 <= 0;
            d2 <= 0;
        end
    
        upDownCounterLeft processingLeft( clk, reset, newGame, lpScoreUp, lpScoreDown, lWinner, d1, d2);
        upDownCounterRight processingRight( clk, reset, newGame, rpScoreUp, rpScoreDown, rWinner, d3, d4);
        
        //downCounter decrement( clk, reset, lpScoreDown, d1, d2);

        SevSeg_4digit seg( clk, d4, d3, d2, d1, a, b, c, d, e, f, g, 0, an);            
        

endmodule   

          
