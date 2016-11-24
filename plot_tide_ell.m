function plot_tide_ell(x,y,SEMA, SEMI, INC, PHA, SF)
% plot single node tidal ellipse
   ECC = SEMI./SEMA;
   Wp = (1+ECC)/2 .*SEMA; % amplitude for anticlockwise circles
   Wm = (1-ECC)/2 .*SEMA; % amplitude for clockwise circles
   THETAp = INC-PHA; % angle for anticlockwise circles
   THETAm = INC+PHA; % angle for clockwise circles

   %convert degrees into radians
   THETAp = THETAp/180*pi;
   THETAm = THETAm/180*pi;
%    INC = INC/180*pi;
%    PHA = PHA/180*pi;

   %Calculate wp and wm.
   wp = Wp.*exp(1i*THETAp); 
   wm = Wm.*exp(1i*THETAm);
   
   dot = pi/36;
   ot = 0:dot:2*pi;
   a = wp*exp(1i*ot);
   b = wm*exp(-1i*ot);   
   w = SF*(a+b);

%    wmax = SEMA*exp(1i*INC);
%    wmin = SEMI*exp(1i*(INC+pi/2));

   plot(x+real(w), y+imag(w),'r')
