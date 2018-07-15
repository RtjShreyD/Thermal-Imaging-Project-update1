%data to gray
function [m,k,l]= maxfun2(I)
[r,c]=size(I);
k=1;
l=1;
m=I(1,1);
for i=1:r
    for j=1:c
            if m<I(i,j)
                m=I(i,j);
                k=i;
                l=j;
            end
    end
end
end