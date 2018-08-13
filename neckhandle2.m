function neck = neckhandle2(filename1,filename2,height,P,ps,t)
fprintf('Now in neckhandle2');
f = 0;
dim = 0;
dx  = zeros(1,65);
thr = 5:70;
for i=1:65
    try
        dx(i)= realneck(filename1,filename2,height,thr(i));
        if dx(i)<0
            dx(i)=abs(dx(i));
        end
        if dx(i)<12
            f = f+1;
        end
        if f>=63
           dx(i) = t*measureneck(P,ps);
        end   
                        
    catch
        %fprintf('Having error in  try section\n');
        if i==65
            fprintf('Using altered old neck method now\n');          
            dx(i) = t*measureneck(P,ps);
                        
        end             
    end
    
        dim = i;
end 
   %disp(dx);
   mat2 = zeros(1,dim);
   mat2 = ridofzero(dx);
   %disp(mat2);       
   mat2 = valbw(mat2);
   %disp(mat2);
   neck = mean(mat2);
   %disp(neck);
       
end