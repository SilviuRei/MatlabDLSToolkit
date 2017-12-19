function [x, fs, durata, bits]=exdatwav1(nume)
%
%   Functia citeste un fisier de tip WAV cu numele in variabila
% nume de felul 'c:folder\file'. file trebuie sa aiba extensia wav.
%   La iesire x este o matrice cu 2 coloane, prima fiind timpul si a doua 
% valoarea citita.
%   Tot ca variabila de iesire este fs, sampling rate la inregistrarea
% in Hertzi iar timpul total variabila durata, data in secunde.
%   Bits arata pe cati biti a fost reprezentata data
%   Daca play este 1 si trimite fisierul la placa de sunet
%   Salveaza in fisierul nume.dat valorile extrase
%
numewav=[nume,'.wav']
[y,fs,bits] = wavread(numewav);
disp(['Rata de achizitie: ', num2str(fs), ' Hz'])
disp(['Achizitie pe:      ', num2str(bits),' biti'])
%
%in vectorul y sunt citite datele
%
n=max(size(y));
dt=1/fs;
durata=(n-1)*dt;
x=zeros(n,2);
x(:,2)=y;
%
%in coloana a doua sunt valorile extrase
%in prima va fi momentul in secunde de la inceputul inreg.
%
t=0:dt:durata;      %so far it is a line vector
x(:,1)=t';          %no longer, it tyrned in a column
%
%time to write data into the file nume.dat
%
numedat=[nume,'.dat'];
save(numedat,'x','-ascii');
%
