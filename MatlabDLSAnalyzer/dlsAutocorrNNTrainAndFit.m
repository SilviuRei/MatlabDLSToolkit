function [dFitAcNN, acf,lags,deltaT] = dlsAutocorrNNTrainAndFit...
    (name,bS,eS,sS,index1,index2,istep,autocorrLags,fs,dispMode,trainFlag,nnHidden)
%-------------------------------------------------------------------------------
% Version 20171220, Silviu Rei
% function [d, acf, deltaT] = batchAutocorrNN (name, index1, index2, autocorrLags, dispMode)
%	The function executes DLS NN procedure. If trainFlag = 1, it also trains the network
%	Input:
%		name 			= name of the time series file
%		index1 			= starting index of the time series files
%		index2 			= end index of the time series files
%		autocorrLags 	= number of lags used in the autocorrelation function
%		fs      		= acquisition frequency
%		dispMode 		= display mode (0=no detailed messages, 1=detailed messages)
%       trainFlag       = if 1 trains the network
%	Output:
%		d 				= diameter vector
%		deltaT 			= total time duration of the procedure
%	Example:
%		[dnn, durationNN]=batchAutocorrNN('sm7-34-', 1, 143, 2499, 16000, 0);
%-------------------------------------------------------------------------------
disp('[++] Neural Network DLS Fit');
t0 = clock;
disp('[+]------------');
dm = bS:sS:eS;
disp(['[+] Loading time series file ' name]);
ts = load(name);
%ts = fltr(ts, 16000, 1, 50, 1);
disp('[+] Calculating ACF');
[acf,lags]=run_analizor_autocor_2('',ts,autocorrLags,fs,'jpg',0,index1,index2);
disp('    [-] ACF Calculation Complete');
if trainFlag == 1
    [deltaT, net] = nnDlsTrain(acf,dm,nnHidden);
end
for i=index1:index2
    tic;
	disp('[+] NN DLS Estimating Average Particle Size');
    dFitAcNN(i)=nn_dls(acf(:,i));
	disp('    [-] NN DLS Estimation Complete');
    disp(['        [-] Diameter = ' num2str(dFitAcNN(i)) ' nanometers']);
    deltat = toc;
    [h, m, s] = sec2time(deltat*(index2-i));
    disp(['[+] Time left=' num2str(h) ':' num2str(m) ':' num2str(s)]);
end
t1=clock;
deltaT = etime(t1,t0);
[h, m, s] = sec2time(deltaT);
disp(['[+++] Total Duration of NN DLS = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's']);
if dispMode == 1
	figure;
	plot(d);
end
