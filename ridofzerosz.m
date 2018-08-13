function [matw,sz] =ridofzerosz(mat)
l=0;
[r,c]=size(mat);
    for k=1:c
        if mat(k)~=0
            matw(k-l)=mat(k);
            
        else
            l=l+1;
                 
        end
    end 
    sz = k-l;
end           