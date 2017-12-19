function [indref,lambda,tcelsius,theta]=initconst3(dmic,dmare)
%
% functia doar initializeaza constantele pentru generare de serii temporale dls
% apelare:
% [indref,lambda,tcelsius,theta]=initconst1
%
indref=1.333;
lambda=633;
tcelsius=20;
theta=atan(dmic/dmare);
rand('twister',10000*abs(cputime)); %initializeaza seria de numere aleatoare
%