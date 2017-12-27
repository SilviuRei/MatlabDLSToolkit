function [d, vst, vth] = vStokesVSBrownian (solvent,roMaterial,i1,i2,istep,t)

kb=1.3806505e-23;
iMax = (i2-i1)/istep+1;
d=i1:istep:i2;
r=d./2*1.e-9;
vst=zeros(1,iMax);
vth=zeros(1,iMax);
if strcmp(solvent,'water')
    for i=1:iMax
        vst(i)=vstokes(r(i), roMaterial, water_density(t), water_viscosity(t));
        volume=4/3*pi*r(i)^3;
        mass=volume*roMaterial;
        vth(i)=((3*kb*(t+273.15))/mass)^0.5;
    end
elseif strcmp(solvent,'air')
     for i=1:iMax
        vst(i)=vstokes(r(i), roMaterial, air_density(t,50,101325), air_viscosity(t));
        volume=4/3*pi*r(i)^3;
        mass=volume*roMaterial;
        vth(i)=((3*kb*(t+273.15))/mass)^0.5;
    end  
end

figure(1);
plot(d,vst, 'b');
title('Stokes Velocity (m/s)');
xlabel('Particle Size (nm)');
ylabel('Velocity (m/s)');
figure(2)
plot(d,vth, 'r');
title('Thermal Velocity (m/s)');
xlabel('Particle Size (nm)');
ylabel('Velocity (m/s)');
figure(3);
plot(d,abs(vst), 'b');
title('Stokes Velocity vs. Thermal Velocity');
xlabel('Particle Size (nm)');
ylabel('Velocity (m/s)');
hold on;
plot(d,abs(vth), 'r');
legend('Stokes Velocity', 'Thermal Velocity');
%msgbox('Complete');
hold off;