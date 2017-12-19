function []=load_ts37(tsName,dmin,pas,dmax,theta,lambda,indref,eta,tcelsius,fs,nt,optsav);
%-------------------------------------------------------------------------------
% Version 20171118, Silviu Rei based on load_ts36 by Dan Chicea
% [a,d]=load_ts37(nume,dmin,pas,dmax,theta,lambda,indref,eta,tcelsius,fs,nt,optsav);
% 
%   The function generates time series for DLS for various sizes, within
%   the defined range.
%
%	Input:
%       tsName      = name of the time series
%       diam        = minimum diameter of particles in nm
%       pas         = step size
%       dmax        = maximum diameter of particles in nm
%       theta       = measuring ange in RAD
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
texpas=0;
nrpasi=(dmax-dmin)/pas;
i=0;
for dd=dmin:pas:dmax
    tic
    i=i+1;
    d(i)=dd;   % trece in vectorul d valoarea curenta
    [t,a(:,i),a0(i,1),a1(i,1)]=gents37(tsName, d(i), theta, lambda, indref, eta, tcelsius, fs, nt, 0);
    texpas=toc;
    timeLeft=(nrpasi-i)*texpas; %timpul aprox ramas
    [h, m, s] = sec2time(timeLeft);
    disp(['[+++] Step: ' num2str(i) ' 	out of ' num2str(nrpasi) ', Time Left = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's']);
end
%
rez=[d',a0,a1]; %le aduna intr-o matrice pt verificare cu fitare
%
if optsav >= 1 % vrea scris fisierul psd pe disc
    save([tsName,'-',int2str(dmin),'-',int2str(pas),'-',int2str(dmax),'_ts_g36.ext'],'a','-ascii')
    save([tsName,'-',int2str(dmin),'-',int2str(pas),'-',int2str(dmax),'_d_g36.txt'],'d','-ascii')
    save([tsName,'-',int2str(dmin),'-',int2str(pas),'-',int2str(dmax),'_d_a0_a1_g36.txt'],'rez','-ascii')
end
t2=etime(clock,t1);
[h, m, s] = sec2time(t2);
disp(['[+++] Total Execution Time for ' int2str(nrpasi) ' diameters is: ' num2str(h) 'h:' num2str(m) 'm:' num2str(s) 's'])
%


