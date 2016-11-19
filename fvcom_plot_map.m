function fvcom_plot_map(fvout,fname,latlim,lonlim)

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
    [xc,yc] = feval(mstruct.mapprojection, mstruct,fvout.latc, fvout.lonc, 'geopoint','forward');
    
    h1=patch('Vertices',[xn,yn],'Cdata',fvout.h,'Faces',fvout.nv,'edgecolor','none','facecolor','interp');
    h2=patch('Vertices',[xn,yn],'Faces',fvout.nv,'edgecolor',[0.4,0.4,0.4],'linewidth',0.2,'facecolor','none');
    
    dstr=sprintf('%s_mesh.png',fname);
    print(myfig,'-dpng','-r600',dstr)
    delete(h1,h2);
    
    for i=1:length(fvout.time)
        h1=patch('Vertices',[xn,yn],'Cdata',fvout.zeta(:,i),...
            'Faces',fvout.nv,'edgecolor','none','facecolor','interp');
        
        h2=quiver(xc,yc,fvout.ua(:,i),fvout.va(:,i),0.5,'k');
        title(datestr(fvout.time(i)),'fontsize',12,'fontweight','b');
        
        dstr=sprintf('%s_hydro_%d.png',fname,i);
        print(myfig,'-dpng','-r600',dstr)
        
        delete(h1,h2);
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
    [xc,yc] = feval(mstruct.mapprojection, mstruct,...
        fvout.latc(eleinside), fvout.lonc(eleinside), 'geopoint','forward');
    
    % convert from FEM node number to clipped node number
    for i=1:length(facek)
        for j=1:3
            facek(i,j)=find(node_id==facek(i,j));
        end
    end
    
    h1=patch('Vertices',[xn,yn],'Cdata',fvout.h(nodeinside),'Faces',facek,'edgecolor','none','facecolor','interp');
    h2=patch('Vertices',[xn,yn],'Faces',facek,'edgecolor',[0.4,0.4,0.4],'linewidth',0.2,'facecolor','none');
    
    dstr=sprintf('%s_mesh.png',fname);
    print(myfig,'-dpng','-r600',dstr)
    delete(h1,h2);
    
    for i=1:length(fvout.time)
        h1=patch('Vertices',[xn,yn],'Cdata',fvout.zeta(nodeinside,i),...
            'Faces',facek,'edgecolor','none','facecolor','interp');
        h2=quiver(xc,yc,fvout.ua(eleinside,i),fvout.va(eleinside,i),0.5,'k');
        title(datestr(fvout.time(i)),'fontsize',12,'fontweight','b');
        
        dstr=sprintf('%s_hydro_%d.png',fname,i);
        print(myfig,'-dpng','-r600',dstr)
        delete(h1,h2);
    end
end
