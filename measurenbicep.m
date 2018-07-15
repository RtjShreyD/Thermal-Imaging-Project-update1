function d=measurenbicep(leftloc,rightloc,X,Y)
[~,c]=maxfun2(X);
distl=zeros(1,2);
k6=zeros(c-rightloc(2)+1,1);
k5=zeros(leftloc(2),1);
for j=leftloc(3)+40
    k5(1:leftloc(2),1)=sqrt((X(j)-X(1:leftloc(2))).^2+(Y(j)-Y(1:leftloc(2))).^2);   
    [distl(1,1),distl(1,2)]=minfun2(k5);
end
distr=zeros(1,2);
for j=rightloc(3)-40
%     for i=rightloc(2):c
        k6(1:c-rightloc(2)+1)=sqrt((X(j)-X(rightloc(2):c)).^2+(Y(j)-Y(rightloc(2):c)).^2);
        [k2,distr(1,2)]=minfun2(k6);
        distr(1,1)=k2;
end
d=pi*(distl(1,1)+distr(1,1))/2;

end