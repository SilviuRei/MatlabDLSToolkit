nightMinSize = [5,5,5,1,1,5,5,1,1];
nightMaxSize = [1500,1500,1500,500,500,1500,1500,500,500];
nightStepSize= [5,5,5,1,1,5,5,1,1];
nightTCelsius= [20,20,20,20,20,20,20,20,20];
nightTheta=    [90,45,4,4,30,90,45,4,30];
nightLambda=   [633,633,633,633,633,532,532,532,532];
nightSolvent = ["water","water","water","air","air","water","water","air","air"];
nightValidationTS = 'sm7-34-';

maxLoop = 9;
for i=1:maxLoop
        disp(['[+++] ---- Overnight Run Loop ' num2str(i) ' out of ' num2str(maxLoop)]);
        
        mkdir(num2str(i));
        cd(num2str(i));
    
        [dMin,dMax,dStep,indref,lambda,eta,tcelsius,theta,pSize,a0start,a0min,...
            a0max,a1start,a1min,a1max,fs,nt,nnHidden,autocorrLags,trainNNFlag]=...
            initConst(nightMinSize(i),nightStepSize(i),nightMaxSize(i),...
            nightTheta(i),nightTCelsius(i),5,nightLambda(i),nightSolvent(i),16000,32768, 150,999,1);
    
        [t,mTS,a0,a1]=batchGenTsStepSize('test',dMin,dStep,dMax,theta,lambda,...
            indref,eta,tcelsius,fs,nt,1);
    
        [dFitDLS,a0FitDLS,a1FitDLS,roF] = batchDLSFindA0A1RollOffFrequencySize ...
            (mTS, nightMinSize(i),nightMaxSize(i),nightStepSize(i),...
            1, (nightMaxSize(i)-nightMinSize(i))/nightStepSize(i)+1, 1, fs, ...
            theta, lambda, indref, eta, tcelsius,...
            a0start, a0min, a0max, a1start, a1min, a1max, 20, 'png', 0, 1);
    
        [dFitNN, acf,lags,deltaT] = dlsAutocorrNNTrainAndFitMem(mTS,nightMinSize(i), ...
            nightMaxSize(i),nightStepSize(i),1,(nightMaxSize(i)-nightMinSize(i))/nightStepSize(i)+1,...
            1,autocorrLags,fs,0,1,nnHidden);
        
        d=nightMinSize(i):nightStepSize(i):nightMaxSize(i);
    
        [errelFitDLS,errelFitNN,errabsFitDLS,errabsFitNN]=estimateErrFitDLSVsNN(d,dFitDLS,dFitNN,'png');
        
        [dclassical, dnn, durationClassical, durationNN, hisq, erabs, ...
            errel, toptimization] = batchDLSFitVsAutocorrNN (nightValidationTS,1,30,autocorrLags,fs,0,1);
        
        cd('..');
end
disp('[+++] Overnight Run Complete');