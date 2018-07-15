function [d,p]=measureslenght(A1,A2)
%%
% [d,p]=measureslenght(A1,A2);
[X1,Y1,x1,y1]=mysmooth(A1);
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
A1=logical(A1);
c1=step(blob,A1);
% left position
N=size(X1,1);
[~,c]=maxfun2(X1);
p=zeros(2,2);
location=zeros(2,1);
% for neck
% from left to right most end traversing to get the neck point 
% here 'c' is the right end and 1 is left end
% from this we get the right corner edge point by using that for loop
% get the maximum peak ie., the bending point
new1=zeros(c,1);
for i=1:c-1
    if(X1(i)>c1(1,1) && Y1(i)<c1(1,2))
        new1(i)=i;
    end
end
k1=find(new1);
x1=X1(k1(1):k1(end));
y1=Y1(k1(1):k1(end));
[~,l1]=findpeaks(-x1);
% l1 consists of locations of the peaks
p(1,1)=x1(l1(1));
p(1,2)=y1(l1(1));
% and locations are saved in location

location(1)=k1(1)+l1(1)-1;

% for sholder
% from neck right point to the right max point in the for loop
x2=x1(l1(1):end);
y2=y1(l1(1):end);
der2=zeros(size(x2,1)-1,1);
% der2 is an array of slope form neck to end
% to find the minimum slope point
for i=1:size(x2,1)-1
    der2(i)=(y2(i)-y2(i+1))/(x2(i)-x2(i+1));
end
[~,l2]=findpeaks(-der2);
% l2 has the location for the minimum slope inthe curve from neck to get
% HPS

p(2,1)=x2(l2(1));
p(2,2)=y2(l2(1));
location(2)=location(1)-1+l2(1);
tt=zeros(size(X1));

for i=1:size(X1,1)
    if X1(i)> c1(1,1) && Y1(i) > c1(1,2) && Y1(i) < c1(1,2) + 150
        tt(i)=i;
    end
end
ll=find(tt);
xr=X1(ll);
locofthumb=ll(1)-1+maxloc(xr);
% to map the thumb and sholder in side view
[X2,Y2,x2,y2]=mysmooth(A2);
new2=zeros(size(X2));
for i=minloc(Y2):maxloc(Y2)
    if Y2(i)> Y1(location(1)) && Y2(i) <Y1(locofthumb)
        new2(i)=i;
    end
end
foundindex=find(new2);
d=foundindex(end)-foundindex(1);
end
