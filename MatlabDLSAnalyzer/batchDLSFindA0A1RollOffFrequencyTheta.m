function [dFitDLS,a0,a1,roF] = batchDLSFindA0A1RollOffFrequencyTheta (m, bT, eT, sT, index1, index2, istep, fs, pSize, lambda, indref, eta, tcelsius,a0start, a0min, a0max, a1start, a1min, a1max, deltaFit, figType, dispMode, cleanMode)
%-------------------------------------------------------------------------------
% Version 20171120, Silviu Rei
% function [d,a0,a1,roF] = batchDLSFindA0A1RollOffFrequencyTheta (m, bT, eT, sT, index1, index2, istep, fs, pSize, lambda, indref, eta, tcelsius,a0start, a0min,a0max, a1start, a1min, a1max, deltaFit, figType, dispMode, cleanMode)
%   The function finds the roll-off Frequency from the Power Spectral
%   Density for a Dynamic Light Scattering Lorentzian function
%   in batch mode, looping for theta in the defined range
%	Input:
%       m           = DLS time series matrix
%       bT,eT       = beginning and end theta of the TS matrix in RAD
%       sT          = step theta of the TS matrix in RAD
%       a0,a1       = Lorentz function parameters (vectors)
%       d           = particle sizes vector
%       index1      = start index
%       index2      = end index
%       istep       = index step
%       fs          = acquisition frequency in Hz
%       pSize       = particle size in nm
%       lambda      = laser wavelength in nm
%       indref      = refractive index of the solvent
%       eta         = viscosity of the solvent
%       tcelsiuis   = celsius temperature
%       deltaFit    = number of linear fitting points
%       figType     = figure type (ex: 'png')
%       dispMode    = if 1 then display graphs
%       cleanMode   = deletes residual files if 1
%	Output:
%		roF         = roll-off frequency in Hz
%       d           = particle size according to Lorentz fitting
%       a0,a1       = Lorentz fitting parameters
%	Example:
%
%-------------------------------------------------------------------------------
thetam = bT:sT:eT;
[dFitDLS,a0,a1,~] = batchDLSFitFindA0A1Theta(m, thetam, index1, index2, istep, fs, pSize, lambda, indref, eta, tcelsius, a0start, a0min, a0max, a1start, a1min, a1max,dispMode, cleanMode);
%[mrows,mcolumns] = size(m); 
roF = batchDLSRollOffFrequencyTheta (a0,a1,bT,eT,sT,lambda,tcelsius,pSize,indref,eta,fs, deltaFit, figType, dispMode);
