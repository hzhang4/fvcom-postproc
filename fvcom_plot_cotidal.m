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
geoshow(mask);

lat=fvout.lat(fvout.tidenode);
lon=fvout.lon(fvout.tidenode);
[xn,yn] = feval(mstruct.mapprojection, mstruct,lat, lon, 'geopoint','forward');
tri=delaunay(xn,yn);

for i=1:length(fvout.tideh.name)
    tname=fvout.tideh.name{i};
    
    A=fvout.tideh.A(i,:)';
    g=fvout.tideh.g(i,:)';
    
    [C h1]=tricontour(tri,xn,yn,A,30);
    [C h2]=tricontour(tri,xn,yn,g,12);
    
    title(tname,'fontsize',12,'fontweight','b');
    
    dstr=sprintf('%s_cotidal_%s.png',fname,tname);
    print(myfig,'-dpng','-r600',dstr)
    
    delete(h1,h2);
    
    
end
