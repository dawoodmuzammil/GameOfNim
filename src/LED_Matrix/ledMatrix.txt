`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Hamzeh Ahangari
// 
// Create Date: 
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision: 
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module top(
	input clk, //100Mhz on Basys3
    input changePlayer, newGame, selr1, selr2, selr3, selr4,
	input logic turned,
	output logic currentPlayer,
	output logic lWinner,
	output logic rWinner,
	
//    output logic timeToTurn,
	
	// FPGA pins for 8x8 display
	output reset_out, //shift register's reset
	output OE, 	//output enable, active low 
	output SH_CP,  //pulse to the shift register
	output ST_CP,  //pulse to store shift register
	output DS, 	//shift register's serial input data
	output [7:0] col_select // active column, active high
	

	);
    
logic [2:0] col_num;

logic [0:7] [7:0] image_red = 
{8'b00000011, 8'b00000011, 8'b00110011, 8'b00110011, 8'b00110011, 8'b00000011, 8'b00000011, 8'b00000000};
logic [0:7] [7:0]  image_green = 
{8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000};
logic [0:7] [7:0]  image_blue = 
{8'b00000000, 8'b00001100, 8'b00001100, 8'b11001100, 8'b00001100, 8'b00001100, 8'b00000000, 8'b00000000};



   
// This module displays 8x8 image on LED display module. 
display_8x8 display_8x8_0(
	.clk(clk),
	
	// RGB data for display current column
	.red_vect_in(image_red[col_num]),
	.green_vect_in(image_green[col_num]),
	.blue_vect_in(image_blue[col_num]),
	
	.col_data_capture(), // unused
	.col_num(col_num),
	
	// FPGA pins for display
	.reset_out(reset_out),
	.OE(OE),
	.SH_CP(SH_CP),
	.ST_CP(ST_CP),
	.DS(DS),
	.col_select(col_select)   
); 
    
//    reg currentPlayer; // 0 -> left ... 1 -> right
    logic row1Selected, row2Selected, row3Selected, row4Selected; 
    

    reg [2:0] row1Count;
    reg [2:0] row2Count;
    reg [2:0] row3Count;
    reg [2:0] row4Count;
    reg [4:0] totalMoves;        
    logic [1:0] control1, control2, control3, control4, control5, controlFinish;
    
    initial begin

        control1 <= 1;
        control2 <= 1;
        control3 <= 1;
        control4 <= 1;
        control5 <= 1;    
        controlFinish <= 0;   
            
        row1Count <= 1;
        row2Count <= 3;
        row3Count <= 5;
        row4Count <= 7;
        totalMoves <= 0;
        currentPlayer <= 0;
        
        
        row1Selected <= 0;
        row2Selected <= 0;
        row3Selected <= 0;
        row4Selected <= 0;
        
        lWinner <= 0;
        rWinner <= 0;
    end
    
    always_ff @( posedge clk ) begin
        
        // =================== dealing with row 1 =============== //
        if ( selr1 && !row1Selected && turned)
            begin            
                control1 <= 1;
                
                row2Selected <= 1;
                row3Selected <= 1;
                row4Selected <= 1;
                if ( row1Count)
                    begin
                        totalMoves++;
                        row1Count--;
        
                        image_blue [3][6] <= 0;
                        image_blue [3][7] <= 0;               
                    end
                else if ( row1Count == 0)
                    begin
                        row2Selected <= 0;
                        row3Selected <= 0;
                        row4Selected <= 0;
                        currentPlayer <= ~currentPlayer;                        
                    end
            end
//        else if ( !selr1)
//            timeToTurn <= 0;    
        
        // =================== dealing with row 2 =============== //    
        if ( selr2 && control2 && !row2Selected && turned) 
            begin                         
                if ( row2Count)
                    begin
                        totalMoves++;
                        row2Count--;
                        
                        row1Selected <= 1;
                        row3Selected <= 1;
                        row4Selected <= 1;
                        
                        if ( row2Count == 2)
                            begin
                                image_red [4][4] <= 0;
                                image_red [4][5] <= 0;
                                control2 <= 0;
                            end
                        if ( row2Count == 1)
                            begin
                                image_red [3][4] <= 0;
                                image_red [3][5] <= 0;
                                control2 <= 0;
                            end
                        if ( row2Count == 0)
                            begin
                                image_red [2][4] <= 0;
                                image_red [2][5] <= 0;
                                control2 <= 0;
                                                                                        
                                row1Selected <= 0;
                                row3Selected <= 0;
                                row4Selected <= 0;
                                currentPlayer <= ~currentPlayer;
                            end                                                            
                    end                                                   
            end
        else if ( !selr2)
            begin
                control2 <= 1;
            end
             
             // =================== dealing with row 3 =============== //   
        if ( selr3 && control3 && !row3Selected && turned) 
            begin                         
                if ( row3Count)
                    begin
                        totalMoves++;
                        row3Count--;
                        
                        row1Selected <= 1;
                        row2Selected <= 1;
                        row4Selected <= 1;

                        if ( row3Count == 4)
                            begin
                                image_blue [5][2] <= 0;
                                image_blue [5][3] <= 0;
                                control3 <= 0;
                            end
                        if ( row3Count == 3)
                            begin
                                image_blue [4][2] <= 0;
                                image_blue [4][3] <= 0;
                                control3 <= 0;
                            end                                                            
                        if ( row3Count == 2)
                            begin
                                image_blue [3][2] <= 0;
                                image_blue [3][3] <= 0;
                                control3 <= 0;
                            end
                        if ( row3Count == 1)
                            begin
                                image_blue [2][2] <= 0;
                                image_blue [2][3] <= 0;
                                control3 <= 0;
                            end
                        if ( row3Count == 0)
                            begin
                                image_blue [1][2] <= 0;
                                image_blue [1][3] <= 0;
                                control3 <= 0;
                                
                                
                                row2Selected <= 0;
                                row1Selected <= 0;
                                row4Selected <= 0;
                                currentPlayer <= ~currentPlayer;
                            end                                                            
                    end
//                    else if ( row3Count == 0)
//                        begin
                    
                        
//                        end                                            
            end
            else if ( !selr3)
                begin
                    control3 <= 1;
//                    timeToTurn <= 0;
                end
            
            // =================== dealing with row 4 =============== //        
            if ( selr4 && control4 && !row4Selected && turned) 
                begin                         
                    if ( row4Count)
                        begin
                            totalMoves++;
                            row4Count--;
                            
                            row1Selected <= 1;
                            row2Selected <= 1;
                            row3Selected <= 1;
                            
                            if ( row4Count == 6)
                                begin
                                    image_red [6][0] <= 0;
                                    image_red [6][1] <= 0;
                                    control4 <= 0;
                                end
                            if ( row4Count == 5)
                                begin
                                    image_red [5][0] <= 0;
                                    image_red [5][1] <= 0;
                                    control4 <= 0;
                                end                                
                            if ( row4Count == 4)
                                begin
                                    image_red [4][0] <= 0;
                                    image_red [4][1] <= 0;
                                    control4 <= 0;
                                end
                            if ( row4Count == 3)
                                begin
                                    image_red [3][0] <= 0;
                                    image_red [3][1] <= 0;
                                    control4 <= 0;
                                end                                                            
                            if ( row4Count == 2)
                                begin
                                    image_red [2][0] <= 0;
                                    image_red [2][1] <= 0;
                                    control4 <= 0;
                                end
                            if ( row4Count == 1)
                                begin
                                    image_red [1][0] <= 0;
                                    image_red [1][1] <= 0;
                                    control4 <= 0;
                                end
                            if ( row4Count == 0)
                                begin
                                    image_red [0][0] <= 0;
                                    image_red [0][1] <= 0;
                                    control4 <= 0;
                                    
                                    row2Selected <= 0;
                                    row3Selected <= 0;
                                    row1Selected <= 0;
                                    currentPlayer <= ~currentPlayer;                
                                end                                                            
                        end
                end
            else if ( !selr4)
                begin
                    control4 <= 1;
                end                                           
            
            // =================== new game =============== //
            if ( !newGame & !control1)
                begin      
                    control1 <= 1;
                    controlFinish <= 0;   
                            
                    row1Count <= 1;
                    row2Count <= 3;
                    row3Count <= 5;
                    row4Count <= 7;
                    totalMoves <= 0;  
                       
                    currentPlayer <= 0;
                    
                    row1Selected <= 0;
                    row2Selected <= 0;
                    row3Selected <= 0;
                    row4Selected <= 0;
                    
                    image_red   <=      {8'b00000011, 8'b00000011, 8'b00110011, 8'b00110011, 8'b00110011, 8'b00000011, 8'b00000011, 8'b00000000};
                    image_green <=      {8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000};
                    image_blue  <=      {8'b00000000, 8'b00001100, 8'b00001100, 8'b11001100, 8'b00001100, 8'b00001100, 8'b00000000, 8'b00000000};
                    
                    lWinner <= 0;
                    rWinner <= 0;
                    
                end
            else if ( newGame)
                control1 <= 0;

            // =================== change player=============== //
            if ( changePlayer && control5 && turned)
                begin
                    control5 <= 0;
                    row1Selected <= 0;
                    row2Selected <= 0;
                    row3Selected <= 0;
                    row4Selected <= 0;
//                    timeToTurn <= 1;
                    if ( currentPlayer == 0)
                        currentPlayer <= 1;
                    else if ( currentPlayer == 1)
                        currentPlayer <= 0;
                end
            else if ( !changePlayer)
                begin
                    control5 = 1;
//                    timeToTurn <= 0;
                end
                
            // =================== game over=============== //    
            if ( totalMoves == 16 && !controlFinish)
                begin
                    controlFinish <= 1;
                    if ( currentPlayer == 1)
                        begin
                            image_red   <=      {8'b00010000, 8'b00111000, 8'b01111100, 8'b11111110, 8'b00111000, 8'b00111000, 8'b00111000, 8'b00111000};
                            image_green <=      {8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000};
                            image_blue  <=      {8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000};
                            lWinner <= 1;                            
                        end
                    else if ( currentPlayer == 0)
                        begin
                            image_red   <=      {8'b00111000, 8'b00111000, 8'b00111000, 8'b00111000, 8'b11111110, 8'b01111100, 8'b00111000, 8'b00010000};
                            image_green <=      {8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000};
                            image_blue  <=      {8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000};    
                            rWinner <= 1;                        
                        end
                end
    end        
                                                   
endmodule