function [neck,l,r,f,b] = rmneck(a1,a2)

A1 = init(a1);
A2 = init(a2);
[X1,Y1,x1,y1]=mysmooth(A1);
[X2,Y2,x2,y2]=mysmooth(A2);
[~,loc]=findpeaks(X1(1:minloc(y1)));
[~,loc2]=findpeaks(-X1(minloc(y1):end));

p(1,1)=x1(loc(1)); %loc(1) has the 1st peak of X and x1(loc(1)) is defined as point p(1,1)
p(1,2)=y1(loc(1)); %loc(1) has the 1st peak of X and y1(loc(1)) is defined as point p(1,2)
p(2,1)=x1(loc2(end)+minloc(y1)); %loc2(end) has the last negative peak of X 
p(2,2)=y1(loc2(end)+minloc(y1)); 


%%for side view
if maxloc(y2)==1
    pppp=size(x2,1);
else
    pppp=maxloc(y2);
end
[~,loc4]=findpeaks(-X2(minloc(y2):pppp));

back=loc4(end)+minloc(y2);
ps(2,1)=x2(back);
ps(2,2)=y2(back);

%%for front neck point%%

head = minloc(Y2);
base = maxloc(Y2);
base2 = base+50;
st = minloc(X2);
diff = abs(Y2(st)-Y2(base2));

if diff<5
    trace = st:head;
    [~,pkloc] = findpeaks(X2(trace));
    front = pkloc;   
else
    [sz,~] = size(Y2);
    ends = sz-1;
    track = base2:ends;
    [~,szx] = size(track);
    dis = zeros(size(track));
    for i=1:szx
       dis(i) = sqrt((Y2(back)-Y2(track(i))).^2 + (X2(back)- X2(track(i))).^2); 
    end    
    mindis = min(dis);
    floc = find(dis == mindis);
    front = track(floc);
end

ps(1,1) = X2(front);
ps(1,2) = Y2(front);

d1=p(2,1)-p(1,1);
d2=sqrt((ps(1,1)-ps(2,1)).^2+(ps(2,2)-ps(1,2)).^2);
neck = pi*(d1+d2)/2;

l = loc(1);
r = loc2(end)+minloc(y1);
f = front;
b = back;


end