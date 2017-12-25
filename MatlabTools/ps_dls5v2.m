function [psdts]=ps_dls5v2(name, mTs,frecv,nr1,nr2,tip,opt, dispMode)
%--------------------------------------------------------------------------
%   [2017.12.22] S.Rei - added save of PS figure (fig2)
%
%   ps_dls5(nume,frecv,nr1,nr2,tip,opt)
%
%   Functia citeste un fisier de tip ASCII cu numele in variabila
% nume de felul 'c:folder\file.ext', extensia trebuie sa fie ext. 
%   datele de intrare:
%       frecv este frecventa de esantionare
%       opt este un parametru de control pentru iesiri
%           Daca 
%                opt=0 salveaza fisierul cu fr si PS
%                opt >=1 reprezinta grafic liniar si loglog
%                opt >=2 salveaza si graficul PSD in format tip
%   Afiseza info despre datele din fisier si calculeaza transformata
%   Fourier a secventei si power spectrum density.
%
%   Fata de versiunea 4 nu pune in fisierul de iesire primele nr1 si
%   ultumele nr2 perechi de valori
%
%numefis=[nume '.ext'];
figureNumber1=1;
figureNumber2=2;
%a=load(numefis);
%mTs=load(numfis);
[m,~]=size(mTs);
if dispMode == 1
	disp(['Fisierul are ', int2str(m), ' inregistrari']);
end
%
% in vectorul a coloana datele, calculeaza FT
%
tmp=fft(mTs);         %transformat Fourier
n=floor(m/2)+1;     %numarul de puncte de interes
ps=tmp(1:n).*conj(tmp(1:n))./m; %din exemplu se imparte la nr total de inregistrari
f=(frecv*(1:n)./m)';   %abscisele
%
% extrage portiunea dorita
%
buf=[f,ps];     %matricea cu coloana f si colana ps
psdts=buf(nr1+1:n-nr2,:);
%
if opt>=1
    numefig=['Power Spectrum Logarithmic Scale',newline,'Frequency=',num2str(frecv), ' Hz'];
    if dispMode == 1
        figure(figureNumber1);
    elseif dispMode == 0
        figureNumber1=figure('visible','off');
    end
    loglog(psdts(:,1),psdts(:,2),'-');
    title(numefig);
    xlabel('f, Hz');
    ylabel('PS');
%
    numefig=['Power Spectrum',newline,'Frequency=',num2str(frecv), ' Hz'];
    if dispMode == 1
        figure(figureNumber2);
    elseif dispMode == 0
        figureNumber2=figure('visible','off');
    end
    plot(psdts(:,1),psdts(:,2),'-');
    title(numefig);
    xlabel('f, Hz');
    ylabel('PS');
end
%
% scrie datele daca este cazul
%
numefisfig1=['plot_ps-loglog-' name];
numefisfig2=['plot_ps-' name];
%
%if opt >= 0
%    numefisout=['ps_' name '.fps'];
%    save(numefisout,'psdts','-ascii');
%end
%
if opt >=2
    saveas(figureNumber1,numefisfig1,tip);
    saveas(figureNumber2,numefisfig2,tip);
end
%
