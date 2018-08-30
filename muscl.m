function measure = muscl(a1, leftloc, rightloc)
[X1,Y1,x1,y1]=mysmooth(a1);
v1 = muscle(a1, leftloc, rightloc);
v2 = measurenbicep(leftloc, rightloc, X1, Y1);

measure = min(v1,v2); %%%CON A
% measure = max(v1,v2); %%%CON B
% measure = (v1+v2)/2;  %%%CON C

end