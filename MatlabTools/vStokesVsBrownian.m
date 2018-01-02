function [d, vst, vth, de] = vStokesVsBrownian (solvent,roMaterial,d1,d2,dstep,t,dispMode,saveMode)
%-------------------------------------------------------------------------------
% Version 20180101, Silviu Rei
% [d, vst, vth, de] = vStokesVsBrownian (solvent,roMaterial,d1,d2,dstep,t,dispMode,saveMode)
%	The function plots and saves the Stokes vs Brownian velocity for particles in a fluid
%	Input:
%		solvent 	= string seecting the solvent. Implemented: 'water', 'air'
%		roMaterial 	= density of material in kg/m3
%		d1,d2,dstep	= particle size range in nm
%		t 		= temperature in Celsius
%		dispMode	= if 1, display plots
%		saveMode	= if 1, save plots and data
%	Output:
%		d	 	= particle size vector (nm)
%		vst 		= Stokes velocity vector (m/s)
% 		vth 		= Brownian/thermal velocity vector  (m/s)
%		de 		= particle size at which vst = vth
%	Example:
%		[d, vst, vth, de] = vStokesVsBrownian ('water',1200,1,10000,1,20,1,1);	
%-------------------------------------------------------------------------------



figType = 'png';
kb=1.3806505e-23;
Tabs = t+273.15;
iMax = (d2-d1)/step+1;
d=d1:dstep:d2;
r=d./2*1.e-9;
vst=zeros(1,iMax);
vth=zeros(1,iMax);
debugDiff=zeros(1,iMax);

scanName = ['Solvent-' solvent '_ro-' num2str(roMaterial) '_size-' ...
    num2str(d1) '-' num2str(dstep) '-' num2str(d2) '_t-' num2str(t)];
disp(['[+++] Stokes vs. Brownian Scan Started for ' scanName]);

if strcmp(solvent,'water')
    for i=1:iMax
        vst(i)=vstokes(r(i), roMaterial, water_density(t), water_viscosity(t));
        volume=4/3*pi*r(i)^3;
        vth(i)=vtermic(volume, roMaterial, Tabs);
    end
elseif strcmp(solvent,'air')
     for i=1:iMax
        vst(i)=vstokes(r(i), roMaterial, air_density(t,50,101325), air_viscosity(t));
        volume=4/3*pi*r(i)^3;
        vth(i)=vtermic(volume,roMaterial, Tabs);
    end  
end
flagFound=0;
debugDiff(1)=abs(vst(1))-abs(vth(1));
for i=2:iMax
    debugDiff(i) = abs(vst(i))-abs(vth(i));
    debugDiffDelta=debugDiff(i)*debugDiff(i-1);
    if debugDiffDelta < 0
        disp(['[-] Equality point found at ' num2str(d(i-1)) ' nm']);
        epi=i;
        de=d(i-1);
        flagFound = 1;
        break
    end
end
if flagFound==0
    de=0;
    disp('[-] Equality point not found');
end
if saveMode==1
    save(['d_' scanName '.txt'],'d','-ascii');
    disp(['   [+] File Saved: d_' scanName '.txt']);
    save(['vst_' scanName '.txt'],'vst','-ascii');
    disp(['   [+] File Saved: vst_' scanName '.txt']);
    save(['vth_' scanName '.txt'],'vth','-ascii');
    disp(['   [+] File Saved: vth_' scanName '.txt']);
    save(['de_' scanName '.txt'],'de','-ascii');
    disp(['   [+] File Saved: de_' scanName '.txt']);
end

if dispMode == 1
    figNumber=figure;
elseif dispMode == 0
    figNumber=figure('visible','off');
end
plot(d,vst, 'b');
title('Stokes Velocity (m/s)');
xlabel('Particle Size (nm)');
ylabel('Velocity (m/s)');

if saveMode==1
    figureName=['plot_vst_' scanName];
    saveas(figNumber,figureName,figType);
    disp(['   [+] Figure Saved: ' figureName]);
end

if dispMode == 1
    figNumber=figure;
elseif dispMode == 0
    figNumber=figure('visible','off');
end
plot(d,vth, 'r');
title('Thermal Velocity (m/s)');
xlabel('Particle Size (nm)');
ylabel('Velocity (m/s)');

if saveMode==1
    figureName=['plot_vth_' scanName];
    saveas(figNumber,figureName,figType);
    disp(['   [+] Figure Saved: ' figureName]);
end

if dispMode == 1
    figNumber=figure;
elseif dispMode == 0
    figNumber=figure('visible','off');
end
plot(d,abs(vst), 'b');
title('Stokes Velocity vs. Thermal Velocity');
xlabel('Particle Size (nm)');
ylabel('Velocity (m/s)');
hold on;
plot(d,abs(vth), 'r');
pslim=get(gca,'ylim');
plot([de, de], pslim, 'b--');
legend('Stokes Velocity', 'Thermal Velocity', 'Equilibrium Point');
%msgbox('Complete');
hold off;

if saveMode==1
    figureName=['plot_vstVsvth_' scanName];
    saveas(figNumber,figureName,figType);
    disp(['   [+] Figure Saved: ' figureName]);
end

disp('[+++] Stokes vs. Brownian Scan Complete');