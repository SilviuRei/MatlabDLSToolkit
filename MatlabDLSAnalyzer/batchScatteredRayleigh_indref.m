function [iS,indref,indref1Threshold,indref2Threshold] = batchScatteredRayleigh_indref(np,iThreshold,laserPower,laserSpotDiameter,theta,R,lambda,~,d,indrefMin,indrefMax,indrefStep,dispMode,saveMode)

figNum = 1;

d=d*1.e-9;
lambda=lambda*1.e-9;
theta=theta*pi/180;
laserSpotDiameter=laserSpotDiameter*1.e-3;
laserSpotArea = pi*((laserSpotDiameter/2)^2);
iZero = laserPower/laserSpotArea;
R = R*1.e-3;

maxSteps = int64((indrefMax-indrefMin)/indrefStep+1);
iS=zeros(1,maxSteps);
indref=indrefMin:indrefStep:indrefMax;
for i=1:maxSteps
    iS(i)=scatteredRayleigh(iZero,theta,R,lambda,indref(i),d,np);
end

indref1Threshold = 0;
indref2Threshold = 0;
index1Threshold = 1;
index2Threshold = 1;
for i=2:maxSteps
    if (iS(i)-iThreshold)*(iS(i-1)-iThreshold) < 0
        index1Threshold = i-1;
        indref1Threshold = indref(i-1);
        break;
    end
end
for i=(index1Threshold+2):maxSteps
    if (iS(i)-iThreshold)*(iS(i-1)-iThreshold) < 0
        index2Threshold = i-1;
        indref2Threshold = indref(i-1);
        break;
    end
end

if dispMode == 1
    figure(figNum);
else
    figNum=figure('visible','off');
end

plot(indref,iS, 'b-');
ylabel('Scattered Intensity (W/m2)');
xlabel('Refractive Index');
xlim([indrefMin indrefMax]);

hold on;
pslimy=get(gca,'ylim');
pslimx=get(gca,'xlim');
if indref1Threshold > 0
    plot([indref1Threshold, indref1Threshold], pslimy, 'r--');
    plot(pslimx,[iThreshold iThreshold], 'r--');
end

if indref2Threshold > 0
    plot([indref2Threshold, indref2Threshold], pslimy, 'r--');
    plot(pslimx,[iThreshold iThreshold], 'r--');
end
hold off;

if indref1Threshold > 0
    legend('Scattered Intensity','Minimum Detectable Intensity (0.001 W/m2)');
end
if indref2Threshold > 0
    legend('Scattered Intensity','Minimum Detectable Intensity (0.001 W/m2)');
end

if saveMode == 1
  figName=['plot_I_lasPow-' num2str(laserPower) '-lasSpotDiam-' num2str(laserSpotDiameter) ...
        'theta-' num2str(theta) ...
        '-R-' num2str(R) '-lambda-' num2str(lambda) ...
        '-indref-' num2str(indrefMin) '-' num2str(indrefStep) '-' num2str(indrefMax) ...
        '-d-' num2str(d) ...
        '-np-' num2str(np) '-iThreshold-' num2str (iThreshold) '.png'];
    saveas(figNum,figName,'png');
end


