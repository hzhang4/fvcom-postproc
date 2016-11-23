function fvcom_plot_mesh(fvout,fname,latlim,lonlim)

subname = 'fvcom_plot_mesh';
global ftbverbose
if ftbverbose
    fprintf('\nbegin : %s\n', subname)
end

if nargin < 4
    plotall=true;
    latlim=[min(fvout.lat) max(fvout.lat)];
    lonlim=[min(fvout.lon) max(fvout.lon)];
else
    plotall=false;
end

if nargin < 2
    fname='fvcom';
end

myfig=figure;
worldmap(latlim, lonlim);
mstruct=gcm;

if plotall
    [xn,yn] = feval(mstruct.mapprojection, mstruct,fvout.lat, fvout.lon, 'geopoint','forward');

    patch('Vertices',[xn,yn],'Cdata',fvout.h,'Faces',fvout.nv,'edgecolor','none','facecolor','interp');
    patch('Vertices',[xn,yn],'Faces',fvout.nv,'edgecolor',[0.4,0.4,0.4],'linewidth',0.2,'facecolor','none');
    
    dstr=sprintf('%s_mesh.png',fname);
    print(myfig,'-dpng','-r600',dstr)
else
    nodeinside=(fvout.lat > latlim(1) & fvout.lat < latlim(2))...
        & (fvout.lon > lonlim(1) & fvout.lon < lonlim(2));
    node_id=find(nodeinside); % node id in the original mesh
    
    % Project node lat/lon
    [xn,yn] = feval(mstruct.mapprojection, mstruct,...
        fvout.lat(nodeinside), fvout.lon(nodeinside), 'geopoint','forward');
    
    %select elements that have all three nodes inside lat and lon limit
    eleinside=sum(nodeinside(fvout.nv),2)==3;
    facek=fvout.nv(eleinside,:);
    
    % convert from FEM node number to clipped node number
    for i=1:length(facek)
        for j=1:3
            facek(i,j)=find(node_id==facek(i,j));
        end
    end
    
    patch('Vertices',[xn,yn],'Cdata',fvout.h(nodeinside),'Faces',facek,'edgecolor','none','facecolor','interp');
    patch('Vertices',[xn,yn],'Faces',facek,'edgecolor',[0.4,0.4,0.4],'linewidth',0.2,'facecolor','none');
    
    dstr=sprintf('%s_mesh.png',fname);
    print(myfig,'-dpng','-r600',dstr)
end

