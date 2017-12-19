function [buf]=ps_dls3(nume,frecv,tip,opt)
%
%   ps_dls1(nume,frecv,tip,opt)
%
%   Functia citeste un fisier de tip ASCII cu numele in variabila
% nume de felul 'c:folder\file.ext', extensia trebuie sa fie ext. 
%   datele de intrare:
%       frecv este frecventa de esantionare
%       opt este un parametru de control pentru iesiri
%           Daca opt=0 nu salveaza nimic
%                opt >=1 salveaza fisierul cu fr si PS
%                opt >=2 salveaza si graficul PSD in format fig
%   Afiseza info despre datele din fisier si calculeaza transformata
%Fourier a secventei si power spectrum density.
%
numefis=[nume,'.','ext'];
a=load(numefis);
[m,m1]=size(a);
disp(['Fisierul are ', int2str(m), ' inregistrari']);
dt=1/frecv;         %intervalul de timp intre citiri
%
% scade media si calculeaza patratul
%
medie=mean(a);
a=a-medie;
a=a.^2;     %acum este power spectrum veritabil
%
% in vectorul a coloana datele, calculeaza FT
%
tmp=fft(a);         %transformat Fourier
n=floor(m/2)+1;     %numarul de puncte de interes
ps=tmp(1:n).*conj(tmp(1:n))./m; %din exemplu se imparte la nr total de inregistrari
ps=ps.^0.5;              % in ps este amplitudinea tr. F a PS
f=(frecv*(1:n)./m)';   %abscisele
figure(1)
loglog(f,ps,'-');
xlabel('f, Hz')
ylabel('PS');
% scrie datele daca este cazul
buf=[f,ps];     %matricea cu coloana f si colana ps
if opt >= 1
    numefisout=[nume,'.fps'];
    save(numefisout,'buf','-ascii');
end
%
if opt >=2
    numefisfig=[nume];
    saveas(1,numefisfig,tip);
end
%
