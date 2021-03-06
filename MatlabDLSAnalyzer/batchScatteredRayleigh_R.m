function [iS,R,RThreshold] = batchScatteredRayleigh_R(np,iThreshold,laserPower,laserSpotDiameter,theta,R,lambda,indref,d,RMin,RMax,RStep,dispMode,saveMode)

figNum = 1;

d=d*1.e-9;
lambda=lambda*1.e-9;
laserSpotDiameter=laserSpotDiameter*1.e-3;
laserSpotArea = pi*((laserSpotDiameter/2)^2);
iZero = laserPower/laserSpotArea;
Rm=R*1.e-3;
RMinm=RMin*1.e-3;
RMaxm=RMax*1.e-3;
RStepm=RStep*1.e-3;

maxSteps = int64((RMax-RMin)/RStep+1);
%maxStepsm = inte64((RMaxm-RMinm)/RStepm+1);

iS=zeros(1,maxSteps);
R=RMin:RStep:RMax;
Rm=RMinm:RStepm:RMaxm;
for i=1:maxSteps
    iS(i)=scatteredRayleigh(iZero,theta,Rm(i),lambda,indref,d,np);
end

RThreshold = 0;
indexThreshold = 1;
for i=2:maxSteps
    if (iS(i)-iThreshold)*(iS(i-1)-iThreshold) < 0
        indexThreshold = i-1;
        RThreshold = R(i-1);
        break;
    end
end

if dispMode == 1
    figure(figNum);
else
    figNum=figure('visible','off');
end

plot(R,iS, 'b-');
ylabel('Scattered Intensity (W/m2)');
xlabel('Distance Sensor-Scattering Volume (mm)');
xlim([RMin RMax]);
hold on;
pslimy=get(gca,'ylim');
pslimx=get(gca,'xlim');
plot([RThreshold RThreshold], pslimy, 'r--');
plot(pslimx, [iS(indexThreshold) iS(indexThreshold)], 'r--');
hold off;

legend('Scattered Intensity','Minimum Detectable Intensity (0.001 W/m2)');

if saveMode == 1
  figName=['plot_IRayleighRThreshold-' num2str(RThreshold)...
	'-lasPow-' num2str(laserPower)  ...
	'-lasSpotDiam-' num2str(laserSpotDiameter) ...
        '-theta-' num2str(theta) ...
        '-R-' num2str(RMin) '-' num2str(RStep) '-' num2str(RMax) ...
        '-lambda-' num2str(lambda) '-indref-' num2str(indref)...
        '-d-' num2str(d) '-' num2str(d) '-' num2str(d) ...
        '-np-' num2str(np) '-iThreshold-' num2str(iThreshold) '.png'];
    saveas(figNum,figName,'png');
end


