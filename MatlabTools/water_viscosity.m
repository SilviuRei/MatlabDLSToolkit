function [eta]=water_viscosity(t)
%
% functia calculeaza cu un polinom de interpolare de gradul 4
% coeficientul de vascozitate dinamica a apei eta la temperatura t
% parametrii i-am determinat prin fitare in matlab pe date exp.
%
% apelare: eta=water_viscosity(15.23);
%
p=[3.11799580180143e-011 -8.70193227515161e-009 9.53135164575034e-007 -5.42716976372715e-005 0.00177215357256412];
eta=polyval(p,t);
%