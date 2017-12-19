function [rho]=water_density(t)
%
% functia calculeaza cu un polinom de interpolare de gradul 4
% densitatea apei rho la temperatura t
% parametrii i-am determinat prin fitare in matlab pe date exp.
%
% apelare: rho=water_density(15.23);
%
p=[3.11799580180143e-011 -8.70193227515161e-009 9.53135164575034e-007 -5.42716976372715e-005 0.00177215357256412];
p=[-1.37418273714452e-007 +4.37388399227706e-005 -0.00778238884274755 +0.0596130979553463 +999.881471503826];
rho=polyval(p,t);
%