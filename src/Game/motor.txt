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
// Revision 0.01 - File Created
// Additional Comments:
// 
// ==================== CLOCK DIVIDER ==================== //
// The code is the one given for CS223 project in the fall semester
module ClockDivider( input clk_in,
                    output clk_out                                        
                    );

    logic [26:0] count = {27{1'b0}};
    logic clk_NoBuf;
    
    always@ (posedge clk_in) 
        begin
            count <= count + 1;
        end//always
        
    assign clk_NoBuf = count[26];
    
    BUFG BUFG_inst (
     .I(clk_NoBuf), // 1-bit input: Clock input
     .O(clk_out) // 1-bit output: Clock output
    );
    
endmodule

// ======================= dealing with rotation of motor ====================== //
module motorRotate(
    input clk, //100Mhz on Basys3
	input logic currentPlayer,
	
    input logic timeToTurn,
	output [3:0] phases,
	output logic enable
    );
   
   reg [2:0] count;
   logic direction;
   logic stop;
   logic [1:0] speed;
   logic turningRight, turningLeft;
   
   
   logic [1:0] control1, control2, control3, control4, control5;
//   logic turned;
      
   initial begin
        count <= 0;
//        turned <= 0;
        control1 <= 1;
        control2 <= 1;
        control3 <= 1;
        control4 <= 1;         
        turningRight <= 1;
        turningLeft <= 1;
    end


stepmotor stepmotor_inst0(
	.clk(clk),
    .direction(direction), //user input for motor direction
	.speed(speed), // user input for motor speed
    .phases(phases), // just connect them to FPGA (motor driver)
	.stop(stop) // user input for stopping the motor
);

    ClockDivider cd( clk, clkOut);

//        count = 2'b00;
//        turned = 0;

    
always_ff @ ( posedge clkOut)  
    begin                            
//        if( count != 'd1) 
//            begin        
//            if ( !turningRight | !turningLeft)
//                begin        
//                    direction <= currentPlayer;
//                    speed <= 3;
//                    stop <= 0;
//                    count <= count + 1;
//                    turned <= 0;
//                    if ( currentPlayer)
//                        turningRight <= 0;
//                    else if ( !currentPlayer)
//                        turningLeft <= 0;
//                end
////                turned <= 0;
//            end
//        else
//            begin
//                stop <= 1;
//                count <= 0;
//                turned <= 1;
//            end

            if ( !currentPlayer && turningLeft)
                begin
                    count <= count + 1;
                    direction <= currentPlayer;
                    stop <= 0;
                    speed <= 3;
                    turningRight <= 1;
                    enable <= 0;
                    
                    if ( count == 'd2)
                        begin
                            count <= 0;
                            turningLeft <= 0;
                            stop <= 1;
                            enable <= 1;
                        end                    
                end
            else if ( currentPlayer && turningRight)
                begin
                    count <= count + 1;
                    direction <= currentPlayer;
                    stop <= 0;
                    speed <= 3;
                    turningLeft <= 1;
                    enable <= 0;
                    
                    if ( count == 'd2)
                        begin
                            count <= 0;
                            turningRight <= 0;
                            stop <= 1;
                            enable <= 1;
                        end                          
                end
    end
endmodule
