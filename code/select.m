function ret = select(antibody,affinity,number)
%SELECT ���̶�ѡ���ܵĺ�� ����number���������
    chance=fitness(antibody,affinity);
    for num=1:number
        thresh=rand;
        for i=1:length(chance)
            if sum(chance(1:i))>=thresh
               ret(num,:)=antibody(i,:);
                break;
            end
        end
    end
     
end

