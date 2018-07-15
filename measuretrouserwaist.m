function d=measuretrouserwaist(p1,p2)
a=sqrt((p1(7,1,1)-p1(7,2,1)).^2+(p1(7,1,2)-p1(7,2,2)).^2);
b=sqrt((p2(7,1,1)-p2(7,2,1)).^2+(p2(7,1,2)-p2(7,2,2)).^2);
d=pi*(a+b)/2;
end