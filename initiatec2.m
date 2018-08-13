function [data4,A]=initiatec2(filename, th)

data=csvread(filename,1,1);
[r,c]=size(data);
c=c-1;

data1(1:round(r/3),1:c)=data(1:round(r/3),1:c);
data2 = data1(1:round(r/3),1:(c/2));
data3 = data2(:, end/2 :end);
data4 = data3(:, end/2 :end);

data4=(data4-minfun(data4))/(maxfun(data4)-minfun(data4));
% figure,
% imshow(data1);
t=imhist(data4);

[~,loc]=maxfun2(t);

smoothened=sgolayfilt(t(loc:end),3,45);
smoothened=sgolayfilt(smoothened,3,45);
smoothened=sgolayfilt(smoothened,3,45);
smoothened=sgolayfilt(smoothened,3,45);
smoothened=sgolayfilt(smoothened,3,45);
smoothened=sgolayfilt(smoothened,3,45);
smoothened=sgolayfilt(smoothened,3,45);
smoothened=sgolayfilt(smoothened,3,45);
smoothened=sgolayfilt(smoothened,3,45);

[~,g2]=findpeaks(-smoothened);

A=data4>(loc+g2(1)+th)/255;
A=bwareaopen(A,10000);
end



