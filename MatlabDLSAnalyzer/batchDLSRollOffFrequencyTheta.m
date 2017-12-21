function [roF] = batchDLSRollOffFrequencyTheta (a0,a1,startTheta,endTheta,stepTheta,lambda,tcelsius,pSize,indref,eta,fs, deltaFit, figType, dispMode)
%-------------------------------------------------------------------------------
% Version 20171120, Silviu Rei
% function [roF] = batchDLSRollOffFrequencyTheta (a0,a1,startTheta,endTheta,stepTheta,lambda,tcelsius,pSize,indref,eta,fs, deltaFit, figType, dispMode)
%   The function finds the roll-off Frequency from the Power Spectral
%   Density for a Dynamic Light Scattering Lorentzian function
%   in batch mode, looping for theta.
%	Input:
%       a0,a1       = Lorentz function parameters (vectors)
%       startTheta  = start theta in RAD
%       endTheta    = end theta in RAD
%       stepTheta   = theta step in RAD
%       lambda      = laser light wavelength (nm)
%       tcelsius    = temperature (C)
%       pSize       = particle size in nm
%       indref      = refractive index
%       eta         = viscosity
%       fs          = acquisition frequency in Hz
%       deltaFit    = number of linear fitting points
%       figType     = figure type (ex: 'png')
%       dispMode    = if 1 then display graphs
%	Output:
%		roF         = roll-off frequency in Hz
%	Example:
%
%-------------------------------------------------------------------------------
    deltaInterval = endTheta - startTheta;
    maxDeltaInterval = deltaInterval/stepTheta+1;
    thetan=startTheta:stepTheta:endTheta;
    t0 = clock;
    for i=1:maxDeltaInterval
        tic
        a0n(i)=a0(i);
        a1n(i)=a1(i);
        roF(i)=dlsRollOffFrequency(pSize,lambda,tcelsius,thetan(i),indref,eta,a0n(i), a1n(i),fs,deltaFit,figType,dispMode);
        deltat = toc;
        timeLeft = deltat*(maxDeltaInterval-i);
        [h, m, s] = sec2time(timeLeft);
        disp(['[+++] Time Left = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's']);
        %disp(['[+] Time left=' num2str(deltat*(index2-i)) ' seconds']);

    end
    
    figure(5);
    plot(thetan,a0n);
    title('Lorentz Parameter a0');
    xlabel('Theta (RAD)');
    ylabel('a0');
    figure(6);
    plot(thetan,a1n);
    title('Lorentz Parameter a1');
    xlabel('Theta (RAD)');
    ylabel('a1');
    figure(7);
    plot(thetan,roF);
    title('Roll-off Frequency');
    xlabel('Theta (RAD)');
    ylabel('Roll-off Frequency (Hz)');
    
    figureNameA0=['batchDlsRoFD_a0_theta-' num2str(startTheta) '-' num2str(endTheta) '-' num2str(stepTheta) '-' ...
        'lambda-' num2str(lambda) '-'...
        'temp-' num2str(tcelsius) '-'...
        'd-' num2str(pSize) '-'...
        'indref-' num2str(indref) '-'...
        'eta-' num2str(eta) '-'... 
        '_f-' num2str(fs)];
    figureNameA1=['batchDlsRoFD_a1_theta-' num2str(startTheta) '-' num2str(endTheta) '-' num2str(stepTheta) '-' ...
        'lambda-' num2str(lambda) '-'...
        'temp-' num2str(tcelsius) '-'...
        'd-' num2str(pSize) '-'...
        'indref-' num2str(indref) '-'...
        'eta-' num2str(eta) '-'... 
        '_f-' num2str(fs)];
    figureNameRoF=['batchDlsRoFD_roF_theta-' num2str(startTheta) '-' num2str(endTheta) '-' num2str(stepTheta) '-' ...
        'lambda-' num2str(lambda) '-'...
        'temp-' num2str(tcelsius) '-'...
        'd-' num2str(pSize) '-'...
        'indref-' num2str(indref) '-'...
        'eta-' num2str(eta) '-'... 
        '_f-' num2str(fs)];

    saveas(5,figureNameA0,figType);
    saveas(6,figureNameA1,figType);
    saveas(7,figureNameRoF,figType);
    
    save(figureNameRoF,'roF','-ascii');
