function [np] = ppmv2np(ppmv,d,scatteringVolume)
%-------------------------------------------------------------------------------
% Version 20180101, Silviu Rei
% function [np] = ppmv2np(ppmv,d,scatteringVolume)
%	The function returns the number of partices in the scattering volume
%   based on volume concentration input
%	Input:
%       ppmv             = parts per million volume concentration
%       d                = particle size in nm
%       scatteringVolume = scattering volume in mm3
%	Output:
%       np               = number of particles
%	Example:
%
%-------------------------------------------------------------------------------
dm = d*1.e-9;
ppmvm = ppmv*1.e-6;
particleVolume = 4/3*pi*(dm/2)^3;
totalParticleVolume = ppmvm*scatteringVolume*1.e-9;
np=totalParticleVolume/particleVolume;
