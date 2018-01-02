function [iS, laserPower, laserPowerThreshold] = batchScatteredRayleigh_laserPower(np,iThreshold,laserPower,laserSpotDiameter,theta,R,lambda,indref,d,laserPowerMin,laserPowerMax,laserPowerStep,dispMode,saveMode)

figNum = 1;

d=d*1.e-9;
lambda=lambda*1.e-9;
theta=theta*pi/180;
laserSpotDiameter=laserSpotDiameter*1.e-3;
laserSpotArea = pi*((laserSpotDiameter/2)^2);
%iZero = laserPower/laserSpotArea;
R = R*1.e-3;
iZeroMin=laserPowerMin/laserSpotArea;
iZeroMax=laserPowerMax/laserSpotArea;
iZeroStep=laserPowerStep/laserSpotArea;
laserPower=laserPowerMin:laserPowerStep:laserPowerMax;

maxSteps = int64((laserPowerMax-laserPowerMin)/laserPowerStep+1);
iS=zeros(1,maxSteps);
iZero=iZeroMin:iZeroStep:iZeroMax;

for i=1:maxSteps
    iS(i)=scatteredRayleigh(iZero(i),theta,R,lambda,indref,d,np);
end

laserPowerThreshold = 0;
indexThreshold = 1;
for i=2:maxSteps
    if (iS(i)-iThreshold)*(iS(i-1)-iThreshold) < 0
        indexThreshold = i-1;
        laserPowerThreshold = laserPower(i-1);
        break;
    end
end

if dispMode == 1
    figure(figNum);
else
    figNum=figure('visible','off');
end

plot(laserPower,iS, 'b-');
xlabel('Laser Power (W)');
ylabel('Scattered Intensity (W/m2)');
xlim([laserPowerMin laserPowerMax]);


if laserPowerThreshold > 0
    hold on;
    pslimy=get(gca,'ylim');
    pslimx=get(gca,'xlim');

    plot([laserPowerThreshold laserPowerThreshold], pslimy, 'r--');
    plot(pslimx,[iThreshold iThreshold], 'r--');
    legend('Scattered Intensity','Minimum Detectable Intensity (0.001 W/m2)');
    
    hold off;
end



if saveMode == 1
      figName=['plot_I_lasPow-' num2str(laserPowerMin) '-' num2str(laserPowerStep) '-' num2str(laserPowerMax)  ...
        '-lasSpotDiam-' num2str(laserPowerDiameter) ... 
        'theta-' num2str(theta) ...
        '-R-' num2str(R) '-lambda-' num2str(lambda) '-indref-' num2str(indref)...
        '-d-' num2str(d) ...
        '-np-' num2str(np) '-iThreshold-' num2str (iThreshold) '.png'];
    saveas(figNum,figName,'png');
end


