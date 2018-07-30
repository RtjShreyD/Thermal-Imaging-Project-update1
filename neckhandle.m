function neck = neckhandle(filename1,filename2,height,P,ps,t)
dim = 0;
dx  = zeros(1,45);
thr = 5:50;
for i=1:45
    try
        dx(i)= realneck(filename1,filename2,height,thr(i));
        if dx(i)<0
            dx(i)=abs(dx(i));
    
        end
        disp(dx(i));
    catch
        fprintf('Having error in  try section\n');
        if i==45
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
   neck = mean(mat2);
   disp(neck);
   
   
    
    
    
        
     
        
        
        
        
        
        
        
        
        
        
        
        
        
        
end