`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2025 11:05:40 AM
// Design Name: 
// Module Name: sync
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


module sync(
        input wire clk,
        input wire rst,
        
        input wire data_delay,
        input wire ready_delay,
        input wire test_delay,
        
        output logic data_sync,
        output logic ready_sync
        
        
    );
    
    always@(posedge clk, negedge rst)
    begin
        if(~rst)
            begin
                data_sync <= 0;
                ready_sync <= 0;
                
            end
        else
            begin
                data_sync <= data_delay;
                ready_sync <= ready_delay;
                
            end
    
    end
    
endmodule