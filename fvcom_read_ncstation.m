function fvout=fvcom_read_ncstation(ncfile,fvout)

ncid = netcdf.open(ncfile,'NC_NOWRITE');

dimid = netcdf.inqDimID(ncid,'siglay');
[~,fvout.sta.nsig] = netcdf.inqDim(ncid,dimid);
dimid = netcdf.inqDimID(ncid,'station');
[~,fvout.sta.nsta] = netcdf.inqDim(ncid,dimid);
dimid = netcdf.inqDimID(ncid,'time');
[~,fvout.sta.ntime] = netcdf.inqDim(ncid,dimid);
varid = netcdf.inqVarID(ncid,'name_station');
fvout.sta.name = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'time');
fvout.sta.time = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'siglay');
fvout.sta.siglay = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'siglev');
fvout.sta.siglev = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'h');
fvout.sta.h = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'u');
fvout.sta.u = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'v');
fvout.sta.v = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'ww');
fvout.sta.ww = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'ua');
fvout.sta.ua = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'va');
fvout.sta.va = netcdf.getVar(ncid,varid);
varid = netcdf.inqVarID(ncid,'zeta');
fvout.sta.zeta = netcdf.getVar(ncid,varid);

netcdf.close(ncid);

fvout.sta.time=double(fvout.sta.time)+datenum('1899-12-30');

for i=1:fvout.sta.nsta
    fvout.sta.title{i}=strtrim(fvout.sta.name(:,i)');
end
