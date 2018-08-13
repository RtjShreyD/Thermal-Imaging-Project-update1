function [r1,r2]=p2p_ratio(filename1,filename2,height)
A1=initiate2(filename1,7);
A2=initiate2(filename2,7);
[~,~,x1,y1]=mysmooth(A1);
[~,~,x2,y2]=mysmooth(A2);
head = minloc(y1);
toe  = maxloc(y1);
head2 = minloc(y2);
toe2 = maxloc(y2);
d1 = sqrt((y1(head)-y1(toe))^2 + (x1(head)-x1(toe))^2);
d2 = sqrt((y2(head2)-y1(toe2))^2 + (x2(head2)-x2(toe2))^2);
r1 = height/d1;
r2 = height/d2;
end




