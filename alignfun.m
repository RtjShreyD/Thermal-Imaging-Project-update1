function [a1,a2]=alignfun(A1,A2)
% input arguments ust be binary images
% and the image of same body in front (A1) and side (A2)
% im aligning wrt the height of the pixels
% aligned by leveling the Y min
[r,c]=size(A1);
[X1,Y1,x1,y1]=mysmooth(A1);
[X2,Y2,x2,y2]=mysmooth(A2);
[m1,c1]=minfun2(y1);
[m2,c2]=minfun2(y2);
[m3,c3]=maxfun2(y1);
[m4,c4]=maxfun2(y2);
full=zeros(r,2*c);
% full(:,1:480)=A1;
i=m1-m2;
if(i>=0)
% if i is +ve then second image must be shifted above and vice versa
    full(m1:end,c+1:2*c)=A2(m2:end-i,:);
    full(:,1:c)=A1;
else
    full(m2:end,1:c)=A1(m1:end+i,:);
    full(:,c+1:2*c)=A2;
end
full=logical(full);
a1=full(:,1:c);
a2=full(:,c+1:2*c);
end