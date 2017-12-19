function [rez]=analizor2(nume, proba, durata, f1, f2, ymin, ymax)
%
% functia citeste in vectorul x fisierul nume.wav. nume este fara extensie,
% de tipul 'proba'. Fisierul trebuie sa fie inregistrat PCM, mono!!!. Functia returneaza vectorul transformata Fourier, toate cu dimensiunea 
% jumatate si vectorul frecvente, adica abscisa la care apare acea
% componenta. Face si graficul frecventelor.
%
numefisier=[nume,'.wav'];
[y,fs,bits] = wavread(numefisier); 
disp([proba,': fr. esantionare: ', num2str(fs),' Hz., achizitie pe: ',num2str(bits),' biti']); 
detaliu=[num2str(f1),'-',num2str(f2)];
disp(detaliu);
x=y(1:min(max(size(y)),fs*durata));   %incercam doar "durata" din inregistrare
%
n=max(size(x)); %dimensiunea transformatei
medie=mean(x);
x=x-medie;      %elimina componenta continua
dt=1/fs;
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
bar(rez(:,1), rez(:,2));
title(['Amplitude fr. spectrum for sample: ',proba,' ', detaliu]);
axis([f1, f2, ymin, ymax]);
xlabel('F, Hz');
ylabel('a.u.');
%
saveas(1, [nume,'_',detaliu,'.jpg'],'jpg');
%