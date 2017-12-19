function [v]=vtermic(vol, ro, tabs)
%
%   Functia calculeaza viteza termica a particulei
%   Datele de intrarea sunt vol - volumul corpului, ro - densitatea, tabs -
%   temperatura absoluta
%
kb=1.3806505e-23;   %constanta lui Boltzman
v=((3*kb*tabs)/(ro.*vol)).^0.5;
%