function ret = Test(plane,antibody)
%   ���н��ж�
%   �������룬�ж��Ƿ���� ������з���1 ���򷵻�0
%% ���Ա����Ƿ���1��ɻ�����Ŀ+1֮��
max_num=size(plane.num,1)+1;    %�ɻ�����Ŀ+1
ret=1;
for i=1:length(antibody)
    if antibody(i)<1 || antibody(i)>max_num   %ֻҪ����һ�������㣬�򷵻�0
        ret=0;
        break;
    end
end
end

