function [d,a0,a1, deltaT] = batchDLSFitFindA0A1Theta (mTs, thetain, index1, index2, istep, ...
    fs, pSize, lambda, indref, eta, tcelsius, a0start, a0min, a0max, ...
    a1start, a1min, a1max, dispMode, cleanMode);
%-------------------------------------------------------------------------------
% Version 20171120, Silviu Rei
% function [d,a0,a1, deltaT] = batchDLSFitFindA0A1Theta (mTs, d, index1, index2, istep, ...
%   fs, theta, lambda, indref, eta, tcelsius, a0start, a0min, a0max, ...
%    a1start, a1min, a1max, dispMode, cleanMode);
%	The function generates the fit parameters a0, a1, for a Lorentzian DLS fit of a time series Power
%   spectral density. It works in batch mode, within the size range defined.
%	Input:
%		mTs    		= time series matrix
%       thetain     = theta vector corresponding to the time series matrix
%		index1 		= starting index of the time series files
%		index2 		= end index of the time series files
%       a0, a1      = dls fit parameters (fill intervals)
%       istep       = step for iterating from index1 to index2
%       fs          = acquisition frequency of the time series
%       pSize       = particle size in nm
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
%
%-------------------------------------------------------------------------------
disp('[++] Fit DLS Batch Mode - Size Variant');
control=2;
tip='png';
t0 = clock;
for i=index1:istep:index2
    tic;
    namef = [num2str(thetain(i)) '.ext'];
    namefile = [num2str(thetain(i))];
	disp('[+]------------');
    disp(['[+] Generating file ' namef]);
    temp=mTs(:,i);
    save(namef, 'temp', '-ascii');
	timeScale = [0:(1/fs):((length(temp)-1)/fs)];
    namePlotTs=['ts-theta-',num2str(thetain(i)),'-f-',num2str(fs),...
        '-d-',num2str(pSize),'-lambda-',num2str(lambda),...
        '-indref-',num2str(indref),'-eta-',num2str(eta),...
        '-tcelsius-',num2str(tcelsius)];
	plotTs(namePlotTs, temp, timeScale, 'png');
    %ts = load(namefile);
    %ts = fltr(ts, 16000, 1, 50, 1);
    disp('[+] Calculating Power Spectrum');
    psdts=ps_dls5v2(namefile,fs,6,0,'png',control, dispMode);
    disp('    [-] Power Spectrum Calculation Complete');
    disp('[+] Starting DLS Fit Procedure');
    [d(i),a0(i),a1(i),chi2min,exitflag]=chi2dlslsq3v2(namefile,thetain(i),indref,lambda,tcelsius,eta,a0start,a0min,a0max,a1start,a1min,a1max,control,tip, dispMode);
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
end
saveNameA0=['batchDlsFitFindA0A1D_a0_theta-' num2str(thetain(index1)) '-' num2str(thetain(index2)) '-' num2str(istep) '-' ...
    'lambda-' num2str(lambda) '-'...
    'temp-' num2str(tcelsius) '-'...
    'd-' num2str(pSize) '-'...
    'indref-' num2str(indref) '-'...
    'eta-' num2str(eta) '-'... 
    '_f-' num2str(fs),'.txt'];
saveNameA1=['batchDlsFitFindA0A1D_a1_theta-' num2str(thetain(index1)) '-' num2str(thetain(index2)) '-' num2str(istep) '-' ...
    'lambda-' num2str(lambda) '-'...
    'temp-' num2str(tcelsius) '-'...
    'd-' num2str(pSize) '-'...
    'indref-' num2str(indref) '-'...
    'eta-' num2str(eta) '-'... 
    '_f-' num2str(fs),'.txt'];
saveNameD=['batchDlsFitFindA0A1D_d_theta-' num2str(thetain(index1)) '-' num2str(thetain(index2)) '-' num2str(istep) '-' ...
    'lambda-' num2str(lambda) '-'...
    'temp-' num2str(tcelsius) '-'...
    'd-' num2str(pSize) '-'...
    'indref-' num2str(indref) '-'...
    'eta-' num2str(eta) '-'... 
    '_f-' num2str(fs),'.txt'];
save(saveNameA0,'a0','-ascii');
save(saveNameA1,'a1','-ascii');
save(saveNameD,'d','-ascii');
t1=clock;
deltaT = etime(t1,t0);
[h, m, s] = sec2time(deltaT);
disp(['[+++] Total Duration of Fit DLS = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's']);
%if dispMode == 1
%    figure(6);
%    plot(d);
%end
