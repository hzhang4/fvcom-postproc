function fvcom_plot_map_TS(fvout,fname,latlim,lonlim)

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
    for i=1:length(fvout.time)
        h=patch('Vertices',[xn,yn],'Cdata',fvout.temp(:,1,i),...
            'Faces',fvout.nv,'edgecolor','none','facecolor','interp');
        title(datestr(fvout.time(i)),'fontsize',12,'fontweight','b');
        h2=colorbar('SouthOutside');
        xlabel(h2, 'SST','fontsize',12,'fontweight','b');
        
        dstr=sprintf('%s_temp_%d.png',fname,i);
        print(myfig,'-dpng','-r600',dstr)
        
        delete(h);
    end
    for i=1:length(fvout.time)
        h=patch('Vertices',[xn,yn],'Cdata',fvout.salinity(:,1,i),...
            'Faces',fvout.nv,'edgecolor','none','facecolor','interp');
        title(datestr(fvout.time(i)),'fontsize',12,'fontweight','b');
        h2=colorbar('SouthOutside');
        xlabel(h2, 'SSS','fontsize',12,'fontweight','b');
        
        dstr=sprintf('%s_sal_%d.png',fname,i);
        print(myfig,'-dpng','-r600',dstr)
        
        delete(h);
    end
else
    %select node inside lat and lon limit
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
    
    for i=1:length(fvout.time)
        h1=patch('Vertices',[xn,yn],'Cdata',fvout.temp(nodeinside,i),...
            'Faces',facek,'edgecolor','none','facecolor','interp');
        title(datestr(fvout.time(i)),'fontsize',12,'fontweight','b');
        h2=colorbar('SouthOutside');
        xlabel(h2, 'SSS','fontsize',12,'fontweight','b');
        
        dstr=sprintf('%s_temp_%d.png',fname,i);
        print(myfig,'-dpng','-r600',dstr)
        delete(h1,h2);
    end
    for i=1:length(fvout.time)
        h1=patch('Vertices',[xn,yn],'Cdata',fvout.salinity(nodeinside,i),...
            'Faces',facek,'edgecolor','none','facecolor','interp');
        title(datestr(fvout.time(i)),'fontsize',12,'fontweight','b');
        h2=colorbar('SouthOutside');
        xlabel(h2, 'SSS','fontsize',12,'fontweight','b');
        
        dstr=sprintf('%s_salinity_%d.png',fname,i);
        print(myfig,'-dpng','-r600',dstr)
        delete(h1,h2);
    end
end
