function [indref,lambda,eta,tcelsius,theta,diam]=initconst5(thetagrade, tcelsius, solvent)
%-------------------------------------------------------------------------------
% Version 20171119, Silviu Rei based on initconst4 by Dan Chicea
% function [indref,lambda,tcelsius,theta]=initconst5(thetagrade)
% 
%   The function initializes the physical constants to be used
%   with DLS time series generator
%	Input:
%       thetagrade  = measuring angle in degrees
%       tcelsius    = temperature in celsius
%       solvent     = 'air' for air, 'water' for water
%	Output:
%		indref      = refractive index of the solvent
%       lambda      = wavelength of the laser light
%       eta         = viscosity in N m/s2
%       tcelsius    = temperature in Celsius
%       theta       = measuring angle in radian
%       diam        = particle size in nm
%       
%	Example:
%		[indref,lambda,eta,tcelsius,theta,diam]=initconst5(90,20);
%-------------------------------------------------------------------------------
if solvent == 'air'
    indref=1.0003;%air
    eta=air_viscosity(tcelsius); %air
else if solvent == 'water'
    indref=1.333;%water
    eta=water_viscosity(tcelsius);  %water
end.
    
lambda=633;
theta=thetagrade*pi/180;
diam=5;
rand('twister',10000*abs(cputime)); %initializeaza seria de numere aleatoare
