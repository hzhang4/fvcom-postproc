function fvcom_plot_ellipse(fvout,mask,fname)

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
geoshow(mask)

lat=fvout.latc(fvout.tidecell);
lon=fvout.lonc(fvout.tidecell);
[xn,yn] = feval(mstruct.mapprojection, mstruct,lat, lon, 'geopoint','forward');

plot_tide_ell(xn,yn,fvout.

dstr=sprintf('%s_cotidal.png',fname);
print(myfig,'-dpng','-r600',dstr)

