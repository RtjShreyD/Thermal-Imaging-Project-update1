function  value = arm_muscle2(filename1,filename2, height)
    %[t1,~]=pixeltobody(filename1,filename2,height);
    val = zeros(1,12);
    %thr = 1:12;
    for j=1:1:12
        try
            m1 = arm_muscle(filename1,filename2, height,j);
            val(j) = m1;
            %disp(val(n));
        catch
            fprintf('error in muscles2 fn, now using the old method\n');
            val(j) = Oldbicep(filename1,filename2, height,j);
            disp(val(j));
            fprintf('loop is at %d \n',j);
            %disp(val(n));
        end    
    end
    disp(val);
    val1 = ridofzero(val);
    val2 = valbw_bicep(val1);
    value = rounds(mean(val2));
end