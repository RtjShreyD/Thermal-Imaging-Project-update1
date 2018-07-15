function d=measuresleeve(a)
%  a must be the front facing image with hands to be close and thumbs must
%  be shown

[X,Y,x,y]=mysmooth(a);
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
a=logical(a);
c=step(blob,a);
[~,l]=findshoulder(a);
dr=zeros(size(X));

for i=1:size(X,1)
    if X(i)> c(1,1) && Y(i) > c(1,2)
        dr(i)=i;
    end
end
ll=find(dr);
xr=X(ll);
locofthumb=ll(1)-1+maxloc(xr);
d1=locofthumb-l(2);
a=flip(a,2);

[X,Y,x,y]=mysmooth(a);
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
a=logical(a);
c=step(blob,a);
[~,l]=findshoulder(a);
dr=zeros(size(X));

for i=1:size(X,1)
    if X(i)> c(1,1) && Y(i) > c(1,2)
        dr(i)=i;
    end
end
ll=find(dr);
xr=X(ll);
locofthumb=ll(1)-1+maxloc(xr);
d2=locofthumb-l(2);
d=min(d1,d2);
end