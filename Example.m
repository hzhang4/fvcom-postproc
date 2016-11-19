%Example

clear all
close all

ncfout='HRYS_0001.nc';

fvout=fvcom_read_ncout(ncfout);

fvout.time=fvout.time+datenum('1899-12-30');
% datestr(fvout.time)

% CoordinateProjection:'+proj=tmerc +datum=NAD83 +lon_0=120 +lat_0=0 +k=1 +x_0=500000 +y_0=0'

mstruct=defaultm('tranmerc');
mstruct.origin=[0,120,0];
mstruct.falseeasting=500000;
mstruct.geoid=[6378137.0, 0.081819190842621];%datum=NAD83
mstruct = defaultm(mstruct);
% [xn,yn] = feval(mstruct.mapprojection, mstruct,fvout.lat, fvout.lon, 'geopoint','forward');
% dx=xn-fvout.x;
% dy=yn-fvout.y;

fvcom_plot_map(fvout,'fig/BH');

fvcom_plot_map(fvout,'fig/BHS',[38 38.5],[120.5 121.2]);

Xsec.latlim=[37.85 38.7];
Xsec.lonlim=[120.85 121.15];

[Xsec.Xlim,Xsec.Ylim] = feval(mstruct.mapprojection, mstruct,Xsec.latlim, Xsec.lonlim, 'geopoint','forward');

% create equal spaced points along transection
Xsec.np=30;
Xsec.X=linspace(Xsec.Xlim(1),Xsec.Xlim(2),Xsec.np);
Xsec.Y=linspace(Xsec.Ylim(1),Xsec.Ylim(2),Xsec.np);

Xsec=fvcom_profile(fvout,Xsec);
fvcom_plot_profile(Xsec,'fig/BHS')

ncsta='HRYS_station_timeseries.nc';

fvout=fvcom_read_ncstation(ncsta,fvout);

load obs.mat

starttime=datenum('2015-01-24');
endtime=datenum('2015-03-01');
fvcom_plot_stations_av(fvout,'fig/BH_Sta_Av',starttime,endtime,obs);

fvcom_plot_stations_vert(fvout, 'fig/BH_Sta', starttime, endtime);
fvcom_plot_stations_vert1(fvout, 'fig/BH_v1_Sta', starttime, endtime);


