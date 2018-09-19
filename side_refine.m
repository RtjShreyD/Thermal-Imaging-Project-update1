function [p] = side_refine(a, ps)
%%to refine the trouser waist point as it was coming on the hand so just
%%found the point that lies on the body not on hand

[X,Y,x,y]=mysmooth(a);
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
p = ps;
maxy = maxloc(Y);
[sz,~] = size(Y);
trc = maxy:sz;
y1 = ps(7,1,2);
loc = find((abs(y1-y(trc))<0.01),1);
lc = trc(loc);
p(7,2,1) = x(lc);
p(7,2,2) = y(lc);


end
