clear
clc
%% ��ʼ��
max_iter=100;%����������
sizepop=300;%��Ⱥ����
x_num=5;%δ֪����
x_range=[0 pi;0 pi;0 pi;0 pi;0 pi];%����ȡֵ��Χ

best_chrom=[];
individuals=struct('fitness',zeros(1,sizepop),'chrom',zeros(sizepop,x_num));

for i=1:sizepop
    individuals.chrom(i,:)=Initial(x_range,x_num);          %���ɳ�ʼ��Ⱥ
    individuals.fitness(1,i)=1./fun(individuals.chrom(i,:));
end
[best_fitness,best_index]=max(individuals.fitness);     %�洢�����Ӧ����Ⱥ
best_chrom=[best_chrom;individuals.chrom(best_index,:)];

%% ������ֳ����
copy_chance=0.7;    %���Ƹ���
mutate_chance=0.1;  %�������
cross_chance=0.2;   %�������

for iter=1:max_iter 
    sumfit=sum(individuals.fitness);        
    norm_fit=individuals.fitness./sumfit;   %��Ӧ�ȹ�һ��
    new_chrom=[];
    for i=1:(sizepop/2)
        index1=Choose(norm_fit);                %ѡ������������������������
        index2=Choose(norm_fit);
        new_chrom=[new_chrom;Reproduce(individuals,[index1,index2],[copy_chance,mutate_chance,cross_chance],iter)];%��ֳ����
    end
    for j=1:sizepop
        individuals.chrom(j,:)=new_chrom(j,:);
        individuals.fitness(1,j)=1./fun(individuals.chrom(j,:));
    end
    [best_fitness,best_index]=max(individuals.fitness);     
    best_chrom=[best_chrom;individuals.chrom(best_index,:)]; %�洢ÿ�ε��������Ӧ����Ⱥ
end
best_fitness=[];
for i=1:max_iter
    best_fitness=[best_fitness;fun(best_chrom(i,:))];
end
plot(1:max_iter,best_fitness,'r');

[min_val,min_index]=min(best_fitness);
min_chrom=best_chrom(min_index,:);
fprintf("    ��Сֵ\t\t\t\t\t x����ѵ�ȡֵ\n");
disp([min_val,min_chrom]);