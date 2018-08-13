function [mat2] =ridofzero(mat)
l=0;
[r,c]=size(mat);
    for k=1:c
        if mat(k)~=0
            mat2(k-l)=mat(k);
            
        else
            l=l+1;
                 
        end
    end 
   end           