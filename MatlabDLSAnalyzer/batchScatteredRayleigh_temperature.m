function [iS,temperature,temperature1Threshold,temperature2Threshold] = batchScatteredRayleigh_temperature(solvent,np,iThreshold,laserPower,laserSpotDiameter,theta,R,lambda,~,d,temperatureMin,temperatureMax,temperatureStep,dispMode,saveMode)

figNum=1;
temperature=temperatureMin:temperatureStep:temperatureMax;
temperature1Threshold=0;
temperature2Threshold=0;
indrefdummy=0;

pressure = 101.325; %kPa - normal air pressure
humidity = 0.5;
method = 'edlen';
xCO2 = 350;
densityMin=water_density(temperatureMin);
densityMax=water_density(temperatureMax);
maxSteps=(temperatureMax-temperatureMin)/temperatureStep+1;

if solvent == 1
    indrefMin=water_indref(temperatureMin,densityMin,lambda);
    indrefMax=water_indref(temperatureMax,densityMax,lambda);
elseif solvent == 2
    indrefMin=air_indref(wavelength,temperatureMin,pressure,humidity,method,xCO2);
    indrefMax=air_indref(wavelength,temperatureMax,pressure,humidity,method,xCO2);
end

if indrefMin>indrefMax
    tempvar=indrefMin;
    indrefMin=indrefMax;
    indrefMax=tempvar;
    tempvar=temperatureMin;
    temperatureMin=temperatureMax;
    temperatureMax=tempvar;
    temperatureStep=-1;
end

temperature=temperatureMin:temperatureStep:temperatureMax;
indrefStep=abs((indrefMax-indrefMin)/(maxSteps-1));
indref=indrefMin:indrefStep:indrefMax;

[iS,indref,indref1Threshold,indref2Threshold] = batchScatteredRayleigh_indref(np,iThreshold,laserPower,...
            laserSpotDiameter,theta,R,lambda,indrefdummy,d,indrefMin,indrefMax,indrefStep,0,0);

indref1Temperature = 0;
indref2Temperature = 0;
index1Threshold = 1;
index2Threshold = 1;
for i=2:maxSteps
    if (iS(i)-iThreshold)*(iS(i-1)-iThreshold) < 0
        index1Threshold = i-1;
        temperature1Threshold = temperature(i-1);
        break;
    end
end
for i=(index1Threshold+2):maxSteps
    if (iS(i)-iThreshold)*(iS(i-1)-iThreshold) < 0
        index2Threshold = i-1;
        temperature2Threshold = temperature(i-1);
        break;
    end
end

if dispMode == 1
    figure(figNum);
else
    figNum=figure('visible','off');
end

plot(temperature,iS, 'b-');
ylabel('Scattered Intensity (W/m2)');
xlabel('Temperature (C)');
if temperatureMin<temperatureMax
    xlim([temperatureMin temperatureMax]);
else
    xlim([temperatureMax temperatureMin]);
end

hold on;
pslimy=get(gca,'ylim');
pslimx=get(gca,'xlim');
if indref1Threshold > 0
    plot([temperature1Threshold, temperature1Threshold], pslimy, 'r--');
    plot(pslimx,[iThreshold iThreshold], 'r--');
end

if indref2Threshold > 0
    plot([temperature2Threshold, temperature2Threshold], pslimy, 'r--');
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
  figName=['plot_IRayleighTempThreshold-' num2str(temperature1Threshold) '-' num2str(temperature2Threshold) ...
	'_lasPow-' num2str(laserPower) '-lasSpotDiam-' num2str(laserSpotDiameter) ...
        '-theta-' num2str(theta) ...
        '-R-' num2str(R) '-lambda-' num2str(lambda) ...
        '-indref-' num2str(indrefMin) '-' num2str(indrefStep) '-' num2str(indrefMax) ...
        '-temperature-' num2str(temperatureMin) '-' num2str(temperatureStep) '-' num2str(temperatureMax) ...
        '-d-' num2str(d) ...
        '-np-' num2str(np) '-iThreshold-' num2str (iThreshold) '.png'];
    saveas(figNum,figName,'png');
end

