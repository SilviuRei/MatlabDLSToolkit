function [dFitNN] = dlsNNFitNoACF (tsName,mACF,index1,index2,istep,autocorrLags,nnHidden,fs,dispMode)
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
disp('[++] Neural Network DLS Fit No Autocorr');
h=999;
m=999;
s=999;
nSteps = (index2-index1)/istep+1;
%dFitNN = zeroes(nSteps);
if dispMode == 1
    waitbarHandle = waitbar(0,['Neural Network DLS Fit...' ...
        newline 'Step:'  ...
        newline 'Time Left = ' ...
        newline 'Progress: 0%']);
end
k=1;
t0=clock;
for i=index1:istep:index2
    tic;
    disp(['   [+] Step ' num2str(k) ' out of ' num2str(nSteps)...
        ', Time left=' num2str(h) ':' num2str(m) ':' num2str(s)]);
    if dispMode == 1
        waitbar((k-1)/nSteps, waitbarHandle,['Neural Network DLS Fit...' ...
            newline 'Step: ' num2str(k) ' out of ' num2str(nSteps)  ...
            newline 'Time Left = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's' ...
            newline 'Progress: ' num2str(100*(k-1)/nSteps) ' %']);
    end
	disp('   [+] NN DLS Estimating Average Particle Size');
    dFitNN(i)=nn_dls(mACF(:,i));
	disp('   [-] NN DLS Estimation Complete');
    disp(['        [-] Diameter = ' num2str(dFitNN(i)) ' nanometers']);
    deltat = toc;
    [h, m, s] = sec2time(deltat*(index2-i));
    k=k+1;
end
if dispMode == 1
    close(waitbarHandle);
end
t1=clock;
deltaT = etime(t1,t0);
[h, m, s] = sec2time(deltaT);
disp(['[+++] Total Duration of NN DLS = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's']);

fileNameFitNN=['dlsNNFitNoACF_dFitNN_index-' num2str(index1) '-' num2str(istep) '-' num2str(index2) '-' ...
        'autocorrLags-' num2str(autocorrLags) '-'...
        'nnHidden-' num2str(nnHidden) '-'...
        '_f-' num2str(fs) '.txt'];
save(fileNameFitNN,'dFitNN','-ascii');
disp(['   [+] File Saved: ' fileNameFitNN]);

fileNameDeltaT=['dlsNNFitNoACF_deltat-index-' num2str(index1) '-' num2str(istep) '-' num2str(index2) '-' ...
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