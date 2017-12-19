function [s]=florentz(arg,f);
%
%   Functia  florentz calculeaza valoarea functiei lorentz pe intreg setul de 
% valori din vectorul de frecvente f si returneaza vectorul cu valorile s 
%
% Arg este un vector linie, primul element este a0 iar al doilea a1
%
a0=arg(1);
a1=arg(2);
%
c=(2.*f).^2+a1.^2;
s=a0*a1./c;
%