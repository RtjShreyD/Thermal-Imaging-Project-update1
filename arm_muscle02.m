function  value = arm_muscle02(filename1,filename2, height)
    %[t1,~]=pixeltobody(filename1,filename2,height);
    val = zeros(1,12);
    %thr = 1:12;
    for j=1:1:12
        try
            m1 = arm_muscle0(filename1,filename2, height,j);
            val(j) = m1;
            %disp(val(n));
        catch
            try
                fprintf('error in muscles2 fn, now using the old method\n');
                val(j) = Oldbicep(filename1,filename2, height,j);
                disp(val(j));
                fprintf('loop is at %d \n',j);
                %disp(val(n));
            catch
                fprintf('error for this value %d of thresholding in new_right/left points\n',j);
                fprintf('moving to next value\n');
                val(j)=0;
            end  
         end    
    end
    %disp(val);
    try    
        val1 = ridofzero(val);
        val2 = valbw_bicep(val1);
        value = rounds(mean(val2));
    catch
        fprintf('No chance to rescue from thresholding in range to calc muscle \n');
        fprintf('Now using thresh 7 to calc muscle using old method \n');
        value = Oldbicep(filename1,filename2, height,7);  
    end    

end
