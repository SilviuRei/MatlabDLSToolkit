function [acf,tlags]=run_analizor_autocor_2(nume,x,steps,fs,extgr,indsave,i1,i2)
%
% functie pt a calcula f de autocorelatie pt un grup de serii din matricea
% cu seriile temporale
%
%   Variabilele de intrare sunt:
%       nume numele aplicatiei, nu are legatura cu numele variabilei
%       x variabila in care se gaseste seria
%       fs frames per second, la achizitie
%       steps numarul de pasi pe care calculeaza autocorelatia
%       ext tipul de fisier grafic sub care salveaza graficele
%       i1 coloana de inceput pt submatrice
%       i2 coloana de sfarsit pt submatrice
%
%    exemplu apelare, pentru coloanele de la 10 la 20 din matricea cu
%    seriile temporale:
%   [acf,lags]=run_analizor_autocor_2('acft17',at17_1_3000,1000,16000,'jpg',0,10,20);
%
k=0;    % coloana 1 va corespunde primei serii temporale din selectie
for i=i1:i2
    k=k+1;
    [acf(:,k),lags]=analizor_autocor2(nume,x(:,i),steps,fs,extgr,indsave);
end
tlags=lags./fs;     % tlags reprezinta timpul (abscisa functiei de autocorelatie)
% that's all
