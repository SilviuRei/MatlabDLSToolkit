function [dFitDLS,a0FitDLS,a1FitDLS,roF] = batchDLSFindA0A1RollOffFrequencySize (mTS, bS, eS, sS, index1, index2, istep, fs, theta, lambda, indref, eta, tcelsius,a0start, a0min, a0max, a1start, a1min, a1max, deltaFit, figType, dispMode, cleanMode)
%-------------------------------------------------------------------------------
% Version 20171119, Silviu Rei
% function [roF] = batchDLSFindA0A1RollOffFrequencySize (a0, a1, d, index1, index2, istep, fs, deltaFit, figType, dispMode)
%   The function finds the roll-off Frequency from the Power Spectral
%   Density for a Dynamic Light Scattering Lorentzian function
%   in batch mode, looping for size in the defined range
%	Input:
%       mTs           = DLS time series matrix
%       bS,eS       = beginning and end size of the TS matrix
%       sS          = step size of the TS matrix
%       a0,a1       = Lorentz function parameters (vectors)
%       d           = particle sizes vector
%       index1      = start index
%       index2      = end index
%       istep       = index step
%       fs          = acquisition frequency in Hz
%       theta       = measuring ange in RAD
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
%	Example:
%		[d,a0,a1,roF] = batchDLSFindA0A1RollOffFrequencySize (x, 5, 30, 5, 1, 6, 1, 16000, theta, lambda, indref, eta, tcelsius,a0start, a0min, a0max, a1start, a1min, a1max, 20, 'png', 0, 1)
%-------------------------------------------------------------------------------
dm = bS:sS:eS;
[dFitDLS,a0FitDLS,a1FitDLS,~] = batchDLSFitFindA0A1Size(mTS, dm, index1, index2, istep, fs, theta, lambda, indref, eta, tcelsius, a0start, a0min, a0max, a1start, a1min, a1max,dispMode, cleanMode);
%[mrows,mcolumns] = size(m); 
roF = batchDLSRollOffFrequencySize(a0FitDLS, a1FitDLS, bS, eS, bS, lambda,tcelsius,theta,indref,eta,fs, deltaFit, figType, dispMode);
