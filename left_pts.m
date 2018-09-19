function [location,p]= left_pts(a,pr)

[X,Y,x,y]=mysmooth(a);
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
a=logical(a);
C=step(blob,a);

head = minloc(Y);
y1 = pr(1,2);
tr = 1:head;
nloc = find((abs(y1-y(tr))<0.01),1);
location(1) = nloc;
p(1,1) = x(location(1));
p(1,2) = y(location(1));

[~,lsh]=findshoulder(a); % shoulder2
y2 = pr(2,2);
trc = lsh(1):location(1);
sloc = find((abs(y2-y(trc))<0.01),1);
location(2) = trc(sloc);
p(2,1) = x(location(2));
p(2,2) = y(location(2)); %shoulder 1

maxy = maxloc(Y);
[sz,~] = size(X);
trk = maxy:sz;
y3 = pr(3,2);
aploc = find((abs(y3-y(trk))<0.01),1);
location(3) = trk(aploc);
p(3,1) = x(location(3));
p(3,2) = y(location(3)); %armpit 

trac = maxy:location(3);
y4 = pr(4,2);
hloc = find((abs(y4-y(trac))<0.01),1);
location(4) = trac(hloc);
p(4,1) = x(location(4));
p(4,2) = y(location(4)); %hip

trace = maxy:location(4);
y5 = pr(5,2);
tloc = find((abs(y5-y(trace))<0.01),1,'last');
location(5) = trace(tloc);
p(5,1) = x(location(5));
p(5,2) = y(location(5)); %thigh

track = location(4):location(3);
y6 = pr(6,2);
shloc = find((abs(y6-y(track))<0.01),1);
location(6) = track(shloc);
p(6,1) = x(location(6));
p(6,2) = y(location(6)); %shirtwaist

trx = location(5):location(6);
y7 = pr(7,2);
trloc = find((abs(y7-y(trx))<0.01),1);
location(7) = trx(trloc);
p(7,1) = x(location(7));
p(7,2) = y(location(7));



% rr = 1:7;
% figure, imshow(a);
% hold on
% plot(X,Y,'b-','linewidth',2);
% plot(C(1,1),C(1,2),'r*');
% plot(pr(rr,1),pr(rr,2),'g*');
% plot(x(location(1)),y(location(1)),'g*');
% plot(x(location(2)),y(location(2)),'g*');
% plot(x(location(3)),y(location(3)),'g*');
% plot(X(location(4)),Y(location(4)),'g*');
% plot(X(location(5)),Y(location(5)),'g*');
% plot(X(location(6)),Y(location(6)),'g*');
% plot(X(location(7)),Y(location(7)),'g*');
end