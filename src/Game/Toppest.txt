`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2018 08:17:45 PM
// Design Name: 
// Module Name: Toppest
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


module toppest( input logic clk,
    input logic reset, changePlayer, newGame, selr1, selr2, selr3, selr4,
    input logic lpScoreUp, lpScoreDown, rpScoreUp, rpScoreDown,
    output logic currentPlayer,
    output a, b, c, d, e, f, g, dp,
    output [3:0] an,
    output reset_out, //shift register's reset
    output OE,     //output enable, active low 
    output SH_CP,  //pulse to the shift register
    output ST_CP,  //pulse to store shift register
    output DS,     //shift register's serial input data
    output [7:0] col_select, // active column, active high)
    
    output [3:0] phases,
    output logic turned
    );
    wire brow1, brow2, brow3, brow4, playerChange;  
    scoreBoardd score( clk, reset, newGame, lpScoreUp, lpScoreDown, rpScoreUp, rpScoreDown, lWinner, rWinner,
                    a, b, c, d, e, f, g, dp, an);
    debounce b1( selr1, clk, brow1);
    debounce b2( selr2, clk, brow2);
    debounce b3( selr3, clk, brow3);
    debounce b4( selr4, clk, brow4);
    debounce b5( changePlayer, clk, playerChange);                  
    top ledMatrix( clk, playerChange, newGame, brow1, brow2, brow3, brow4, enable,    currentPlayer, lWinner, rWinner, reset_out, OE, SH_CP, ST_CP, DS, col_select);
    motorRotate motor( clk, currentPlayer, timeToTurn, phases, enable);
                             
endmodule
