function ret= similar(x,y)
%SIMILAR ���ƶȼ���
%  ���룺�������� ��������ƶ�
   ret= sum(round(x)==round(y))/length(x);
end

