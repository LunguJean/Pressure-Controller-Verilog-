`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2025 11:24:52 AM
// Design Name: 
// Module Name: pressure_controller
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


module pressure_controller(
        input wire clk,
        input wire rst,
        
        input logic start_stb,
        input logic [3:0] pressure,
        input logic testmode,
        output logic captured,
        output logic stable_flag,
        output logic test_flag
        
    );
    
    logic testmode_prev, testmode_stb, testmode_delay, testmode_sync;
    
    
    //delay si sync pt testmode
    always@(posedge clk, negedge rst)
    begin
        if(~rst)
            begin
                
                testmode_delay <= 0;
                testmode_sync <= 0;
            end
        else
            begin
                testmode_delay <= testmode;
                testmode_sync <= testmode_delay;
                
            end
    
    end
    
    
    
    
    //re pentru testmode
    
    
    always@(posedge clk, negedge rst)
    begin
        if(~rst)
        begin
            testmode_stb <= 0;
            testmode_prev <= 0;
        
        end
        else
            begin
                testmode_prev <= ~testmode_sync;
                testmode_stb <= testmode_prev && testmode_sync;
            end
    
    
    
    end    
    
    //declar variabilele pentru a putea jongla printre stari
    logic [3:0] state,state_next;
    
    
    //structura pentru controller : trecem din state in state_next
    always@(posedge clk, negedge rst)
    begin
        if(~rst)
        begin
            state <= 0;
        end
        else
            begin
                state <= state_next;
            end
    end
    
    //starile:
    //0 : idle
    //1 : wait
    //2 : capture_pressure
    //3 : stable
    //4 ; testmode
    //5 : pressure_lin
    //6 : fault
    
    //declar starile prin care trece
    logic circuit_stable;
    logic correct_stb;
    logic error_stb;
    logic [3:0] pressure_s;
    logic [2:0] counter;
    
    always_comb
    begin
        case(state)
        0 : 
            begin
                state_next <= 1;
            end
        
        1:
            begin
                if(start_stb)
                    begin
                        state_next <= 2;
                    end
                else
                    begin
                        state_next <= 1;
                    end
    
            end
        2:
            begin
                if(circuit_stable)
                    begin
                        state_next <= 3;
                    end
                else
                    begin
                        state_next <= 2;
                    end
    
            end
        3:
            begin
                if(start_stb)
                    begin
                        state_next <= 2;
                    end
                else if(testmode_stb)
                    begin
                        state_next <= 4;
                    end
                else
                    begin
                        state_next <= 3;
                    end
            end
        
        4:
            begin
                if(start_stb)
                    begin
                        state_next <= 5;
                    end
                else
                    begin
                        state_next <= 4;
                    end
            end  
            
            
         5:
            begin
            if(correct_stb)
                    begin
                        state_next <= 3;
                    end
                else if(error_stb)
                    begin
                        state_next <= 6;
                    end
                else
                    begin
                        state_next <= 5;
                    end
            end
         6:
            begin
                state_next <= 6;
            end
       endcase
       
    end
    
    
    always@(posedge clk, negedge rst)
    begin
        if(~rst)
            begin
                captured <= 0;
                test_flag <= 0;
                stable_flag <= 0;
                correct_stb <= 0;
                error_stb <= 0;
                pressure_s <= 0;
                counter <= 0;
            
            end
        else
            begin
                case(state)
                2: //capture_pressure
                    begin
                        pressure_s <= pressure;
                        counter <= counter + 1;
                        if(counter == 7)
                            begin
                                circuit_stable <= 1;
                                counter <= 0;
                                captured <= 1;
                            end
                        else
                            begin
                                circuit_stable <= 0;
                            end  
                    end
                3: // stable
                    begin
                        captured <= 1;
                        stable_flag <= 1;
                        
                        
                        
                        
                        
                    end
                
                4: //testmode
                    begin
                        captured <= 0;
                        stable_flag <= 0;
                        test_flag <= 1;
                    
                        
                    end
                
                5://pressure_lin
                    begin
                        test_flag <= 1;
                        if(pressure == pressure_s)
                            begin
                                correct_stb <= 1;
                            end
                        else
                            begin    
                                error_stb <= 1;
                            end

                    end
                6://fault
                    begin
                        test_flag <= 1;
                    end
                
                endcase
            end
    
    
    
    
    end
    
endmodule