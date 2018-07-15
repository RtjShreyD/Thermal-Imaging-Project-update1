function d=measurechest(p1,p2)
a=sqrt((p1(3,1,1)-p1(3,2,1)).^2+(p1(3,1,2)-p1(3,2,2)).^2);
b=sqrt((p2(3,1,1)-p2(3,2,1)).^2+(p2(3,1,2)-p2(3,2,2)).^2);
d=pi*(a+b)/2;
end