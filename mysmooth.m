function [X,Y,x,y]=mysmooth(A)
% take boundaries
bound=bwboundaries(A);

k=size(bound,1);
% what im doing is to select the blob with the highest circumference
check=zeros(k,1);
for i=1:k
    check(i)=size(bound{i,1},1);
end
[~,indexofmax]=maxfun2(check);
B=bound{indexofmax,1};

new=B;

% seperate X and Y
x=new(:,2);
y=new(:,1);
windowWidth = 61;
polynomialOrder = 3;
% smooth them using sowitscky golay filter
X = sgolayfilt(x, polynomialOrder, windowWidth);
Y = sgolayfilt(y, polynomialOrder, windowWidth);
end