%Inputs:centrl(index of the point on the boundary of the image, which has same value of Y as that of centroid and is right to it.)
%,crorl(index of the point on the boundary of the image, which has same
%value of Y as that of crotch and is right to it,
%X(the x values' matrix of the image's boundary),Y(y
%values' matrix of the image's boundary)
%Output:rh(the index location of the right trouser waist point)
% ALGORITHM:
% Step 1:In between the centrl,crorl find the slopes of each point on the
% boundary.
% Step 2:Now find  the peaks ,locations of the peaks of slopes.
% Step 3:Now the index of location of mid point gives us the index location
% of the right trouser waist point.
function rh=rh2(centrl,crorl,X,Y)
a=min(centrl,crorl);
b=max(centrl,crorl);
A1=zeros(size(X));

for i=1:size(X,1)-1
    if i<=b && i>=a
        A1(i)=(Y(i+1)-Y(i))/(X(i+1)-X(i));
    end
end

[~,loc]=findpeaks(A1);
rh=loc(round(size(loc,1)/2));
end