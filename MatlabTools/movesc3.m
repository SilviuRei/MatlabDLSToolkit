function [poz]=movesc3(poz,vs,mpart,tabs,deltat,deltatbrown)
%
% functia schimba pozitiile centrilor de imprastiere considerand vitezele
% medii vs calculate dupa legea lui Stokes
% versiunea 3 considera miscarea browniana dar nu cu pasul de timp deltat ci in pasi de deltatbrown.
% var. de intrare: poz=matrice(nscat,3) cu pozitiile
% tabs = temperatura absoluta, in K
% deltat = intervalul de timp in care sa considere miscarea
%deltatbrown, pentru miscarea browniana
%   in plus, distributia trebuie sa fie Maxwell-Boltzman, adica normala cu
%   varianta (kt/m).^0.5
%
% axa OX este orientata in sus, OY spre dreapta si OZ inainte, la distanta D fiind ecranul
%stept=5.0e-3;   %pasul de timp pentru miscarea browniana
kb=1.38e-23;
varianta=(kb*tabs/mpart);
%
[ns, dim]=size(poz);
deplasari=zeros(ns,dim);
npasit=deltat/deltatbrown;
%a=input('<CR>');
for k=1:npasit
    viteze=((varianta).^0.5)*randn(ns,dim);
    deplasari=deplasari+viteze*deltatbrown; %pana aici a sumat deplasarile browniene
end
deplasari(:,1)=deplasari(:,1)+(vs*deltat); %doar pe axa x se deplaseaza Stokes, 
% axa OX fiind orientata in sus, OY spre dreapta si OZ inainte, la distanta D fiind ecranul
poz=poz+deplasari;
%

