function [cost,mission] = Cost_Bias(plane,target,antibody)
% ����һ���������Ӧ��
init_mission=InitialSolution(plane,target,antibody);
mission=ModifiedSolution(plane,init_mission);
mission=Unlock(mission);
cost = CostBias(plane,target,mission);
end

