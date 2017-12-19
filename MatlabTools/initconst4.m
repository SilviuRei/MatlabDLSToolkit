function [indref,lambda,tcelsius,theta]=initconst4(thetagrade)
%
% functia doar initializeaza constantele pentru generare de serii temporale dls
% apelare:
% [indref,lambda,tcelsius,theta]=initconst1
%
indref=1.333;
lambda=633;
tcelsius=20;
theta=thetagrade*pi/180;
rand('twister',10000*abs(cputime)); %initializeaza seria de numere aleatoare
%