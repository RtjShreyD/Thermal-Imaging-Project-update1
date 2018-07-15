function P=pointadjust(p1,p2,C)
avg=zeros(size(p1));
avg(:,1)=(abs(p1(:,1)-C(1,1))+abs(p2(:,1)-C(1,1)))/2;
avg(:,2)=(abs(p1(:,2)-C(1,2))+abs(p2(:,2)-C(1,2)))/2;
[r,c]=size(p1);
p_1=zeros(r,c);
p_2=zeros(r,c);
for i=1:size(p1,1)
    if(p1(i,2)<C(1,2))
        p_2(i,2)=C(1,2)-avg(i,2);
        p_1(i,2)=C(1,2)-avg(i,2);
    else
        p_2(i,2)=C(1,2)+avg(i,2);
        p_1(i,2)=C(1,2)+avg(i,2);
    end
end
p_1(:,1)=C(1,1)-avg(:,1);
p_2(:,1)=C(1,1)+avg(:,1);
r=size(p_1,1);
P=zeros(r,2,2);
P(:,1,:)=p_1(:,:);
P(:,2,:)=p_2(:,:);
end
