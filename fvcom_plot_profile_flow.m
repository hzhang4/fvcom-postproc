function fvcom_plot_profile_flow(Xsec,fname, starttime, endtime)

if nargin < 2
    fname='fvcom';
end

if nargin < 4
    ts=1;
    tend=Xsec.ntime;
else
    [c ts]=min(abs(Xsec.time-starttime));
    [c tend]=min(abs(Xsec.time-endtime));
end

myfig=figure;

for i=ts:tend
   
    xdist=repmat(Xsec.td',1,Xsec.nsiglay);
    
    h1=subplot('Position',[0.1 0.66 0.8 0.23]);
    contourf(xdist,Xsec.zz(:,:,i),Xsec.u(:,:,i),'LineStyle','none')
    set(gca,'LineWidth',2,'FontSize',12,'FontWeight','b')
    %     xlabel('Date','fontsize',12,'fontweight','b');
    ylabel('Depth (m)','fontsize',12,'fontweight','b');
    title(datestr(Xsec.time(i)),'fontsize',12,'fontweight','b');
    ch1=colorbar('EastOutside');
    ylabel(ch1, 'U (m/s)','fontsize',12,'fontweight','b');

    h2=subplot('Position',[0.1 0.38 0.8 0.23]);
    contourf(xdist,Xsec.zz(:,:,i),Xsec.v(:,:,i),'LineStyle','none')
    set(gca,'LineWidth',2,'FontSize',12,'FontWeight','b')
    %     xlabel('Date','fontsize',12,'fontweight','b');
    ylabel('Depth (m)','fontsize',12,'fontweight','b');
%     title(datestr(Xsec.time(i)),'fontsize',12,'fontweight','b');
    ch1=colorbar('EastOutside');
    ylabel(ch1, 'V (m/s)','fontsize',12,'fontweight','b');
    
    h3=subplot('Position',[0.1 0.1 0.8 0.23]);
    contourf(xdist,Xsec.zz(:,:,i),Xsec.ww(:,:,i),'LineStyle','none')
    set(gca,'LineWidth',2,'FontSize',12,'FontWeight','b')
    xlabel('Section Distance (m)','fontsize',12,'fontweight','b');
    ylabel('Depth (m)','fontsize',12,'fontweight','b');
%     title(datestr(Xsec.time(i)),'fontsize',12,'fontweight','b');
    ch1=colorbar('EastOutside');
    ylabel(ch1, 'W (m/s)','fontsize',12,'fontweight','b');

    dstr=sprintf('%s_Xsec_flow_%d.png',fname,i);
    print(myfig,'-dpng','-r600',dstr)
    delete(h1,h2,h3);
end
