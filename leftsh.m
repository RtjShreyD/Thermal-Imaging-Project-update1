function sh=leftsh(c,X,Y)
req_reg=zeros(size(X));
for i=1:round(size(X)/2)
    if c(1,1)>X(i) && Y(i)<c(1,2)
        req_reg(i)=X(i);
    end
end
f=find(req_reg);
A=zeros(size(f));
B=0;
for i=1:size(A,1)-1
    if (f(i+1,1)-f(i,1))>1
        B=i;
    end
end

for i=1:size(f,1)-B
    A(i,1)=f(B+i);
end
for i=1:B
    A(i+size(f,1)-B)=f(i);
end
dist=zeros(size(A));
for i=1:size(A,1)-B
    dist(i)=distcent(f(i+B),c,X,Y);
end
for i=1:B
    dist(i+size(f,1)-B)=distcent(f(i),c,X,Y);
end

dismi=minfun(dist);
disma=maxfun(dist);
angle=atan((disma-dismi)/(size(dist,1)));
q=1:size(dist,1);
w=transpose(dist);
v = [q;w];
x_center=0;
y_center=0;
center = repmat([x_center; y_center], 1, length(q));
theta = -angle;       % pi/3 radians = 60 degrees
R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
s = v - center;     % shift points in the plane so that the center of rotation is at the origin
so = R*s;           % apply the rotation about the origin
vo = so + center;   
dist_rotated = vo(2,:);
for i=1:3
dist_rotated=sgolayfilt(dist_rotated,3,45);
end
[~,loc_dr]=findpeaks(dist_rotated);
sh=A(loc_dr(1,1));
end