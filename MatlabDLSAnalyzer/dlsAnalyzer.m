function [dFitDLS,a0FitDLS,a1FitDLS,roF,dFitAcNN,acf,lags,deltaT,errRelDLSFit,errAbsDLSFit, ...
    errRelNNFit,errAbsNNFit] = ...
    dlsAnalyzer(tsName,dMin,dStep,dMax,theta,lambda,indref,eta,tcelsius,fs,nt)
%-------------------------------------------------------------------------------
% Version 20171120, Silviu Rei
%
%   The function generates a matrix of DLS time series, fits it using
%   classical Lorentz fitting, finds the roll-off frequency, trains a 
%   NN for DLS fit and fits the data with the NN. Then it evaluates the
%   performance of the classical and NN fit.
optsav=1;
function [t,m,a0,a1]=batchGenTsStepSize(tsName,dMin,dStep,dMax,theta,lambda,indref,eta,tcelsius,fs,nt,optsav);
bS=dMin;
eS=dMax;
sS=dStep;
istep=1;
index1=1;
index2=(eS-bS)/sS+2;
[dFitDLS,a0FitDLS,a1FitDLS,roF] = batchDLSFindA0A1RollOffFrequencySize ...
    (m, bS, eS, sS, index1, index2, istep, fs, theta, lambda, indref, eta, ...
    tcelsius,a0start, a0min, a0max, a1start, a1min, a1max, deltaFit, figType, dispMode, cleanMode);
