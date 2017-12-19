function [indref,lambda,eta,tcelsius,theta,diam]=initconst5(thetagrade, tcelsius)
%-------------------------------------------------------------------------------
% Version 20171118, Silviu Rei based on initconst4 by Dan Chicea
% function [indref,lambda,tcelsius,theta]=initconst5(thetagrade)
% 
%   The function initializes the physical constants to be used
%   with DLS time series generator
%	Input:
%       thetagrade  = measuring angle in degrees
%	Output:
%		indref      = refractive index of the solvent
%       lambda      = wavelength of the laser light
%       tcelsius    = temperature in Celsius
%       theta       = measuring angle in radian
%       diam        = particle size in nm
%       
%	Example:
%		[indref,lambda,tcelsius,theta]=initconst5(90);
%-------------------------------------------------------------------------------
indref=1.0003;%air
%indref=1.333;%water
eta=1.8369247E-5; %air viscosity at 20C
%eta=water_viscosity(tcelsius);  % vascozitate apei, in daP
lambda=633;
%tcelsius=20;
theta=thetagrade*pi/180;
diam=5;
rand('twister',10000*abs(cputime)); %initializeaza seria de numere aleatoare
%
