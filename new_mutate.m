function ret = new_mutate(antibody,num)
%	���캯��
    pos=randi(length(antibody));
    antibody(pos)=rand*num+1;   %������һλ���¸�ֵ
    ret = antibody;
end

