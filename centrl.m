function centr =centrl(c,X,Y)
s=zeros(size(X));
for i=1:size(X,1)
          if abs(c(1,2)-Y(i,1))<1000&& c(1,1)<X(i,1)
        s(i)=i;
      else s(i)=0;
         end
end    
e=find(s);
dis=zeros(size(e));
for i=1:size(e,1)
dis(i)=distcent(e(i),c,X,Y);
end
minl=minloc(dis);
centr=e(minl);
end