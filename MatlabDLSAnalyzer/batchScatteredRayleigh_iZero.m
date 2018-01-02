function [iS, i0, i0Threshold] = batchScatteredRayleigh_iZero(np,iThreshold,iZero,theta,R,lambda,indref,d,iMin,iMax,iStep,dispMode,saveMode)

figNum = 1;
d=d*1.e-9;
lambda=lambda*1.e-9;
theta=theta*pi/180;
maxSteps = int64((iMax-iMin)/iStep+1);
iS=zeros(1,maxSteps);
i0=iMin:iStep:iMax;
for i=1:maxSteps
    iS(i)=scatteredRayleigh(i0(i),theta,R,lambda,indref,d,np);
end
iSZero=scatteredRayleigh(iZero,theta,R,lambda,indref,d,np);

i0Threshold = 0;
indexThreshold = 1;
for i=2:maxSteps
    if (iS(i)-iThreshold)*(iS(i-1)-iThreshold) < 0
        indexThreshold = i;
        i0Threshold = i0(i);
        break;
    end
end

if dispMode == 1
    figure(figNum);
else
    figNum=figure('visible','off');
end

plot(i0,iS, 'b-');
xlabel('Initial Intensity (W/m2)');
ylabel('Scattered Intensity (W/m2)');
xlim([iMin iMax]);

hold on;
pslimy=get(gca,'ylim');
pslimx=get(gca,'xlim');
plot([iZero iZero], pslimy, 'r--');
plot([i0Threshold, i0Threshold], pslimy, 'g--');
plot(pslimx,[iSZero iSZero], 'r--');
plot(pslimx, [iS(indexThreshold) iS(indexThreshold)], 'g--');
hold off;

legend('Scattered Intensity','LED Laser Intensity','Minimum Detectable Intensity (0.001 W/m2)');

if saveMode == 1
      figName=['plot_I_I0-' num2str(iZeroMin) '-' num2str(iZeroStep) '-' num2str(iZeroMax)  ...
        'theta-' num2str(theta) ...
        '-R-' num2str(R) '-lambda-' num2str(lambda) '-indref-' num2str(indref)...
        '-d-' num2str(d) ...
        '-np-' num2str(np) '-iThreshold-' num2str (iThreshold) '.png'];
    saveas(figNum,figName,'png');
end


