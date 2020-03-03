load('/Users/root1/Desktop/FOSSACS/fossacs_data/traj_cmpc_bf_200.mat')

j = 1;
k = 1000;
for i = 1:200
    x(j:k,:) = traj(i).x(1:1000,:);
    y(j:k,:) = traj(i).y(1:1000,:);
    vx(j:k,:) = traj(i).vx(1:1000,:);
    vy(j:k,:) = traj(i).vy(1:1000,:);
    ax(j:k,:) = traj(i).ax(1:1000,:);
    ay(j:k,:) = traj(i).ay(1:1000,:);
    j = k+1;
    k = k + 1000;
end
    