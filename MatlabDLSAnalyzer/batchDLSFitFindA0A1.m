function [d,a0,a1, deltaT] = batchDLSFitFindA0A1 (mTs, index1, index2, istep, frequency, theta, lambda, indref, eta, tcelsius, dispMode, cleanMode);
%-------------------------------------------------------------------------------
% Version 20171117, Silviu Rei
% function [d, a0, a1, deltaT] = batchDLSFitFindA0A1 (mTs, index1, index2, istep, frequency dispMode, cleanMode)
%	The function generates the fit parameters a0, a1, for a Lorentzian DLS fit of a time series Power
%   spectral density.
%	Input:
%		mTs    		= time series matrix
%		index1 		= starting index of the time series files
%		index2 		= end index of the time series files
%       istep       = step for iterating from index1 to index2
%       frequency   = acquisition frequency of the time series
%       theta       = measuring ange in RAD
%       lambda      = laser wavelength in nm
%       indref      = refractive index of the solvent
%       eta         = viscosity of the solvent
%       tcelsiuis   = celsius temperature
%		dispMode 	= display mode (0=no detailed messages, 1=detailed messages)
%		cleanMode 	= delete temp files (0=no, 1=yes)
%	Output:
%		d 			= diameter vector
%       a0          = a0 Lorentzian fitting parameter
%       a1          = a1 Lorentzian fitting parameter
%		deltaT 		= total time duration of the procedure
%	Example:
%		[d,a0,a1, deltaT] = batchDLSFitFindA0A1 (m, 100, 3000, 100, 16000, 0, 1);
%-------------------------------------------------------------------------------
disp('[++] Fit DLS Batch Mode');
n1=index1;
n2=index2;
%pas=1;
%teta=pi/2;
%indref=1.33;%water
%indref=1.003;%air
%lambda=633.e-9;
%tcelsius=20;
%eta=1.8369247E-5; %for air at 20C
%eta=water_viscosity(tcelsius); %for water at 20C
a0start=10;
a0min=1.e-5;
a0max=1.e8;
a1start=10;
a1min=0.001;
a1max=130000;
control=2;
tip='png';
text2='';
%text1=name;
t0 = clock;

for i=index1:istep:index2
    tic;
    namef = [num2str(i) '.ext'];
    namefile = [num2str(i)];
	disp('[+]------------');
    disp(['[+] Generating file ' namef]);
    temp=mTs(:,i);
    save(namef, 'temp', '-ascii');
	timeScale = [0:(1/frequency):((length(temp)-1)/frequency)];
	plotTs(num2str(i), temp, timeScale, 'png');
    %ts = load(namefile);
    %ts = fltr(ts, 16000, 1, 50, 1);
    disp('[+] Calculating Power Spectrum');
    psdts=ps_dls5v2(namefile,frequency,6,0,'png',control, dispMode);
    disp('    [-] Power Spectrum Calculation Complete');
    disp('[+] Starting DLS Fit Procedure');
    [d(i),a0(i),a1(i),chi2min,exitflag]=chi2dlslsq3v2(namefile,theta,indref,lambda,tcelsius,eta,a0start,a0min,a0max,a1start,a1min,a1max,control,tip, dispMode);
    d(i) = d(i)*1e9;
    disp('    [-] DLS Fit Procedure Complete');
    disp(['        [-] Diameter = ' num2str(d(i)) ' nanometers']);
    deltat = toc;
    timeLeft = deltat*(index2-i);
    [h, m, s] = sec2time(timeLeft);
    disp(['[+++] Time Left = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's']);
    %disp(['[+] Time left=' num2str(deltat*(index2-i)) ' seconds']);
    if cleanMode == 1    
        delete('*.ext');
        delete('*.fps');
        delete('*.rez');
    end
    save('a0.txt','a0','-ascii');
    save('a1.txt','a1','-ascii');
end
t1=clock;
deltaT = etime(t1,t0);
[h, m, s] = sec2time(deltaT);
disp(['[+++] Total Duration of Fit DLS = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's']);
if dispMode == 1
    figure(6);
    plot(d);
end
