ox = [19.500000,16.778626,47.767176,39.251908,41.709924];
oy = [18.578244,31.307252,7.780534,26.742366,42.982824];
w = [4.038168,26.335878,28.969466,2.458015,16.152672];
l = [3.687023,4.916031,22.824427,2.458015,4.389313];

for t = 1:25
    for i = 1:1000
        for j = 1:15
            for k = 1:5
                %dx = max(abs(x{t}(i,j) - ox(1,k)) - w(1,k) / 2, 0);
                %dy = max(abs(y{t}(i,j) - oy(1,k)) - l(1,k) / 2, 0);
                dx = max(abs(traj(t).x(i,j) - ox(1,k)) - w(1,k) / 2, 0);
                dy = max(abs(traj(t).y(i,j) - oy(1,k)) - l(1,k) / 2, 0);
                buffer(1,k) = sqrt(dx * dx + dy * dy);
            end
            obs(i,j) = min(buffer,[],'all');
        end
    end
    min_obs(t,1) = min(obs,[],'all');
    %clearvars buffer dx dy obs
end

z = linspace(1,1,100);
plot(z,'r.')
hold on
plot(min_obs)
axis([0 100 0 2.5])