function run_gents37(nume, dmin, pas, dmax, theta, lambda, indref, eta, tcelsius, fs, nt, opt)
%-------------------------------------------------------------------------------
% Version 20171118, Silviu Rei based on run_gents36 by Dan Chicea
% run_gents37(nume, dmin, pas, dmax, theta, lambda, indref, tcelsius, fs, nt, opt)
% 
%   The function generates time series for DLS
%	Input:
%       nume        = name of the TS
%       dmin        = minimum diameter of particles in nm
%       pas         = step size in nm
%       dmax        = maximum diameter of particles in nm
%       theta       = measuring ange in RAD
%       lambda      = laser wavelength in nm
%       indref      = refractive index of the solvent
%       eta         = solvent viscosity
%       fs          = acquisition frequency
%       nt          = number of samples in the series
%       opt         = if 1 save the time series in a file
%	Output:
%	Example:
%		run_gents37('water',5,5,1500, theta, lambda, indref, eta, tcelsius, 16000, 32768, 1);
%-------------------------------------------------------------------------------
% Original Dan Chicea Comments:
%%

% functia genereaza un set de serii temporale pornind de la dmin, cu pasul
% pas panala dmax, toate un nm
% salveaza si fisierrul cu valorile a0 si a1 pentru fiecare diametru
%-------------------------------------------------------------------------------

i=0;
for diam=dmin:pas:dmax
    i=i+1;
    d(i)=diam;
    [t,x,a0(i),a1(i)]=gents37(nume, diam, theta, lambda, indref, eta, tcelsius, fs, nt, opt);
end
rez=[d',a0',a1'];
save([nume,'-diam-a0-a1-gents37.txt'],'rez','-ascii')
%
