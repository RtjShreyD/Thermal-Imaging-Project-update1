%loci=index point location(edge)
function distcro = distcro(loci,cro,X,Y)
distcro=sqrt((X(cro,1)-X(loci,1))^2 + (Y(cro,1)-Y(loci,1))^2);
end