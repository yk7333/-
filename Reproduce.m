function ret= Reproduce(individuals,index,list,iter)
%REPRODUCE  ��ֳ����
%   ����Ⱥ���з��ܣ�ѡ�����һ����Ⱥ
%    [copy_chance,mutate_chance,cross_chance]=list;
    num=Choose(list);
    if num==1   %����
       ret=[individuals.chrom(index(1),:);individuals.chrom(index(2),:)]; 
    end
    if num==2   %����
       ret1=Mutate(individuals,index(1),iter);
       ret2=Mutate(individuals,index(2),iter);
       ret=[ret1;ret2];
    end
    
    if num==3   %����
       ret=Cross(individuals,index);
    end
end

