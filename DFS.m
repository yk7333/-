function lock_arr = DFS(array,road,lock_arr)
%   ��������㷨 
num=road(length(road));
len=size(array,2);

for i=1:len
    if array(num,i)~=0  
        if sum(road==array(num,i))~=0       %���·�����Ѿ��д�·��,��˵����������
            new_road=[road,array(num,i)];
            if lock_arr~=zeros(1,len+2)
                lock_len=size(lock_arr,1);
                for j=1:length(new_road)
                    lock_arr(lock_len+1,j)=new_road(j);
                end
                break;
            end
            if lock_arr==zeros(1,len+2)     %�ж��Ƿ��ǵ�һ��ע������
                for j=1:length(new_road)
                    lock_arr(1,j)=new_road(j);
                end
            end
            
        end
        if sum(road==array(num,i))==0       %�����·�����Ҳ��ظ���������������
           new_road=[road,array(num,i)];
           lock_arr= DFS(array,new_road,lock_arr);
        end
        
    end
    
end

end

