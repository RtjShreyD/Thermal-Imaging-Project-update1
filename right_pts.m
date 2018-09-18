function [location,p]= right_pts(a,crotch,hiplevel)

[X,Y,x,y]=mysmooth(a);
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
a=logical(a);
C=step(blob,a);
N=size(X,1);
[~,c]=maxfun2(X);
p=zeros(7,2);
location=zeros(7,7);

new1=zeros(c,1);
for i=1:c-1
    if(X(i)>C(1,1) && Y(i)<C(1,2))
        new1(i)=i;
    end
end
k1=find(new1);
x1=X(k1(1):k1(end));
y1=Y(k1(1):k1(end));
[~,l1]=findpeaks(-x1);
location(1)=k1(1)+l1(1)-1;
p(1,1)=x(location(1));
p(1,2)=y(location(1));  %front neck

[~,lsh]=findshoulder(a); % shoulder2
trace = location(1):lsh(2);
[~,s] = size(trace);
x2 = zeros(s,1);
for i=1:s
   diff = abs(X(trace(1))-X(trace(i)));
   if diff<3
       x2(i) = X(trace(i));
   end 
end 
mx = max(x2);
mxloc = find(x2==mx);
location(2) = trace(mxloc); %shoulder 1

new3=zeros(N-c,1);
for i=c+1:N
    if(X(i)>C(1,1) && Y(i)<C(1,2))
        new3(i)=i;
    end
end
k3=find(new3);
x3=X(k3(1):k3(end));
y3=Y(k3(1):k3(end));
[~,l3]=findpeaks(-y3);
der3=zeros(size(y3,1)-l3(end)-1,1);
for i=l3(end):size(y3,1)-1
     der3(i-l3(end)+1)=(y3(i+1)-y3(i))/(x3(i+1)-x3(i))+1;
end
der3=abs(der3);
% minimum of the slope
[~,l_3]=minfun2(der3);
location(3)=l3(end)+l_3+k3(1)-1;  
p(3,1)=x(location(3));
p(3,2)=y(location(3)); %Armpit points

locA =crorl(crotch,X,Y);
y3 = C(1,2);
trac = location(3):locA;
locB = find(abs(y3-Y(trac))<1); %approx centrl
locB = min(locB);
locC = trac(locB);
location(4) = round((locA+locC)/2);  
p(4,1) = x(location(4));
p(4,2) = y(location(4)); %Hip points

maxy = maxloc(Y);
tr = location(4):maxy;
[~, pkls] = findpeaks(X(location(4):maxy));
pkl = tr(pkls(1));
delta = X(pkl)-X(location(4));
if delta<3
    location(5)=pkl;
else
    location(5)=round((location(4)+pkl)/2); 
end
p(5,1) = x(location(5));
p(5,2) = y(location(5)); %thigh points

trk = location(3):location(4);
[~,pklocs] = findpeaks(-x(trk));
pkloc = round(mean(pklocs));
location(6)= trk(pkloc);
p(6,1) = x(location(6));
p(6,2) = y(location(6)); %shirtwaist point/underbust point

location(7)=rh2(location(6),location(5),X,Y);
p(7,1)=x(location(7));
p(7,2)=y(location(7));





figure, imshow(a);
hold on
plot(X,Y,'b-','linewidth',2);
plot(C(1,1),C(1,2),'r*');
plot(X(location(1)),Y(location(1)),'g*');
plot(X(location(2)),Y(location(2)),'g*');
plot(X(location(3)),Y(location(3)),'g*');
plot(X(location(4)),Y(location(4)),'g*');
plot(X(location(5)),Y(location(5)),'g*');
plot(X(location(6)),Y(location(6)),'g*');
plot(X(location(7)),Y(location(7)),'g*');


end