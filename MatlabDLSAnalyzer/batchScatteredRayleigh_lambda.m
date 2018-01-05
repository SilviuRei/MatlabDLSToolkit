function [iS,lambda,lambdaThreshold] = batchScatteredRayleigh_lambda(np,iThreshold,laserPower,laserSpotDiameter,theta,R,lambda,indref,d,lambdaMin,lambdaMax,lambdaStep,dispMode,saveMode)

figNum = 1;

d=d*1.e-9;
lambda=lambda*1.e-9;
lambdaMinm=lambdaMin*1.e-9;
lambdaMaxm=lambdaMax*1.e-9;
lambdaStepm=lambdaStep*1.e-9;
laserSpotDiameter=laserSpotDiameter*1.e-3;
laserSpotArea = pi*((laserSpotDiameter/2)^2);
iZero = laserPower/laserSpotArea;
R=R*1.e-3;

lambda=lambdaMin:lambdaStep:lambdaMax;
lambdam=lambdaMinm:lambdaStepm:lambdaMaxm;

maxSteps = int64((lambdaMax-lambdaMin)/lambdaStep+1);
iS=zeros(1,maxSteps);

for i=1:maxSteps
    iS(i)=scatteredRayleigh(iZero,theta,R,lambdam(i),indref,d,np);
end

lambdaThreshold = 0;
indexThreshold = 1;
for i=2:maxSteps
    if (iS(i)-iThreshold)*(iS(i-1)-iThreshold) < 0
        indexThreshold = i-1;
        lambdaThreshold = lambda(i-1);
        break;
    end
end

if dispMode == 1
    figure(figNum);
else
    figNum=figure('visible','off');
end

plot(lambda,iS, 'b-');
ylabel('Scattered Intensity (W/m2)');
xlabel('Light Wavelength (nm)');
xlim([lambdaMin lambdaMax]);
hold on;
pslimy=get(gca,'ylim');
pslimx=get(gca,'xlim');
plot([lambdaThreshold lambdaThreshold], pslimy, 'r--');
plot(pslimx, [iS(indexThreshold) iS(indexThreshold)], 'r--');
hold off;

legend('Scattered Intensity','Minimum Detectable Intensity (0.001 W/m2)');

if saveMode == 1
  figName=['plot_IRayleighLambdaThreshold-' num2str(lambdaThreshold) ...
	'-lasPow-' num2str(laserPower) '-lasSpotDiam-' num2str(laserSpotDiameter)  ...
        '-theta-' num2str(theta) ...
        '-R-' num2str(R) '-lambda-' num2str(lambdaMin) '-' num2str(lambdaStep) ...
        '-' num2str(lambdaMax) '-indref-' num2str(indref)...
        '-d-' num2str(d) '-' num2str(d) '-' num2str(d) ...
        '-np-' num2str(np) '-iThreshold-' num2str(iThreshold) '.png'];
    saveas(figNum,figName,'png');
end


