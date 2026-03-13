`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2025 11:57:42 AM
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
//////////////////////////////////////////////////////////////////////////////////


module top(
        input wire clk,
        input wire rst, 
        
        input wire data,
        input wire ready,
        input wire test,
        output logic led0,
        output logic led1,
        output logic led2
    );
    
    logic data_del1, ready_del1, data_s, ready_s;
    logic [3:0] pressure_stb;
    logic start_stb;
    
    delay d1(
        .clk(clk),
        .rst(rst),
        .data_i(data),
        .ready_i(ready),
        .data_delay(data_del1),
        .ready_delay(ready_del1)
    
        
    );
    
    sync s1(
        .clk(clk),
        .rst(rst),
        .data_delay(data_del1),
        .ready_delay(ready_del1),
        .data_sync(data_s),
        .ready_sync(ready_s)
    
    
    
    );
    
    counter_interface ci1(
        .clk(clk),
        .rst(rst),
        .data_i(data_s),
        .done_i(ready_s),
        .pressure(pressure_stb),
        .end_stb(start_stb)
    
    
    
    );
    
    pressure_controller pc1(
        .clk(clk),
        .rst(rst),
        .start_stb(start_stb),
        .pressure(pressure_stb),
        .testmode(test),
        .captured(led0),
        .stable_flag(led1),
        .test_flag(led2)
    
    
    );
      
    
endmodule