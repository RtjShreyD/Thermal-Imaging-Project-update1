function neck = neckhandl(filename1,filename2,height,P,ps,t)

dim = 0;
f = 0;
dx  = zeros(1,25); 
% nx = zeros(1,65);
thr1 = 5:30;
thr2 = 31:55;
thr3 = 56:80;
for i=1:25
    try
        dx(i)= realneck2(filename1,filename2,height,thr1(i));
        if dx(i)<0
            dx(i)=abs(dx(i));
        end
        
        if dx(i)<10
            f =f+1;
        end
       
        
        
    catch
        fprintf('Having error in  try section\n for range 5:30');
        try
            dx(i)= realneck2(filename1,filename2,height,thr2(i));
            if dx(i)<0
                dx(i)=abs(dx(i));
            end
        catch
            fprintf('Having error in  try section\n for range 31:55');
            try
                dx(i)= realneck2(filename1,filename2,height,thr3(i));
                if dx(i)<0
                        dx(i)=abs(dx(i));
                end
            catch
                fprintf('Having error in  try section\n for range 31:55');
                if i==25
                    fprintf('Using altered old neck method now\n');          
                    dx(i) = t*measureneck(P,ps);
                end
            end
        end
              
    end             
    
        dim = i; 
end
   %disp(dx);
   mat2 = zeros(1,dim);
   mat2 = ridofzero(dx);
   disp(mat2);
   mat2 = valbw(mat2);
   %disp(mat2);
   neck = mean(mat2);
   disp(neck);        
end