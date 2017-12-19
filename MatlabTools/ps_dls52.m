function [buf1]=ps_dls52(nume,a1,frecv,plui2,nr1,nr2,tip,opt)
%
%   ps_dls5(nume,frecv,nr1,nr2,tip,opt)
%
%   Functia citeste un fisier de tip ASCII cu numele in variabila
% nume de felul 'c:folder\file.ext', extensia trebuie sa fie ext. 
%   datele de intrare:
%       frecv este frecventa de esantionare
%       opt este un parametru de control pentru iesiri
%           Daca 
%                opt <0 nu salveaza nimic si nu scrie nimic pe disc, doar
%                returneaza tr. Fourier ca parametru de iesire
%                opt >=0 salveaza fisierul cu fr si PS
%                opt >=1 reprezinta grafic liniar si loglog
%                opt >=2 salveaza si graficul PSD in format tip
%   Afiseza info despre datele din fisier si calculeaza transformata
%   Fourier a secventei si power spectrum density.
%
%   Fata de versiunea 4 nu pune in fisierul de iesire primele nr1 si
%   ultumele nr2 perechi de valori
%   Varianta 51 ia datele de intrare ca variabila nu ca fisier
%
%   Varianta 52 ia in calcul doar 2^plui2 din valori nu toate.
%
%numefis=[nume,'.','ext'];
%a=load(numefis);
[m,m1]=size(a1);
disp(['Setul are ', int2str(m), ' inregistrari']);
nrvalset=2^plui2;
nrval=min(m,nrvalset);   %acesta este numarul de valori pe care face transformata Fourier
m=nrval;
disp(['Se proceseaza ', int2str(m), ' inregistrari']);
a=a1(1:m);  %doar aceste se iau in considerare
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
    figure(1)
    loglog(buf1(:,1),buf1(:,2),'o');
    xlabel('f, Hz');
    ylabel('PS');
%
    figure(2)
    plot(buf1(:,1),buf1(:,2),'-');
    xlabel('f, Hz');
    ylabel('PS');
end
%
% scrie datele daca este cazul
%
numefisfig=[nume];
%
if opt >= 0
    numefisout=[nume,'.fps'];
    save(numefisout,'buf1','-ascii');
end
%
if opt >=2
    saveas(1,numefisfig,tip);
end
%
