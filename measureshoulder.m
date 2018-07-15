function d=measureshoulder(a)

[p,~]=findshoulder(a);

d=sqrt((p(1,1)-p(2,1)).^2+(p(1,2)-p(2,2)).^2);
% a=flip(a,2);
end