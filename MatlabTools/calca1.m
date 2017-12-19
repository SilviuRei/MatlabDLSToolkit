function [a1]=calca1(diam, tcelsius,unghi_rad, lambda, indref);
%
% functia calculeaza valoare de start a lui a1 functie de diametru, unghi
% si temperatura
%
% apelare [a1]=calca1(130.e-9, 20, atan(2/41), 630.e-9, 1.5);
%
kb=1.3806503e-23;       %constanta lui Boltzman
tkelvin=tcelsius+273.15;    %temperatura absoluta
eta=water_viscosity(tcelsius);
teta=unghi_rad;
kmare=(4*pi*indref*sin(0.5*teta))/lambda;
raza=0.5*diam;
a1=(2*kb*tkelvin*kmare.^2)/(6*pi*eta*raza);
%
