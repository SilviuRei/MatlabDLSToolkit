function [dFitNN, acf,lags,deltaT] = dlsAutocorrNNTrainAndFitMem(mTS,bS,eS,sS,index1,index2,istep,autocorrLags,fs,dispMode,trainNNFlag,nnHidden, trainFcn)
%-------------------------------------------------------------------------------
% Version 20171223, Silviu Rei
% function [dFitNN, acf,lags,deltaT] = dlsAutocorrNNTrainAndFitMem(mTS,bS,eS,sS,index1,index2,istep,autocorrLags,fs,dispMode,trainNNFlag,nnHidden, trainFcn)
%	The function executes DLS NN procedure. If trainFlag = 1, it also trains the network
%	Input:
%		mTs 			= matrix containing the time series
%		index1 			= starting index of the time series files
%		index2 			= end index of the time series files
%		autocorrLags 	= number of lags used in the autocorrelation function
%		fs      		= acquisition frequency
%		dispMode 		= display mode (0=no detailed messages, 1=detailed messages)
%       trainNNFlag     = if 1 trains the network
%       trainFcn        = training Function
%	Output:
%		d 				= diameter vector
%		deltaT 			= total time duration of the procedure
%	Example:
%		
%-------------------------------------------------------------------------------
disp('---------------------------------------------------------------------');
disp('  [++] Neural Network DLS Fit');
indsave = 2;
tsName = ['Autocorr_d-' num2str(bS) '-' num2str(sS) '-' num2str(eS) '-autocorLags-'...
            num2str(autocorrLags) '-fs-' num2str(fs)];
t0 = clock;
disp('   [+]------------');
dm = bS:sS:eS;
disp('   [+] Loading time series');
ts = mTS;
%ts = fltr(ts, 16000, 1, 50, 1);
disp('[   +] Calculating ACF');
[acf,lags]=run_analizor_autocor_2(tsName,ts,autocorrLags,fs,'png',indsave,...
    bS,eS,sS,index1,index2,istep,dispMode);
disp('   [-] ACF Calculation Complete');
if trainNNFlag == 1
    disp('   [+] Training Neural Network');
    [~, ~] = nnDlsTrain(acf,dm,nnHidden,trainFcn);
    disp('   [-] Training Complete');
end

for i=index1:istep:index2
    tic;
	disp('   [+] NN DLS Estimating Average Particle Size');
    dFitNN(i)=nn_dls(acf(:,i));
	disp('   [-] NN DLS Estimation Complete');
    disp(['        [-] Diameter = ' num2str(dFitNN(i)) ' nanometers']);
    deltat = toc;
    [h, m, s] = sec2time(deltat*(index2-i));
    disp(['   [+] Time left=' num2str(h) ':' num2str(m) ':' num2str(s)]);
end
t1=clock;
deltaT = etime(t1,t0);
[h, m, s] = sec2time(deltaT);
disp(['[+++] Total Duration of NN DLS = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's']);

fileNameFitNN=['dlsAutocorrNNTrainAndFitMem_dFitN_d-' num2str(bS) '-' num2str(eS) '-' num2str(sS) '-' ...
        'autocorrLags-' num2str(autocorrLags) '-'...
        'nnHidden-' num2str(nnHidden) '-'...
        '_f-' num2str(fs) '.txt'];
save(fileNameFitNN,'dFitNN','-ascii');
disp(['   [+] File Saved: ' fileNameFitNN]);

fileNameAcf=['dlsAutocorrNNTrainAndFitMem_acf_d-' num2str(bS) '-' num2str(eS) '-' num2str(sS) '-' ...
        'autocorrLags-' num2str(autocorrLags) '-'...
        'nnHidden-' num2str(nnHidden) '-'...
        '_f-' num2str(fs) '.txt'];
save(fileNameAcf,'acf','-ascii');
disp(['   [+] File Saved: ' fileNameAcf]);

fileNameFitNN=['dlsAutocorrNNTrainAndFitMem_dFitN_deltat-' num2str(bS) '-' num2str(eS) '-' num2str(sS) '-' ...
        'autocorrLags-' num2str(autocorrLags) '-'...
        'nnHidden-' num2str(nnHidden) '-'...
        '_f-' num2str(fs) '.txt'];
save(fileNameFitNN,'deltat','-ascii');
disp(['   [+] File Saved: ' fileNameFitNN]);
    
if dispMode == 1
	figure;
	plot(d);
end

disp('[++] Neural Network DLS Fit Complete');
