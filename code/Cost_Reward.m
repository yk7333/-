function [cost,mission] = Cost_Reward(plane,target,antibody)
% ����һ���������Ӧ��
init_mission=InitialSolution(plane,target,antibody);
mission=ModifiedSolution(plane,init_mission);
mission=Unlock(mission);
cost = -Reward(plane,target,mission);
end

