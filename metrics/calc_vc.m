load('/Users/root1/Desktop/FOSSACS/fossacs_data/traj_cmpc_bf_100.mat')

for l = 1:100
    %V1 = sqrt(traj(l).vx.^2 + traj(l).vy.^2);
    for i = 1:1000
        
        % For CMPC
        avg_Vx1(i,1) = mean(traj(l).vx(i,:));
        avg_Vy1(i,1) = mean(traj(l).vy(i,:));
        %avg_V1(i,1) = mean(V1(i,:));
        
        % For DMPC
        avg_Vx3(i,1) = mean(trajs(l).vx(i,:));
        avg_Vy3(i,1) = mean(trajs(l).vy(i,:));
        
        % For DNC
        avg_Vx2(i,1) = mean(vx{l}(i,:));
        avg_Vy2(i,1) = mean(vy{l}(i,:));
        
        for j = 1:15
            
            % For CMPC
            diff_vcx1(i,j) = traj(l).vx(i,j) - avg_Vx1(i,1);
            diff_vcy1(i,j) = traj(l).vy(i,j) - avg_Vy1(i,1);
            %diff_vc1(i,j) = abs(V1(i,j) - avg_V1(i,1));
            
            % For DMPC
            diff_vcx3(i,j) = trajs(l).vx(i,j) - avg_Vx3(i,1);
            diff_vcy3(i,j) = trajs(l).vy(i,j) - avg_Vy3(i,1);
            
            % For DNC
            diff_vcx2(i,j) = abs(vx{l}(i,j) - avg_Vx2(i,1));
            diff_vcy2(i,j) = abs(vy{l}(i,j) - avg_Vy2(i,1));
            
        end
    end
    
    diff_vc1 = sqrt(diff_vcx1.^2 + diff_vcy1.^2);
    diff_vc2 = sqrt(diff_vcx2.^2 + diff_vcy2.^2);
    diff_vc3 = sqrt(diff_vcx3.^2 + diff_vcy3.^2);
    
    for k = 1:1000
        vc1(l,k)=sum(diff_vc1(k,:))/15;
        vc2(l,k)=sum(diff_vc2(k,:))/15;
        vc3(l,k)=sum(diff_vc3(k,:))/15;
    end
end

for i = 1:1000
    avg_vc1(1,i) = mean(vc1(:,i));
    avg_vc2(1,i) = mean(vc2(:,i));
    avg_vc3(1,i) = mean(vc3(:,i));
end

z = linspace(0,100,1000);
plot(z,avg_vc1,'k','Linewidth',2)
hold on
plot(z,avg_vc2,'r-','Linewidth',2)
hold on
plot(z,avg_vc3,'b-.','Linewidth',2)
