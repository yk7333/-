function ret=test(pick)
    flag=1;
    global x_range;
    for i=1:length(pick)
        if (pick(i)<x_range(i,1))||(pick(i)>x_range(i,2))
           flag=0; %���ڷ�Χ���򲻿���
        end
    end
    ret=flag;
end

