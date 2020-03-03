load('/Users/root1/Desktop/FOSSACS/fossacs_data/traj_dmpc_pa_100.mat')

for l = 1:100
    coll = 0;
    for k = 1:1000
        for i = 1:15
            es(k,i) = sqrt((traj(l).x(k,i)-traj(l).x(k,16))^2 + (traj(l).y(k,i)-traj(l).y(k,16))^2);
        end
    end
    if any(es(:)<1 & es(:)>0) == 1
        coll = coll + 1;                      
    end
    if coll > 0
        pc(l,1) = 1;
    else
        pc(l,1) = 0;
    end
    clearvars es
end