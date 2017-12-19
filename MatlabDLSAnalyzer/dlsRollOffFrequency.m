function [roF] = dlsRollOffFrequency (pSize, a0, a1, frequency, deltaFit, figType, dispMode)
%-------------------------------------------------------------------------------
% Version 20171117, Silviu Rei
% function [roF] = dlsRollOffFrequency (a0, a1, index1, index2, istep, frequency)
%   The function finds the roll-off Frequency from the Power Spectral
%   Density for a Dynamic Light Scattering Lorentzian function
%	Input:
%       pSize       = particle size in nm
%       a0,a1       = Lorentz function parameters
%       frequency   = acquisition frequency in Hz
%       deltaFit    = number of linear fitting points
%       figType     = figure type (ex: 'png')
%       dispMode    = if 1 then display graphs
%	Output:
%		roF         = roll-off frequency in Hz
%	Example:
%		roF = dlsRollOffFrequency (100, a0(100), a1(100), 16000, 20, 'png', 1);
%-------------------------------------------------------------------------------

f=1:1:frequency/2; %if frequency=Acquisition frequency, then the range goes up to Nyquist frequency
s=florentz3(a0,a1,f);
slog=log10(s);
flog=log10(f);
p1=polyfit(flog(1:deltaFit),slog(1:deltaFit),1);
p2=polyfit(flog((frequency/2-deltaFit):(frequency/2)),slog((frequency/2-deltaFit):(frequency/2)),1);
s1fit=polyval(p1,flog);
s2fit=polyval(p2,flog);
flogIntersect = fzero(@(x) polyval(p1-p2,x),3);
roF = 10^flogIntersect;

%if dispMode==1
    figure(1);
    plot(f,s);
    title(['Frequency Spectrum - Lorentz Function' newline 'Size=' num2str(pSize), ' nm']);
    xlabel('Frequency (Hz)');
    ylabel('Power Spectrum');
    hold on;
    pslim=get(gca,'ylim');
    plot([roF, roF], pslim, 'b--');
    hold off;

    figure(2);
    plot(flog,slog,'b');
    title(['Frequency Spectrum - Lorentz Function. Logarithmic Scale' newline 'Size=' num2str(pSize) ' nm']);
    xlabel('Frequency (log Hz)');
    ylabel('Power Spectrum');
    hold on;
    plot(flog,s1fit,'r--');
    plot(flog,s2fit,'r--');
    pslim=get(gca,'ylim');
    plot([flogIntersect flogIntersect], pslim, 'b--');
    hold off;
    
    figureName1=[num2str(pSize) '_a0-' num2str(a0) '_a1' num2str(a1) '_f-' num2str(frequency) '.png'];
    figureName2=[num2str(pSize) '_log_a0-' num2str(a0) '_a1' num2str(a1) '_f-' num2str(frequency) '.png'];
    saveas(1,figureName1,figType);
    saveas(2,figureName2,figType);    
end
