load('/Users/root1/Desktop/FOSSACS/fossacs_data/traj_cmpc_bf_200.mat')

n = 1;
coll1 = 0;
coll2 = 0;

for l = 1:200
    m = 1;
    for k = 1:1000
        for i = 1:15
            for j = i+1:15
                
                % For CMPC
                es1(i,j) = sqrt((traj(l).x(k,i)-traj(l).x(k,j))^2 + (traj(l).y(k,i)-traj(l).y(k,j))^2);
                min1(n,m) = min(es1(es1>0));
                
                % For DNC
                es2(i,j) = sqrt((x{l}(k,i)-x{l}(k,j))^2 + (y{l}(k,i)-y{l}(k,j))^2);
                min2(n,m) = min(es2(es2>0));
                
            end
        end
        m = m+1;
    end
    n = n+1;
end

for i = 1:1000
    avg_min1(1,i) = min(min1(:,i));
    avg_min2(1,i) = min(min2(:,i));
end

plot(avg_min1)
hold on
plot(avg_min2)