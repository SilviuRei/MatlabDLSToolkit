function [dMin,dMax,dStep,indref,lambda,eta,tcelsius,theta,pSize,a0start,a0min,a0max,a1start,a1min,a1max,fs,nt,nnHidden,autocorrLags,trainNNFlag,deltaFit]=initConst(dMin,dStep,dMax,thetagrade,tcelsius,pSize,lambda,solvent,fs,nt, nnHidden,autocorrLags,trainNNFlag,deltaFit)
%-------------------------------------------------------------------------------
% Version 20180101, Silviu Rei based on initconst4 by Dan Chicea
% function [dMin,dMax,dStep,indref,lambda,eta,tcelsius,theta,pSize,...
%	a0start,a0min,a0max,a1start,a1min,a1max,fs,nt,nnHidden,autocorrLags,...
%	trainNNFlag,deltaFit]=initConst(dMin,dStep,dMax,thetagrade,tcelsius,...
%	pSize,lambda,solvent,fs,nt, nnHidden,autocorrLags,trainNNFlag,deltaFit)
%
%   The function initializes the physical constants to be used
%   with DLS time series generator.
%   
%   Input:
%
%
%   Output:
%	indref      = refractive index of the solvent
%       lambda      = wavelength of the laser light
%       eta         = viscosity in N m/s2
%       tcelsius    = temperature in Celsius
%       theta       = measuring angle in radian
%       diam        = particle size in nm
%       a0,a1       = DLS fit parameters
%       fs          = acquisition frequency
%       nt          = number of samples in the series
%       nnHidden    = number of neurons in the hidden layer
%       autocorrLags= number of lags in the autocorrelation function
%   Example:
%       
%-------------------------------------------------------------------------------
if strcmp(solvent,'air')
    indref=air_indref(lambda,tcelsius,101.325,50,'edlen',1000);%indref=1.0003;%air@20C
    eta=air_viscosity(tcelsius); %air
end
if strcmp(solvent,'water')
    indref = water_indref(tcelsius, 1000, lambda);%indref=1.333;%water@20C
    eta=water_viscosity(tcelsius);  %water
end
    
theta=thetagrade*pi/180;

a0start=10;
a0min=1.e-5;
a0max=1.e8;
a1start=10;
a1min=0.001;
a1max=130000;

rand('twister',10000*abs(cputime)); %initializeaza seria de numere aleatoare
