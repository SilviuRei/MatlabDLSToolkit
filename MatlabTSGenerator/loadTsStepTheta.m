function [t,x,a0,a1]=loadTsStepTheta(tsName,diam,thetaMin,thetaStep,thetaMax,lambda,indref,eta,tcelsius,fs,nt,optsav);
%-------------------------------------------------------------------------------
% Version 20171118, Silviu Rei based on load_ts36 by Dan Chicea
% [a,d]=load_ts37(nume,dmin,pas,dmax,theta,lambda,indref,eta,tcelsius,fs,nt,optsav);
% 
%   The function generates time series for DLS for various sizes, within
%   the defined range.
%
%	Input:
%       tsName      = name of the time series
%       diam        = diameter of particles in nm
%       thetamin    = minimum measuring angle in RAD
%       thetastep   = step measuring angle in RAD
%       thetamax    = maximum measuring angle in RAD
%       lambda      = laser wavelength in nm
%       indref      = refractive index of the solvent
%       eta         = viscosity of the solvent
%       tcelsiuis   = celsius temperature
%       fs          = acquisition frequency
%       nt          = number of samples in the series
%       optsav      = if 1 save the time series in separate files for a0,a1,ts
%	Output:
%       t           = time axis of the time series
%       x           = time series
%       a0, a1      = Lorentz parameters       
%	Example:
%		[a,d]=load_ts37('water',100,100,1000,theta,lambda,indref,eta,tcelsius,16000,32768,1);
%-------------------------------------------------------------------------------%
% Original Comment of Dan Chicea
% functia incarca matricea cu serii temporale, cate o serie pe cate o
% coloana, cate o coloana pentru fiecare diametru
% seriile sunt genreate cu gents36
% 
% Daca opt este >=1 va scrie si fisierul cu matricea, ascii, pe disc, cu
% extensia ext si fisierul cu valorile diametrelor, a0 si a1 pentru fiecare
% serie
%
disp('[+++] DLS Time Series Generator Started');
t1=clock;
nSteps=(thetaMax-thetaMin)/thetaStep;
theta=zeros(1,nSteps);
x=zeros(nt,nSteps);
a0=zeros(nSteps,1);
a1=zeros(nSteps,1);
i=0;
for thetaTemp=thetaMin:thetaStep:thetaMax
    tic
    i=i+1;
    theta(i)=thetaTemp;
    [t,x(:,i),a0(i,1),a1(i,1)]=gents37(tsName, diam, theta(i), lambda, indref, eta, tcelsius, fs, nt, 0);
    deltaT=toc;
    timeLeft=(nSteps-i)*deltaT;
    [h, m, s] = sec2time(timeLeft);
    disp(['[+++] Step: ' num2str(i) ' 	out of ' num2str(nSteps) ', Time Left = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's']);
end
if optsav >= 1 % vrea scris fisierul psd pe disc
    save([tsName,'-',num2str(thetaMin),'-',num2str(thetaStep),'-',num2str(thetaMax),'_ts.ext'],'x','-ascii');
    save([tsName,'-',num2str(thetaMin),'-',num2str(thetaStep),'-',num2str(thetaMax),'_theta.txt'],'theta','-ascii');
    save([tsName,'-',num2str(thetaMin),'-',num2str(thetaStep),'-',num2str(thetaMax),'_a0.txt'],'a0','-ascii');
    save([tsName,'-',num2str(thetaMin),'-',num2str(thetaStep),'-',num2str(thetaMax),'_a1.txt'],'a1','-ascii');
end
t2=etime(clock,t1);
[h, m, s] = sec2time(t2);
disp(['[+++] Total Execution Time for ' int2str(nSteps) ' diameters is: ' num2str(h) 'h:' num2str(m) 'm:' num2str(s) 's'])