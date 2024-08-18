`timescale 1ns/1ns
module washing_machine (clock,reset,door_close,start,filled,detergent_added,
        cycle_timeout,drained,spin_timeout,door_lock,motor_on,fill_valve_on,
        drain_valve_on,done,soap_wash,water_wash);
input clock,reset,door_close,start,filled,detergent_added,cycle_timeout,drained,spin_timeout;
output reg door_lock,motor_on,fill_valve_on,drain_valve_on,done,soap_wash,water_wash;

parameter check_door = 3'b000;
parameter fill_water = 3'b001;
parameter add_detergent = 3'b010;
parameter cycle = 3'b011;
parameter drain_water = 3'b100;
parameter spin = 3'b101;
reg [2:0]current_state,next_state;

always @(current_state or start or door_close or filled or detergent_added
         or drained or cycle_timeout or spin_timeout) 
         begin
           case (current_state)
            check_door : if (start == 1 && door_close == 1) 
                         begin
                           next_state = fill_water;
                           motor_on = 0;
                           fill_valve_on = 0;
                           drain_valve_on = 0;
                           door_lock = 1;
                           water_wash = 0;
                           soap_wash = 0;
                           done = 0;
                         end
                         else 
                         begin
                            next_state = current_state;
                            motor_on = 0;
                            fill_valve_on = 0;
                            drain_valve_on = 0;
                            door_lock = 0;
                            water_wash = 0;
                            soap_wash = 0;
                            done = 0;
                         end
            fill_water : if (filled) 
                         begin
                           if (soap_wash == 0) 
                           begin
                             next_state = add_detergent;
                             motor_on = 0;
                             fill_valve_on = 0;
                             drain_valve_on = 0;
                             door_lock = 1;
                             soap_wash = 1;
                             water_wash = 0;
                             done = 0; 
                           end
                           else
                           begin
                            next_state = cycle;
                            motor_on = 0;
                            fill_valve_on = 0;
                            drain_valve_on = 0;
                            door_lock = 1;
                            soap_wash = 1;
                            water_wash = 1;
                            done = 0;
                           end
                         end  
                         else
                           begin
                            next_state = current_state;
                            motor_on = 0;
                            fill_valve_on = 1;
                            drain_valve_on = 0;
                            door_lock =1;
                            done = 0;
                           end 
             add_detergent: if (detergent_added == 1) 
                            begin
                              next_state = cycle;
                              motor_on = 0;
                              fill_valve_on = 0;
                              drain_valve_on = 0;
                              door_lock = 1;
                              soap_wash = 1;
                              done = 0; 
                            end  
                            else
                            begin
                              next_state = current_state;
                              motor_on = 0;
                              fill_valve_on = 0;
                              door_lock = 1;
                              soap_wash = 1;
                              done = 0;
                            end 
             cycle : if (cycle_timeout == 1) 
                     begin
                      next_state = drain_water;
                      motor_on = 0;
                      fill_valve_on = 0;
                      drain_valve_on = 0;
                      door_lock = 1;
                      //soap_wash = 1;
                      done = 0;
                     end       
                     else
                     begin
                        next_state = current_state;
                        motor_on = 1;
                        fill_valve_on = 0;
                        drain_valve_on = 0;
                        door_lock = 1;
                        // soap_wash = 1;
                        done = 0;
                     end    
             drain_water : if (drained == 1) 
                           begin
                             if (water_wash == 0) 
                             begin
                               next_state = fill_water;
                               motor_on = 0;
                               fill_valve_on = 0;
                               drain_valve_on = 0;
                               door_lock = 1;
                               soap_wash = 1;
                               // water_wash = 1;
                               done = 0;     
                             end
                             else
                             begin
                                next_state = spin;
                                motor_on = 0;
                                fill_valve_on = 0;
                                drain_valve_on = 0;
                                door_lock = 1;
                                soap_wash = 1;
                                water_wash = 1;
                                done = 0;
                             end
                           end
                           else
                           begin
                            next_state = current_state;
                            motor_on = 0;
                            fill_valve_on = 0;
                            drain_valve_on = 1;
                            door_lock = 1;
                            soap_wash = 1;
                            // water_wash = 1;
                            done = 0;
                           end
             spin : if (spin_timeout == 1) 
                    begin
                      next_state = door_close;
                      motor_on = 0;
                      fill_valve_on = 0;
                      drain_valve_on = 0;
                      door_lock = 1;
                      soap_wash = 1;
                      water_wash = 1;
                      done = 1;
                    end
                    else
                    begin
                        next_state = current_state;
                        motor_on = 0;
                        fill_valve_on = 0;
                        drain_valve_on = 1;
                        door_lock = 1;
                        soap_wash = 1;
                        water_wash = 1;
                        done = 0;
                    end                          
            default: next_state = check_door; 
           endcase
         end

always @(posedge clock or negedge reset) 
begin
  if (reset) 
   current_state <= 3'b000;  
  else
    current_state <= next_state;    
end

endmodule