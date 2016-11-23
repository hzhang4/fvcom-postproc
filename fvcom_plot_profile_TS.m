function fvcom_plot_profile_TS(Xsec,fname, starttime, endtime)

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
    
    h1=subplot('Position',[0.1 0.5 0.8 0.35]);
    contourf(xdist,Xsec.zz(:,:,i),Xsec.temp(:,:,i),'LineStyle','none')
    set(gca,'LineWidth',2,'FontSize',12,'FontWeight','b')
    ylabel('Depth (m)','fontsize',12,'fontweight','b');
    title(datestr(Xsec.time(i)),'fontsize',12,'fontweight','b');
    ch1=colorbar('EastOutside');
    s = sprintf('Temperature (%cC)', char(176));
    ylabel(ch1, s,'fontsize',12,'fontweight','b');

    h2=subplot('Position',[0.1 0.1 0.8 0.35]);
    contourf(xdist,Xsec.zz(:,:,i),Xsec.salinity(:,:,i),'LineStyle','none')
    set(gca,'LineWidth',2,'FontSize',12,'FontWeight','b')
    xlabel('Section Distance (m)','fontsize',12,'fontweight','b');
    ylabel('Depth (m)','fontsize',12,'fontweight','b');
    ch1=colorbar('EastOutside');
    ylabel(ch1, 'Salinity','fontsize',12,'fontweight','b');
    
    dstr=sprintf('%s_Xsec_TS_%d.png',fname,i);
    print(myfig,'-dpng','-r600',dstr)
    delete(h1,h2);
end
