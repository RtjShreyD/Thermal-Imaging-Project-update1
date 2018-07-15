function d=measureinseam(X1,Y1,x1,y1,cro)
% d=maxfun(Y)-Y(cro);
[~,l1]=maxfun2(Y1(cro:end));
l1=l1+cro-1;
[~,l2]=maxfun2(Y1(1:cro));
d1=sqrt((X1(l1)-x1(cro)).^2+(Y1(l1)-y1(cro)).^2);
d2=sqrt((X1(l2)-x1(cro)).^2+(Y1(l2)-y1(cro)).^2);
d=max(d1,d2);
end