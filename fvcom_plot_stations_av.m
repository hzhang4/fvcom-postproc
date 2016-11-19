function fvcom_plot_stations_av(fvout, fname, starttime, endtime, obs)

if nargin < 5
    plotobs=false;
else
    plotobs=true;
end

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
    h1=subplot('Position',[0.1 0.66 0.8 0.24]);
    
    plot(fvout.sta.time(ts:tend),fvout.sta.zeta(i,ts:tend),'Color','b','LineStyle','-','LineWidth',1);
    hold on
    if plotobs
        plot(obs.time(i,:),obs.dep(i,:),'sr','MarkerSize',2)
    end
    set(gca,'LineWidth',2,'FontSize',12,'FontWeight','b')
    datetick('x',2,'keeplimits');
    %     xlabel('Date','fontsize',12,'fontweight','b');
    ylabel('SSH (m)','fontsize',12,'fontweight','b');
    title(fvout.sta.title{i},'fontsize',16,'fontweight','b');
    
    h2=subplot('Position',[0.1 0.38 0.8 0.24]);
    plot(fvout.sta.time(ts:tend),fvout.sta.ua(i,ts:tend),'Color','b','LineStyle','-','LineWidth',1);
    hold on
    if plotobs
        plot(obs.time(i,:),obs.ua(i,:),'sr','MarkerSize',2)
    end
    
    set(gca,'LineWidth',2,'FontSize',12,'FontWeight','b')
    datetick('x',2,'keeplimits');
    %     xlabel('Date','fontsize',12,'fontweight','b');
    ylabel('U (m)','fontsize',12,'fontweight','b');
    %      legend('SIM','v_{sim}','u_{obs}','v_{obs}','fontsize',12,'fontweight','b');
    
    h3=subplot('Position',[0.1 0.1 0.8 0.24]);
    plot(fvout.sta.time(ts:tend),fvout.sta.va(i,ts:tend),'Color','b','LineStyle','-','LineWidth',1);
    hold on
    if plotobs
        plot(obs.time(i,:),obs.va(i,:),'sr','MarkerSize',2)
    end
    
    set(gca,'LineWidth',2,'FontSize',12,'FontWeight','b')
    datetick('x',2,'keeplimits');
    xlabel('Date','fontsize',12,'fontweight','b');
    ylabel('V (m)','fontsize',12,'fontweight','b');
    
    dstr=sprintf('%s%d.png',fname,i);
    print(myfig,'-dpng','-r600',dstr)
    
    delete(h1,h2,h3);
end

