function [roF] = batchDLSRollOffFrequency (a0, a1, d, index1, index2, istep,lambda,tcelsius,theta,indref,eta,frequency, deltaFit, figType, dispMode)
%-------------------------------------------------------------------------------
% Version 20171119, Silviu Rei
% function [roF] = batchDLSRollOffFrequency (a0, a1, d, index1, index2, istep, frequency, deltaFit, figType, dispMode)
%   The function finds the roll-off Frequency from the Power Spectral
%   Density for a Dynamic Light Scattering Lorentzian function
%   in batch mode
%	Input:
%       a0,a1       = Lorentz function parameters (vectors)
%       d           = particle sizes vector
%       index1      = start size
%       index2      = end size
%       istep       = size step
%       lambda      = laser light wavelength (nm)
%       tcelsius    = temperature (C)
%       theta       = scattering angle (rad)
%       indref      = refractive index
%       eta         = viscosity
%       frequency   = acquisition frequency in Hz
%       deltaFit    = number of linear fitting points
%       figType     = figure type (ex: 'png')
%       dispMode    = if 1 then display graphs
%	Output:
%		roF         = roll-off frequency in Hz
%	Example:
%		[roF] = batchDLSRollOffFrequency (a0, a1, d, index1, index2, istep, frequency, deltaFit, figType, dispMode)
%-------------------------------------------------------------------------------
    deltaInterval = index2 - index1;
    maxDeltaInterval = deltaInterval/istep;
    t0 = clock;
    for i=1:maxDeltaInterval
        tic
        a0n(i)=a0(istep*i);
        a1n(i)=a1(istep*i);
        dn(i)=d(istep*i);
        roF(i)=dlsRollOffFrequency(dn(i),lambda,tcelsius,theta,indref,eta,a0n(i), a1n(i), frequency, deltaFit, figType, dispMode);
        deltat = toc;
        timeLeft = deltat*(maxDeltaInterval-i);
        [h, m, s] = sec2time(timeLeft);
        disp(['[+++] Time Left = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's']);
        %disp(['[+] Time left=' num2str(deltat*(index2-i)) ' seconds']);

    end
    
    figure(5);
    plot(dn,a0n);
    title('Lorentz Parameter a0');
    title(['Lorentz Parameter a0' ...
        newline 'Lambda=' num2str(lambda) ' nm' ...
        newline 'Temperature=' num2str(tcelsius) ' C' ...
        newline 'Theta=' num2str(theta) ' RAD' ...
        newline 'Refractive Index=' num2str(indref) ...
        newline 'Viscosity=' num2str(eta) ' Nm/s2']);
    xlabel('Particle Size (nm)');
    ylabel('a0');
    figure(6);
    plot(dn,a1n);
    title(['Lorentz Parameter a1'...
        newline 'Lambda=' num2str(lambda) ' nm' ...
        newline 'Temperature=' num2str(tcelsius) ' C' ...
        newline 'Theta=' num2str(theta) ' RAD' ...
        newline 'Refractive Index=' num2str(indref) ...
        newline 'Viscosity=' num2str(eta) ' Nm/s2']);
    xlabel('Partice Size (nm)');
    ylabel('a1');
    figure(7);
    plot(dn,roF);
    title(['Roll-off Frequency'...
        newline 'Lambda=' num2str(lambda) ' nm' ...
        newline 'Temperature=' num2str(tcelsius) ' C' ...
        newline 'Theta=' num2str(theta) ' RAD' ...
        newline 'Refractive Index=' num2str(indref) ...
        newline 'Viscosity=' num2str(eta) ' Nm/s2']);
    xlabel('Particle Size (nm)');
    ylabel('Roll-off Frequency (Hz)');
    
    figureNameA0=['dls_a0-' ...
        '-lambda-' num2str(lambda)...
        '-tcelsius-' num2str(tcelsius)...
        '-theta-' num2str(theta)...
        '-indref-' num2str(indref) ...
        '-eta-' num2str(eta) ...
        '-d-' num2str(d(index1)) '-' num2str(d(istep)) '-' num2str(d(index2))];
    figureNameA1=['dls_a1-'...
        '-lambda-' num2str(lambda)...
        '-tcelsius-' num2str(tcelsius)...
        '-theta-' num2str(theta)...
        '-indref-' num2str(indref) ...
        '-eta-' num2str(eta) ...
        '-d-' num2str(d(index1)) '-' num2str(d(istep)) '-' num2str(d(index2))];
    figureNameRoF=['dls_RollOffFrequency-' ...
        '-lambda-' num2str(lambda)...
        '-tcelsius-' num2str(tcelsius)...
        '-theta-' num2str(theta)...
        '-indref-' num2str(indref) ...
        '-eta-' num2str(eta) ...
        '-d-' num2str(d(index1)) '-' num2str(d(istep)) '-' num2str(d(index2))];
    
    saveas(5,figureNameA0,figType);
    saveas(6,figureNameA1,figType);
    saveas(7,figureNameRoF,figType);
    
    fileNameRoF=['roF-' ...
        '-lambda-' num2str(lambda)...
        '-tcelsius-' num2str(tcelsius)...
        '-theta-' num2str(theta)...
        '-indref-' num2str(indref) ...
        '-eta-' num2str(eta) ...
        '-d-' num2str(d(index1)) '-' num2str(d(istep)) '-' num2str(d(index2))...
        '.txt'];
    save(fileNameRoF,'roF','-ascii');
