function [xfft,xffta, xfftph, f]=vfft1(x,dt)
%
% functia citeste vectorul x si scalarul dt, care este
% int. de timp dintre doua citiri ale valorii lui x
% si returneaza vectorul transformata Fourier, modulul, faza, toate cu dimensiunea 
% jumatate si vectorul frecvente, adica abscisa
%
n=max(size(x));  %dimensiunea transformatei
tmp=fft(x); %transformata bruta
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
%
