function ret = bestselect(antibody,fitness,sizemem)
%BESTSELECT �������ŵĸ��嵽�������
    [~,index]=sort(fitness,'descend');      %����ѡ����ѵ�sizemem������
    ret=zeros(sizemem,size(antibody,2));      
    for i=1:sizemem
        ret(i,:)=antibody(index(i),:);     %����ѵĿ������
    end
end

