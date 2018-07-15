function d=measureoutseam(X,Y,cro,p)
[~,l1]=maxfun2(Y(cro:end));
[~,l2]=maxfun2(Y(1:cro));
d1=sqrt((X(l1)-p(7,1,1)).^2+(Y(l1)-p(7,1,2)).^2);
d2=sqrt((X(l2)-p(7,2,1)).^2+(Y(l2)-p(7,2,2)).^2);
% (X(l2)-p(7,2,1)).^2+
d=max(d1,d2);
% d=(d1+d2)/2;
% d=maxfun(Y)-p(7,2,2);
end