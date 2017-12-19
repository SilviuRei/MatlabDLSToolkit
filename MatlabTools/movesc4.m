function [poz]=movesc4(poz,vs,coefdif,deltat)
%
% functia schimba pozitiile centrilor de imprastiere considerand vitezele
% medii vs calculate dupa legea lui Stokes
% versiunea 3 considera miscarea browniana dar nu cu pasul de timp deltat ci in pasi de deltatbrown.
% var. de intrare: poz=matrice(nscat,3) cu pozitiile
% tabs = temperatura absoluta, in K
% deltat = intervalul de timp in care sa considere miscarea
%deltatbrown, pentru miscarea browniana
%   in plus, distributia trebuie sa fie Maxwell-Boltzman, adica normala cu
%   varianta (kt/m)
%
% axa OX este orientata in sus, OY spre dreapta si OZ inainte, la distanta D fiind ecranul
%
% V4 modificat in 18.11.2015
% Modificarea a fost facuta pentru ca viteza de calcul sa scada drastic. Nu
% mai generez viteza ci ditributie Gauss (normala) la fiecare pas de timp
% de miscare browniana ci generez direct deplasarile pe x,y,si z cu distributie normala 
%de varianta 2Dt, o generarea pentru deltat, intervalul dintre doua
%frame-uri
%
varianta=2.*coefdif.*deltat;
%
[ns, dim]=size(poz);    %dim arata in cate dimensiuni este simularea
deplasari=zeros(ns,dim);
%a=input('<CR>');
deplasari=(varianta.^0.5)*randn(ns,dim); %pana aici a rezolvat deplasarile browniene
deplasari(:,1)=deplasari(:,1)+(vs*deltat); %doar pe axa x se deplaseaza Stokes, 
% axa OX fiind orientata in sus, OY spre dreapta si OZ inainte, la distanta D fiind ecranul
poz=poz+deplasari;
%

