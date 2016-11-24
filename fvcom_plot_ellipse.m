function fvcom_plot_ellipse(fvout,mask,fname)

subname = 'fvcom_plot_ellipse';
global ftbverbose
if ftbverbose
    fprintf('\nbegin : %s\n', subname)
end

if nargin < 3
    fname='fvcom';
end

lat_lim=[min(fvout.lat) max(fvout.lat)];
lon_lim=[min(fvout.lon) max(fvout.lon)];

myfig=figure;
worldmap(lat_lim, lon_lim);
mstruct=gcm;
geoshow(mask)

xl=xlim;yl=ylim;

scale_factor=min(abs(xl(1)-xl(2)),abs(yl(1)-yl(2)))/50;

lat=fvout.latc(fvout.tidecell);
lon=fvout.lonc(fvout.tidecell);
[xn,yn] = feval(mstruct.mapprojection, mstruct,lat, lon, 'geopoint','forward');
for i=1:length(fvout.tidecell)
    plot_tide_ell(xn(i),yn(i),fvout.tideuv.Lsmaj(i),fvout.tideuv.Lsmin(i),...
        fvout.tideuv.theta(i),fvout.tideuv.g(i),scale_factor);
    hold on
end

dstr=sprintf('%s_ellipse.png',fname);
print(myfig,'-dpng','-r600',dstr)

