function d=measureshirtwaist(p1,p2)
a=sqrt((p1(6,1,1)-p1(6,2,1)).^2+(p1(6,1,2)-p1(6,2,2)).^2);
b=sqrt((p2(6,1,1)-p2(6,2,1)).^2+(p2(6,1,2)-p2(6,2,2)).^2);
d=pi*(a+b)/2;
end