function [dFitNN] = dlsNNFit (tsName,mTs,index1,index2,istep,autocorrLags,nnHidden,fs,dispMode)
%-------------------------------------------------------------------------------
% Version 20171223, Silviu Rei
% function 
%	The function 
%	Input:
%	Output:
%	Example:
%		
%-------------------------------------------------------------------------------
indsave = 2;
disp('---------------------------------------------------------------------');
disp('[++] Neural Network DLS Fit');
disp('   [+] Calculating ACF');
[acf,~]=run_analizor_autocor_2(tsName,mTs,autocorrLags,fs,'png',indsave,...
    index1,index2,istep,dispMode);
disp('   [-] ACF Calculation Complete');
h=999;
m=999;
s=999;
nSteps = (index2-index1)/istep+1;
dFitNN = zeros(1,nSteps);
waitbarHandle = waitbar(0,['Neural Network DLS Fit...' ...
        newline 'Step:'  ...
        newline 'Time Left = ' ...
        newline 'Progress: 0%']);
k=1;
t0=clock;
for i=index1:istep:index2
    tic;
    disp(['   [+]Step ' num2str(k) ' out of ' num2str(nSteps)...
        ', Time left=' num2str(h) ':' num2str(m) ':' num2str(s)]);
    waitbar((k-1)/nSteps, waitbarHandle,['Neural Network DLS Fit...' ...
        newline 'Step: ' num2str(k) ' out of ' num2str(nSteps)  ...
        newline 'Time Left = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's' ...
        newline 'Progress: ' num2str(100*(k-1)/nSteps) ' %']);
	disp('   [+] NN DLS Estimating Average Particle Size');
    dFitNN(i)=nn_dls(acf(:,i));
	disp('   [-] NN DLS Estimation Complete');
    disp(['        [-] Diameter = ' num2str(dFitNN(i)) ' nanometers']);
    deltat = toc;
    [h, m, s] = sec2time(deltat*(index2-i));
    k=k+1;
end
close(waitbarHandle);
t1=clock;
deltaT = etime(t1,t0);
[h, m, s] = sec2time(deltaT);
disp(['[+++] Total Duration of NN DLS = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's']);

fileNameFitNN=['dlsNNFit_dFitNN_index-' num2str(index1) '-' num2str(istep) '-' num2str(index2) '-' ...
        'autocorrLags-' num2str(autocorrLags) '-'...
        'nnHidden-' num2str(nnHidden) '-'...
        '_f-' num2str(fs) '.txt'];
save(fileNameFitNN,'dFitNN','-ascii');
disp(['   [+] File Saved: ' fileNameFitNN]);

fileNameAcf=['dlsNNFit_acf_index-' num2str(index1) '-' num2str(istep) '-' num2str(index2) '-' ...
        'autocorrLags-' num2str(autocorrLags) '-'...
        'nnHidden-' num2str(nnHidden) '-'...
        '_f-' num2str(fs) '.txt'];
save(fileNameAcf,'acf','-ascii');
disp(['   [+] File Saved: ' fileNameAcf]);

fileNameDeltaT=['dlsNNFit_deltat-index-' num2str(index1) '-' num2str(istep) '-' num2str(index2) '-' ...
        'autocorrLags-' num2str(autocorrLags) '-'...
        'nnHidden-' num2str(nnHidden) '-'...
        '_f-' num2str(fs) '.txt'];
save(fileNameDeltaT,'deltat','-ascii');
disp(['   [+] File Saved: ' fileNameDeltaT]);
    
if dispMode == 1
	figure;
	plot(d);
end

disp('[++] Neural Network DLS Fit Complete');