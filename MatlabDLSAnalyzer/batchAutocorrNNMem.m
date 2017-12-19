function [d, deltaT] = batchAutocorrNNMem (m, index1, index2, autocorrLags, frequency, dispMode)
%-------------------------------------------------------------------------------
% Version 20171030, Silviu Rei
% function [d, deltaT] = batchAutocorrNN (name, index1, index2, autocorrLags, dispMode)
%	The function executes DLS NN procedure, in batch mode
%	Input:
%		m    			= time series matrix
%		index1 			= starting index of the time series files
%		index2 			= end index of the time series files
%		autocorrLags 	= number of lags used in the autocorrelation function
%		frequency		= acquisition frequency
%		dispMode 		= display mode (0=no detailed messages, 1=detailed messages)
%	Output:
%		d 				= diameter vector
%		deltaT 			= total time duration of the procedure
%	Example:
%		[dnn, durationNN]=batchAutocorrNN(m, 1, 143, 2499, 16000, 0);
%-------------------------------------------------------------------------------
disp('[++] Neural Network DLS Batch Mode');
t0 = clock;
for i=index1:index2
    tic;
	disp('[+]------------');
    disp(['[+] Loading entry ' num2str(i)]);
    ts=m(:,i);
    %ts = fltr(ts, 16000, 1, 50, 1);
    disp('[+] Calculating ACF');
    [acf,lags]=run_analizor_autocor_2('',ts,autocorrLags,frequency,'jpg',0,1,1);
    disp('    [-] ACF Calculation Complete');
	disp('[+] NN DLS Estimating Average Particle Size');
    d(i)=nn_dls(acf);
	disp('    [-] NN DLS Estimation Complete');
    disp(['        [-] Diameter = ' num2str(d(i)) ' nanometers']);
    deltat = toc;
    disp(['[+] Time left=' num2str(deltat*(index2-i)) ' seconds']);
end
t1=clock;
deltaT = etime(t1,t0);
[h, m, s] = sec2time(deltaT);
disp(['[+++] Total Duration of NN DLS = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's']);
if dispMode == 1
	figure;
	plot(d);
end
