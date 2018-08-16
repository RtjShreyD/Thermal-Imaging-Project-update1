function [hipleft,hipright] = newhipfront(a)
[X1,Y1,x1,y1]=mysmooth(a);

blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
%a=logical(a);
C=step(blob,a);


cll = centll(C,x1,y1); 
crl = centrl(C,x1,y1);
crotch = crotchfn(a,C,x1,y1);
ymax = maxloc(y1);
trac = crl:ymax;
[~,sz]=size(trac);
dis1 = zeros(size(trac));
dis2 = zeros(size(trac));
for n=1:sz
    dis1(n)=sqrt((y1(crl)-y1(trac(n)))^2 + (x1(crl)-x1(trac(n)))^2);
end
for n=1:sz
    dis2(n)=sqrt((y1(crotch)-y1(trac(n)))^2 + (x1(crotch)-x1(trac(n)))^2);
end
%%for one right hip point
dis = dis1-dis2;
ds = ones(size(dis));
ds = round(dis);
for n=1:sz
    if ds(n)==0
        v = n;
    end
end
hipr=trac(v);

trac2 = crotch:cll; %for left leg max pt
[~,sx] = size(trac2);
dis3 = zeros(size(trac2));
for n=1:sx
   dis3(n)=sqrt((y1(ymax)-y1(trac2(n)))^2 + (x1(ymax)-x1(trac2(n)))^2); 
end
dismin = min(dis3);
yl = find(dis3==dismin);
yml = trac2(yl)+30; %%left max point in y

trac3=yml:cll;
[~,sc] = size(trac3);
dis4 = zeros(size(trac3));
for n=1:sc
   dis4(n)=sqrt((y1(hipr)-y1(trac3(n)))^2 + (x1(hipr)-x1(trac3(n)))^2);
end
dis_min = min(dis4);
yll = find(dis4==dis_min);
hipl = trac3(yll);
hipll = round(mean(hipl));
hiplll= hipll-15;

if (y1(hipr)-y1(hipll))>15
    hipleft = hiplll;
else
    hipleft = hipll;
end
    hipright = hipr;
end