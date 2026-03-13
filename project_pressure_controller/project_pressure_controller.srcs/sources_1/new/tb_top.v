`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2025 12:09:52 PM
// Design Name: 
// Module Name: toip_tb
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


module top_tb(
    );
    logic d,r,t,l0,l1,l2,clk,rst;
    
    top TOP(
        .data(d),
        .ready(r),
        .test(t),
        .led0(l0),
        .led1(l1),
        .led2(l2),
        .clk(clk),
        .rst(rst)
    
    
    );
    
    initial begin
        clk = 0;
        forever #3 clk = ~clk ;
        end
        
     initial begin
        d = 0;
        r = 0;
        t = 0;
        rst = 0;
        
        
     #5 rst = 1;
     #10 d = 1;
     #10 d = 0; 
     #10 d = 1; 
     #10 d = 0; 
     #10 d = 1; 
     #10 d = 0;    
        
     
     #10 r = 1; 
     #10 r = 0;
     
     
     #10 d = 1; 
     #10 d = 0; 
     #10 d = 1; 
     #10 d = 0;
     
     
     #10 t = 1;
     #10 t = 0;  
     
     #50 $stop();
     
     end
       
endmodule