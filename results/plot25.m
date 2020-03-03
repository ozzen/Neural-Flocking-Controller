x = csvread('/Users/root1/Desktop/FOSSACS/C_Code/results/bf_sim_gen/25_x_1.csv');
y = csvread('/Users/root1/Desktop/FOSSACS/C_Code/results/bf_sim_gen/25_y_1.csv');

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
x16 = x(1:t,16);
x17 = x(1:t,17);
x18 = x(1:t,18);
x19 = x(1:t,19);
x20 = x(1:t,20);
x21 = x(1:t,21);
x22 = x(1:t,22);
x23 = x(1:t,23);
x24 = x(1:t,24);
x25 = x(1:t,25);

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
y16 = y(1:t,16);
y17 = y(1:t,17);
y18 = y(1:t,18);
y19 = y(1:t,19);
y20 = y(1:t,20);
y21 = y(1:t,21);
y22 = y(1:t,22);
y23 = y(1:t,23);
y24 = y(1:t,24);
y25 = y(1:t,25);

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
h16 = plot(x16(1),y16(1),'r.');
h17 = plot(x17(1),y17(1),'r.');
h18 = plot(x18(1),y18(1),'r.');
h19 = plot(x19(1),y19(1),'r.');
h20 = plot(x20(1),y20(1),'r.');
h21 = plot(x21(1),y21(1),'r.');
h22 = plot(x22(1),y22(1),'r.');
h23 = plot(x23(1),y23(1),'r.');
h24 = plot(x24(1),y24(1),'r.');
h25 = plot(x25(1),y25(1),'r.');

axis([-20 50 -20 50])
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
    set(h16,'XData',x16(n),'YData',y16(n));
    set(h17,'XData',x17(n),'YData',y17(n));
    set(h18,'XData',x18(n),'YData',y18(n));
    set(h19,'XData',x19(n),'YData',y19(n));
    set(h20,'XData',x20(n),'YData',y20(n));
    set(h21,'XData',x21(n),'YData',y21(n));
    set(h22,'XData',x22(n),'YData',y22(n));
    set(h23,'XData',x23(n),'YData',y23(n));
    set(h24,'XData',x24(n),'YData',y24(n));
    set(h25,'XData',x25(n),'YData',y25(n));
    drawnow
end
