function ret = Affinity_old(best_fit_gen,gen)
%  ���ǰ��ʮ����Ӧ��ƽ��ֵ
    if gen<=50
        ret=mean(best_fit_gen(1:gen-1));
    end
    if gen>50
        ret=mean(best_fit_gen(gen-50:gen-1));
    end
end

