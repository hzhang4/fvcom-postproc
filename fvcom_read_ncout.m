function fvout=fvcom_read_ncout(ncsta,varlist)

ncid = netcdf.open(ncsta,'NC_NOWRITE');

dimid = netcdf.inqDimID(ncid,'nele');
[~,fvout.nele] = netcdf.inqDim(ncid,dimid);
dimid = netcdf.inqDimID(ncid,'node');
[~,fvout.nnode] = netcdf.inqDim(ncid,dimid);
dimid = netcdf.inqDimID(ncid,'siglay');
[~,fvout.nsiglay] = netcdf.inqDim(ncid,dimid);
dimid = netcdf.inqDimID(ncid,'siglev');
[~,fvout.nsiglev] = netcdf.inqDim(ncid,dimid);
dimid = netcdf.inqDimID(ncid,'time');
[~,fvout.ntime] = netcdf.inqDim(ncid,dimid);

% varid = netcdf.inqVarID(ncid,'partition');
% fvout.partition = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'x');
fvout.x = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'y');
fvout.y = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'lon');
fvout.lon = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'lat');
fvout.lat = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'xc');
fvout.xc = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'yc');
fvout.yc = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'lonc');
fvout.lonc = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'latc');
fvout.latc = netcdf.getVar(ncid,varid);

varid = netcdf.inqVarID(ncid,'siglay');
fvout.siglay = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'siglev');
fvout.siglev = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'h');
fvout.h = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'nv');
fvout.nv = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'time');
fvout.time = netcdf.getVar(ncid,varid);

for aa=1:length(varlist)
    varid = netcdf.inqVarID(ncid,(varlist{aa}));
    fvout.(varlist{aa}) = netcdf.getVar(ncid,varid);
end

netcdf.close(ncid);
