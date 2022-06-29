function ret = CostBias(plane,target,mission)
%	ʱ��ƫ�����
%   ����δ���ո���ʱ������������Ĵ���
[num,len]=size(mission);
max_iter=30;
A=zeros(size(mission));   %A������¼ÿ�����˻�����ص��ʱ��
E=zeros(max(mission(:)));
for i=1:num
    if mission(i,1)==0
        continue;
    end
    A(i,1)=norm(plane.pos(i,:)-target.pos(mission(i,1),:))/plane.v(i);  %��һ�������ʱ��
    E(mission(i,1))=A(i,1);
end

fresh=ones(size(mission));
for iter=1:max_iter            %���������´�������ֹ��������һֱѭ����
    last_A=A;
    for i=1:num
        for j=2:len
            if mission(i,j)>0
                if fresh(i,j)==1
                    A(i,j)=A(i,j-1)+target.t(mission(i,j-1))+norm(target.pos(mission(i,j),:)-target.pos(mission(i,j-1),:))/plane.v(i); %��n���������ʼʱ����ǰһ����������ʱ�����·��ʱ�����
                end
                if A(i,j)>E(mission(i,j))
                    E(mission(i,j))=A(i,j); %��¼��󵽴���������˻�ʱ��
                end
            end
        end
    end
    fresh=zeros(size(mission));
    for i=1:num
        for j=1:len
            if mission(i,j)>0 && A(i,j)~=E(mission(i,j)) %Эͬ����ʱ��Ҫ�������һ�����˻��ĵ���ʱ����Ϊ����ʼʱ��
                    A(i,j)=E(mission(i,j));
                    for k=j+1:len
                        fresh(i,k)=1;
                    end
            end
        end
    end
    
    if A==last_A  %����ϴκ���һ�ε�����ʱ��û�з������£�˵���������
        break;
    end
    
end

S=target.win(:,1);  %ÿ���������ʼʱ��
C=target.win(:,2);  %ÿ������Ľ���ʱ��
TD=0;   %ƫ��ʱ��Ĵ���
b1=1;
b2=1;
for i=1:num
    for j=1:len
        if mission(i,j)>0
            TD=TD+b1*max(0,S(mission(i,j))-A(i,j))+b2*max(0,A(i,j)-C(mission(i,j)));
        end
    end
end
ret=TD;    
end

