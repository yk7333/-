function ret = reverse(antibody)
%REVERSE ��ת����
    [anti_num,anti_len]=size(antibody);
    for i=1:anti_num
        pos1=randi(anti_len);
        pos2=randi(anti_len);
        if pos1>pos2
            temp=pos1;
            pos1=pos2;
            pos2=temp;
        end
        while pos2==pos1
            pos2=randi(anti_len);
        end
        antibody(i,pos1:pos2)=antibody(i,pos2:-1:pos1);   %��ת����
    end
    ret = antibody;
end

