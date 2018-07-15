function A=initiate2(filename,kk)
% read  the csv file into an image
data=csvread(filename,1,1);
[r,c]=size(data);
c=c-1;
% data=csvread(filename,1,1,[1 1 320 240]);
data1(1:r,1:c)=data(1:r,1:c);
data1=(data1-minfun(data1))/(maxfun(data1)-minfun(data1));
% figure 
% imshow(data1);
t=imhist(data1);
% histogram of the image is taken
% imhist(data1);
[~,loc]=maxfun2(t);
% smothened the curve
smoothened=sgolayfilt(t(loc:end),3,45);
smoothened=sgolayfilt(smoothened,3,45);
smoothened=sgolayfilt(smoothened,3,45);
smoothened=sgolayfilt(smoothened,3,45);
smoothened=sgolayfilt(smoothened,3,45);
smoothened=sgolayfilt(smoothened,3,45);
smoothened=sgolayfilt(smoothened,3,45);
smoothened=sgolayfilt(smoothened,3,45);
smoothened=sgolayfilt(smoothened,3,45);
% divide the forward and backward pixels in the image
[~,g2]=findpeaks(-smoothened);
% remove the backward pixels and take the threshold
A=data1>(loc+g2(1)-kk)/256;
% remove smaller ojects
A=bwareaopen(A,10000);
end