function []=entireprocess(filename1,filename2,filename3,filename4)
A1=initiate2(filename1);
A2=initiate2(filename2);
A2=flip(A2,2);
[a1,a2]=alignfun(A1,A2);
A3=initiate2(filename3);
[a3,a4]=alignfun(A3,flip(A2,2));
% for knee we have to take a side view picture from side view .
a5=initiate2(filename4);
[X1,Y1,x1,y1]=mysmooth(a1);
[X2,Y2,x2,y2]=mysmooth(a2);
[X3,Y3,x3,y3]=mysmooth(a3);
[X4,Y4,x4,y4]=mysmooth(a4);
% blob analysis
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
C=step(blob,a1);
C2=step(blob,a2);
% [X2,Y2,x2,y2]=mysmooth(a2);
% 
cro=crotchfn(a1,C,X1,Y1);
hip =hipfn(C2,X2,Y2);
hiplevel=y2(hip);
[location2,p1]=new_right_points(a1,cro,hiplevel);
[location,p2]=new_left_points(a1,cro,hiplevel);
leftloc=location;
rightloc=location2;
% pixel to physical ratio
t=70.375/(maxfun(Y1)-minfun(Y1));

% plotting
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
[~,~,pneck]=newsideneck(a2,l);
ps(1,1,1)=pneck(1,1);
ps(1,1,2)=pneck(1,2);
ps(1,2,1)=pneck(2,1);
ps(1,2,2)=pneck(2,2);

% measuring
t1=measurethigh(P,ps);
ValuesInInches(10)=t1*t;

ValuesInInches(7)=realmeasureneck(filename1,filename2);
t3=measureinseam(X1,Y1,cro);
ValuesInInches(12)=t3*t;
t4=measurehip(P,ps);
ValuesInInches(3)=t4*t;
t5=measurechest(P,ps);
ValuesInInches(1)=t5*t;
t6= measurenbicep(leftloc,rightloc,X1,Y1);
ValuesInInches(6)=t6*t;
t7=measuretrouserwaist(P,ps);
ValuesInInches(9)=t7*t;
t8=measureshirtwaist(P,ps);
ValuesInInches(2)=t8*t;
t9=measureoutseam(X1,Y1,cro,P);
ValuesInInches(11)=t9*t;
%
t9=measuresleeve(a3);
ValuesInInches(5)=t9*t;
[t10,~]=measureslenght(a3,a4);
ValuesInInches(4)=t*t10;
t11=measureshoulder(a3);
ValuesInInches(8)=t11*t;
ValuesInInches(13)=measureknee(a5);
ValuesInInches=ValuesInInches';
file='measure.csv';
measurements{1,1}='Chest';
measurements{2,1}='Shirt Waist';
measurements{3,1}='Hip';
measurements{4,1}='Shirt Length';
measurements{5,1}='Sleeve';
measurements{6,1}='Bicep';
measurements{7,1}='Neck';
measurements{8,1}='Shoulder';
measurements{9,1}='Trouser Waist';
measurements{10,1}='Thigh';
measurements{11,1}='Outseam';
measurements{12,1}='Inseam';
measurements{13,1}='Knee';
T=table(measurements,ValuesInInches);
writetable(T,file);


end