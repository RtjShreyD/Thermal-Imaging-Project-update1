function [newVal] = rounds(x) 
    dist = mod(x, 0.5); 
    floorVal = x - dist; 
    if  dist  >=0.25
        newVal = floorVal + 0.5;      
    else
        newVal = floorVal;
    end
end

