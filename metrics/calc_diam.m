load('/Users/root1/Desktop/FOSSACS/fossacs_data/traj_cmpc_bf_100.mat')
coll2 = 0;
n = 1;

for l = 1:100
    coll1 = 0;
    m = 1;
    for k = 1:1000
        for i = 1:15
            for j = i+1:15
        
                % For CMPC
                es1(i,j) = sqrt((traj(l).x(k,i)-traj(l).x(k,j))^2 + (traj(l).y(k,i)-traj(l).y(k,j))^2);
                diam1(n,m) = max(es1,[],'all');
                
                % For DNC
                %es2(i,j) = sqrt((x{l}(k,i)-x{l}(k,j))^2 + (y{l}(k,i)-y{l}(k,j))^2);
                %diam2(n,m) = max(es2,[],'all');   
            end
        end
        if any(es1(:)<1.5 & es1(:)>0) == 1
            coll1 = coll1+1;                      
        end
        m = m+1;
    end
    if coll1 > 0
        ic(l,1) = 1;
    else
        ic(l,1) = 0;
    end
    n = n+1;
end

for i = 1:1000
    cmpc_bf_diam(1,i) = mean(diam1(:,i));
    %dnc_bf_diam(1,i) = mean(diam2(:,i));
end

%plot(dmpc_bf_diam)
%hold on
%plot(dnc_bf_diam)
% ylabel('Diameter')
% xlabel('Time')