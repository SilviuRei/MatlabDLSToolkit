function [a]=ts_cond_1(nume,a,optread,optsav)
%
% Apelare:
% [a_cond]=ts_cond_1(nume,a,optread,optsav);
% Exemplu:
% [a_cond]=ts_cond_1('ts18',a,0,optsav)
%
%   Functia citeste un fisier de tip ASCII cu numele in variabila
% nume de felul 'c:folder\file.ext', extensia trebuie sa fie ext. 
%   datele de intrare:
%       nume - numele fisierului; adauga extensia '.ext'
%       optsav este un parametru de control pentru iesiri
%       optread - parametru de control al intrarii:
%           Daca:
%           optread=0 ia matricea cu coloane fiecare coloana fiind o serie temporala
%           din matricea a, variabila existenta in m omentul apelarii
%               optread >=1 citeste matricea de pe disc din fisier
%           Daca :
%                optsav =0 nu salveaza nimic si nu scrie nimic pe disc, doar
%                matricea cu seriile temporale ca parametru de iesire,
%                optsav >0 salveaza fisierul cu matricea
%   Afiseza info despre datele din fisier 
%
if optread >=1
    numefis=[nume,'.','ext'];
    a=load(numefis);
end % in acest punct are datele de intrare in matricea a
[m,n]=size(a);
%
% primul lucru face seria zero based, daca a fost inregistrata experimental
%
minim=min(a);  %min este un vector linie cu minumele de pe fiecare coloana
for i=1:n %trateaza fiecare coloana individual
    a(:,i)=a(:,i)-minim(i);
end
%
medie=mean(a);
for i=1:n %conditioneaza fiecare coloana individual
    a(:,i)=a(:,i)./(0.78*medie(i));
end
%
% scrie datele daca este cazul
%
if optsav > 0
    numefisout=[nume,'_tscond1.ext'];
    save(numefisout,'a','-ascii');
end
%
