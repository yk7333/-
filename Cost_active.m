function [cost,mission] = Cost_active(plane,target,antibody)
% ����һ���������Ӧ��
init_mission=InitialSolution(plane,target,antibody);
mission=ModifiedSolution(plane,init_mission);
mission=Unlock(mission);
cost = CostRoad(plane,target,mission)+CostBias(plane,target,mission)-Reward(plane,target,mission);
end

