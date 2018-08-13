function neck = neckhandle3(filename1,filename2,height,P,ps,t,ps0)
f = 0;
dim = 0;
dx  = zeros(1,65);
thr = 5:70;
for i=1:65
    try
        dx(i)= realneck2(filename1,filename2,height,thr(i));
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
        fprintf('Having error in  try section of neckhandle3 at %f\n',i);
        if i==65
            fprintf('Using altered old neck method now......\n');
            fprintf('The next val obtained could be either the only val for the last time loop run or the last val preceding some number of 0 vals\n');
            dx(i) = t*measureneck(P,ps);
                        
        end             
    end
    
        dim = i;
end
try
   mat2 = zeros(1,dim);
   mat2 = ridofzero(dx);
   %disp(mat2);       
   mat2 = valbw(mat2);
   %disp(mat2);
   neck = mean(mat2);
   %disp(neck);
catch
   fprintf('no values in range trying to get other way\n'); 
   neck = neckhandle2(filename1,filename2,height,P,ps0,t); %ps0 has been calculated using newsideneck0(). newsideneck0() is same as newsideneck() the only difference being that newsideneck() has been modified and correction variable is applied in it while newsideneck0 is the original.
   
end    
