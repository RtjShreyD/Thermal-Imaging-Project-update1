function muscle = muscles(a1,leftloc, rightloc)

[X1,Y1,x1,y1]=mysmooth(a1);

xmin = minloc(x1);
track = xmin:leftloc(2);
apl = leftloc(3);
[~,sz] = size(track);
k = zeros(sz);
for n=1:sz
    k(n)= sqrt((Y1(apl)-Y1(track(n))).^2 + (X1(apl)-X1(track(n))).^2);
end
k=ridofzero(k);
mink = min(k);
minkloc = find(k==mink);
bcpl = track(minkloc); %bicep left loc

p1 = leftloc(3)+10;
p2 = leftloc(3)+50;
tr1 = p1:p2;
[~,siz] = size(tr1);
trds = zeros(1,siz);
for  n=1:siz
    trds(n) = sqrt((Y1(bcpl)-Y1(tr1(n))).^2 + (X1(bcpl)-X1(tr1(n))).^2);
end
trd = min(trds);   %%%use to measure
trloc = find(trds==trd);
tcpl = tr1(trloc);

xmax = maxloc(X1);
track2 = rightloc(2):xmax;
apr = rightloc(3);
[~,szr] = size(track2);
kr = zeros(szr);
for n=1:szr
   kr(n) = sqrt((y1(apr)-y1(track2(n))).^2 + (x1(apr)-x1(track2(n))).^2);
end
kr=ridofzero(kr);
minkr = min(kr);
minkrloc = find(kr==minkr);
bcpr = track2(minkrloc); %bicep right loc

pr1 = rightloc(3)-10;
pr2 = rightloc(3)-50;
tr2 = pr2:pr1;
[~,sizr] = size(tr1);
trdsr = zeros(1,sizr);
for  n=1:sizr
    trdsr(n) = sqrt((Y1(bcpr)-Y1(tr2(n))).^2 + (X1(bcpr)-X1(tr2(n))).^2);
end
trdr = min(trdsr); %%use to measure
trlocr = find(trdsr==trdr);
tcpr = tr2(trlocr); 

p=x1(bcpl)+5; %%x left se inc hga
q=y1(tcpl)-5;
r=x1(bcpr)-5; %%x right se dec hga
s=y1(tcpr)-5; %%%because pt match krmme k liye y hmesha upar jaega

d1= sqrt((y1(bcpl)-q).^2 + (p-x1(tcpl)).^2);
d2= sqrt((y1(bcpr)-s).^2 + (r-x1(tcpr)).^2);

muscle = pi*(max(d1,d2));

% muscle = pi*(min(trdr,trd)); %%for muscle original remove the correction
% and use this
% disp(muscle);
end