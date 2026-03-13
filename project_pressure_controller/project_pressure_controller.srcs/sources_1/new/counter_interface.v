`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2025 11:14:29 AM
// Design Name: 
// Module Name: counter_interface
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


module counter_interface(
        input wire data_i,
        input wire done_i,
        
        input wire clk,
        input wire rst, 
        
        output logic [3:0] pressure,
        output logic end_stb
    );
    
    logic data_re,data_prev;
    logic done_re,done_prev;
    logic [3:0] pressure_counter;
    
    
    //rising edge pentru data
    always@(posedge clk, negedge rst)
    begin
        if(~rst)
        begin
            data_re <= 0;
            data_prev <= 0;
        end
        else
        begin
            data_prev <= ~data_i;
            data_re <= data_prev && data_i;
        end

    end
    
    //rising edge pentru done
    always@(posedge clk, negedge rst)
    begin
        if(~rst)
        begin
            done_re <= 0;
            done_prev <= 0;
        end
        else
        begin
            done_prev <= ~done_i;
            done_re <= done_prev && done_i;
        end

    end
    
    
    always@(posedge clk, negedge rst)
    begin
        if(~rst)
        begin
            pressure <= 0;
            pressure_counter <= 0;
            end_stb <= 0;
        end
        else
        begin
            if(done_re)
                begin
                    pressure <= pressure_counter;
                    pressure_counter <= 0;
                    end_stb <= 1;
                
                end
            else if(data_re)
                    begin
                        pressure_counter <= pressure_counter +1;
                        end_stb <= 0;
                    end   
            else
                begin
                    end_stb <= 0;
                end
            
            
        end
    
    end
    
    
    
    
    
    
endmodule