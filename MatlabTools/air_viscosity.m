function [eta]=air_viscosity(t)
%-------------------------------------------------------------------------------
% Version 20171119, Silviu Rei
% function [eta]=air_viscosity(t)
%   The function returns the air viscosity
%	Input:
%       t           = temperature in celsius
%	Output:
%		eta         = viscosity in Nm/s2
%	Example:
%		[eta]=air_viscosity(20);
%-------------------------------------------------------------------------------
p=[2.96188559446133e-16,-1.90489010804906e-12,4.96383517700351e-09,-7.04677460878148e-06,0.00783417856961846,0.00790864515232377];
eta=polyval(p,(t+273.15))*1.e-5;