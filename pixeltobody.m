function [t1,t2]=pixeltobody(filename1,filename2,height)
A1=initiate2(filename1,7);
A2=initiate2(filename2,7);
[~,~,~,y1]=mysmooth(A1);
[~,~,~,y2]=mysmooth(A2);
t1=(maxfun(y1)-minfun(y1));
t2=(maxfun(y2)-minfun(y2));
t1=height/t1;
t2=height/t2;
end