function [n] = valbw_bicep(arr)
b=0;
[r,c] = size(arr);
    for j=1:c
        if arr(j)>=10 && arr(j)<=15    
            n(j-b)= arr(j);
        else 
            b=b+1;
        end    
    end
end    