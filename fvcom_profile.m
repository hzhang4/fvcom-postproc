function Xsec=fvcom_profile(fvout,Xsec,varlist)

Xsec.td=sqrt((Xsec.X-Xsec.X(1)).^2+(Xsec.Y-Xsec.Y(1)).^2);

xv=fvout.x(fvout.nv);
yv=fvout.y(fvout.nv);
Xsec.ntime=fvout.ntime;
Xsec.nsiglay=fvout.nsiglay;
Xsec.time=fvout.time;
Xsec.siglay=fvout.siglay(1,:);

for i=1:Xsec.np
    Xsec.ele(i)=-1; % transection point is not in model domain
    px=Xsec.X(i);
    py=Xsec.Y(i);
    
    for j=1:fvout.nele
        if inpolygon(px,py,xv(j,:),yv(j,:))
            Xsec.ele(i)=j;                 % locate cell number of each transection points
            Xsec.node(i,:)=fvout.nv(j,:);
            
            uu=fvout.h(fvout.nv(j,:));
            Xsec.h(i) = mean(uu); %interpolation
            
            uu=fvout.zeta(fvout.nv(j,:),:);
            Xsec.zeta(i,:) = mean(uu,1); %interpolation
            
            Xsec.z(i,:)=Xsec.h(i)*Xsec.siglay;
            for k=1:Xsec.ntime
                Xsec.zz(i,:,k)=(Xsec.h(i)+Xsec.zeta(i,k))*Xsec.siglay;
            end
            
            for aa=1:length(varlist)
                 Xsec.(varlist{aa})(i,:,:)= fvout.(varlist{aa})(j,:,:);
            end
            
            Xsec.u(i,:,:)= fvout.u(j,:,:);
            Xsec.v(i,:,:)= fvout.v(j,:,:);
            Xsec.ww(i,:,:)= fvout.ww(j,:,:);
            Xsec.temp(i,:,:)= fvout.temp(j,:,:);
            Xsec.salinity(i,:,:)= fvout.salinity(j,:,:);
            
            break
        end
    end
end


