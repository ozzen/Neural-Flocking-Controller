%intervals = [0 20 40 60 80 100];
z = linspace(0,100,1000);
% plot(z,cmpc_bf_diam,'k','Linewidth',2)
% hold on
% plot(z,dnc_bf_diam,'r--','Linewidth',2)
% hold on
% plot(z,dmpc_bf_diam,'b-.','Linewidth',2)
% set(gca, 'XTick',intervals,'FontSize',20)
% ylabel('D','FontSize',30)
% xlabel('Time','FontSize',30)    
% legend('CMPC','DNC')
%fig=gcf;ax=fig.CurrentAxes;fig.OuterPosition=fig.InnerPosition;
%saveas(fig,'/Users/root1/Downloads/plot_diam','epsc')

plot(z,avg_vc1,'k','Linewidth',2)
hold on
plot(z,avg_vc2,'r--','Linewidth',2)
hold on
plot(z,avg_vc3,'b-.','Linewidth',2)
set(gca, 'FontSize',20)
ylabel('VC','FontSize',30)
xlabel('Time','FontSize',30)
fig=gcf;ax=fig.CurrentAxes;fig.OuterPosition=fig.InnerPosition;
saveas(fig,'/Users/root1/Downloads/plot_vc','epsc')