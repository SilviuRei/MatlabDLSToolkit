function [acf,lags]=analizor_autocor2(nume,x,steps,fs,extgr,indsave)
%
%   Functia citeste in vectorul x fisierul nume.ext_fis; nume este fara extensie,
% de tipul 'proba'. Fisierul trebuie sa contina o coloana de numere.
%   Functia returneaza matricea cu doua coloane, timp  si functia de
%   autocorelatie pe steps lags.
%   Dacac indsave este >=2 scrie si graficul functiei de autocorelatie
%   Daca indsave este >=1 scrie pe disc lags si functia de autocorelatie, cu extensia acr 
%   si graficul functiei il salveaza pe disc ca 'ext', cu alcelasi nume ca fisierul adaugand
%   -autocor.
%   Variabilele de intrare sunt:
%       nume numele aplicatiei, nu are legatura cu numele variabilei
%       x variabila in care se gaseste seria
%       fs frames per second, la achizitie
%       lags numarul de pasi pe care calculeaza autocorelatia
%       ext tipul de fisier grafic sub care salveaza graficele
%   Fata de versiunea 1 prela seria ca o coloana nu o citeste de pe disc. 
%   Face grafice si salveaza fisier pe disc numai daca indsav >=2
%   Aceasta versiune este pt a functiona in batch mode apelata din
%   load_acr1
%
%disp(['   Analizez fisierul: ',numefisier])
%disp(['   Fr. esantionare:   ',num2str(fs)]); 
%detaliu=[num2str(steps)];
%disp(['   Numar de pasi: ',detaliu]);
%x=load(numefisier,'-ascii');   %incarca fisierul
%xmed=mean(x);
%x=x-xmed;
%
[acf, lags, bounds]=autocorr(x, steps, [], 2);     %transformata bruta
dt=1/fs;        %intervalul dintre doua valori
lags=lags*dt;
%
% calculam abscisa, adica la ce frecvente gasim acel spectru
%
if indsave >=1
    fid1 = fopen([nume,'.acr',],'w');
    for k=1:steps+1
        fprintf(fid1, '%11.5g %11.5g \n', lags(k), acf(k));
    end %k
    fclose(fid1);
    % calculeaza si timpul de autocorelatie
    k=1;
    e=exp(1);
    while (acf(k)>=1/e)&(k<steps)
        tcor=lags(k);
        k=k+1;
    end
    disp([nume,' timp de corelatie: ',num2str(tcor),' +/- ',num2str(dt),' secunde']); 
end %if
%
if indsave >= 2
    figure(1)
    plot(lags, acf,'.k');
    grid on
    title(['   Autocorrelation function for sample: ',nume,]);
    xlabel('t, s');
    ylabel('a.u.');
    xmax=max(lags);
    axis([0, xmax, -0.2, 1]);
    saveas(1, [nume,'-accr'],extgr);
end %if
