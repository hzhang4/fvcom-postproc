function fvout=fvcom_read_ncout(ncsta)

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

varid = netcdf.inqVarID(ncid,'partition');
fvout.partition = netcdf.getVar(ncid,varid);
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
varid = netcdf.inqVarID(ncid,'zeta');
fvout.zeta = netcdf.getVar(ncid,varid);

varid = netcdf.inqVarID(ncid,'u');
fvout.u = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'v');
fvout.v = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'ww');
fvout.ww = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'ua');
fvout.ua = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'va');
fvout.va = netcdf.getVar(ncid,varid);

netcdf.close(ncid);
