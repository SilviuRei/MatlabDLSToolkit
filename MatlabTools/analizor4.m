function [rez]=analizor4(nume,proba,durata,f1,f2,ymin, ymax,ext,indsave)
%
%   Functia citeste in vectorul x fisierul nume.wav. nume este fara extensie,
% de tipul 'proba'. Fisierul trebuie sa fie inregistrat PCM, mono!!!.
%   Functia returneaza matricea cu doua coloane, frecvente si transformata Fourier
%   doar in intervalul de frecvente f1 si f2. Face si graficul frecventelor
%   si il salveaza pe disc ca jpg, cu alcelasi nume ca fisierul adaugand
%   intervalul de frecvente.
%   Variabilele de intrare sunt:
%       nume numele fisierului fara extensie
%       proba textul de afisat
%       durata timpul in secunde, din fisierul de intrare, pe care sa faca analiza
%       f1, f2, limitele de frecventa pe care sa reprezinte grafic
%       ymin si ymax sunt limitele pe axa y; + si - inf means default
%
numefisier=[nume,'.wav'];
[y,fs,bits] = wavread(numefisier); 
disp(['   ',proba,': fr. esantionare: ', num2str(fs),' Hz., achizitie pe: ',num2str(bits),' biti']); 
detaliu=[num2str(f1),'-',num2str(f2)];
disp(['   Intervalul de frecvente: ',detaliu]);
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
tmp=zeros(ntr,2);
rez=tmp;        %in rez este doar intervalul dorit 
tmp(:,1)=f';
tmp(:,2)=xffta;
%
% trece in rez doar perechile frecventa-valoare care sunt in intervalul de
% frecventa
%
nrez=0;
for k=1:ntr
    if (tmp(k,1)>=f1) & (tmp(k,1)<=f2)
        nrez=nrez+1;
        rez(nrez,:)=tmp(k,:);
    end
end
%
figure(1)
%plot(rez(1:nrez,1), rez(1:nrez,2),'k');
bar(rez(1:nrez,1), rez(1:nrez,2),'k');
%hist(rez(1:nrez,2), rez(1:nrez,1));
title(['   Amp. frequency spectrum for sample: ',proba,', ', detaliu,' Hz.']);
axis([f1, f2, ymin, ymax]);
xlabel('F, Hz');
ylabel('a.u.');
%
if indsave == 1
  saveas(1, [nume,'_',detaliu],ext);
end
%