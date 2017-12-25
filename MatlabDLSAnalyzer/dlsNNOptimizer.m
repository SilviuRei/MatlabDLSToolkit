function [nnHidden, mF, errel, dur] = dlsNNOptimizer (mACF, dm, dMin, dMax,...
    dStep, name, index1, index2, istep, autocorrLags, fs, nnHidden1, ...
    nnHidden2, nnHiddenStep, averagingSteps, trainFcn, dispMode)
%-------------------------------------------------------------------------------
% Version 20171225, Silviu Rei
% function [nnHidden, mF, erabs, errel, dur] = dlsNNOptimizer (x, t, range1, range2, name, index1, index2, autocorrLags, frequency, nnHidden1, nnHidden2, nnHiddenStep, dClassical, dispMode)
%	The function searches for the best number of hidden neurons for DLS NN
%	Input:
%       x               = input training time series
%       t               = target training vector
%       range1          = starting point for training vector
%       range2          = end point for training vector
%		name 			= name of the time series
%		index1 			= starting index of the time series files
%		index2 			= end index of the time series files
%		autocorrLags 	= number of lags used in the autocorrelation function
%		frequency		= acquisition frequency
%       nnHidden1       = minimum number of neurons in the hidden layer
%       nnHidden2       = maximum number of neurons in the hidden layer
%       nnHiddenStep    = step for searching the hidden layer number of the neurons
%       averagingSteps  = number of steps for averaging the minimizing funtion and errel
%       dClassical      = classical diameters obtained by DLS Fit
%		dispMode 		= display mode (0=no detailed messages, 1=detailed messages)
%	Output:
%		nnHidden		= vector containing the hidden layer neuron number
%		mF   			= minimization function output
%	Example:
%		[nnHidden, mF, erabs, errel, dur]=dlsNNOptimizer(x, t, 1, 1000, 'sm7-34-', 1, 20, 2499, 16000, 5, 1000, 5, dClassical, 0);
%-------------------------------------------------------------------------------

%x = load('ts18_1_1_8000-acf.txt');  
%t = load('ts18-1-1-8000_d_g36.txt');
disp('---------------------------------------------------------------------');
disp('[+++] Neural Network Optimizer');
warning off;
figureNumber = 90;
mF = 0;
h = 999;
m = 999;
s = 999;
%mTs = mTs(:,dMin:dMax);  
maxI = (nnHidden2-nnHidden1)/nnHiddenStep+1;
t0 = clock;
nnHidden = zeros(1,maxI);
mF = zeros(1,maxI);
dur = zeros(1,maxI);
errabs = zeros(1,maxI);
errel = zeros(1,maxI);
waitbarHandle = waitbar(0,['Neural Network Optimizer...' ...
    newline 'Step:'  ...
    newline 'Time Left = ' ...
    newline 'Progress: 0%']);
for i=1:maxI
    t00=clock;
    disp(['   [+]Step ' num2str(i) ' out of ' num2str(maxI)...
    ', Time left=' num2str(h) ':' num2str(m) ':' num2str(s)]);
    waitbar((i-1)/maxI, waitbarHandle,['Neural Network Optimizer...' ...
        newline 'Step: ' num2str(i) ' out of ' num2str(maxI)  ...
        newline 'Time Left = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's' ...
        newline 'Progress: ' num2str(100*(i-1)/maxI) ' %']);
    mF_temp = 0;
    errabs_temp = zeros();
    errel_temp = zeros();
    dur_temp = 0;
    nnHidden(i) = nnHidden2-(i-1)*nnHiddenStep;
    tsName=['dls_nn-nnHidden-' num2str(nnHidden(i)) '-' name];
    for j=1:averagingSteps
        t01 = clock;
        disp(['   [+] Training Neural Network With ' num2str(nnHidden(i))...
            ' Neurons in the Hidden Layer']);        
        [~,~] = nnDlsTrain(mACF, dm, nnHidden(i),trainFcn,dispMode);
        disp('   [-] Training Complete');
        disp(['   [+] Evaluating Neural Network Performance. Step '...
            num2str(j) ' out of ' num2str(averagingSteps) ]);
        [dnn] = dlsNNFitNoACF (tsName,mACF,dMin,dMax,dStep,index1,index2,...
            istep,autocorrLags,nnHidden(i),fs,dispMode);
        [temp_mF, temp_errabs, temp_errel] = xdif (dm(:,index1:index2), dnn);
        mF_temp = mF_temp + temp_mF;
        errabs_temp = errabs_temp + temp_errabs;
        errel_temp = errel_temp + temp_errel;            
        disp('   [-] Done');
        deltat = etime(clock,t01);
        dur_temp = dur_temp + deltat;
        [h,m,s]=sec2time(deltat*(maxI*averagingSteps-i*j));
        disp(['[+] Time left= ' num2str(h) 'h' num2str(m) 'm' num2str(s) 's']);
        disp(['[+] Steps = ' num2str(i) ' out of ' num2str(maxI)]);
        disp(['[+] Averaging Steps = ' num2str(j) ' out of ' num2str(averagingSteps)]);
        save([tsName '.txt'],'dnn','-ascii');
        disp(['   [+] File Saved: ' tsName '.txt']);
        mkdir(tsName);
        copyfile ('nn_dls*',tsName);
    end
    mF(i) = mF_temp/averagingSteps;
    dur(i) = dur_temp/averagingSteps;
    errabs(i) = mean(errabs_temp./averagingSteps);
    errel(i) = mean(errel_temp./averagingSteps);
    deltat = etime(clock,t00);
    [h, m, s] = sec2time(deltat*(maxI-i));
end
close(waitbarHandle);
t1=clock;
deltaT = etime(t1,t0);
[h, m, s] = sec2time(deltaT);
disp(['[-] Total Duration = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's']);

fileNameBase = [tsName '-nnHidden1-' num2str(nnHidden1) '-nnHidden2-' ...
    num2str(nnHidden2) '-nnStep-' num2str(nnHiddenStep)];

fileNameErrRel = [fileNameBase '-NNErrel.txt'];
save(fileNameErrRel,'errel','-ascii');
disp(['[+] File Saved: ' fileNameErrRel]);

fileNameErrAbs = [fileNameBase '-NNErrabs.txt'];
save(fileNameErrAbs,'errabs','-ascii');
disp(['[+] File Saved: ' fileNameErrAbs]);

fileNameDur = [fileNameBase '-dur.txt'];
save(fileNameDur,'dur','-ascii');
disp(['[+] File Saved: ' fileNameDur]);
    
    
if dispMode==1
    figure(figureNumber);
elseif dispMode==0
    figureNumber=figure('visible','off');
end

figureName = ['plot_' fileNameBase '-NNErrelErrabs'];
subplot(2,1,1);
plot(nnHidden, errel.*100);
xlabel('Number of hidden neurons');
ylabel('Relative error (%)');
subplot(2,1,2);
plot(nnHidden,dur);
xlabel('Number of hidden neurons');
ylabel('Duration(seconds)');
saveas(figureNumber, figureName, 'png');
warning on;