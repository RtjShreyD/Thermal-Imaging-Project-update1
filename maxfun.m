%data to gray
function m= maxfun(I)
[r,c]=size(I);
m=I(1,1);
for i=1:r
    for j=1:c
            if m<I(i,j)
                m=I(i,j);
            end
    end
end
end