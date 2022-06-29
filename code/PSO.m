clear;clc;
%% ��ȡ����
X=xlsread('UAV.xlsx');
plane=struct('pos',0,'p',0,'max',0,'v',0);
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
%% ����Ⱥ�㷨
maxgen=800;      %����������
par_num=100;    %���ӵ���Ŀ
Bias=100;       %ƫ�������Ӧ�Ⱥ���Ϊ��
c1=2;
c2=2;
w_max=0.5;
w_min=0;
v_max=size(plane.num,1);
v_min=-v_max;
pos_max=size(plane.num,1)+1;
pos_min=1;

for i=1:par_num
    par_len=sum(target.num(:));                  %Ҫ���������ӳ���
    par_max=size(plane.num,1);              
    par_pos(i,:)=rand(1,par_len)*par_max+1;      %par_pos��¼����λ��
    par_v(i,:)=rand(1,par_len)*2*par_max-par_max;        %par_v��¼�����ٶ�
    [cost,~]=Cost(plane,target,par_pos(i,:));
    affinity(i)=1/(cost+Bias);
end
par_i=par_pos;                          %par_i��¼�������ӵ���ʷ���
best_fit_i=affinity;
[best_fit_g,best_index]=max(affinity);     
par_g=par_pos(best_index,:);            %par_g��¼Ⱥ�����ӵ���ʷ���
best_fit_gen=zeros(1,maxgen);             %best_fit_gen��¼gen������������Ӧ��

for gen=1:maxgen
    disp(['��������:',num2str(gen)]);
    if gen==1
        affinity_old=best_fit_g;
    end
    if gen>1
        affinity_old=Affinity_old(best_fit_gen,gen);
    end
    w=w_max-gen/maxgen*(w_max-w_min)+0.5*exp((best_fit_g-affinity_old)/best_fit_g);
    for i=1:par_num
            par_v(i,:)=w.*par_v(i,:)+c1*rand.*(par_i(i,:)-par_pos(i,:))+c2*rand.*(par_g-par_pos(i,:));
            par_v(i,find(par_v(i,:)>v_max))=v_max;
            par_v(i,find(par_v(i,:)<v_min))=v_min;
            par_pos(i,:)=par_pos(i,:)+par_v(i,:);
            ok=Test(plane,par_pos(i,:));
            while ok==0
                par_v(i,:)=w.*par_v(i,:)+c1*rand.*(par_i(i,:)-par_pos(i,:))+c2*rand.*(par_g-par_pos(i,:));
                par_v(i,find(par_v(i,:)>v_max))=v_max;
                par_v(i,find(par_v(i,:)<v_min))=v_min;
                par_pos(i,:)=par_pos(i,:)+par_v(i,:);
                ok=Test(plane,par_pos(i,:));
            end
            [cost,mission]=Cost(plane,target,par_pos(i,:));
            affinity(i)=1/(cost+Bias);
            if affinity(i)>best_fit_i(i)
                par_i(i,:)=par_pos(i,:);
                best_fit_i(i)=affinity(i);
                if affinity(i)>best_fit_g
                    par_g=par_pos(i,:);
                    best_fit_g=affinity(i);
                    best_mission=mission;
                end
            end
    end
    best_fit_gen(gen)=best_fit_g;
    res=1./best_fit_g-Bias
end
plot(1./best_fit_gen-Bias)
xlabel("��������")
ylabel("��Ӧ��ֵ")

disp('����������');
disp(best_mission);
disp(['��С����:',num2str(CostRoad(plane,target,best_mission)+CostBias(plane,target,best_mission)-Reward(plane,target,best_mission))])
