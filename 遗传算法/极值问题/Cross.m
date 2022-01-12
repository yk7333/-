function ret = Cross(individuals,index)
%CROSS ���溯��
flag1=0;
flag2=0;
    while (flag1&&flag2)~=1
        weight=rand;
        ret1=individuals.chrom(index(1),:).*(1-weight)+individuals.chrom(index(2),:).*weight;
        ret2=individuals.chrom(index(2),:).*(1-weight)+individuals.chrom(index(1),:).*weight;
        flag1=test(ret1);
        flag2=test(ret2);
    end
    ret=[ret1;ret2];
end

