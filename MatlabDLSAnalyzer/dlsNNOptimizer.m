function [nnHidden, mF, errel, dur] = dlsNNOptimizer (x, t, range1, range2, name, index1, index2, autocorrLags, frequency, nnHidden1, nnHidden2, nnHiddenStep, averagingSteps, dClassical, dispMode)
%-------------------------------------------------------------------------------
% Version 20171105, Silviu Rei
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
    warning off;
    mF = 0;
    x = x(:,range1:range2);
    t = t(:,range1:range2);    
    maxI = (nnHidden2-nnHidden1)/nnHiddenStep+1;
    t0 = clock;
    for i=1:maxI
        mF_temp = 0;
        erabs_temp = zeros();
        errel_temp = zeros();
        dur_temp = 0;
        nnHidden(i) = nnHidden2-(i-1)*nnHiddenStep;
        for j=1:averagingSteps
            t01 = clock;
            disp('[+]------------------------------------------------');
            disp(['[+] Training Neural Network with ' num2str(nnHidden(i)) ' neurons in the hidden layer']);        
            [delta, net] = nnDlsTrain(x, t, nnHidden(i));
            disp(['[+] Evaluating Neural Network Performance. Step ' num2str(j) ' out of ' num2str(averagingSteps) ]);
            [dnn, durationNN]=batchAutocorrNNSilent(name, index1, index2, autocorrLags, frequency, 0);
            [temp_mF, temp_erabs, temp_errel] = xdif (dClassical(:,index1:index2), dnn);
            mF_temp = mF_temp + temp_mF;
            erabs_temp = erabs_temp + temp_erabs;
            errel_temp = errel_temp + temp_errel;            
            disp('[-] Done');
            deltat = etime(clock,t01);
            dur_temp = dur_temp + deltat;
            [h,m,s]=sec2time(deltat*(maxI*averagingSteps-i*j));
            disp(['[-] Time left= ' num2str(h) 'h' num2str(m) 'm' num2str(s) 's']);
            disp(['[-] Steps = ' num2str(i) ' out of ' num2str(maxI)]);
            disp(['[-] Averaging Steps = ' num2str(j) ' out of ' num2str(averagingSteps)]);
        end
        mF(i) = mF_temp/averagingSteps;
        dur(i) = dur_temp/averagingSteps;
        erabs(i) = mean(erabs_temp./averagingSteps);
        errel(i) = mean(errel_temp./averagingSteps);
        save('errel.mat','errel','mF','nnHidden');
    end
    t1=clock;
    deltaT = etime(t1,t0);
    [h, m, s] = sec2time(deltaT);
    disp(['[-] Total Duration = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's']);
    
    h = figure;
    subplot(2,1,1);
    plot(nnHidden, errel.*100);
    xlabel('Number of hidden neurons');
    ylabel('Relative error (%)');
    subplot(2,1,2);
    plot(nnHidden,dur);
    xlabel('Number of hidden neurons');
    ylabel('Duration(seconds)');
    saveas(h, 'results.png');
    save('run.mat');
    warning on;
end
