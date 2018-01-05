function [iS, laserPower, laserSpotDiameterThreshold] = batchScatteredRayleigh_laserSpotDiameter(np,iThreshold,laserPower,laserSpotDiameter,theta,R,lambda,indref,d,laserSpotDiameterMin,laserSpotDiameterMax,laserSpotDiameterStep,dispMode,saveMode)

figNum = 1;

d=d*1.e-9;
lambda=lambda*1.e-9;
theta=theta*pi/180;
laserSpotDiameterm=laserSpotDiameter*1.e-3;
laserSpotDiameterMinm=laserSpotDiameterMin*1.e-3;
laserSpotDiameterMaxm=laserSpotDiameterMax*1.e-3;
laserSpotDiameterStepm=laserSpotDiameterStep*1.e-3;
laserSpotAreaMin = pi*((laserSpotDiameterMinm/2)^2);
laserSpotAreaMax = pi*((laserSpotDiameterMaxm/2)^2);
laserSpotAreaStep = pi*((laserSpotDiameterStepm/2)^2);
%iZero = laserPower/laserSpotArea;
R = R*1.e-3;

%iZeroMin=laserPower/laserSpotAreaMin;
%iZeroMax=laserPower/laserSpotAreaMax;
%iZeroStep=laserPower/laserSpotAreaStep;

laserSpotDiameter=laserSpotDiameterMin:laserSpotDiameterStep:laserSpotDiameterMax;
laserSpotDiameterm=laserSpotDiameterMinm:laserSpotDiameterStepm:laserSpotDiameterMaxm;
laserSpotArea=laserSpotAreaMin:laserSpotAreaStep:laserSpotAreaMax;

maxSteps = int64((laserSpotDiameterMax-laserSpotDiameterMin)/laserSpotDiameterStep+1);
iS=zeros(1,maxSteps);
%iZero=iZeroMin:iZeroStep:iZeroMax;

for i=1:maxSteps
    iZero=laserPower/laserSpotArea(i);
    iS(i)=scatteredRayleigh(iZero,theta,R,lambda,indref,d,np);
end

laserSpotDiameterThreshold = 0;
indexThreshold = 1;
for i=2:maxSteps
    if (iS(i)-iThreshold)*(iS(i-1)-iThreshold) < 0
        indexThreshold = i-1;
        laserSpotDiameterThreshold = laserSpotDiameter(i);
        break;
    end
end

if dispMode == 1
    figure(figNum);
else
    figNum=figure('visible','off');
end

plot(laserSpotDiameter,iS, 'b-');
xlabel('Laser SpotDiameter (mm)');
ylabel('Scattered Intensity (W/m2)');
xlim([laserSpotDiameterMin laserSpotDiameterMax]);


if laserSpotDiameterThreshold > 0
    hold on;
    pslimy=get(gca,'ylim');
    pslimx=get(gca,'xlim');

    plot([laserSpotDiameterThreshold laserSpotDiameterThreshold], pslimy, 'r--');
    plot(pslimx,[iThreshold iThreshold], 'r--');
    legend('Scattered Intensity','Minimum Detectable Intensity (0.001 W/m2)');
    
    hold off;
end

if saveMode == 1
      figName=['plot_IRayleighlasSpotDiamThreshold-' num2str(laserSpotDiameterThreshold)...
        '_lasPow-' num2str(laserPower)...
        '-lasSpotDiam-' num2str(laserSpotDiameterMin) '-' num2str(laserSpotDiameterStep) ...
        '-' num2str(laserSpotDiameterMax)... 
        '-theta-' num2str(theta) ...
        '-R-' num2str(R) '-lambda-' num2str(lambda) '-indref-' num2str(indref)...
        '-d-' num2str(d) ...
        '-np-' num2str(np) '-iThreshold-' num2str(iThreshold) '.png'];
    saveas(figNum,figName,'png');
end


