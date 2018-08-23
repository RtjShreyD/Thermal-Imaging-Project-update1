function h=measurehip2(p1,p2)
try
    j=sqrt((p1(8,1,1)-p1(8,2,1)).^2+(p1(8,1,2)-p1(8,2,2)).^2);
    k=sqrt((p2(8,1,1)-p2(8,2,1)).^2+(p2(8,1,2)-p2(8,2,2)).^2);
    l=pi*(j+k)/2;
    %disp(l);
    a=sqrt((p1(5,1,1)-p1(5,2,1)).^2+(p1(5,1,2)-p1(5,2,2)).^2);
    b=sqrt((p2(5,1,1)-p2(5,2,1)).^2+(p2(5,1,2)-p2(5,2,2)).^2);
    d=pi*(a+b)/2;
%     disp(d);
%     h=max(l,d);   %%CON.A
%     h = (l+d)/2;   %%CON.B
%     disp(h);
    minn=min(l,d); 
    maxx=max(l,d);
    diff=maxx-minn;
    h=maxx+diff;      %%CON.C
    %avg=(maxx+minn)/2;
    %diff=maxx-avg;
    %h=maxx+diff;        %%CON.D
    
    
catch
    fprintf('Calculating simply with newhip front()\n');
    a=sqrt((p1(5,1,1)-p1(5,2,1)).^2+(p1(5,1,2)-p1(5,2,2)).^2);
    b=sqrt((p2(5,1,1)-p2(5,2,1)).^2+(p2(5,1,2)-p2(5,2,2)).^2);
    h=pi*(a+b)/2;
    %disp(h);
end
