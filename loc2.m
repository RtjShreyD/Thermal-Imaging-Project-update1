function ps=loc2(X,Y,l)
l=l';
[r,c]=size(l);
ps=zeros(r,c,2);
for i=1:r
    for j=1:c
        ps(i,j,1)=X(l(i,j));
        ps(i,j,2)=Y(l(i,j));
    end
end
end