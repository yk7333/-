clear;clc;
%% ��ȡ����
X=xlsread('UAV.xlsx');
plane=struct('pos',0,'p',0,'num',0,'v',0);
plane.pos=X(:,1:2);     %�ɻ�����ʼλ��
plane.p=X(:,3);         %�ɻ��Ĵ���ɹ���
plane.num=X(:,4);       %�ɻ������������
plane.v=X(:,5);         %�ɻ��ķ�������

X=xlsread('Target.xlsx');
target=struct('pos',0,'val',0,'win',0,'t',0,'num',0);
target.pos=X(:,1:2);    %������λ��
target.val=X(:,3);      %����ļ�ֵ
target.win=X(:,4:5);    %�����ʱ�䴰��
target.t=X(:,6);        %�������ʱ
target.num=X(:,7);      %��Ҫ���˻�������

%% �����趨
maxgen=100;     %����������
sizepop=100;    %��Ⱥ��ģ
sizemem=20;     %���������
Bias=200;       %ƫ�������Ӧ�Ⱥ���Ϊ��
%��ʼ������
antibody_len=sum(target.num(:));
antibody=zeros(sizepop,antibody_len);

for i=1:sizepop
    antibody(i,:)=rand(1,antibody_len)*size(plane.num,1)+1;
end
affinity=zeros(1,sizepop);   
%ע��:�˴�Ӧ��Ϊ�׺Ͷ�,������Ӧ�� �����㷨����Ӧ�Ȼ�Ҫ���ǿ���Ũ��

for i=1:sizepop
    [cost,~]=Cost_Road(plane,target,antibody(i,:));
    affinity(i)=1/(cost+Bias);
end
best_aff=max(affinity);

for gen=1:maxgen
    disp(['��������:',num2str(gen)]);  
    if gen<=1
        a = 1;
    end
    if gen>1
        a = exp((best_aff-Affinity_old(best_aff_gen,gen))/Affinity_old(best_aff_gen,gen));
    end
    b=3-2*gen/maxgen;
    c=10;
    memory=bestselect(antibody,affinity,sizemem);                %����ѵĸ��屣���ڼ������
    antibody_select=select(antibody,affinity,sizepop-sizemem);           %����Ⱥ���з���ѡ��
    antibody_exchange=exchange(antibody_select);                %�ڲ�����
    for i=1:sizepop-sizemem
        [cost_sel,~]=Cost_Road(plane,target,antibody_select(i,:));
        [cost_exc,~]=Cost_Road(plane,target,antibody_exchange(i,:));
        if cost_exc>cost_sel && rand>exp(-a*b*(cost_exc-cost_sel)/cost_sel)  %ģ���˻�(exp��ֵ����ֵԽСԽ�����½�)
            antibody_exchange(i,:)=antibody_select(i,:);
        end
        [cost_exc,mission]=Cost_Road(plane,target,antibody_exchange(i,:));
        affinity(i)=1./(cost_exc+Bias);
        if affinity(i)>best_aff
            best_mission=mission;
            best_aff=affinity(i);
        end
    end
    antibody_cross=cross(antibody_exchange,best_aff,affinity,plane);       %�������
    for i=1:sizepop-sizemem
        [cost_exc,~]=Cost_Road(plane,target,antibody_exchange(i,:));
        [cost_cro,~]=Cost_Road(plane,target,antibody_cross(i,:));
        if cost_cro>cost_exc && rand>exp(-a*b*(cost_cro-cost_exc)/cost_exc)  %ģ���˻�(exp��ֵ����ֵԽСԽ�����½�)
            antibody_cross(i,:)=antibody_exchange(i,:);
        end
        [cost_cro,mission]=Cost_Road(plane,target,antibody_cross(i,:));
        affinity(i)=1./(cost_cro+Bias);
        if affinity(i)>best_aff
            best_mission=mission;
            best_aff=affinity(i);
        end
    end
    antibody_reverse=reverse(antibody_cross);                 %��ת����
    for i=1:sizepop-sizemem
        [cost_cro,~]=Cost_Road(plane,target,antibody_cross(i,:));
        [cost_rev,~]=Cost_Road(plane,target,antibody_reverse(i,:));
        if cost_rev>cost_cro && rand>exp(-a*b*(cost_rev-cost_cro)/cost_cro)  %ģ���˻�
            antibody_reverse(i,:)=antibody_cross(i,:);
        end
        [cost_rev,mission]=Cost_Road(plane,target,antibody_reverse(i,:));
        affinity(i)=1./(cost_rev+Bias);
        if affinity(i)>best_aff
            best_mission=mission;
            best_aff=affinity(i);
        end
    end
    
    antibody_mutate=mutate(antibody_reverse,plane);                   %�������
    for i=1:sizepop-sizemem
        [cost_rev,~]=Cost_Road(plane,target,antibody_reverse(i,:));
        [cost_mut,~]=Cost_Road(plane,target,antibody_mutate(i,:));
        if cost_mut>cost_rev && rand>exp(-a*b*(cost_mut-cost_rev)/cost_rev)  %ģ���˻�
            antibody_mutate(i,:)=antibody_reverse(i,:);
        end
        [cost_mut,mission]=Cost_Road(plane,target,antibody_mutate(i,:));
        affinity(i)=1./(cost_mut+Bias);
        if affinity(i)>best_aff                                  %��Ѱ��ѵĸ���
            best_mission=mission;
            best_aff=affinity(i);
        end
    end
    antibody=[antibody_mutate;memory];
    for i=1:sizepop
        [cost,mission]=Cost_Road(plane,target,antibody(i,:));
        affinity(i)=1/(cost+Bias);
        if affinity(i)>best_aff
            best_mission=mission;
            best_aff=affinity(i);
        end
    end

    result(gen)=1./best_aff-Bias;    %Cost�����Biasƫ�� Ϊ�˴������Ϊ����� �˴������ȥ
    best_aff_gen(gen)=best_aff;
    res=1./best_aff-Bias
end
plot(result,'-r','LineWidth',2)
xlabel("��������")
ylabel("���ۺ���ֵ")

disp('����������');
disp(best_mission);
disp(['��С����:',num2str(Cost_Road(plane,target,best_mission)+CostBias(plane,target,best_mission)-Reward(plane,target,best_mission))])
