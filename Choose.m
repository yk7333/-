function ret = Choose(list)
%CHOOSE ѡ�����������������
    threshold=rand;
    for i=1:length(list)
       if sum(list(1:i))>threshold
          ret=i; 
          break;
       end
    end
end

