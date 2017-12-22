function [roF] = batchDLSRollOffFrequencySize (a0,a1,startSize,endSize,stepSize,lambda,tcelsius,theta,indref,eta,fs, deltaFit, figType, dispMode)
%-------------------------------------------------------------------------------
% Version 20171119, Silviu Rei
% function [roF] = batchDLSRollOffFrequencySize (a0, a1, d, index1, index2, istep,lambda,tcelsius,theta,indref,eta,fs, deltaFit, figType, dispMode)
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
    deltaInterval = endSize - startSize;
    maxDeltaInterval = deltaInterval/stepSize+1;
    dn=startSize:stepSize:endSize;
    t0 = clock;
    for i=1:maxDeltaInterval
        tic
        a0n(i)=a0(i);
        a1n(i)=a1(i);
        roF(i)=dlsRollOffFrequency(dn(i),lambda,tcelsius,theta,indref,eta,a0n(i), a1n(i),fs,deltaFit,figType,dispMode);
        deltat = toc;
        timeLeft = deltat*(maxDeltaInterval-i);
        [h, m, s] = sec2time(timeLeft);
        disp(['[+++] Step ' num2str(i) ' out of ' num2str(maxDeltaInterval)...
            ', Time Left = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's']);
        %disp(['[+] Time left=' num2str(deltat*(index2-i)) ' seconds']);

    end
    
    figure(50);
    plot(dn,a0n);
    title('Lorentz Parameter a0');
    xlabel('Particle Size (nm)');
    ylabel('a0');
    figure(51);
    plot(dn,a1n);
    title('Lorentz Parameter a1');
    xlabel('Partice Size (nm)');
    ylabel('a1');
    figure(52);
    plot(dn,roF);
    title('Roll-off Frequency');
    xlabel('Particle Size (nm)');
    ylabel('Roll-off Frequency (Hz)');
    
    figureNameA0=['batchDlsRoFD_a0_d-' num2str(startSize) '-' num2str(endSize) '-' num2str(stepSize) '-' ...
        'lambda-' num2str(lambda) '-'...
        'temp-' num2str(tcelsius) '-'...
        'theta-' num2str(theta) '-'...
        'indref-' num2str(indref) '-'...
        'eta-' num2str(eta) '-'... 
        '_f-' num2str(fs)];
    figureNameA1=['batchDlsRoFD_a1_d-' num2str(startSize) '-' num2str(endSize) '-' num2str(stepSize) '-' ...
        'lambda-' num2str(lambda) '-'...
        'temp-' num2str(tcelsius) '-'...
        'theta-' num2str(theta) '-'...
        'indref-' num2str(indref) '-'...
        'eta-' num2str(eta) '-'... 
        '_f-' num2str(fs)];
    figureNameRoF=['batchDlsRoFD_roF_d-' num2str(startSize) '-' num2str(endSize) '-' num2str(stepSize) '-' ...
        'lambda-' num2str(lambda) '-'...
        'temp-' num2str(tcelsius) '-'...
        'theta-' num2str(theta) '-'...
        'indref-' num2str(indref) '-'...
        'eta-' num2str(eta) '-'... 
        '_f-' num2str(fs)];

    saveas(50,figureNameA0,figType);
    saveas(51,figureNameA1,figType);
    saveas(52,figureNameRoF,figType);
    
    save([figureNameRoF '.txt'],'roF','-ascii');
