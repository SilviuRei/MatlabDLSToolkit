function [errelmin, errelmax, errelmean] = dlsNNAveraging (x, t, range1, range2, name, index1, index2, autocorrLags, frequency, nnHidden, averagingSteps, dClassical, dispMode)
%-------------------------------------------------------------------------------
% Version 20171106, Silviu Rei
% function [errelmin, errelmax, errelmean] = dlsNNAveraging (x, t, range1, range2, name, index1, index2, autocorrLags, frequency, nnHidden, averagingSteps, dClassical, dispMode)
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
%       nnHidden        = number of neurons in the hidden layer
%       averagingSteps  = number of averaging steps
%       dClassical      = classical diameters obtained by DLS Fit
%		dispMode 		= display mode (0=no detailed messages, 1=detailed messages)
%	Output:
%       errelmin
%       errelmax
%       errelmean
%	Example:
%		[errelmin, errelmax, errelmean]=dlsNNAveraging(x, t, 10, 1000, 'sm7-34-', 1, 34, 2499, 16000, 275, 100, dClassical, 0);
%-------------------------------------------------------------------------------

    %x = load('ts18_1_1_8000-acf.txt');  
    %t = load('ts18-1-1-8000_d_g36.txt');
    warning off;
    x = x(:,range1:range2);
    t = t(:,range1:range2);    
    disp('[+]------------------------------------------------');
    disp(['[+] Testing Neural Network with ' num2str(nnHidden) ' neurons in the hidden layer']); 
    t0 = clock;
    for i=1:averagingSteps
        t01 = clock;
        disp('[+]------------------------------------------------');
        disp(['[+] Testing Loop ' num2str(i) ' out of ' num2str(averagingSteps)]);
        disp('[+] Training Neural Network');
        [delta, net] = nnDlsTrain(x, t, nnHidden);
        disp('[-] Training Complete');
        disp('[+] Testing Neural Network');
        [dnn, durationNN]=batchAutocorrNNSilent(name, index1, index2, autocorrLags, frequency, 0);
        [mF(i), erabs(:,i), errel(:,i)] = xdif (dClassical(:,1:index2), dnn);
        deltat = etime(clock,t01);
        dur(i) = deltat;
        [h,m,s]=sec2time(deltat*(averagingSteps-i));
        disp('-] Testing Complete');
        disp(['[-] Time left= ' num2str(h) 'h' num2str(m) 'm' num2str(s) 's']);
        disp(['[-] Steps = ' num2str(i) ' out of ' num2str(averagingSteps)]);
        errelmin(i) = min(errel(:,i));
        errelmax(i) = max(errel(:,i));
        errelmean(i) = mean(errel(:,i));
        save('averaging_temp.mat', 'errelmin','errelmax','errelmean');
    end
    t1=clock;
    deltaT = etime(t1,t0);
    [h, m, s] = sec2time(deltaT);
    disp(['[-] Total Duration = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's']);
    errelmin = min(errelmin);
    errelmax = max(errelmax);
    errelmean = mean(errelmean);
    disp(['[-] Relative error: min = ' num2str(100*errelmin) '%, max = ' num2str(100*errelmax) '%, mean = ' num2str(100*errelmean) '%']);
    save('averaging.mat');
    warning on;
end
