axis([0,62,0,5.5]);%x�� y��ķ�Χ
set(gca,'xtick',0:2:62) ;%x�����������
set(gca,'ytick',0:1:5.5) ;%y�����������
xlabel('ʱ��'),ylabel('���˻����');%x�� y�������
title('���˻�Эͬ������������');%ͼ�εı���
n_bay_nb=5;%���˻���Ŀ
n_task_nb = 27;%������Ŀ
%x�� ��Ӧ�ڻ�ͼλ�õ���ʼ����x
n_start_time= [5.38 14.15 18.48 26.19 33.21 18.48 26.19 33.21 38.97 46.77 53.03 59.56 1.8 7.76 15.51 19.51 22.19 8.7 12.4 17.25 19.66 5 8.7 17.25 19.66 22.77 46.77];%ÿ������Ŀ�ʼʱ��
%length ��Ӧ��ÿ��ͼ����x�᷽��ĳ���
n_duration_time =[1 1 2 2 2 2 2 2 2 2 1 1 1 2 2 1 1 2 2 1 1 1 2 1 1 2 2];%duration time of every task  //ÿ������ĳ���ʱ��
%y�� ��Ӧ�ڻ�ͼλ�õ���ʼ����y
n_bay_start=[1 1 1 1 1 2 2 2 2 2 2 2 3 3 3 3 3 4 4 4 4 5 5 5 5 5 5]-1; %bay id of every task  ==������Ŀ��������һ�л���
%����ţ����Ը��ݹ����ѡ��ʹ����һ����ɫ
n_job_id=[7 11 12 14 2 12 14 2 10 16 13 17 1 20 18 15 9 8 4 5 19 3 8 5 19 6 16];%
rec=[0,0,0,0];%temp data space for every rectangle  
color_list=[[1,0,0];[0,1,0];[0,0,1];[0.95,0.64,0.37];[1,1,0];[0.1333,0.7451,0.5333];[0.60,0.8,0.2];[0.8,0.36,0.36];[0.74,0.71,0.42];[0.52,0.81,0.98];[0.41,0.35,0.8];[0.4667,0.5333,0.6];[0.98,0.92,0.84];[0.94118,1,0.94118];[0.86,0.86,0.86];[0.5,1,0.83];[0.823,0.411,0.117];[0.63,0.13,0.94];[0.87,0.63,0.87];[0,1,1];[1,0.38,0];[0.4,0.1,0.9];[0,0.9,0.2]];
for i =1:n_task_nb  
  rec(1) = n_start_time(i);%���εĺ�����
  rec(2) = n_bay_start(i)+0.7;  %���ε�������
  rec(3) = n_duration_time(i);  %���ε�x�᷽��ĳ���
  rec(4) = 0.6; 
  txt=sprintf('p(%d,%d)=%d',n_bay_start(i),n_job_id(i),n_duration_time(i));%�������ţ�����ţ��ӹ�ʱ�������ַ���
   rectangle('Position',rec,'LineWidth',0.5,'LineStyle','-','FaceColor',color_list(n_job_id(i),:));%draw every rectangle  
   if n_duration_time(i)==1 && n_job_id(i)>=10
   text(n_start_time(i)+0.12,(n_bay_start(i)+1),num2str(n_job_id(i)),'FontWeight','Bold','FontSize',10);%label the id of every task  ��������������������
   end
   if n_duration_time(i)==1 && n_job_id(i)<10
   text(n_start_time(i)+0.3,(n_bay_start(i)+1),num2str(n_job_id(i)),'FontWeight','Bold','FontSize',10);%label the id of every task  ��������������������
   end
   if n_duration_time(i)==2 && n_job_id(i)>=10
   text(n_start_time(i)+0.6,(n_bay_start(i)+1),num2str(n_job_id(i)),'FontWeight','Bold','FontSize',10);%label the id of every task  ��������������������
   end
   if n_duration_time(i)==2 && n_job_id(i)<10
   text(n_start_time(i)+0.8,(n_bay_start(i)+1),num2str(n_job_id(i)),'FontWeight','Bold','FontSize',10);%label the id of every task  ��������������������
   end
end
