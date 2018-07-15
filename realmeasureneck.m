function d=realmeasureneck(filename1,filename2,height)

[~,A1]=initiate3(filename1);

[~,A2]=initiate3(filename2);
% imshow(A1)

[X1,Y1,x1,y1]=mysmooth(A1);
[X2,Y2,x2,y2]=mysmooth(A2);
%
[~,loc]=findpeaks(X1(1:minloc(y1)));
%
[~,loc2]=findpeaks(-X1(minloc(y1):end));
%
p(1,1)=x1(loc(1));
p(1,2)=y1(loc(1));
p(2,1)=x1(loc2(end)+minloc(y1));
p(2,2)=y1(loc2(end)+minloc(y1));
%
d1=p(2,1)-p(1,1);
%
% for the side view because the neck point is at up and down so it is 
% [~,loc3]=findpeaks(X2(maxloc(y2):end));
%
if maxloc(y2)==1
    pppp=size(x2,1);
else
    pppp=maxloc(y2);
end
[~,loc4]=findpeaks(-X2(minloc(y2):pppp));
% ps(1,1)=x2(loc3(1)+maxloc(y2));
% ps(1,2)=y2(loc3(1)+maxloc(y2));
front=loc4(end)+minloc(y2);
ps(2,1)=x2(front);
ps(2,2)=y2(front);
%
% d2=sqrt((ps(1,1)-ps(2,1)).^2+(ps(2,2)-ps(1,2)).^2);
% d=t*pi*(d1+d2)/2;
A2=flip(A2,2);
[X2,Y2,x2,y2]=mysmooth(A2);
[~,loc3]=findpeaks(-X2(minloc(y2):end));
ps(1,1)=size(A2,2)+1-x2(loc3(end)+minloc(y2));
ps(1,2)=y2(loc3(end)+minloc(y2));
A2=flip(A2,2);
[X2,Y2,x2,y2]=mysmooth(A2);
xr(:,1)=abs(x2(:)-ps(1,1));
yr(:,1)=abs(y2(:)-ps(1,2));
sr(:,1)=xr(:,1)+yr(:,1);
locc=minloc(sr);
%  now back point is locc
back=locc;
%
% keeping back as stagnant and move front towards upside
if y2(1)>y2(locc)
    backtrav=locc-10:minloc(y2);
else
    backtrav=locc-10:size(x2,1);
end
% now for traversing of front
dist1=zeros(front-minloc(y2)+1,1);
for i=minloc(y2):front
    dist1(i-minloc(y2)+1,1)=sqrt((ps(1,1)-x2(i)).^2+(ps(1,2)-y2(i)).^2);
end
% to find the minimum distance location 
tempfront=minloc(dist1);
frontt=tempfront+minloc(y2)-1;
ps(2,1)=x2(frontt);
ps(2,2)=y2(frontt);
%
% now for traversing of back
dist2=zeros(size(backtrav',1),1);
%
for i=backtrav(1):backtrav(end)
    dist2(i-backtrav(1)+1,1)=(ps(2,1)-x2(i)).^2+(ps(2,2)-y2(i)).^2;
end
%
tempback=minloc(dist2);
backk=tempback+backtrav(1)-1;
ps(1,1)=x2(backk);
ps(1,2)=y2(backk);

%
d2=sqrt((ps(1,1)-ps(2,1)).^2+(ps(2,2)-ps(1,2)).^2);
[t1,t2]=pixeltobody(filename1,filename2,height);
d=pi*(d1*t1+d2*t2)/2;
end