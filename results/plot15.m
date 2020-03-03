x = csvread('/Users/root1/Desktop/FOSSACS/C_Code/results/bf_sim_gen/15_x_1.csv');
y = csvread('/Users/root1/Desktop/FOSSACS/C_Code/results/bf_sim_gen/15_y_1.csv');

t = 1000;

x1 = x(1:t,1);
x2 = x(1:t,2);
x3 = x(1:t,3);
x4 = x(1:t,4);
x5 = x(1:t,5);
x6 = x(1:t,6);
x7 = x(1:t,7);
x8 = x(1:t,8);
x9 = x(1:t,9);
x10 = x(1:t,10);
x11 = x(1:t,11);
x12 = x(1:t,12);
x13 = x(1:t,13);
x14 = x(1:t,14);
x15 = x(1:t,15);
%x16 = x(1:t,16);

y1 = y(1:t,1);
y2 = y(1:t,2);
y3 = y(1:t,3);
y4 = y(1:t,4);
y5 = y(1:t,5);
y6 = y(1:t,6);
y7 = y(1:t,7);
y8 = y(1:t,8);
y9 = y(1:t,9);
y10 = y(1:t,10);
y11 = y(1:t,11);
y12 = y(1:t,12);
y13 = y(1:t,13);
y14 = y(1:t,14);
y15 = y(1:t,15);
%y16 = x(1:t,16);

hold on

h1 = plot(x1(1),y1(1),'r.');
h2 = plot(x2(1),y2(1),'r.');
h3 = plot(x3(1),y3(1),'r.');
h4 = plot(x4(1),y4(1),'r.');
h5 = plot(x5(1),y5(1),'r.');
h6 = plot(x6(1),y6(1),'r.');
h7 = plot(x7(1),y7(1),'r.');
h8 = plot(x8(1),y8(1),'r.');
h9 = plot(x9(1),y9(1),'r.');
h10 = plot(x10(1),y10(1),'r.');
h11 = plot(x11(1),y11(1),'r.');
h12 = plot(x12(1),y12(1),'r.');
h13 = plot(x13(1),y13(1),'r.');
h14 = plot(x14(1),y14(1),'r.');
h15 = plot(x15(1),y15(1),'r.');
%h16 = plot(x16(1),y16(1),'b.');

axis([-15 80 -15 80])

% rectangle('Position',[17.4809,15.7347,14.038168,13.687023],'FaceColor','black')
% rectangle('Position',[1.6107,38.8492,26.335878,10.916031],'FaceColor','black')
% rectangle('Position',[33.2824,-5.6317,28.969466,8.824427],'FaceColor','black')
% rectangle('Position',[40.0229,15.5134,13.458015,10.458015],'FaceColor','black')
% rectangle('Position',[33.6336,33.7882,16.152672,4.389313],'FaceColor','black')

% rectangle('Position',[17.4809,16.7347,4.038168,3.687023],'FaceColor','black')
% rectangle('Position',[3.6107,28.8492,26.335878,4.916031],'FaceColor','black')
% rectangle('Position',[33.2824,-3.6317,28.969466,22.824427],'FaceColor','black')
% rectangle('Position',[38.0229,25.5134,2.458015,2.458015],'FaceColor','black')
% rectangle('Position',[33.6336,40.7882,16.152672,4.389313],'FaceColor','black')

%rectangle conversion: cx = x + 0.5w, cy = y + 0.5l 

grid on

for n = 1:2:t
    set(h1,'XData',x1(n),'YData',y1(n));
    set(h2,'XData',x2(n),'YData',y2(n));
    set(h3,'XData',x3(n),'YData',y3(n));
    set(h4,'XData',x4(n),'YData',y4(n));
    set(h5,'XData',x5(n),'YData',y5(n));
    set(h6,'XData',x6(n),'YData',y6(n));
    set(h7,'XData',x7(n),'YData',y7(n));
    set(h8,'XData',x8(n),'YData',y8(n));
    set(h9,'XData',x9(n),'YData',y9(n));
    set(h10,'XData',x10(n),'YData',y10(n));
    set(h11,'XData',x11(n),'YData',y11(n));
    set(h12,'XData',x12(n),'YData',y12(n));
    set(h13,'XData',x13(n),'YData',y13(n));
    set(h14,'XData',x14(n),'YData',y14(n));
    set(h15,'XData',x15(n),'YData',y15(n));
    %set(h16,'XData',x16(n),'YData',y16(n));
    drawnow
end
