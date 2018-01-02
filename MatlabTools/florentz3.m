function [s]=florentz3(a0,a1,f);
%-------------------------------------------------------------------------------
% Version 20180101, Silviu Rei based on florentz2 by Dan Chicea
% function 
%	The function returns the Lorentz function 
%	Input:
%		a0,a1 	= Lorentz function parameter
%		f 	= frequency vector
%	Output:
%		s	= Lorentz function vector
%	Example:
%		[s] = florentz3(a0,a1,f);
%-------------------------------------------------------------------------------
%   Functia  florentz calculeaza valoarea functiei lorentz pe intreg setul de 
% valori din vectorul de frecvente f si returneaza vectorul cu valorile s 
%
% Arg este un vector linie, primul element este a0 iar al doilea a1
%
% Versiunea 2 este corectata
%
%a0=arg(1);
%a1=arg(2);
%
c=(2*pi.*f).^2+a1.^2;
s=a0*a1./c;
%