function fvcom_plot_cotidal(fvout,mask,fname)

subname = 'fvcom_plot_cotidal';
global ftbverbose
if ftbverbose
    fprintf('\nbegin : %s\n', subname)
end

if nargin < 3
    fname='fvcom';
end

latlim=[min(fvout.lat) max(fvout.lat)];
lonlim=[min(fvout.lon) max(fvout.lon)];

myfig=figure;
worldmap(latlim, lonlim);
mstruct=gcm;

lat=fvout.lat(fvout.tidenode);
lon=fvout.lon(fvout.tidenode);
[xn,yn] = feval(mstruct.mapprojection, mstruct,lat, lon, 'geopoint','forward');
tri=delaunay(xn,yn);
A=fvout.tideh.A';
g=fvout.tideh.g';

h1=tricontour(tri,xn,yn,A,20);
h2=tricontour(tri,xn,yn,g,12);
geoshow(mask);

dstr=sprintf('%s_cotidal.png',fname);
print(myfig,'-dpng','-r600',dstr)
