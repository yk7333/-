function ret = fitness(antibody,fitness)
%CHANCE ���㷱ֳ�ĸ���(׿Խ�ȣ�
    a=0.6;
    fit_sum=sum(fitness);
    concent=concentration(antibody);
    concent_sum=sum(1./concent);        %Ũ��Խ�� ԽҪ����  ��Ũ�ȵ͵Ŀ��己ֳ����
    for i=1:size(antibody,1)
        ret(i) = a*fitness(i)/fit_sum+(1-a)*(1/concent(i)/concent_sum);
    end
    sum_ret=sum(ret);
    for i=1:size(antibody,1)
        ret(i)=ret(i)/sum_ret;
    end
end

