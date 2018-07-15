%loci=index point location(edge)
function distcent = distcent(loci,c,X,Y)
distcent=sqrt((c(1,1)-X(loci,1))^2 + (c(1,2)-Y(loci,1))^2);
end