function [ Move_No ] = Get_Move_No(t)

persistent COUNTER;    
    
if (isempty(COUNTER) || (abs(t - 180.) <= eps(180.)))
    COUNTER = uint16(1);
else
    COUNTER = COUNTER + 1;        
end
Move_No = COUNTER;