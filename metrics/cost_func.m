load('/Users/root1/Desktop/FOSSACS/fossacs_data/traj_cmpc_bf_200.mat')

for k = 1:200
    px = traj(k).x(1000,1:15);
    py = traj(k).y(1000,1:15);

    % for centralized cost function
    for i = 1:15
        for j = i+1:15
            es1(i,j) = ((px(1,i)-px(1,j))^2 + (py(1,i)-py(1,j))^2);
        end
    end
    
    for i = 1:14
        es1(i,16) = sum(es1(i,:));
    end
    
    % for distributed cost function
    for i = 1:15
        for j = 1:15
            es2(i,j) = ((px(1,i)-px(1,j))^2 + (py(1,i)-py(1,j))^2);
        end
    end
    for i = 1:15
        sorted(i,:) = sort(es2(i,1:15));
    end
    for i = 1:15
        sorted(i,16) = sum(sorted(i,1:5));
    end

    cohes_cen(k,1) = sum(es1(:,16));
    cohes_dist(k,1) = sum(sorted(:,16));
    
    invsort = 1./sorted(:,1:15);
    for i = 1:15
        invsort(i,16) = sum(invsort(i,2:15));
    end
    sep(k,1) = sum(invsort(2:15,16));
    
    clearvars px py es1 es2 sorted
    
end

for i = 1:200
    cost_cen(i,1) = (4/(15*14))*(cohes_cen(i,1) + 1500*(1/sep(i,1)));
    cost_dist(i,1) = (1/15)*cohes_dist(i,1) + 1500*(1/sep(i,1));
end

mean_cost_cen = mean(cost_cen);
mean_cost_dist = mean(cost_dist);