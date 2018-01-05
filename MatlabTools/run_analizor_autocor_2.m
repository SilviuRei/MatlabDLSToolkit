function [acf,tlags]=run_analizor_autocor_2(tsName,x,steps,fs,extgr,indsave,i1,i2,istep,dispMode)
%--------------------------------------------------------------------------
% Version 20171225, Silviu Rei based on run_analizor_autocor_2 by Dan Chicea
%--------------------------------------------------------------------------
% Original Comment by Dan Chicea
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
%--------------------------------------------------------------------------
disp('---------------------------------------------------------------------');
disp('[+++] Autocorrelation Computing - Time Series Matrix');
disp(['   [+] Using ' tsName]);
h=999;
m=999;
s=999;

dirName='plots';
cd(dirName);

k=1;    % coloana 1 va corespunde primei serii temporale din selectie
numSteps = (i2-i1)/istep+1;
waitbarHandle = waitbar(0,['Computing Autocorrelation...' ...
        newline 'Step:'  ...
        newline 'Time Left =' ...
        newline 'Progress: 0%']);
for i=i1:istep:i2
    tic
    disp(['[+++] Step ' num2str(k) ' out of ' num2str(numSteps)...
            ', Time Left = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's']);
        waitbar((k-1)/numSteps, waitbarHandle,['Autocorrelation Computing...' ...
            newline 'Step: ' num2str(k) ' out of ' num2str(numSteps)  ...
            newline 'Time Left = ' num2str(h) 'h ' num2str(m) 'm ' num2str(s) 's' ...
            newline 'Progress: ' num2str(100*(k-1)/numSteps) ' %']);
    seriesName = [num2str(i) '-' tsName ];
    [acf(:,k),lags]=analizor_autocor2(seriesName,x(:,i),steps,fs,extgr,indsave,dispMode);
    deltat = toc;
    timeLeft = deltat*(numSteps-k);
    [h, m, s] = sec2time(timeLeft);
    k=k+1;
end
close(waitbarHandle);
tlags=lags./fs;     % tlags reprezinta timpul (abscisa functiei de autocorelatie)
% that's all

cd('..');

save(['acf_' tsName '.txt'],'acf','-ascii');
disp(['   [+] File Saved: acf_' tsName '.txt']);
disp('[+++] Autocorrelation Computing Complete');