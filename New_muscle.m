function muscle = New_muscle(a1,a3,leftloc,rightloc)
[X1,Y1,x1,y1]=mysmooth(a1);
[X3,Y3,x3,y3]=mysmooth(a3);

%xmin = minloc(X3);
ymin = minloc(Y3);
apl = leftloc(3);
apr = rightloc(3);
track = 1:ymin;
dloc = round(mean(track));
xmax = maxloc(X3);
track2=ymin:xmax;
[~,sz] = size(track2);
k = zeros(sz);
for n=1:sz
    if y3(dloc)==y3(track2(n))
        k(n)=n;
        break;
    elseif y3(dloc)-1==y3(track2(n))||y3(dloc)+1==y3(track2(n))
        k(n)=n;
    else
        k(n)=0;
    end
end
kn = ridofzero(k);
idx = round(mean(kn));
dloc2 = track2(idx);

dist1 = sqrt((y3(dloc)-y3(dloc2)).^2 + (x3(dloc)-x3(dloc2)).^2);
dist2 = sqrt((y1(apl)-y1(apr)).^2 + (x1(apl)-x1(apr)).^2);
dis = dist1-dist2;
arm = dis/2;
muscle = pi*(dis+arm)/2;
%disp(muscle);

end