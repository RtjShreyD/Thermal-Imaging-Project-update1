function knee=measureknee(a,t)
[p1,p2]=kneel2(a);
[X,Y,x,y]=mysmooth(a);
knee=(t)*(abs(x(p1)-x(p2)))*pi;
end