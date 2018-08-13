function neck = neckhandle4(filename1,filename2,height)
fprintf('Inside neckhandle4\n');
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
        
    catch
        fprintf('Error occured in realneck2 at %f\n',i);            
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
   fprintf('no values in range.......Current limit of programs error handling reached\n'); 
end    