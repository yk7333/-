function mission = Get_mission(plane,target,antibody)
% ������������������������
init_mission=InitialSolution(plane,target,antibody);
mission=ModifiedSolution(plane,init_mission);
mission=Unlock(mission);
end