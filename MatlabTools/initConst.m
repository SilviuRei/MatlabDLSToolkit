function [indref,lambda,eta,tcelsius,theta,diam,a0start,a0min,a0max,a1start,a1min,a1max]= ... 
    initConst(thetagrade, tcelsius, solvent)
%-------------------------------------------------------------------------------
% Version 20171119, Silviu Rei based on initconst4 by Dan Chicea
% function [indref,lambda,eta,tcelsius,theta,diam,a0start,a0min,a0max,a1start,a1min,a1max]= initConst(thetagrade, tcelsius, solvent)
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
%       a0,a1       = DLS fit parameters
%	Example:
%		[indref,lambda,eta,tcelsius,theta,diam,a0start,a0min,a0max,a1start,a1min,a1max]=
%		initConst(90, 20, 'water');
%-------------------------------------------------------------------------------
if strcmp(solvent,'air')
    indref=1.0003;%air
    eta=air_viscosity(tcelsius); %air
end
if strcmp(solvent,'water')
    indref=1.333;%water
    eta=water_viscosity(tcelsius);  %water
end
    
lambda=633;
theta=thetagrade*pi/180;
diam=5;

a0start=10;
a0min=1.e-5;
a0max=1.e8;
a1start=10;
a1min=0.001;
a1max=130000;

rand('twister',10000*abs(cputime)); %initializeaza seria de numere aleatoare
