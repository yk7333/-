function ret = mutate(antibody,plane)
%	���캯��
    [anti_num,anti_len]=size(antibody);
    for i=1:anti_num
        pos=randi(anti_len);
        antibody(i,pos)=rand*size(plane.num,1)+1;   %������һλ���¸�ֵ
    end
    ret = antibody;
end

