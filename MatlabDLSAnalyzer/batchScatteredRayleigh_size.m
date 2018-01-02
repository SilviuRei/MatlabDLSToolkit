function [iS, d, dThreshold] = batchScatteredRayleigh_size(np,iThreshold,laserPower,laserSpotDiameter,theta,R,lambda,indref,~,dMin,dMax,dStep,dispMode,saveMode)

figNum = 1;

dMinnm = dMin*1.e-9;
dMaxnm = dMax*1.e-9;
dStepnm= dStep*1.e-9;
lambda=lambda*1.e-9;
theta=theta*pi/180;
laserSpotDiameter=laserSpotDiameter*1.e-3;
laserSpotArea = pi*((laserSpotDiameter/2)^2);
iZero = laserPower/laserSpotArea;
R=R*1.e-3;

maxSteps = int64((dMax-dMin)/dStep+1);
iS=zeros(1,maxSteps);
dnm=dMinnm:dStepnm:dMaxnm;
d=dMin:dStep:dMax;
for i=1:maxSteps
    iS(i)=scatteredRayleigh(iZero,theta,R,lambda,indref,dnm(i),np);
end

indexThreshold = 1;
dThreshold = 0;
for i=2:maxSteps
    if (iS(i) - iThreshold)*(iS(i-1)-iThreshold) < 0
        indexThreshold = i-1;
        dThreshold = d(i-1);
        break;
    end
end

if dispMode == 1
    figure(figNum);
else
    figNum=figure('visible','off');
end

plot(d,iS, 'b-');
ylabel('Scattered Intensity (W/m2)');
xlabel('Particle Size (nm)');
xlim([dMin dMax]);
if dThreshold > 0
    hold on;
    pslimy=get(gca,'ylim');
    pslimx=get(gca,'xlim');
    plot([dThreshold dThreshold], pslimy, 'r--');
    plot(pslimx, [iS(indexThreshold) iS(indexThreshold)], 'r--');
    hold off;
    legend('Scattered Intensity','Minimum Detectable Intensity (0.001 W/m2)');
end

if saveMode == 1
    figName=['plot_I_lasPow-' num2str(laserPower) '-lasSpotDiam-' num2str(laserSpotDiameter)...
        'theta-' num2str(theta) ...
        '-R-' num2str(R) '-lambda-' num2str(lambda) '-indref-' num2str(indref)...
        '-d-' num2str(dMin) '-' num2str(dStep) '-' num2str(dMax) ...
        '-np-' num2str(np) '-iThreshold-' num2str (iThreshold) '.png'];
    saveas(figNum,figName,'png');
end


