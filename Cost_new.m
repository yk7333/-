function [cost_road,cost_bias,cost_reward] = Cost_new(plane,target,mission)
% ����һ���������Ӧ��
cost_road=CostRoad(plane,target,mission);
cost_bias=CostBias(plane,target,mission);
cost_reward=-Reward(plane,target,mission);

end

