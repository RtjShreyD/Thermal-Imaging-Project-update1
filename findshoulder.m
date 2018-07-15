function [p,l]=findshoulder(a)
[X,Y,x,y]=mysmooth(a);
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
a=logical(a);
c=step(blob,a);
sh=leftsh(c,X,Y);
a1=flip(a,2);
c1=step(blob,a1);
[X1,Y1,x1,y1]=mysmooth(a1);
rh=leftsh(c1,X1,Y1);
p(1,1)=X(sh);
p(1,2)=Y(sh);
l(1)=sh;
p(2,1)=size(a,2)+1-X1(rh);
p(2,2)=Y1(rh);
xr(:)=abs(X(:)-p(2,1));
yr(:)=abs(Y(:)-p(2,2));
sr=xr+yr;
sr=sr';
minl=minloc(sr);
p(2,1)=X(minl);
p(2,2)=Y(minl);
l(2)=minl;
% findpeaks(X(sh:))
end