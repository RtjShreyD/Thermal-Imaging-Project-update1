function hip =hipfn(c,X,Y)
[~,k1]=maxfun2(Y);
[~,k2]=minfun2(Y);
A=zeros((2*k1)-k2,1);
for i = 1:(2*k1)-k2
    if i>=k2 && i<=k1
        A(i,1)=X(i,1);
    else A(i,1)=0;
    end
end
[~,locs]=findpeaks(A);
dis=zeros(size(locs));
h=size(locs,1);
for i=1:h
    dis(i,1)=distcent(locs(i),c,X,Y);
end
[~,pos]=minfun2(dis);
hip=locs(pos);
end