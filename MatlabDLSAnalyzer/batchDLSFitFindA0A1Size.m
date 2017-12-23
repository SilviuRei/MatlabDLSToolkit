function [d,a0,a1, deltaT] = batchDLSFitFindA0A1Size (mTs, din, index1, index2, istep, ...
    fs, theta, lambda, indref, eta, tcelsius, a0start, a0min, a0max, ...
    a1start, a1min, a1max, dispMode, cleanMode);
%-------------------------------------------------------------------------------
% Version 20171119, Silviu Rei
% function [d,a0,a1, deltaT] = batchDLSFitFindA0A1Size (mTs, d, index1, index2, istep, ...
%   frequency, theta, lambda, indref, eta, tcelsius, a0start, a0min, a0max, ...
%    a1start, a1min, a1max, dispMode, cleanMode);
%	The function generates the fit parameters a0, a1, for a Lorentzian DLS fit of a time series Power
%   spectral density. It works in batch mode, within the size range defined.
%	Input:
%		mTs    		= time series matrix
%       din           = size vector corresponding to the time series matrix
%		index1 		= starting index of the time series files
%		index2 		= end index of the time series files
%       a0, a1      = dls fit parameters (fill intervals)
%       istep       = step for iterating from index1 to index2
%       fs          = acquisition frequency of the time series
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
%		[d,a0,a1, deltaT] = batchDLSFitFindA0A1Size (x, 5:5:30, 1, 6, 1,16000, theta, lambda, indref, eta, tcelsius, a0start, a0min, a0max, a1start, a1min, a1max, 0, 1);
%-------------------------------------------------------------------------------
disp('---------------------------------------------------------------------');
disp('[+++] Fit DLS Batch Mode - Size Variant');
disp(['    [+] Using ' 'd-' num2str(din(index1)) '-' num2str(istep) '-' num2str(din(index2)) '-' ...
    'lambda-' num2str(lambda) '-'...
    'temp-' num2str(tcelsius) '-'... 
    'theta-' num2str(theta) '-'...
    'indref-' num2str(indref) '-'...
    'eta-' num2str(eta) '-'... 
    '_f-' num2str(fs)]);
control=2;
tip='png';
t0 = clock;
j=1;
h=999;
m=999;
s=999;
nSteps=(index2-index1)/istep+1;
waitbarHandle = waitbar(0,['DLS Fit...' ...
        newline 'Step:'  ...
        newline 'Time Left =' ...
        newline 'Progress: 0%']);
%set(waitbarHandle, 'WindowStyle','modal');
for i=index1:istep:index2
    tic;
    disp(['[+++] Step ' num2str(j) 'out of ' num2str(nSteps) , ...
        ', Time Left = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's']);
    waitbar((j-1)/nSteps, waitbarHandle,['DLS Fit...' ...
        newline 'Step: ' num2str(j) ' out of ' num2str(nSteps)  ...
        newline 'Time Left = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's' ...
        newline 'Progress: ' num2str(100*(j-1)/nSteps) ' %']);
    namef = [num2str(din(i)) '.ext'];
    namefile = [num2str(din(i))];
	disp('[+]------------');
    disp(['[+] Generating file ' namef]);
    temp=mTs(:,i);
    save(namef, 'temp', '-ascii');
	timeScale = [0:(1/fs):((length(temp)-1)/fs)];
    namePlotTs=['ts-d-',num2str(din(i)),'-f-',num2str(fs),...
        '-theta-',num2str(theta),'-lambda-',num2str(lambda),...
        '-indref-',num2str(indref),'-eta-',num2str(eta),...
        '-tcelsius-',num2str(tcelsius)];
	plotTs(namePlotTs, temp, timeScale, 'png',dispMode);
    %ts = load(namefile);
    %ts = fltr(ts, 16000, 1, 50, 1);
    disp('[+] Calculating Power Spectrum');
    psdts=ps_dls5v2(namefile,fs,6,0,'png',control, dispMode);
    disp('    [-] Power Spectrum Calculation Complete');
    disp('[+] Starting DLS Fit Procedure');
    [d(i),a0(i),a1(i),chi2min,exitflag]=chi2dlslsq3v2(namefile,theta,indref,lambda,tcelsius,eta,a0start,a0min,a0max,a1start,a1min,a1max,control,tip, dispMode);
    d(i) = d(i)*1e9;
    disp('    [-] DLS Fit Procedure Complete');
    disp(['        [-] Diameter = ' num2str(d(i)) ' nanometers']);
    deltat = toc;
    timeLeft = deltat*(nSteps-j);
    [h, m, s] = sec2time(timeLeft);
    %disp(['[+] Time left=' num2str(deltat*(index2-i)) ' seconds']);
    if cleanMode == 1    
        delete('*.ext');
        delete('*.fps');
        delete('*.rez');
    end
    j=j+1;
end
close(waitbarHandle);
t1=clock;
deltaT = etime(t1,t0);
[h, m, s] = sec2time(deltaT);
disp(['[+++] Total Duration of Fit DLS = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's']);

saveNameA0=['batchDlsFitFindA0A1D_a0_d-' num2str(din(index1)) '-' num2str(din(index2)) '-' num2str(istep) '-' ...
    'lambda-' num2str(lambda) '-'...
    'temp-' num2str(tcelsius) '-'...
    'theta-' num2str(theta) '-'...
    'indref-' num2str(indref) '-'...
    'eta-' num2str(eta) '-'... 
    '_f-' num2str(fs),'.txt'];
saveNameA1=['batchDlsFitFindA0A1D_a1_d-' num2str(din(index1)) '-' num2str(din(index2)) '-' num2str(istep) '-' ...
    'lambda-' num2str(lambda) '-'...
    'temp-' num2str(tcelsius) '-'...
    'theta-' num2str(theta) '-'...
    'indref-' num2str(indref) '-'...
    'eta-' num2str(eta) '-'... 
    '_f-' num2str(fs),'.txt'];
saveNameD=['batchDlsFitFindA0A1D_d_d-' num2str(din(index1)) '-' num2str(din(index2)) '-' num2str(istep) '-' ... '-' ...
    'lambda-' num2str(lambda) '-'...
    'temp-' num2str(tcelsius) '-'...
    'theta-' num2str(theta) '-'...
    'indref-' num2str(indref) '-'...
    'eta-' num2str(eta) '-'... 
    '_f-' num2str(fs),'.txt'];
saveNameDeltaT=['batchDlsFitFindA0A1D_deltat-' num2str(din(index1)) '-' num2str(din(index2)) '-' num2str(istep) '-' ... '-' ...
    'lambda-' num2str(lambda) '-'...
    'temp-' num2str(tcelsius) '-'...
    'theta-' num2str(theta) '-'...
    'indref-' num2str(indref) '-'...
    'eta-' num2str(eta) '-'... 
    '_f-' num2str(fs),'.txt'];

save(saveNameA0,'a0','-ascii');
disp(['   [+] File Saved: ' saveNameA0]);

save(saveNameA1,'a1','-ascii');
disp(['   [+] File Saved: ' saveNameA1]);

save(saveNameD,'d','-ascii');
disp(['   [+] File Saved: ' saveNameD]);

save(saveNameDeltaT,'deltaT','-ascii');
disp(['   [+] File Saved: ', saveNameDeltaT]);

disp('[+++] Fit DLS Batch Mode Execution Complete');

%if dispMode == 1
%    figure(6);
%    plot(d);
%end
