function neck = neckhandle(filename1,filename2,height,P,ps,t)
f = 0;
dim = 0;
dx  = zeros(1,65);
thr = 5:70;  %manually checked for all using realmeasureneck() so thresholding variable was between 5 to 70 for those 30 people
for i=1:65
    try
        dx(i)= realneck2(filename1,filename2,height,thr(i));  %realneck2 is same as realmeasureneck() with aminor change
        if dx(i)<0
            dx(i)=abs(dx(i));
        end
        if dx(i)<12 %12 is considered a general minimum neck measurement for all
            f = f+1; %used as a flag variable for those images for whom the realneck() does not give values larger than 12
        end
        if f>=63
           dx(i) = t*measureneck(P,ps); 
        end   
                        
    catch
        fprintf('Having error in  try section\n');
        if i==65 %if realneck() does not work for all values of thresholding
            fprintf('Using altered old neck method now\n');          
            dx(i) = t*measureneck(P,ps);
            
        end             
    end
    
        dim = i;
end 
   %disp(dx);
   mat2 = zeros(1,dim);
   mat2 = ridofzero(dx); %function to get rid of all the zero elements of array
   %disp(mat2);
   mat2 = valbw(mat2); %function to only consider values between 12 and 18 where 18 is considered as a general maximum neck measurement for all
   %disp(mat2);
   neck = mean(mat2); %calculating the mean of all neck values calculated in range from 2 to 18
   disp(neck);
   
   
    
    
    
        
     
        
        
        
        
        
        
        
        
        
        
        
        
        
        
end
