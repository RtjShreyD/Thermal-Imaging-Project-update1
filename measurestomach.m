function  stomach = measurestomach(a1,a2,l,height)

[X1,Y1,x1,y1]=mysmooth(a1);
[X2,Y2,x2,y2]=mysmooth(a2);
% blob analysis
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
C=step(blob,a1);
C2=step(blob,a2);
%
cll = centll(C,x1,y1); 
crl = centrl(C,x1,y1);
fstom=l(1,6);
bstom=l(2,6);
% pixel to physical ratio
t=height/(maxfun(Y2)-minfun(Y2));

 a=sqrt((y1(cll)-y1(crl)).^2 + (x1(cll)-x1(crl)).^2);
 b=sqrt((y2(fstom)-y2(bstom)).^2 + (x2(fstom)-x2(bstom)).^2);
 stom= pi*(a+b)/2; %circumfrence of ellipse using Naive formula
 %stom1 = t*((stom/2));
 halfrect = (a+b); %perimeter of the half rectangle in (]
 stom2 = t*(stom); 
 stom3 = t*((stom/2)+halfrect);
 stom4 = t*((stom/2)+a); %half circumference + a ie, (| in (|]
 stom5 = (stom2+stom3+stom4)/3;
 %disp(stom5);

 p=sqrt((y1(cll)-y1(crl)).^2 + (x1(cll)-x1(crl)).^2)/2;
 q=sqrt((y2(fstom)-y2(bstom)).^2 + (x2(fstom)-x2(bstom)).^2)/2;
 stomm = pi*(3*(p+q)-sqrt((3*p+q)*(p+3*q))); %find circumference of the ellipse using Ramanujam formula
 %stomm1 = t*((stomm/2));
 halfrec = (p+q);
 stomm2 = t*(stomm); 
 stomm3 = t*((stomm/2)+halfrec);
 stomm4 = t*((stomm/2)+q);
 stomm5 = (stomm2+stomm3+stomm4)/3;
 %disp(stomm5);
 stomach = (stom5+stomm5)/2;
 end
