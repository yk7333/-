function mission = InitialSolution(plane,target,antibody)
%	��ʼ������
%   ���ݸ����Ŀ��壬������Ӧ�ĳ�ʼ�� ����ΪNcά���� ���Ϊmission����
target_num=size(target.num,1);
plane_num=size(plane.num,1);
index=1;
for i=1:target_num
    for j=1:target.num(i)
        task(index)=i;    %task��ÿһλ�ϵ�ֵ��Ӧ��input��ÿһλ�ϵ�������
        index=index+1;
    end
end
In=floor(antibody);            %��������(����ÿ�������зɻ��ı��)
De=antibody-In;                %С������(����ÿ�������зɻ���˳��
mission=zeros(plane_num,max(plane.num));
for i=1:plane_num
    temp=[];
    index=[];
    for j=1:length(In)
        if In(j)==i
            temp=[temp,De(j)];  
            index=[index,j];    
        end
    end
    [~,subscript]=sort(temp);
    for k=1:length(subscript)
        mission(i,k)=task(index(subscript(k)));    %mission���ɻ�����Լ�˳����
    end
end

end

