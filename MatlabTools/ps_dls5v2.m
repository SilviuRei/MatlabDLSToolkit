function [buf1]=ps_dls5(nume,frecv,nr1,nr2,tip,opt, dispMode)
%
%   [2017.12.17] S.Rei - added save of PS figure (fig2)
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
numefis=[nume,'.','ext'];
a=load(numefis);
[m,m1]=size(a);
if dispMode == 1
	disp(['Fisierul are ', int2str(m), ' inregistrari']);
end
%
% in vectorul a coloana datele, calculeaza FT
%
tmp=fft(a);         %transformat Fourier
n=floor(m/2)+1;     %numarul de puncte de interes
ps=tmp(1:n).*conj(tmp(1:n))./m; %din exemplu se imparte la nr total de inregistrari
f=(frecv*(1:n)./m)';   %abscisele
%
% extrage portiunea dorita
%
buf=[f,ps];     %matricea cu coloana f si colana ps
buf1=buf(nr1+1:n-nr2,:);
%
if opt>=1
    numefig=['Power Spectrum Logarithmic Scale',newline,'Frequency=',num2str(frecv), ' Hz'];
    figure(1)
    loglog(buf1(:,1),buf1(:,2),'-');
    title(numefig);
    xlabel('f, Hz');
    ylabel('PS');
%
    numefig=['Power Spectrum',newline,'Frequency=',num2str(frecv), ' Hz'];
    figure(2)
    plot(buf1(:,1),buf1(:,2),'-');
    title(numefig);
    xlabel('f, Hz');
    ylabel('PS');
end
%
% scrie datele daca este cazul
%
numefisfig1=[nume,'-ps-loglog'];
numefisfig2=[nume,'-ps'];
%
if opt >= 0
    numefisout=[nume,'.fps'];
    save(numefisout,'buf1','-ascii');
end
%
if opt >=2
    saveas(1,numefisfig1,tip);
    saveas(2,numefisfig2,tip);
end
%
