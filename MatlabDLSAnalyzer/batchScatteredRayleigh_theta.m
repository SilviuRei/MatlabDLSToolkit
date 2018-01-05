function [iS,theta,theta1Threshold,theta2Threshold] = batchScatteredRayleigh_theta(np,iThreshold,laserPower,laserSpotDiameter,~,R,lambda,indref,d,thetaMin,thetaMax,thetaStep,dispMode,saveMode)

figNum = 1;

d=d*1.e-9;
lambda=lambda*1.e-9;
laserSpotDiameter=laserSpotDiameter*1.e-3;
laserSpotArea = pi*((laserSpotDiameter/2)^2);
iZero = laserPower/laserSpotArea;
R=R*1.e-3;

maxSteps = int64((thetaMax-thetaMin)/thetaStep+1);
iS=zeros(1,maxSteps);
thetarad=zeros(1,maxSteps);
theta=thetaMin:thetaStep:thetaMax;
for i=1:maxSteps
    thetarad(i)=theta(i)*pi/180;
    iS(i)=scatteredRayleigh(iZero,thetarad(i),R,lambda,indref,d,np);
end

theta1Threshold = 0;
theta2Threshold = 0;
index1Threshold = 1;
index2Threshold = 1;
for i=2:maxSteps
    if (iS(i)-iThreshold)*(iS(i-1)-iThreshold) < 0
        index1Threshold = i-1;
        theta1Threshold = theta(i-1);
        break;
    end
end
for i=(index1Threshold+2):maxSteps
    if (iS(i)-iThreshold)*(iS(i-1)-iThreshold) < 0
        index2Threshold = i-1;
        theta2Threshold = theta(i-1);
        break;
    end
end

if dispMode == 1
    figure(figNum);
else
    figNum=figure('visible','off');
end

plot(theta,iS, 'b-');
xlabel('Scattering Angle (deg)');
ylabel('Scattered Intensity (W/m2)');
xlim([thetaMin thetaMax]);
hold on;
pslimy=get(gca,'ylim');
pslimx=get(gca,'xlim');
if theta1Threshold > 0
    plot([theta1Threshold, theta1Threshold], pslimy, 'r--');
    plot(pslimx,[iThreshold iThreshold], 'r--');
end
if theta2Threshold > 0
    plot([theta2Threshold, theta2Threshold], pslimy, 'r--');
    plot(pslimx,[iThreshold iThreshold], 'r--');
end
hold off;
if theta1Threshold > 0
    legend('Scattered Intensity','Minimum Detectable Intensity (0.001 W/m2)');
end
if theta2Threshold > 0
    legend('Scattered Intensity','Minimum Detectable Intensity (0.001 W/m2)');
end

if saveMode == 1 
  figName=['plot_IRayleighThetaThreshold-' num2str(theta1Threshold) '-' num2str(theta2Threshold) ...
	'_lasPow-' num2str(laserPower) '-lasSpotDiam-' num2str(laserSpotDiameter)  ...
        '-theta-' num2str(thetaMin) '-' num2str(thetaStep) '-' num2str(thetaMax) ...
        '-R-' num2str(R) '-lambda-' num2str(lambda) '-indref-' num2str(indref)...
        '-d-' num2str(d) ...
        '-np-' num2str(np) '-iThreshold-' num2str(iThreshold) '.png'];
    saveas(figNum,figName,'png');
end


