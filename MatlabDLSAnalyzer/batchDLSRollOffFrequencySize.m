function [roF] = batchDLSRollOffFrequencySize (a0,a1,startSize,endSize,...
    stepSize,lambda,tcelsius,theta,indref,eta,fs, deltaFit, figType, dispMode)
%-------------------------------------------------------------------------------
% Version 20171125, Silviu Rei
% function [roF] = batchDLSRollOffFrequencySize (a0,a1,startSize,endSize,...
%    stepSize,lambda,tcelsius,theta,indref,eta,fs, deltaFit, figType, dispMode)
%   The function finds the roll-off Frequency from the Power Spectral
%   Density for a Dynamic Light Scattering Lorentzian function
%   in batch mode, looping for size.
%	Input:
%       a0,a1       = Lorentz function parameters (vectors)
%       startSize   = start size
%       endSize     = end size
%       stepSize    = size step
%       lambda      = laser light wavelength (nm)
%       tcelsius    = temperature (C)
%       theta       = scattering angle (rad)
%       indref      = refractive index
%       eta         = viscosity
%       fs          = acquisition frequency in Hz
%       deltaFit    = number of linear fitting points
%       figType     = figure type (ex: 'png')
%       dispMode    = if 1 then display graphs
%	Output:
%		roF         = roll-off frequency in Hz
%	Example:
%		[roF] = batchDLSRollOffFrequencySize (a0,a1,5,30,5,lambda,tcelsius,theta,indref,eta,16000, 20, 'png', 1);
%-------------------------------------------------------------------------------
    disp('-----------------------------------------------------------------');
    disp('[+++] DLS Fit: Find Roll-off Frequency Started');
    disp(['Using d-' num2str(startSize) '-' num2str(endSize) '-' num2str(stepSize) '-' ...
        'lambda-' num2str(lambda) '-'...
        'temp-' num2str(tcelsius) '-'...
        'theta-' num2str(theta) '-'...
        'indref-' num2str(indref) '-'...
        'eta-' num2str(eta) '-'... 
        '_f-' num2str(fs)]);
    figureNumber1 = 50;
    figureNumber2 = 51;
    figureNumber3 = 53;
    h=999;
    m=999;
    s=999;
    deltaInterval = endSize - startSize;
    maxDeltaInterval = deltaInterval/stepSize+1;
    dn=startSize:stepSize:endSize;
    a0n=zeros(1,maxDeltaInterval);
    a1n=zeros(1,maxDeltaInterval);
    roF=zeros(1,maxDeltaInterval);
    waitbarHandle = waitbar(0,['DLS Roll-off Frequency Search...' ...
        newline 'Step:' ...
        newline 'Time Left =' ...
        newline 'Progress: 0%']);
    for i=1:maxDeltaInterval
        tic
        disp(['[+++] Step ' num2str(i) ' out of ' num2str(maxDeltaInterval)...
            ', Time Left = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's']);
        waitbar((i-1)/maxDeltaInterval, waitbarHandle,['DLS Roll-off Frequency Search...' ...
            newline 'Step: ' num2str(i) ' out of ' num2str(maxDeltaInterval)  ...
            newline 'Time Left = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's' ...
            newline 'Progress: ' num2str(100*(i-1)/maxDeltaInterval) ' %']);
        a0n(i)=a0(i);
        a1n(i)=a1(i);
        roF(i)=dlsRollOffFrequency(dn(i),lambda,tcelsius,theta,indref,eta,...
            a0n(i), a1n(i),fs,deltaFit,figType,dispMode);
        deltat = toc;
        timeLeft = deltat*(maxDeltaInterval-i);
        [h, m, s] = sec2time(timeLeft);
    end
    close(waitbarHandle);
    
    if dispMode == 1
        figure(figureNumber1);
    elseif dispMode == 0
        figureNumber1 = figure('visible', 'off');
    end
    plot(dn,a0n);
    title('Lorentz Parameter a0');
    xlabel('Particle Size (nm)');
    ylabel('a0');
    
    if dispMode == 1
        figure(figureNumber2);
    elseif dispMode == 0
        figureNumber2 = figure('visible', 'off');
    end
    plot(dn,a1n);
    title('Lorentz Parameter a1');
    xlabel('Partice Size (nm)');
    ylabel('a1');
    
    if dispMode == 1
        figure(figureNumber3);
    elseif dispMode == 0
        figureNumber3 = figure('visible', 'off');
    end
    plot(dn,roF);
    title('Roll-off Frequency');
    xlabel('Particle Size (nm)');
    ylabel('Roll-off Frequency (Hz)');
    
    figureNameA0=['plot_dlsRoF_a0_d-' num2str(startSize) '-' num2str(endSize) '-' num2str(stepSize) '-' ...
        'lambda-' num2str(lambda) '-'...
        'temp-' num2str(tcelsius) '-'...
        'theta-' num2str(theta) '-'...
        'indref-' num2str(indref) '-'...
        'eta-' num2str(eta) '-'... 
        '_f-' num2str(fs)];
    figureNameA1=['plot_dlsRoF_a1_d-' num2str(startSize) '-' num2str(endSize) '-' num2str(stepSize) '-' ...
        'lambda-' num2str(lambda) '-'...
        'temp-' num2str(tcelsius) '-'...
        'theta-' num2str(theta) '-'...
        'indref-' num2str(indref) '-'...
        'eta-' num2str(eta) '-'... 
        '_f-' num2str(fs)];
    figureNameRoF=['plot_dlsRoF_RoF_d-' num2str(startSize) '-' num2str(endSize) '-' num2str(stepSize) '-' ...
        'lambda-' num2str(lambda) '-'...
        'temp-' num2str(tcelsius) '-'...
        'theta-' num2str(theta) '-'...
        'indref-' num2str(indref) '-'...
        'eta-' num2str(eta) '-'... 
        '_f-' num2str(fs)];
    fileNameRoF=['dlsRoF_RoF_d-' num2str(startSize) '-' num2str(endSize) '-' num2str(stepSize) '-' ...
        'lambda-' num2str(lambda) '-'...
        'temp-' num2str(tcelsius) '-'...
        'theta-' num2str(theta) '-'...
        'indref-' num2str(indref) '-'...
        'eta-' num2str(eta) '-'... 
        '_f-' num2str(fs)];

    saveas(figureNumber1,figureNameA0,figType);
    disp(['   [+] Figure Saved: ' figureNameA0]);

    saveas(figureNumber2,figureNameA1,figType);
    disp(['   [+] Figure Saved: ' figureNameA1]);

    saveas(figureNumber3,figureNameRoF,figType);
    disp(['   [+] Figure Saved: ' figureNameRoF]);
    
    save([fileNameRoF '.txt'],'roF','-ascii');
    disp(['   [+] File Saved: ' fileNameRoF '.txt']);

disp('[+++] DLS Fit: Find Roll-off Frequency Execution Complete');
