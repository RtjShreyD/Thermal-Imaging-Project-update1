clear
clc

%Chest_factor is calc from MH and input here by checking change in chest by varying by single unit in muscle, weight, prop, then calculate variation ratios for all,
%then calc mean ratio in each parameter, then calc mean ratio of all 3 mean ratios obtained.
    file = 'f_mh5.png';
    file2 = 's_mh5.png';
    height = 172.18; %input in cms
    height=rounds2(height);
   
    Mh_mus = 64.60; % input in percentage
    Mh_wt = 115.90; %input in percentage
    prop_units = 5.5;  %input in units after manual calculation
    chest_factor = 0.98; 

mus_units = Mh_mus/(100/12);   %%caliberation is taken as 12 units in the MH software for 100% in muscles and proportion 
wt_units = Mh_wt/(150/12);   %% and for weight is 150% for 12 units.



%
D = im2bin(file);
D2 = im2bin(file2);
%
[a1,a2] = alignfun(D,D2);
%
[X1,Y1,x1,y1]=mysmooth(a1);
[X2,Y2,x2,y2]=mysmooth(a2);
% 
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
C=step(blob,a1);
C2=step(blob,a2);
cro=crotchfn(a1,C,X1,Y1);
hip =hipfn(C,X2,Y2);
hiplevel=y2(hip);
[location2,p1]=new_right_points2(a1,cro,hiplevel);
[location,p2]=new_left_points2(a1,cro,hiplevel);
% leftloc=location;
% rightloc=location2;
% X=X1;
% Y=Y1;
% cll = centll(C,x1,y1); 
% crl = centrl(C,x1,y1);

t=height/(maxfun(Y2)-minfun(Y2));

P=pointadjust(p1,p2,C);
p_1=P(:,1,2);
Pround=round(p_1);
l=zeros(2,size(Pround,1));

for i=1:size(Pround,1)
    p=find(abs(y2-Pround(i))<0.01);
    l(1,i)=p(1);
    l(2,i)=p(end);
end
ps=loc2(X2,Y2,l);

neck2 = t*rmneck2(a1,a2);
disp(neck2);
    
chest = rounds2(t*measurechest(P,ps));
chest2 = chest + chest_factor*(prop_units + wt_units - mus_units); 
disp(chest2);

rr=1:7;
figure, imshow(a1);
hold on
plot(X1,Y1,'b-','linewidth',2);
plot(C(1,1),C(1,2),'r*');
plot(P(1,1,1),P(1,1,2),'g*');
plot(P(2,1,1),P(2,1,2),'g*');



% 
% figure, imshow(a2);
% hold on
% plot(X2,Y2,'b-','linewidth',2);
% plot(C2(1,1),C2(1,2),'r*');
% plot(ps(rr,:,1),ps(rr,:,2),'g*');






% %%%get points on boundary 
% N = 100 ;
% x = linspace(min(X1),max(X1),N) ; 
% y = linspace(min(Y1),max(Y1),N) ; 
% [X,Y] = meshgrid(x,y) ;
% 
% idx = inpolygon(X(:),Y(:),X1,Y1) ;
% 
% X = X(idx) ; Y = Y(idx) ;  

%i1 = X1(location(3)
