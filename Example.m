%Example

clear all
close all

global ftbverbose
ftbverbose = true; %print information to screen [true/false]

ncsta='HRYS_0001.nc';

varlist={'zeta','ua','va','wet_nodes','wet_cells'};
% varlist={'zeta','u','v','ww','ua','va','temp','salinity'};

fvout=fvcom_read_ncout(ncsta,varlist);
fvout.time=fvout.time+datenum('1899-12-30');
% datestr(fvout.time)

fvcom_plot_mesh(fvout,'fig/BH')
fvcom_plot_mesh(fvout,'fig/BH',[38 38.5],[120.5 121.2])

% plot selected nodes and cells on the mesh
patch('Vertices',[fvout.x,fvout.y],'Faces',fvout.nv,'edgecolor',[0.4,0.4,0.4],'linewidth',0.2,'facecolor','none');
hold on
selnode=763;
scatter(fvout.x(selnode),fvout.y(selnode),10,'r');
selcell=17000;
patch('Vertices',[fvout.x,fvout.y],'Faces',fvout.nv(selcell,:),'edgecolor','r','facecolor','r');

% CoordinateProjection:'+proj=tmerc +datum=NAD83 +lon_0=120 +lat_0=0 +k=1 +x_0=500000 +y_0=0'
mstruct=defaultm('tranmerc');
mstruct.origin=[0,120,0];
mstruct.falseeasting=500000;
mstruct.geoid=[6378137.0, 0.081819190842621];%datum=NAD83
mstruct = defaultm(mstruct);

% [xn,yn] = feval(mstruct.mapprojection, mstruct,fvout.lat, fvout.lon, 'geopoint','forward');
% dx=xn-fvout.x;
% dy=yn-fvout.y;

fvcom_plot_map_flow(fvout,'fig/BH');

fvcom_plot_map_flow(fvout,'fig/BHS',[38 38.5],[120.5 121.2]);

cnstit={'M2  ','S2  ','K1  ','O1  '};

% trim node for tidal analysis
fvout.tidenode=1:5:fvout.nnode;
fvout.tidecell=1:50:fvout.nele;

fvout=fvcom_tidal_harmonic(fvout,cnstit);

load yscst
fvcom_plot_cotidal(fvout,yscst,'fig/BH')
fvcom_plot_ellipse(fvout,yscst,'fig/BH')

ele=17000;
node=fvout.nv(ele,1);
tr=1:24;
t=fvout.time(tr);
h=fvout.zeta(node,tr)';
u=fvout.ua(ele,tr)';
v=fvout.va(ele,tr)';
lat=fvout.latc(ele);

th1=ut_solv (t,h,[], lat, cnstit, 'OLS', 'White', 'LinCI');
tuv1=ut_solv (t,u,v, lat, cnstit, 'OLS', 'White', 'LinCI');

SEMA=tuv1.Lsmaj;
SEMI=tuv1.Lsmin;
INC=tuv1.theta;
PHA=tuv1.g;

figure
for i=1:length(t)
    quiver(0,0,u(i),v(i),1,'k');
    hold on
    pause
end
plot_tide_ell(tuv1.Lsmaj,tuv1.Lsmin,tuv1.theta,tuv1.g)


% i=763;
% plot(fvout.time,fvout.zeta(i,:))
% 
% plot(fvout.time,fvout.ua(i,:),fvout.time,fvout.va(i,:))

%transectional plots

Xsec.latlim=[37.85 38.7];
Xsec.lonlim=[120.85 121.15];

[Xsec.Xlim,Xsec.Ylim] = feval(mstruct.mapprojection, mstruct,Xsec.latlim, Xsec.lonlim, 'geopoint','forward');

% create equal spaced points along transection
Xsec.np=30;
Xsec.X=linspace(Xsec.Xlim(1),Xsec.Xlim(2),Xsec.np);
Xsec.Y=linspace(Xsec.Ylim(1),Xsec.Ylim(2),Xsec.np);

varlist={'zeta','ua','va'};
% varlist={'zeta','u','v','ww','ua','va','temp','salinity'};

Xsec=fvcom_profile(fvout,Xsec,varlist);

starttime=datenum('2015-01-24');
endtime=datenum('2015-03-01');

fvcom_plot_profile_flow(Xsec,'fig/BHS', starttime, endtime)
fvcom_plot_profile_TS(Xsec,'fig/BHS', starttime, endtime)


ncsta='HRYS_station_timeseries.nc';

fvout=fvcom_read_ncstation(ncsta,fvout);

load obs.mat

starttime=datenum('2015-01-24');
endtime=datenum('2015-03-01');
fvcom_plot_stations_av(fvout,'fig/BH_Sta_Av',starttime,endtime,obs);

fvcom_plot_stations_vert(fvout, 'fig/BH_Sta', starttime, endtime);
fvcom_plot_stations_vert1(fvout, 'fig/BH_v1_Sta', starttime, endtime);


