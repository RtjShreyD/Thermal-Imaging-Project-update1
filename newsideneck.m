function [backkk,frontt,p]=newsideneck(a2,l)
l=l';
a2=flip(a2,2);
[row,col]=size(a2);
a=zeros(1,2);
p=zeros(2,2);
[X1,Y1,x1,y1]=mysmooth(a2);
[~,minloc]=minfun2(y1);
[~,right]=findpeaks(-X1(minloc:end));
a(1,1)=col+1-x1(minloc+right(1)-1);
a(1,2)=y1(minloc+right(1)-1);
a2=flip(a2,2);
[X2,Y2,x2,y2]=mysmooth(a2);
[~,minloc2]=minfun2(y2);
[~,maxloc2]=maxfun2(y2);
[~,left]=findpeaks(-x2(minloc2:maxloc2));
%  bak is the position of neck position at back side of the neck(index)
% and p(2,:) is the point of 
back=minloc2+left(1)-1;
p(2,1)=x2(back);
p(2,2)=y2(back);
xr=zeros(size(X2));
yr=zeros(size(X2));
xr(:)=abs(x2(:)-a(1,1));
yr(:)=abs(y2(:)-a(1,2));
sr=xr+yr;
% sr=sr';
% the above method is to find out the the idex(locofmin) is itself is the
% front point of the image given
% it is shifted because of the change in index.
[~,locofmin]=minfun2(sr);
if Y2(end)<Y2(locofmin)
    fronttraverse=size(x2,1);
else
    fronttraverse=l(1,1);
end
% fronttraverse=
siz=fronttraverse-locofmin+1;
dist=zeros(siz,1);
for i=locofmin:fronttraverse
    dist(i-locofmin+1)=sqrt((x2(i)-p(2,1)).^2+(y2(i)-p(2,2)).^2);
end

[~,cc]=minfun2(dist);

front=cc-1+locofmin;
p(1,1)=x2(front);
p(1,2)=y2(front);
% now in the same way i have to do the same algo for refining the front
% point.
siz2=l(3,2)-back+1;
dist2=zeros(siz2,1);
for j=back:l(3,2)
    dist2(j-back+1)=sqrt((x2(j)-p(1,1)).^2+(y2(j)-p(1,2)).^2);
end
[~,locback]=minfun2(dist2);
backk=locback-1+back;
p(2,1)=x2(backk);
p(2,2)=y2(backk);
% now in the same way i have to do the same algo for refining the front
% point keeping the back point constant.
siz3=fronttraverse-front+1;
dist3=zeros(siz3,1);
for k=front:fronttraverse
    dist3(k-front+1)=sqrt((x2(k)-p(2,1)).^2+(y2(k)-p(2,2)).^2);
end
[~,locfront]=minfun2(dist3);
frontt=locfront-1+front;
p(1,1)=x2(frontt);
p(1,2)=y2(frontt);
% now in the same way i have to do the same algo for refining the front
% point.
siz4=l(3,2)-backk+1;
dist4=zeros(siz4,1);
for j=backk:l(3,2)
    dist4(j-backk+1)=sqrt((x2(j)-p(1,1)).^2+(y2(j)-p(1,2)).^2);
end
[~,locbackk]=minfun2(dist4);
backkk=locbackk-1+backk;
p(2,1)=x2(backkk);
p(2,2)=y2(backkk);

end