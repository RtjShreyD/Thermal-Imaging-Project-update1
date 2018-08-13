function [n] = valbw(arr)
b=0;
[r,c] = size(arr);
    for j=1:c
        if arr(j)>=12 && arr(j)<=18    %%20 or 18 which is better
            n(j-b)= arr(j);
        else 
            b=b+1;
        end    
    end