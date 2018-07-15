function crorl =crorl(cro,X,Y)
s=zeros(size(X));
for i=1:size(X,1)
          if abs(Y(cro)-Y(i,1))<0.5&& X(cro)<X(i,1)
        s(i)=i;
      else s(i)=0;
         end
end    
e=find(s);
dis=zeros(size(e));
for i=1:size(e,1)
dis(i)=distcro(e(i),cro,X,Y);
end
maxl=maxloc(dis);
crorl=e(maxl);
end