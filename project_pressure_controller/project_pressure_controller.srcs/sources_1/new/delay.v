`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2025 11:11:12 AM
// Design Name: 
// Module Name: delay
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


module delay(
        input wire clk,
        input wire rst,
        
        input wire data_i,
        input wire ready_i,
        input wire test_i,
        
        output logic data_delay,
        output logic ready_delay,
        output logic test_delay
    );
    
    always@(posedge clk, negedge rst)
    begin
        if(~rst)
            begin
                data_delay <= 0;
                ready_delay <= 0;
                
            end
        else
            begin
                 data_delay <= data_i;
                 ready_delay <= ready_i;
                 
            end
    
    end
    
    
    
endmodule