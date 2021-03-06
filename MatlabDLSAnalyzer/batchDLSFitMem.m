function [d, deltaT] = batchDLSFitMem (m, index1, index2, frequency, dispMode, cleanMode)
%-------------------------------------------------------------------------------
% Version 20171030, Silviu Rei
% function [d, deltaT] = batchDLSFit (name, index1, index2, dispMode, cleanMode)
%	The function executes DLS fit procedure using the least square method, in 
% 	batch mode
%	Input:
%		m    		= time series matrix
%		index1 		= starting index of the time series files
%		index2 		= end index of the time series files
%		dispMode 	= display mode (0=no detailed messages, 1=detailed messages)
%		frequency 	= acquisition frequency
%		cleanMode 	= delete temp files (0=no, 1=yes)
%	Output:
%		d 			= diameter vector
%		deltaT 		= total time duration of the procedure
%	Example:
%		[dclassical, durationClassical]=batchDLSFit(m, 1, 143, 16000, 0, 1);
%-------------------------------------------------------------------------------
disp('[++] Fit DLS Batch Mode');
n1=index1;
n2=index2;
pas=1;
teta=pi/2;
indref=1.33;%water
%indref=1.003;%air
lambda=633.e-9;
tcelsius=20;
eta=water_viscosity(tcelsius);
%eta=1.8369247E-5; %for air at 20C
a0start=10;
a0min=1.e-5;
a0max=1.e8;
a1start=10;
a1min=0.001;
a1max=9000;
control=2;
tip='fig';
text2='';
%text1=name;
t0 = clock;

for i=index1:index2
    tic;
    namef = [num2str(i) '.ext'];
    namefile = [num2str(i)];
	disp('[+]------------');
    disp(['[+] Generating file ' namef]);
    temp=m(:,i);
    save(namef, 'temp', '-ascii')
    %ts = load(namefile);
    %ts = fltr(ts, 16000, 1, 50, 1);
    disp('[+] Calculating Power Spectrum');
    psdts=ps_dls5v2(namefile,frequency,6,0,'png',control, dispMode);
    disp('    [-] Power Spectrum Calculation Complete');
    disp('[+] Starting DLS Fit Procedure');
    [d(i),a0,a1,chi2min,exitflag]=chi2dlslsq3v2(namefile,teta,indref,lambda,tcelsius,eta,a0start,a0min,a0max,a1start,a1min,a1max,control,tip, dispMode);
    d(i) = d(i)*1e9;
    disp('    [-] DLS Fit Procedure Complete');
    disp(['        [-] Diameter = ' num2str(d(i)) ' nanometers']);
    deltat = toc;
    disp(['[+] Time left=' num2str(deltat*(index2-i)) ' seconds']);
    if cleanMode == 1    
        delete('*.ext');
        delete('*.fps');
        delete('*.rez');
    end
end
t1=clock;
deltaT = etime(t1,t0);
[h, m, s] = sec2time(deltaT);
disp(['[+++] Total Duration of Fit DLS = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's']);
if dispMode == 1
    figure;
    plot(d);
end
