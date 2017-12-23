clear;
clc;

nightMinSize		= [1,900,5,1000];
nightMaxSize 		= [100,1000,200,1500];
nightStepSize		= [1,1,5,5];
nightTCelsius		= [20,20,20,20];
nightTheta		= [30,30,30,30];
nightLambda		= [633,633,633,633];
nightSolvent 		= ["air","air","water","water"];
nightFs			= [16000, 16000, 16000, 16000];
nightNt			= [32768, 32768, 32768, 32768];
nightNNHidden		= [150, 150, 150, 150];
nightAutocorrLags 	= [999, 999, 999, 999];
nightValidationTS = 'sm7-34-';
nightTitle = '20171221_run1';

maxLoop = length(nightMinSize);


for i=1:maxLoop
        disp(['[+++] ---- Overnight Run Loop ' num2str(i) ' out of ' num2str(maxLoop)]);
        
        [dMin,dMax,dStep,indref,lambda,eta,tcelsius,theta,pSize,a0start,a0min,...
            a0max,a1start,a1min,a1max,fs,nt,nnHidden,autocorrLags,trainNNFlag]=...
            initConst(nightMinSize(i),nightStepSize(i),nightMaxSize(i),...
            nightTheta(i),nightTCelsius(i),5,nightLambda(i),nightSolvent(i),nightFs(i),...
            nightNt(i),nightNNHidden(i),nightAutocorrLags(i),1);
       
	dirName = [num2str(i) '_' nightTitle '-d' num2str(dMin) '-' num2str(dStep) '-' ...
	    num2str(dMax) '-theta-' num2str(theta) '-lambda-' num2str(lambda) ...
	    '-indref-' num2str(indref) '-eta-' num2str(eta) '-tcelsius-' num2str(tcelsius) ...
	    '-fs-' num2str(fs) '-nt-' num2str(nt)];
       
	mkdir(dirName);
        
        cd(dirName);
    
           
        [t,mTS,a0,a1]=batchGenTsStepSize(dirName,dMin,dStep,dMax,theta,lambda,...
            indref,eta,tcelsius,fs,nt,1);
    
        [dFitDLS,a0FitDLS,a1FitDLS,roF] = batchDLSFindA0A1RollOffFrequencySize ...
            (mTS, dMin,dMax,dStep, 1, (dMax-dMin)/dStep+1, 1, fs, ...
            theta, lambda, indref, eta, tcelsius,...
            a0start, a0min, a0max, a1start, a1min, a1max, 20, 'png', 0, 1);
    
        [dFitNN, acf,lags,deltaT] = dlsAutocorrNNTrainAndFitMem(mTS,dMin, ...
            dMax,dStep,1,(dMax-dMin)/dStep+1,1,autocorrLags,fs,0,1,nnHidden, 'traincgf');
        
        d=dMin:dStep:dMax;
    
        [errelFitDLS,errelFitNN,errabsFitDLS,errabsFitNN]=estimateErrFitDLSVsNN(d,dFitDLS,dFitNN,'png',1);
        
        [dclassical, dnn, durationClassical, durationNN, hisq, erabs, ...
            errel, toptimization] = batchDLSFitVsAutocorrNN (nightValidationTS,1,30,autocorrLags,fs,0,1);
        
        cd('..');
end
diary([dirname 'diary.txt']);
disp('[+++] Overnight Run Complete');