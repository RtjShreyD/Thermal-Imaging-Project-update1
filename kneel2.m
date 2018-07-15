function [p1,p2]=kneel2(ar)
[X,Y,x,y]=mysmooth(ar);
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
ar=logical(ar);
c=step(blob,ar);
[peaks,locs]=findpeaks(Y);
% if the peak values in the curve are having the same peaks then can be
% taken as 1 itself, same in the sense they must be taken with a variation
% of 10 pixels of height is tollerable if greaterr than that they can be
% seperated

for j=1:size(peaks,1)
    for i=1:size(peaks,1)-1
        if peaks(i+1)-peaks(i)<10
            peaks(i+1)=peaks(i);
        end
    end
end

maxp=maxfn(peaks);
% mxloc has the value of index of the boundary with leg which is on the
% ground
maxloc1=maxloc(peaks);
mxloc=locs(maxloc1);
% write to zero which are maximum peaks
for i=1:size(peaks,1)
    if peaks(i)==maxp
        peaks(i)=0;
    end
end
% now romoving the maximum peak we take the second (raised) leg will be our second peak
max2loc=maxloc(peaks);
max2p=locs(max2loc);
a=min(max2p,mxloc);
b=max(max2p,mxloc);
% to find the nearest point from centroid between left and right legs .
% will be 'mindis'
dist=zeros(b-a+1,1);
for i=1:b-a+1
    dist(i,1)=distcent(i+a-1,c,X,Y);
end
min_loc=minloc(dist);
mindis=min_loc+a-1;
% now i have to  make a new matrix to load the X,Y in betweeb mindis and max2p (raise leg)  
R=mindis;
x_n=zeros(R-a+1,1);
y_n=zeros(R-a+1,1);
for i=1:R-a+1
    x_n(i)=x(i+a-1);
end
for i=1:R-a+1
    y_n(i)=y(i+a-1);
end
xmal=maxloc(x_n);
xmil=minloc(x_n);
% xmal and xmil will be the starting and ending points of the matrix
% andd now rotation comes into the picture
angle=atan((y_n(xmil)-y_n(xmal))/(size(x_n,1)));
q=transpose(x_n);
w=transpose(-y_n);
v = [q;w];
x_center=0;
y_center=0;
center = repmat([x_center; y_center], 1, length(q));
theta = -angle;
R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
s = v - center;
so = R*s;
vo = so + center;
x_n_rotated = vo(1,:);
y_n_rotated = vo(2,:);
% x_n_rotated = vo(1,:);
% y_n_rotated = vo(2,:); are the rotated matrices

for i=1:3
y_n_rotated=sgolayfilt(y_n_rotated,3,45);
end
[~,loc_y_n_r]=findpeaks(y_n_rotated);
knee=loc_y_n_r+a-1;

B=Y;

xmx=maxloc(X);
kn33=zeros(size(X));
a1=max(mxloc,knee);
b1=min(mxloc,knee);
for i=1:size(X,1)
if i<=a1 && i>=b1
    kn33(i)=X(i);
end
end
% kn33 has the X values between knee point to the location of the grounded
% leg
[~,kn33l]=findpeaks(kn33);
% ymp is the location of toe end of the grounded leg
ymp=kn33l(end);

knl=Y(ymp)-Y(xmx)+Y(knee);
% knee level in Y axis

for i=1:size(Y,1)
    if abs(B(i)-knl)<=1 && X(i)<X(knee)
        B(i)=i;
    else
        B(i)=0;
    end
end
M=find(B);
disk=zeros(size(M));
for i=1:size(M,1)
    disk(i)=((Y(ymp)-Y(M(i)))^2+(X(ymp)-X(M(i)))^2)^(0.5);
end
% p1=M(minloc(disk));

for i=1:size(M,1)-1
    if M(i+1)-M(i)<2
        M(i)=0;
    end
end
% rrr=1;
as=find(M);
p1=M(as(1,1));
p2=M(as(2,1));

end
