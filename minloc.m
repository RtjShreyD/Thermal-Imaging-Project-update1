function l=minloc(I)
[r,c]=size(I);
l=1;
m=I(1,1);
for i=1:r
    for j=1:c
            if m>I(i,j)
                m=I(i,j);
                l=i;
            end
    end
end
end