function [rez]=analizor1(nume,dt, proba)
%
% functia citeste in vectorul x fisierul nume.txt. nume este fara extensie,
% de tipul 'proba'. dt este int. de timp dintre doua citiri ale valorii lui x
% Returneaza vectorul transformata Fourier, toate cu dimensiunea 
% jumatate si vectorul frecvente, adica abscisa la care apare acea
% componenta. Face si graficul frecventelor.
%
numefisier=[nume,'.txt'];
x=load(numefisier);
%
n=max(size(x)); %dimensiunea transformatei
medie=mean(x);
x=x-medie;      %elimina componenta continua
tmp=fft(x);     %transformata bruta
%
ntr=floor(n/2)+1;  %dimensiunea vectorilor de iesire
xfft=tmp(1:ntr);   %vectorul complex cu tr. Fourier
xffta=abs(xfft);   %modulul tr. Fourier
xfftph=angle(xfft);%faza transformatei
%
% calculam abscisa, adica la ce frecvente gasim acel spectru
%
f=1:1:ntr;
f=f./(n*dt);
rez=zeros(ntr,2);
rez(:,1)=f';
rez(:,2)=xffta;
%
figure(1)
%plot(rez(:,1), rez(:,2));
%stem(rez(:,1), rez(:,2));
bar(rez(:,1), rez(:,2));
title(['Amplitude fr. spectrum for sample ',proba]);
xlabel('F, Hz');
ylabel('a.u.');
%
saveas(1, [nume,'.jpg'],'jpg');
%