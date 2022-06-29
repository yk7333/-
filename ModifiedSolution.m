function ret = ModifiedSolution(plane,mission)
%   �������н�
%   ������ʼ�Ľ⣬����ת��Ϊ���н�
%plane.num : �������˻�ִ�е�������� target.num: ����������Ҫ�����˻�����
[num,mission_len]=size(mission);

%% ��һ�� ��ÿ�ܷɻ�С�����Ӧ�����������   
while true      %һֱѭ��ֱ����������
    Release=[];     %��Ŵ����������������Ҫ�ų���������˻����
    Receive=[];     %���С����������������Խ�����������˻����
    for i=1:num
        mission_number(i)=mission_len;     %Ĭ�ϳ���Ϊmission_len,����ǰ����0�����
        for j=1:mission_len
            if mission(i,j)==0
                mission_number(i)=j-1;     %ÿһ�е�������
                break;
            end
        end
        if mission_number(i)>plane.num(i)  %���ʵ�����������ڷɻ����������
            Release=[Release,i];
        end
        if mission_number(i)<plane.num(i)  %���ʵ��������С�ڷɻ����������
            Receive=[Receive,i];
        end
    end
    if isempty(Release)
         break;
    end
    
    for i=1:length(Release)
        for j=1:mission_len
            if mission(i,j)==0
                mission_number(i)=j-1;     %ÿһ�е�������
            end
        end
        if mission_number(i)==0             %�����һ����Ϊ0,��0�ŵ�����ȥ
            for p=1:num
                for q=1:mission_len
                    if mission(p,q)==0
                        for r=q:mission_len-1
                            mission(p,r)=mission(p,r+1);
                        end
                    end
                end
            end
            continue;
        end
        delete=unidrnd(mission_number(i));          %���ѡ��ɾ����λ��
        delete_num=mission(Release(i),delete);   %��ɾ��������ֱ���
        for k=delete:mission_len-1
            mission(Release(i),k)=mission(Release(i),k+1);        
        end
        mission(Release(i),mission_len)=0;
            
        for j=1:length(Receive)
            if sum(delete_num==mission(Receive(j),:))==0    %���ɾ��������û�ڿɽ��������г��ֹ�
                for k=1:mission_len
                    if mission(Receive(j),k)==0
                        mission_number(Receive(j))=k-1;     %ÿһ�е�������
                        break;
                    end
                end
                if mission_number(Receive(j))==0    %���һ������û�� ��ֱ��Ϊ��һ������
                    mission(Receive(j),1)=delete_num;
                    break;
                end
                
                insert=unidrnd(mission_number(Receive(j))); %����������������������
                for k=mission_len:-1:insert+1
                    mission(Receive(j),k)=mission(Receive(j),k-1);  %�������ֺ���
                end
                mission(Receive(j),insert)=delete_num;  %��ɾ�������ݲ���
                break;
            end
        end
    end
end
mission=mission(:,1:max(plane.num));
[num,mission_len]=size(mission);

%% �ڶ��� ȥ��ÿ�����˻��е���ͬ������       
for i=1:num
    zero_bias=0;
    while mission_len-length(unique(mission(i,:)))+zero_bias~=0  %������ظ�����������
        unique_mission=unique(mission(i,:));
        for m=1:length(unique_mission)
            if sum(mission(i,:)==unique_mission(m))==1  %sumΪ1��˵���ظ��Ĳ��Ǹ�����   0����û�����������ظ�
                continue;   
            end
            if unique_mission(m)==0     %��0Ϊ�ظ������֣��������
                zero_bias=1-sum(mission(i,:)==0);
                continue;
            end
            first=0;                
            for j=1:mission_len
                if mission(i,j)==unique_mission(m) 
                    if first==0
                         first=1;        %�ж��Ƿ�Ϊ���ֵ�һλ
                         continue;
                    end
                    if first~=0
                        for k=j:mission_len-1
                            mission(i,k)=mission(i,k+1);    %����������ǰ��һ��
                        end
                        mission(i,mission_len)=0;
                        for k=1:num
                            if k~=i && sum(unique_mission(m)==mission(k,:))==0 && mission_number(k)<plane.num(k) %�����k�����˻�û������each ����û���������� ��each�������
                                insert=unidrnd(mission_number(k));
                                if mission_number(k)==0         %���һ������Ҳû�а��� ���������һ��
                                    insert=1;
                                end
                                for l=length(mission(k,:)):-1:insert+1
                                    mission(k,l)=mission(k,l-1);        %���������Ԫ�غ���
                                end
                                mission(k,insert)=unique_mission(m);     %��each����
                                break;
                            end
                        end
                    end       
                end
            end
        end
    end
end
for p=1:num
    for q=1:mission_len
        if mission(p,q)==0
            for r=q:mission_len-1
                mission(p,r)=mission(p,r+1);
            end
        end
    end
end
ret = mission;      
end

