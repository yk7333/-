function ret = CostRoad(plane,target,mission)
%   ���̴���
%   �������˻�����ʼ�㿪ʼ����������������ٷ��ص�·������
[num,len]=size(mission);
dis=0;           %����ÿ�����˻����еľ���
last=ones(1,num)*len;       %last����ÿ�����˻���������
for i=1:num
    for j=1:len
        if mission(i,j)==0
            last(i)=j-1;    %����������Ϊ0��˵����ʱ�Ѿ�������������Ϊj-1
            break;
        end
    end
end


for i=1:num
    if last(i)==0
        continue;
    end
    dis=dis + norm(plane.pos(i,:)-target.pos(mission(i,1),:))+norm(plane.pos(i,:)-target.pos(mission(i,last(i)),:));
    for j=2:len
        if mission(i,j)>0
            dis=dis+norm(target.pos(mission(i,j-1),:)-target.pos(mission(i,j),:)); 
            
        end
    end
end
ret = dis;

end


