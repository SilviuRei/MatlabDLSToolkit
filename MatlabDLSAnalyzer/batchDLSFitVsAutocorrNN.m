function [dclassical, dnn, durationClassical, durationNN, hisq, erabs, errel, toptimization] = batchDLSFitVsAutocorrNN (name, index1, index2, autocorrLags, frequency, dispMode, cleanMode)
%-------------------------------------------------------------------------------
%	Version 20171030, Silviu Rei
%	function [hisq, erabs, errel, dclassical, dnn, durationClassical, durationNN, optimization] = batchDLSFitVsAutocorrNN (name, index1, index2, autocorrLags, frequency, dispMode, cleanMode)
%		The function executes DLS least square fit vs. NN procedure, in batch mode
%	Input:
%		name 				= name of the time series
%		index1 				= starting index of the time series files
%		index2 				= end index of the time series files
%		autocorrLags		= number of lags used in the autocorrelation function
%		frequency 			= acquisition frequency
%		dispMode 			= display mode (0=no detailed messages, 1=detailed messages)
%		cleanMode 			= delete temp files (0=no, 1=yes)
%	Output:
%		dclassical 			= diameter vector estimated by classical least square fitting procedure
%		dnn 				= diameter vector estimated by NN
%		durationClassical 	= duration of the classical fitting procedure
%		durationNN 			= duration of the NN procedure
%		hisq 				= overall deviation function
%		erabs 				= absolute error vector
%		errel 				= relative error vector
%		toptimization 		= time optimization
%	Example:
%		[dclassical, dnn, durationClassical, durationNN, hisq, erabs, errel, toptimization] = batchDLSFitVsAutocorrNN ('sm7-34-', 1, 143, 2499, 16000, 0, 1)
%-------------------------------------------------------------------------------
disp('[++++++] DLS Fit Vs. Autocorr DLS NN Batch Mode');
disp('[+++] Starting Step 1 of 2');
[dclassical, durationClassical]=batchDLSFit(name, index1, index2, frequency, dispMode, cleanMode);
disp('[+++] Step 1 of 2 Complete');
disp('[+++] Starting Step 2 of 2');
[dnn, durationNN]=batchAutocorrNN(name, index1, index2, autocorrLags, frequency, dispMode);
disp('[+++] Step 2 of 2 Complete');
%dnn=dnn';
totalDuration = (durationClassical + durationNN)/60;
disp(['[++++++] Total Duration = ' num2str(totalDuration) ' minutes']);
toptimization = abs(durationClassical-durationNN)/durationClassical*100;
disp(['[++++++] Time Optimization = ' num2str(toptimization) ' %']);
%dclassical = dclassical.*1e9;
[hisq, erabs, errel] = xdif(dclassical, dnn);
errel = errel.*100;
figure(20);
subplot(3,1,1);
plot(dclassical, 'b--o');
hold on;
plot(dnn, 'r--o');
title('Evaluated Particle Size');
xlabel('Time (min)');
ylabel('Diameter (nm)');
legend;
legend('Classical', 'Neural Network');
hold off;
subplot(3,1,2);
plot(erabs);
xlabel ('Time (min)');
ylabel('Absolute Error (nm)');
ylabel('Absolute Error (nm)');
title('Neural Network Absolute Error');
subplot(3,1,3);
plot(errel);
xlabel('Time (min)');
ylabel('Relative Error (%)');
title('Neural Network Relative Error');
%save('ValidationDLSFitVsNN.mat');
save('ValidationDLSFitVsNN_dnn.txt','dnn','-ascii');
save('ValidationDLSFitVsNN_dclassical.txt','dclassical','-ascii');
save('ValidationDLSFitVsNN_durationNN.txt','durationNN','-ascii');
save('ValidationDLSFitVsNN_durationClassical.txt','durationClassical','-ascii');
save('ValidationDLSFitVsNN_errel.txt','errel','-ascii');
save('ValidationDLSFitVsNN_erabs.txt','erabs','-ascii');
save('ValidationDLSFitVsNN_toptimization','toptimization','-ascii');
saveas(20,'ValidationDLSFitVsNN','png');
%savefig('DLSFitVsNN.fig');
