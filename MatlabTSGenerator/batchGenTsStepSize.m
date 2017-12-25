function [t,x,a0,a1]=batchGenTsStepSize(tsName,dMin,dStep,dMax,theta,lambda,indref,eta,tcelsius,fs,nt,optsav);
%--------------------------------------------------------------------------
% Version 20171225, Silviu Rei based on load_ts36 by Dan Chicea
% [t,x,a0,a1]=batchGenTsStepSize(tsName,dMin,dStep,dMax,theta,lambda,indref,eta,tcelsius,fs,nt,optsav);
% 
%   The function generates time series for DLS for various sizes, within
%   the defined range.
%
%	Input:
%       tsName      = name of the time series
%       dMin        = minimum diameter of particles in nm
%       dStep       = step size
%       dMax        = maximum diameter of particles in nm
%       theta       = measuring ange in RAD
%       lambda      = laser wavelength in nm
%       indref      = refractive index of the solvent
%       eta         = viscosity of the solvent
%       tcelsiuis   = celsius temperature
%       fs          = acquisition frequency
%       nt          = number of samples in the series
%       optsav      = if 1, save the time series in separate files for a0,a1,ts
%	Output:
%       t           = time axis of the time series
%       m           = time series
%       a0, a1      = Lorentz parameters       
%	Example:
%		[t,m,a0,a1]=batchGenTsStepDSize('test',5,5,30,theta,lambda,indref,eta,tcelsius,100,200,1);
%--------------------------------------------------------------------------
% Original Comment of Dan Chicea
% functia incarca matricea cu serii temporale, cate o serie pe cate o
% coloana, cate o coloana pentru fiecare diametru
% seriile sunt genreate cu gents36
% 
% Daca opt este >=1 va scrie si fisierul cu matricea, ascii, pe disc, cu
% extensia ext si fisierul cu valorile diametrelor, a0 si a1 pentru fiecare
% serie
%--------------------------------------------------------------------------
disp('---------------------------------------------------------------------');
disp('[+++] DLS Time Series Generator Started - Size Step Variant');
disp(['   [+] Generating Time Series ' ...
        ,'d-',num2str(dMin),'-',num2str(dStep),'-',num2str(dMax), ...
        '-theta-',num2str(theta), ...
        '-lambda-',num2str(lambda),...
        '-indref-',num2str(indref),...
        '-eta-',num2str(eta),...
        '-tcelsius-',num2str(tcelsius),...
        '-fs-',num2str(fs),...
        '-nt-',num2str(nt)]);
t1=clock;
nSteps=(dMax-dMin)/dStep+1;
d=zeros(1,nSteps);
m=zeros(nt,nSteps);
a0=zeros(nSteps,1);
a1=zeros(nSteps,1);
i=1;
h=999;
m=999;
s=999;
waitbarHandle = waitbar(0,['Generating Time Series...' ...
        newline 'Step:'  ...
        newline 'Time Left =' ...
        newline 'Progress: 0%']);
for dd=dMin:dStep:dMax
    tic
    disp(['[+++] Step: ' num2str(i) ' out of ' num2str(nSteps)  ...
        ', Time Left = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's']);
    waitbar((i-1)/nSteps, waitbarHandle,['Generating Time Series...' ...
        newline 'Step: ' num2str(i) ' out of ' num2str(nSteps)  ...
        newline 'Time Left = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's' ...
        newline 'Progress: ' num2str(100*(i-1)/nSteps) ' %']);
    d(i)=dd;
    [t,x(:,i),a0(i,1),a1(i,1)]=gents37(tsName, d(i), theta, lambda,...
        indref, eta, tcelsius, fs, nt, 0);
    deltaT=toc;
    timeLeft=(nSteps-i+1)*deltaT;
    [h, m, s] = sec2time(timeLeft);
    i=i+1;
end
close(waitbarHandle);
%
%rez=[d',a0,a1]; %le aduna intr-o matrice pt verificare cu fitare
%
if optsav >= 1 % vrea scris fisierul psd pe disc
    fileNameTs = ['ts_' tsName '.txt'];
    save(fileNameTs,'x','-ascii');
    disp(['   [+] File ' fileNameTs ' saved']);
    
    fileNameD = ['d_' tsName '.txt'];
    save(fileNameD,'d','-ascii');
    disp(['   [+] File ' fileNameD ' saved']);
    
    fileNameA0 = ['a0_' tsName '.txt'];
    save(fileNameA0,'a0','-ascii');
    disp(['   [+] File ' fileNameA0 ' saved']);
    
    fileNameA1 = ['a1_' tsName '.txt'];
    save(fileNameA1,'a1','-ascii');
    disp(['   [+] File ' fileNameA1 ' saved']);
end
t2=etime(clock,t1);
[h, m, s] = sec2time(t2);
disp('[+++] DLS Time Series Generator Execution Complete');
disp(['[+++] Total Execution Time for ' int2str(nSteps+1) ... 
    ' diameters is: ' num2str(h) 'h:' num2str(m) 'm:' num2str(s) 's']);