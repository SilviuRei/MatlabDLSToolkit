function [t,x,a0,a1]=batchGenTsStepLambda(tsName,diam,theta,lambdaMin,lambdaStep,lambdaMax,indref,eta,tcelsius,fs,nt,optsav);
%-------------------------------------------------------------------------------
% Version 20171119, Silviu Rei based on load_ts36 by Dan Chicea
% function [t,x,a0,a1]=batchGenTsStepLambda(tsName,diam,theta,lambdaMin,lambdaStep,lambdaMax,indref,eta,tcelsius,fs,nt,optsav);
% 
%   The function generates time series for DLS for various lambda, within
%   the defined range.
%
%	Input:
%       tsName      = name of the time series
%       diam        = diameter of particles in nm
%       theta       = measuring angle in RAD
%       lambdaMin   = minimum laser wavelength in nm
%       lambdaStep  = step for laser wavelength in nm
%       lambdaMax   = maximum laser wavelength in nm
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
%       [t,x,a0,a1]=batchGenTsStepLambda('test_lambda',diam,theta,200,100,800,indref,eta,tcelsius,2000,4000,1);%-------------------------------------------------------------------------------%
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
nSteps=(lambdaMax-lambdaMin)/lambdaStep;
lambda=zeros(1,nSteps);
x=zeros(nt,nSteps);
a0=zeros(nSteps,1);
a1=zeros(nSteps,1);
i=0;
for lambdaTemp=lambdaMin:lambdaStep:lambdaMax
    tic
    i=i+1;
    lambda(i)=lambdaTemp;
    [t,x(:,i),a0(i,1),a1(i,1)]=gents37(tsName, diam, theta, lambda(i), indref, eta, tcelsius, fs, nt, 0);
    deltaT=toc;
    timeLeft=(nSteps-i+1)*deltaT;
    [h, m, s] = sec2time(timeLeft);
    disp(['[+++] Step: ' num2str(i) ' 	out of ' num2str(nSteps) ', Time Left = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's']);
end
if optsav >= 1 % vrea scris fisierul psd pe disc
    save([tsName,'-',num2str(lambdaMin),'-',num2str(lambdaStep),'-',num2str(lambdaMax),'_ts.ext'],'x','-ascii');
    save([tsName,'-',num2str(lambdaMin),'-',num2str(lambdaStep),'-',num2str(lambdaMax),'_lambda.txt'],'lambda','-ascii');
    save([tsName,'-',num2str(lambdaMin),'-',num2str(lambdaStep),'-',num2str(lambdaMax),'_a0.txt'],'a0','-ascii');
    save([tsName,'-',num2str(lambdaMin),'-',num2str(lambdaStep),'-',num2str(lambdaMax),'_a1.txt'],'a1','-ascii');
end
t2=etime(clock,t1);
[h, m, s] = sec2time(t2);
disp(['[+++] Total Execution Time for ' int2str(nSteps) ' diameters is: ' num2str(h) 'h:' num2str(m) 'm:' num2str(s) 's'])