function ret = g(iter)
%G ���캯���еı���̶�
    global max_iter;
    ret=0.1*(1-iter/max_iter)^2;
end

