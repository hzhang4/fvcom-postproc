function fvcom_plot_stations_vert(fvout, fname, starttime, endtime)

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

for i=1:fvout.sta.nsta
    for j=ts:tend
        vh(:,j-ts+1)=-(fvout.sta.h(i)+fvout.sta.zeta(i,j))*fvout.sta.siglay(i,:);
    end
    
    th=repmat(fvout.sta.time(ts:tend)',fvout.sta.nsig,1);
    
    ttick=(endtime-starttime)/6;
    xt=fvout.sta.time(ts):ttick:fvout.sta.time(tend);

    h1=subplot('Position',[0.1 0.66 0.8 0.23]);
    contourf(th,vh,flipud(squeeze(fvout.sta.u(i,:,ts:tend))),'LineStyle','none')
    set(gca,'LineWidth',2,'FontSize',12,'FontWeight','b','XTick',xt,'XTickLabel','','YDir','normal')
    datetick('x',6,'keepticks');
    %     xlabel('Date','fontsize',12,'fontweight','b');
    ylabel('Depth (m)','fontsize',12,'fontweight','b');
    title(fvout.sta.title{i},'fontsize',16,'fontweight','b');
    ch1=colorbar('EastOutside');
    ylabel(ch1, 'U (m/s)','fontsize',12,'fontweight','b');
    
    h2=subplot('Position',[0.1 0.38 0.8 0.23]);
    contourf(th,vh,flipud(squeeze(fvout.sta.v(i,:,ts:tend))),'LineStyle','none')
    set(gca,'LineWidth',2,'FontSize',12,'FontWeight','b','XTick',xt,'XTickLabel','','YDir','normal')
    datetick('x',6,'keepticks');
    %     xlabel('Date','fontsize',12,'fontweight','b');
    ylabel('Depth (m)','fontsize',12,'fontweight','b');
    ch2=colorbar('EastOutside');
    ylabel(ch2, 'V (m/s)','fontsize',12,'fontweight','b');
    
    h3=subplot('Position',[0.1 0.1 0.8 0.23]);
    contourf(th,vh,flipud(squeeze(fvout.sta.ww(i,:,ts:tend))),'LineStyle','none')
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
