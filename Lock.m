function ret = Lock(mission)
%   ���ݷ�������� ���������·�ߵĴ��� ���ش�������
    array=Graph(mission);   %������Ӿ���array
    lock_arr=DFS(array,1,zeros(1,size(array,1)+1));   %��ȡ������·
    new_arr=zeros(size(lock_arr));  %new_arr�����������Ƕ�·��
    first=1;
    first_each=1;
    for each=1:max(mission(:))
        lock_arr=DFS(array,each,zeros(1,size(array,1)+1));   %��ȡ������·
        [num,len]=size(lock_arr);
        if sum(lock_arr)==0
            continue;
        end
        for i=1:num
            Start=0;
            End=len;
            for j=1:len
                if sum(lock_arr(i,:)==lock_arr(i,j))~=1 && lock_arr(i,j)~=0   %�ҵ�������λ��
                    if Start~=0
                        End = j;
                    end
                    if Start == 0
                        Start = j;
                    end
                end
            end
            
            
            if first==1 || first_each==each
                first=0;
                first_each=each;
                for j=1:End-Start
                    new_arr(i,j)=lock_arr(i,j+Start-1);         %��һ�ε�����������ֱ�ӷ���array��
                end
                
                continue;
            end
            
            arr_len=size(new_arr,1);                            %���ǵ�һ�ε����������ݷ�����һ��array���·�
            for j=1:End-Start
                new_arr(arr_len+1,j)=lock_arr(i,j+Start-1);
            end
        end
        
    end
    
    [new_num,~]=size(new_arr);
    loop=0;                 %loop���治�ظ��Ļ�·
    add=1;
    for i=1:new_num
        if loop==0
            loop=new_arr(1,:);
            continue;
        end
        u=unique(new_arr(i,:));
        for j=1:size(loop,1)
            if size(u)==size(unique(new_arr(j,:)))
                if  u==unique(new_arr(j,:))
                    add=0;
                end
            end
        end
        if add==1
            loop=[loop;new_arr(i,:)];
        end
    end
    
    ret=zeros(max(mission(:)),max(mission(:)));        %��¼���ֻ�·ʱ��ÿ���߳��ֵĴ���
    for i=1:size(loop,1)
        last=size(loop,2);
        for j=1:size(loop,2)
            if loop(i,j)>0 && loop(i,j+1)>0
                ret(loop(i,j),loop(i,j+1))=ret(loop(i,j),loop(i,j+1))+1;
            end
            if loop(i,j)==0
                last=j-1;
                break;
            end
        end
        if sum(ret)~=0
            ret(loop(i,last),loop(i,1))=ret(loop(i,last),loop(i,1))+1;
        end
    end
end