function [ppmv] = np2ppmv(np,d,scatteringVolume)
%-------------------------------------------------------------------------------
% Version 20180101, Silviu Rei
% function [ppmv] = np2ppmv(np,d,scatteringVolume)
%	The function returns the number of partices in the scattering volume
%   based on volume concentration input
%	Input:
%       np               = number of particles
%       d                = particle size in nm
%       scatteringVolume = scattering volume in mm3
%	Output:
%       ppmv             = parts per million volume concentration
%	Example:
%
%-------------------------------------------------------------------------------
dm = d*1.e-9;
particleVolume = 4/3*pi*(dm/2)^3;
totalParticleVolume = np*particleVolume;
ppmv = (totalParticleVolume / (scatteringVolume*1.e-9))*1.e+6;
