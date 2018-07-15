function [location,p]=new_left_points(a,cro,hiplevel)
[X,Y,x,y]=mysmooth(a);
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
a=logical(a);
C=step(blob,a);
% cro is the index in 
N=size(X,1);
N2=round(N/2);
% neck point
new1=zeros(N2,1);
for i=1:N2
    if(C(1,1)>X(i) && C(1,2)>Y(i))
        new1(i)=i;
    end
end
k1=find(new1);
x1=x(k1(1):k1(end));
y1=y(k1(1):k1(end));
[~,loc]=findpeaks(x1);
p(1,1)=x1(loc(end));
p(1,2)=y1(loc(end));
location(1)=loc(end)+k1(1)-1;


%  sholder point
x2=x1(1:loc(end));
y2=y1(1:loc(end));
der2=zeros(loc(end)-1,1);
for i=1:loc(end)-1
    der2(i)=(y2(i)-y2(i+1))/(x2(i)-x2(i+1));
end
[~,l2]=findpeaks(der2);
p(2,1)=x2(l2(end));
p(2,2)=y2(l2(end));
location(2)=l2(end);
% armpit point
new3=zeros(N2,1);
for i=N2:N
    if(X(i)<C(1,1) && Y(i)<C(1,2))
        new3(i)=i;
    end
end
k3=find(new3);
x3=X(k3(1):k3(end));
y3=Y(k3(1):k3(end));
[~,loc3]=findpeaks(-y3);
der3=zeros(loc3(end)-1,1);
for j=1:loc3(end)-1
    der3(j)=((y3(j)-y3(j+1))/(x3(j)-x3(j+1)))-1;
end
der3=abs(der3);
[~,l3]=minfun2(der3);
p(3,1)=x3(l3);
p(3,2)=y3(l3);
location(3)=l3+k3(1)-1;

% thigh
loc4=find(abs(y-y(cro))<0.0001);
location(4)=loc4(end);
p(4,1)=X(location(4));
p(4,2)=Y(location(4));

% hip
location(5)=find(abs(y(location(4):location(3))-hiplevel)<0.001)+location(4)-1;
p(5,1)=X(location(5));
p(5,2)=Y(location(5));

% left shirt waist point
% ALGORITHM:left shirt waist point
% Step 1:Find out the left leg maximum point
% Step 2:Now from left arm pit location to the above found,left leg maxium point,find peaks in the negative x values.
% Step 3:Now find the location of the peak which is nearest to the
% centroid.This is the left shirt waist point.
A=zeros(size(X));
for i=1:size(X,1)
    if X(i)<C(1,1) && Y(i)>C(1,2)
        A(i)=Y(i);
    end
end
lal=location(3);
q=centll(C,X,Y);
a=min(q,lal);
b=max(q,lal);
A1=zeros(size(X));
for i=1:size(X,1)
    if i<=b && i>=a
        A1(i)=X(i);
    end
end
[~,loc]=findpeaks(A1);
dis=zeros(size(loc));
for i=1:size(loc,1)
dis(i)=distcent(loc(i),C,X,Y);
end
g=minloc(dis);
lw=loc(g);
location(6)=lw;
p(6,1)=X(location(6));
p(6,2)=Y(location(6));

% trouser waist is found out by the lh2 function
location(7)=lh2(location(6),location(5),X,Y);
p(7,1)=X(location(7));
p(7,2)=Y(location(7));

end