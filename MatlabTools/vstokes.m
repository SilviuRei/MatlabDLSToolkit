function [v]=vstokes(raza, ro, rozero, eta)
%
%   Functia calculeaza viteza limita de cadere in regim laminar, cu formula
%   lui Stokes.
%   Datele de intrarea sunt rozero - densitatea fluidului, ro - densitatea
%   corpului, raza - raza sferei
%   Daca rozero > ro v > 0, merge in sus pe aza X si invers
%   Toate datele sunt in S.I., eta in daP
%
%   Atentie, functia returneaza proiectia vitezei Stokes pe axa verticala
%
g=9.80665;
v=(2.*raza.*raza*g/(9*eta))*(rozero-ro);
%