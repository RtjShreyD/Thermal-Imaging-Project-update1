function bicep = Oldbicep(filename1,filename2, height,kk)
A1=initiate2(filename1,kk);
A2=initiate2(filename2,kk);
[a1,a2]=alignfun(A1,A2);
[X1,Y1,x1,y1]=mysmooth(a1);
[X2,Y2,x2,y2]=mysmooth(a2);
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
C=step(blob,a1);
%C2=step(blob,a2);
hip =hipfn(C,X2,Y2);
hiplevel=y2(hip);
cro = crotchfn(a1,C,X1,Y1);
[location2,~]=new_right_points3(a1,cro,hiplevel);
[location,~]=new_left_points3(a1,cro,hiplevel);
leftloc=location;
rightloc=location2;
% pixel to physical ratio
t=height/(maxfun(Y2)-minfun(Y2));

bicep = t*measurenbicep(leftloc,rightloc,X1,Y1);
end
