function fvout=fvcom_tidal_harmonic(fvout,cnstit)

subname = 'fvcom_tidal_harmonic';

global ftbverbose
if ftbverbose
    fprintf('\nbegin : %s\n', subname)
end

% Tidal Elevation Harmonic Analysis
wet_nodes = (sum(fvout.wet_nodes,2)==fvout.ntime) & (std(fvout.zeta,0,2)>0);
node_id=find(wet_nodes); % node id in the original mesh

fvout.tideh = ut_solv (fvout.time,fvout.zeta(node_id,:)', [], mean(fvout.lat), cnstit, 'OLS', 'White', 'LinCI');
fvout.tidenode=node_id;

wet_cells = (sum(fvout.wet_cells,2)==fvout.ntime) & (std(fvout.ua,0,2)>0)& (std(fvout.va,0,2)>0);
cell_id=find(wet_cells); % node id in the original mesh
fvout.tideuv = ut_solv (fvout.time, fvout.ua(cell_id,:)', fvout.va(cell_id,:)',mean(fvout.latc), cnstit, 'OLS', 'White', 'LinCI');
fvout.tidecell=cell_id;

