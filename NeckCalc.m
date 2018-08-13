function neck = NeckCalc(filename1,filename2,height)
%kk=5; 
% height=70.5;
% filename1='Dileep_f1.csv';
% filename2='Dileep_s1.csv';

[~,A1]=initiate3(filename1);
[~,A2]=initiate3(filename2);


% try
    [a1,a2]=alignfun(A1,A2);
    [X1,Y1,x1,y1]=mysmooth(a1);
    [X2,Y2,x2,y2]=mysmooth(a2);

    blob=vision.BlobAnalysis;
    blob.AreaOutputPort = false;
    blob.BoundingBoxOutputPort = false;
    C=step(blob,a1);
    C2=step(blob,a2);
% catch
%     [X1,Y1,x1,y1]=mysmooth(A1);
%     [X2,Y2,x2,y2]=mysmooth(A2);
% 
%     blob=vision.BlobAnalysis;
%     blob.AreaOutputPort = false;
%     blob.BoundingBoxOutputPort = false;
%     C=step(blob,A1);
%     C2=step(blob,A2);
% end
head = minloc(y1);
travf = centrl(C,X1,Y1);
trace = 1:head;
[~,lnck] = findpeaks(x1(trace));
mlnck = min(lnck);
track = head:travf;
dist = zeros(size(track));
 [~,n] = size(track);
 for i=1:n
     k = track(i);
     dist(i) = sqrt((y1(mlnck)-y1(k)).^2 + (x1(mlnck)-x1(k)).^2);
 end
 dist = dist';
 mindist_loc = minloc(dist);
 mrnckp = track(mindist_loc); %right neck best point

%%%%computed left nck pt as the best point
dists = zeros(size(trace));
[~,n] = size(trace);
for i=1:n
     k = trace(i);
     dists(i) = sqrt((y1(mrnckp)-y1(k)).^2 + (x1(mrnckp)-x1(k)).^2);
end
 dists = dists';
 mindist_locs = minloc(dists);
 mlnckp = trace(mindist_locs);  %left neck best point
 
figure,
imshow(a1);
hold on
plot(x1,y1,'-b','linewidth',2);
plot(C(1,1),C(1,2),'r*');
plot(x1(mlnckp),y1(mlnckp),'m*');
plot(x1(mrnckp),y1(mrnckp),'m*');

head2 = minloc(y2); 
%disp(head2);
xmin2 = minloc(x2);
[~,nxloc2] = findpeaks(x2(xmin2:head2));
disp(nxloc2);
bnck = max(nxloc2);   %%back neck point not perfect for all cases 
travf2 = centrl(C2,X2,Y2);
trace2 = 1:head2;
track2 = head2:travf2;
dist2 = zeros(size(track2));
[~,n2] = size(track2);
 for i=1:n2
     k2 = track2(i);
     dist2(i) = mean(abs(sqrt((y2(bnck)-y2(k2)).^2 + (x2(bnck)-x2(k2)).^2))); 
 end
 dist2 = dist2';
 mindist_loc2 = minloc(dist2);
 fnckp = track2(mindist_loc2);  %%front neck best point

%%%compute back neck pt as the best point
dist2s = zeros(size(trace2));
[~,n2s] = size(trace2);
 for i=1:n2s
     k2s = trace2(i);
     dist2s(i) = sqrt((y2(fnckp)-y2(k2s)).^2 + (x2(fnckp)-x2(k2s)).^2); 
 end
 dist2s = dist2s';
 mindist_loc2s = minloc(dist2s);
 bnckp = trace2(mindist_loc2s);  %%back neck best point

[r1,r2] = p2p_ratio(filename1,filename2,height);

% disp(fnckp);
% disp(bnckp);

%%%thresholding correction
p = x2(fnckp)-5;
q = x2(bnckp)+5;
r = y2(fnckp)-5;
s = y2(bnckp)+5;
j = x1(mlnckp)+15;
k = x1(mrnckp)-15;
l = y1(mlnckp)+15;
m = y1(mrnckp)-15;
% p = x2(fnckp)+5;
% q = x2(bnckp)-5;
% r = y2(fnckp)+5;
% s = y2(bnckp)-5;
% j = x1(mlnckp)-10;
% k = x1(mrnckp)+10;
% l = y1(mlnckp)-10;
% m = y1(mrnckp)+10;    %%to be added as fat body correction later

a = sqrt((p-q).^2 + (r-s).^2); %major axis
b = sqrt((j-k).^2 + (l-m).^2); %minor axis

[t1,t2]=pixeltobody(filename1,filename2,height);
neck2 = pi*(t1*a+t2*b)/2;
neck3 = pi*(r1*a+r2*b)/2;

%neck = min(neck2,neck3);    %%for NeckCalc-1
%neck = max(neck2,neck3);    %%for NeckCalc-2
neckx = (neck2 + neck3)/2;    %%for NeckCalc-3
necky = min(neck2,neck3); 
neck = (neckx + necky)/2;     %%for NeckCalc-4    %%finalised NeckCalc-4


% figure,
% imshow(a2);
% hold on
% plot(x2,y2,'-b','linewidth',2);
% plot(C2(1,1),C2(1,2),'r*');
%  plot(x2(bnck),y2(bnck),'c*');
% % plot(x2(fnckp),y2(fnckp),'c*');
% % plot(x2(1),y2(1),'c*');
% plot(x2(head2),y2(head2),'c*');
% plot(x2(xmin2),y2(xmin2),'c*');
end





