//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 04/30/2018 06:14:29 PM
//// Design Name: 
//// Module Name: ControlUnit
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


//module ControlUnit(
//    input logic clk,
//    input logic reset, changePlayer, newGame, selr1, selr2, selr3, selr4
////    output a, b, c, d, e, f, g, dp, 
////    output reg [7:0] lpScore, rpScore, /* stepperMotorPosition, LED Matrix*/ 
////    output [3:0] an
//    );
    
//    typedef enum logic [3:0] { lpTurn, leftTakingTurn, rpTurn, rightTakingTurn, row1, row2, row3, row4, winnerDetermined} Statetype;
//    Statetype [1:0] state, nextState;
    
//    reg currentPlayer = 0; // 0 -> left ... 1 -> right
//    //reg [7:0] lpScoreCount;
//    //reg [7:0] rpScoreCount;
////    reg lpScoreTemp;
////    reg rpScoreTemp;
    
//    logic [2:0] row1Count;
//    logic [2:0] row2Count;
//    logic [2:0] row3Count;
//    logic [2:0] row4Count;
//    logic [4:0] totalMoves;
    
//    always_ff @ (posedge clk or negedge newGame)// or negedge reset or negedge lpScoreUp or negedge rpScoreUp or negedge lpScoreDown or negedge rpScoreDown)
//    //always_ff @ (posedge clk)
//        begin
//            if ( newGame)
//                begin
//                    state <= lpTurn;
//                    //lpScore <= 0;
//                    //rpScore <= 0;
                    
//                    row1Count <= 0;
//                    row2Count <= 0;
//                    row3Count <= 0;
//                    row4Count <= 0;
//                    totalMoves <= 0;     
//                    state <= lpTurn;               
//                end
            
////            else if ( !reset)
////                begin
////                    lpScore = 0;
////                    rpScore = 0;
////                end
            
////            else if ( !lpScoreUp)
////                begin
////                    lpScore++;
////                end
            
////            else if ( !rpScoreUp)
////                begin
////                    rpScore++;
////                end  
            
////            else if ( !lpScoreDown)
////                begin
////                    lpScore--;
////                end  
            
////            else if ( !rpScoreDown)
////                begin
////                    rpScore--;
////                end  
                    
//            else              
//            begin     
//                state = nextState;     
                      
//                case( state)
                
//                lpTurn:
//                    begin                            
//                        // step motor points to left
//                        currentPlayer <= 0;
//                        nextState <= leftTakingTurn; 
//                    end   
                                
//                leftTakingTurn:
//                    begin
//                        if ( selr1)
//                        begin
//                            // remove matchstick from row1
//                            totalMoves++;
//                            row1Count++;
//                            nextState <= row1;
//                        end
//                        else if ( selr2)
//                        begin
//                            // remove matchstick from row2
//                            totalMoves++;
//                            row2Count++;
//                            nextState <= row2;
//                        end
//                        else if ( selr3)
//                        begin
//                            // remove matchstick from row2
//                            totalMoves++;
//                            row3Count++;
//                            nextState <= row3;
//                       end
//                       else if ( selr4)
//                       begin
//                            // remove matchstick from row2
//                            totalMoves++;
//                            row4Count++;
//                            nextState <= row4;
//                       end
//                       else if ( changePlayer)
//                            nextState <= rpTurn;
//                    end
                    
//                rpTurn:
//                    begin
//                        // stepperMotorPosition to right
//                        currentPlayer <= 1;
//                        nextState <= rightTakingTurn;
//                    end
                    
//                rightTakingTurn:
//                    begin
//                        if ( selr1)
//                            begin
//                                // remove matchstick from row1
//                                totalMoves++;
//                                row1Count++;
//                                nextState <= row1;
//                            end
//                        else if ( selr2)
//                        begin
//                            // remove matchstick from row2
//                            totalMoves++;
//                            row2Count++;
//                            nextState <= row2;
//                        end
//                        else if ( selr3)
//                        begin
//                            // remove matchstick from row2
//                            totalMoves++;
//                            row3Count++;
//                            nextState <= row3;
//                        end
//                            else if ( selr4)
//                        begin
//                            // remove matchstick from row2
//                            totalMoves++;
//                            row4Count++;
//                            nextState <= row4;
//                        end
//                        else if ( changePlayer)
//                        begin
//                            nextState <= lpTurn;
//                        end
//                end
                    
//                row1:
//                    begin
//                        if (row1Count < 1'b1)
//                        begin
//                            if ( selr1)
//                            begin
//                                // remove matchstick
//                                totalMoves++;
//                                row1Count++;
//                                nextState <= row1;
//                            end                            
//                            else if ( changePlayer)
//                            begin
//                                if ( currentPlayer == 0)
//                                begin
//                                    nextState <= rpTurn;
//                                end
//                                else
//                                begin
//                                    nextState <= lpTurn;
//                                end
//                            end
//                        end
//                        else
//                        begin
//                            if ( currentPlayer == 0)
//                            begin
//                               nextState <= rpTurn;
//                            end
//                            else
//                            begin
//                               nextState <= lpTurn;
//                            end
//                        end                                                                                             
//                    end
                    
//                row2:
//                    begin
//                        if (row2Count < 2'b11)
//                        begin
//                            if ( selr2)
//                            begin
//                                // remove matchstick
//                                totalMoves++;
//                                row2Count++;
//                                nextState <= row2;
//                            end                            
//                            else if ( changePlayer)
//                            begin
//                                if ( currentPlayer == 0)
//                                begin
//                                    nextState <= rpTurn;
//                                end
//                                else
//                                begin
//                                    nextState <= lpTurn;
//                                end
//                            end
//                        end
//                        else
//                        begin
//                            if ( currentPlayer == 0)
//                            begin
//                                nextState <= rpTurn;
//                            end
//                            else
//                            begin
//                                nextState <= lpTurn;
//                            end
//                        end                                                                                             
//                    end
                        
//                row3:
//                    begin
//                        if (row3Count < 3'b101)
//                        begin
//                            if ( selr3)
//                            begin
//                                // remove matchstick
//                                totalMoves++;
//                                row3Count++;
//                                nextState <= row3;
//                            end                            
//                            else if ( changePlayer)
//                            begin
//                                if ( currentPlayer == 0)
//                                begin
//                                    nextState <= rpTurn;
//                                end
//                                else
//                                begin
//                                    nextState <= lpTurn;
//                                end
//                            end
//                        end
//                        else
//                        begin
//                            if ( currentPlayer == 0)
//                            begin
//                                nextState <= rpTurn;
//                            end
//                            else
//                            begin
//                                nextState <= lpTurn;
//                            end
//                        end                                                                                             
//                    end
                        
//                row4:
//                    begin
//                        if (row4Count < 3'b111)
//                        begin
//                            if ( selr4)
//                            begin
//                                // remove matchstick
//                                totalMoves++;
//                                row4Count++;
//                                nextState <= row4;
//                            end                         
//                            else if ( changePlayer)
//                                begin
//                                    if ( currentPlayer == 0)
//                                    begin
//                                    nextState <= rpTurn;
//                                    end
//                                    else
//                                    begin
//                                        nextState <= lpTurn;
//                                end
//                            end
//                        end
//                        else
//                        begin
//                            if ( currentPlayer == 0)
//                            begin
//                                nextState <= rpTurn;
//                            end
//                            else
//                            begin
//                                nextState <= lpTurn;
//                            end
//                        end                                                                                             
//                    end
                        
//                winnerDetermined:
//                    begin
//                        if ( currentPlayer == 0)
//                        begin
//                            // right player score increments
//                            // step motor points to right
//                            // LED matrix displays arrow towards right
//                        end
//                        else
//                        begin
//                            // right player score increments
//                            // step motor points to right
//                            // LED matrix displays arrow towards right
//                        end
//                    end
//            endcase
//        end
//    end
    
////    assign lpScore = lpScoreTemp;
////    assign rpScore = rpScoreTemp;
//    //SevSeg_4digit seg( clk, lpScore[7:4], lpScore[3:0], rpScore[7:4], rpScore[3:0], a, b, c, d, e, f, g, dp, an);
       
//endmodule
