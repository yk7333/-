function [cost,mission] = Cost_Road(plane,target,antibody)
% ����һ���������Ӧ��
init_mission=InitialSolution(plane,target,antibody);
mission=ModifiedSolution(plane,init_mission);
mission=Unlock(mission);
cost = CostRoad(plane,target,mission);
end

