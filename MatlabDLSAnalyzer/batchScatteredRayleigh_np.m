function [iS, np, npThreshold] = batchScatteredRayleigh_np(np,iThreshold,laserPower,laserSpotDiameter,theta,R,lambda,indref,d,npMin,npMax,npStep,dispMode,saveMode)

figNum = 1;

d=d*1.e-9;
lambda=lambda*1.e-9;
theta=theta*pi/180;
laserSpotDiameter=laserSpotDiameter*1.e-3;
laserSpotArea = pi*((laserSpotDiameter/2)^2);
iZero = laserPower/laserSpotArea;
R = R*1.e-3;

np=logspace(npMin,npMax,npStep);
[~,maxSteps] = size(np);
iS=zeros(1,maxSteps);
for i=1:maxSteps
    iS(i)=scatteredRayleigh(iZero,theta,R,lambda,indref,d,np(i));
end

indexThreshold = 1;
npThreshold=0;
for i=2:maxSteps
    if iS(i) > iThreshold
        indexThreshold = i-1;
        npThreshold = np(i-1);
        break;
    end
end


if dispMode == 1
    figure(figNum);
else
    figNum=figure('visible','off');
end

plot(np,iS, 'b-');
ylabel('Scattered Intensity (W/m2)');
xlabel('Number of Particles in the Scattering Volume');
xlim([np(1) np(maxSteps)]);

if npThreshold > 0
  hold on;
  pslimy=get(gca,'ylim');
  pslimx=get(gca,'xlim');
  plot([npThreshold npThreshold], pslimy, 'r--');
  plot(pslimx, [iS(indexThreshold) iS(indexThreshold)], 'r--');
  hold off;
  legend('Scattered Intensity','Minimum Detectable Intensity (0.001 W/m2)');
end

if saveMode == 1
  figName=['plot_IRayleighNPThreshold-' num2str(npThreshold)...
	'lasPow-' num2str(laserPower)  ...
        '-lasSpotDiam-' num2str(laserSpotDiameter) ...
        '-theta-' num2str(theta) ...
        '-R-' num2str(R) '-lambda-' num2str(lambda) '-indref-' num2str(indref)...
        '-d-' num2str(d) ...
        '-np-' num2str(npMin) '-' num2str(npStep) '-' num2str(npMax) '-iThreshold-' num2str(iThreshold) '.png'];
    saveas(figNum,figName,'png');
end


