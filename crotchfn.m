function cro=crotchfn(img,c,X,Y)
[pks,locs]=findpeaks(Y);
[~,p1]=maxfun2(pks);
i1=locs(p1);
pks(p1,1)=minfun(pks)-1;
[~,p2]=maxfun2(pks);
i2=locs(p2);
k1=min(i1,i2);
k2=max(i1,i2);
A=zeros(size(Y));
for i=k1:k2
    if i>=k1 && i<=k2
        A(i,1)=Y(i,1);
    else A(i,1)=0;
    end
end
[~,loc]=findpeaks(size(img,1)-A);
dis=zeros(size(loc));
h=size(loc,1);
for i=1:h
    dis(i,1)=distcent(loc(i),c,X,Y);
end
[~,pos]=minfun2(dis);
cro=loc(pos);
end