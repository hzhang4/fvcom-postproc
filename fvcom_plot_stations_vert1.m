function fvcom_plot_stations_vert1(fvout, fname, starttime, endtime)

if nargin < 4
    ts=1;
    tend=fvout.sta.ntime;
else
    [c ts]=min(abs(fvout.sta.time-starttime));
    [c tend]=min(abs(fvout.sta.time-endtime));
end

if nargin < 2
    fname='fvcom_sta';
end

myfig=figure;

%plot vertical velocity distribution without sea level variation
for i=1:fvout.sta.nsta
    dd=fvout.sta.h(i)*fvout.sta.siglay(i,:);
    
    ttick=(endtime-starttime)/6;
    xt=fvout.sta.time(ts):ttick:fvout.sta.time(tend);
    
    h1=subplot('Position',[0.1 0.66 0.8 0.23]);
    imagesc(fvout.sta.time(ts:tend),dd,squeeze(fvout.sta.u(i,:,ts:tend)))
    set(gca,'LineWidth',2,'FontSize',12,'FontWeight','b','XTick',xt,'XTickLabel','','YDir','normal')
    datetick('x',6,'keepticks');
    %     xlabel('Date','fontsize',12,'fontweight','b');
    ylabel('Depth (m)','fontsize',12,'fontweight','b');
    title(fvout.sta.title{i},'fontsize',16,'fontweight','b');
    ch1=colorbar('EastOutside');
    ylabel(ch1, 'U (m/s)','fontsize',12,'fontweight','b');
    
    h2=subplot('Position',[0.1 0.38 0.8 0.23]);
    imagesc(fvout.sta.time(ts:tend),dd,squeeze(fvout.sta.v(i,:,ts:tend)))
    set(gca,'LineWidth',2,'FontSize',12,'FontWeight','b','XTick',xt,'XTickLabel','','YDir','normal')
    datetick('x',6,'keepticks');
    %     xlabel('Date','fontsize',12,'fontweight','b');
    ylabel('Depth (m)','fontsize',12,'fontweight','b');
    ch2=colorbar('EastOutside');
    ylabel(ch2, 'V (m/s)','fontsize',12,'fontweight','b');
    
    h3=subplot('Position',[0.1 0.1 0.8 0.23]);
    imagesc(fvout.sta.time(ts:tend),dd,squeeze(fvout.sta.ww(i,:,ts:tend)))
    set(gca,'LineWidth',2,'FontSize',12,'FontWeight','b','XTick',xt,'YDir','normal')
    datetick('x',6,'keepticks');
    xlabel('Date','fontsize',12,'fontweight','b');
    ylabel('Depth (m)','fontsize',12,'fontweight','b');
    ch3=colorbar('EastOutside');
    ylabel(ch3, 'W (m/s)','fontsize',12,'fontweight','b');
    
    dstr=sprintf('%s%d_vel.png',fname,i);
    print(myfig,'-dpng','-r600',dstr)
    
    delete(h1,h2,h3);
end
