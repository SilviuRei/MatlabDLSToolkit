function [iThreshold,laserPower,laserSpotDiameter,theta,R,lambda,indref,d,np] = initConstantsScatteredRayleigh ()

iThreshold=0.001;
theta = 90;%degrees
R = 10;%mm
lambda = 650;%nm
indref = 1.55;
d = 5;%nm
laserPower = 1.e-3;%W
laserSpotDiameter = 1;%mm
%spotArea = pi*((spotSize/2)^2);
%iZero = laserPower/spotArea;
np=1.e+15;


