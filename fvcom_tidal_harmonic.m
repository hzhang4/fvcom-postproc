function fvout=fvcom_tidal_harmonic(fvout,cnstit)

subname = 'fvcom_tidal_harmonic';

global ftbverbose
if ftbverbose
    fprintf('\nbegin : %s\n', subname)
end

% Tidal Elevation Harmonic Analysis
% remove dry nodes
ti=sum(fvout.wet_nodes(fvout.tidenode,:),2)==fvout.ntime;
fvout.tidenode=fvout.tidenode(ti);

% remove nodes with invalid elevation
ti=std(fvout.zeta(fvout.tidenode,:),0,2)>1e-8;
fvout.tidenode=fvout.tidenode(ti);

fvout.tideh = ut_solv (fvout.time,fvout.zeta(fvout.tidenode,:)', [], ...
    fvout.lat(fvout.tidenode)', cnstit, 'OLS', 'White', 'LinCI');

% remove cells with invalid elevation
ti=sum(fvout.wet_cells(fvout.tidecell,:),2)==fvout.ntime;
fvout.tidecell=fvout.tidecell(ti);

% remove cells with invalid elevation
ti= (std(fvout.ua(fvout.tidecell,:),0,2)>1e-8) & (std(fvout.va(fvout.tidecell,:),0,2)>1e-8);
fvout.tidecell=fvout.tidecell(ti);

fvout.tideuv = ut_solv (fvout.time, fvout.ua(fvout.tidecell,:)',...
    fvout.va(fvout.tidecell,:)',fvout.latc(fvout.tidecell)', cnstit, 'OLS', 'White', 'LinCI');

