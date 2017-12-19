function [indref,lambda,tcelsius,theta]=initconst2(dmic,dmare)
%
% functia doar initializeaza constantele pentru generare de serii temporale dls
% apelare:
% [indref,lambda,tcelsius,theta]=initconst1
%
indref=1.5;
lambda=633;
tcelsius=20;
theta=atan(dmic/dmare);
%