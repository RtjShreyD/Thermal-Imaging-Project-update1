function [psl,psr,ll,lr] = side_refine(a, p1)

[X,Y,x,y]=mysmooth(a);
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
a=logical(a);
C=step(blob,a);

y1 = p1(1,2);
tr = 1:minloc(Y);
nloc = find((abs(y1-y(tr))<0.01),1);
tr2 = minloc(Y):maxloc(Y);
nloc2 = find((abs(y1-y(tr2))<0.01),1);
ll(1) = nloc;
psl(1,1) = x(ll(1));
psl(1,2) = y(ll(1)); %frontneck
lr(1) = tr2(nloc2);
psr(1,1) = x(lr(1));
psr(1,2) = y(lr(1)); %backneck

y2 = p1(2,2);
sloc = find((abs(y2-y(tr))<0.01),1);
ll(2) = sloc;
psl(2,1) = x(ll(2));
psl(2,2) = y(ll(2)); %front shoulder1 
sloc2 = find((abs(y2-y(tr2))<0.01),1);
lr(2) = tr2(sloc2);
psr(2,1) = x(lr(2));
psr(2,2) = y(lr(2)); %back shoulder1 

y3 = p1(3,2);
aloc = find((abs(y3-y(tr))<0.01),1);
ll(3) = aloc;
psl(3,1) = x(ll(3));
psl(3,2) = y(ll(3)); %front chest point
aloc2 = find((abs(y3-y(tr2))<0.01),1);
lr(3) = tr2(aloc2);
psr(3,1) = x(lr(3));
psr(3,2) = y(lr(3)); %back chest 

y4 = p1(4,2);
[sz,~] = size(X);
trc = maxloc(Y):sz;
hloc = find((abs(y4-y(trc))<0.01),1);
ll(4) = trc(hloc);
psl(4,1) = x(ll(4));
psl(4,2) = y(ll(4)); %front hip
hloc2 = find((abs(y4-y(tr2))<0.01),1);
lr(4) = tr2(hloc2);
psr(4,1) = x(lr(4));
psr(4,2) = y(lr(4)); %back hip

y5 = p1(5,2);
tloc = find((abs(y5-y(trc))<0.01),1);
ll(5) = trc(tloc);
psl(5,1) = x(ll(5));
psl(5,2) = y(ll(5));  %front thigh
tloc2 = find((abs(y5-y(tr2))<0.01),1);
lr(5) = tr2(tloc2);
psr(5,1) = x(lr(5));
psr(5,2) = y(lr(5));  %back hip

y6 = p1(6,2);
shloc = find((abs(y6-y(tr))<0.01),1);
ll(6) = tr(shloc);
psl(6,1) = x(ll(6));
psl(6,2) = y(ll(6)); %front shirtwaist
shloc2 = find((abs(y6-y(tr2))<0.01),1);
lr(6) = tr2(shloc2);
psr(6,1) = x(lr(6));
psr(6,2) = y(lr(6)); %back shirtwaist


y7 = p1(7,2);
wloc = find((abs(y7-y(trc))<0.01),1);
ll(7) = trc(wloc);
psl(7,1) = x(ll(7));
psl(7,2) = y(ll(7)); %front trouser waist point
wloc2 = find((abs(y7-y(tr2))<0.01),1);
lr(7) = tr2(wloc2);
psr(7,1) = x(lr(7));
psr(7,2) = y(lr(7)); %back trouser waist point


end
