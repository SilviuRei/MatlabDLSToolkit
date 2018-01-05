function [buf1]=ps_cond_1(nume,a,nr1,tip,optread,optsav)
%
%   [buf1]=ps_cond_1(nume,a,nr1,tip,optread,optsav)
%
%   Functia citeste un fisier de tip ASCII cu numele in variabila
% nume de felul 'c:folder\file.ext', extensia trebuie sa fie psd. 
%   datele de intrare:
%       nume - numele fisierului. adauga extensia '.fps'
%       optsav este un parametru de control pentru iesiri
%       optread - parametru de control al intrarii:
%           Daca:
%           optread=0 ia matricea cu doua coloane - fr - PSD in
%                       matricea a
%               optread >=1 citeste matricea de pe disc din fisier
%           Daca :
%                optsav <0 nu salveaza nimic si nu scrie nimic pe disc, doar
%                returneaza fr si tr. Fourier ca parametru de iesire,
%                matrice cu 2 coloane
%                opt >=0 salveaza fisierul cu fr si PS
%                opt >=1 reprezinta grafic liniar si loglog
%                opt >=2 salveaza si graficul PSD in format tip
%   Afiseza info despre datele din fisier si calculeaza transformata
%   Fourier a secventei si power spectrum density.
%
%   Nu ia in considerare primele nr1 perechi de valori dar le proceseaza
%
if optread >=1
    numefis=[nume,'.','ext'];
    a=load(numefis);
end % in acest punct are datel ede intrare in matricea a1
[m,m1]=size(a);
%
f=a(:,1);
ps=a(:,2);
medie=mean(ps(nr1+1:nr1+1+200));
ps=ps.*1./medie;   % a scalat coloana ps astfel incat sa fie media perimelor pe 10
%
buf1=[f,ps];     %matricea cu coloana f si colana ps
%
if optsav>=1
    figure(1)
    loglog(buf1(:,1),buf1(:,2),'-');
    xlabel('f, Hz');
    ylabel('PS');
%
%    figure(2)
%    plot(buf1(:,1),buf1(:,2),'-');
%    xlabel('f, Hz');
%    ylabel('PS');
end
%
% scrie datele daca este cazul
%
numefisfig=[nume];
%
if optsav >= 0
    numefisout=[nume,'.fps'];
    save(numefisout,'buf1','-ascii');
end
%
if optsav >=2
    saveas(1,numefisfig,tip);
end
%
