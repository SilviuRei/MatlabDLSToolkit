function [x, fs, durata, bits]=exdatwav2(nume, parametru)
%
%   Functia citeste un fisier de tip WAV cu numele in variabila
% nume de felul 'c:folder\file'. file trebuie sa aiba extensia wav.
%   La iesire x este o matrice cu 2 coloane, prima fiind timpul si a doua 
% valoarea citita, cu extensia dat, daca parametru este 1 si o 
% coloana cu valorile inregistrate daca parametru este 2.
%   Tot ca variabila de iesire este fs, sampling rate la inregistrarea
% in Hertzi iar timpul total variabila durata, data in secunde.
%   Bits arata pe cati biti a fost reprezentata data
%   Se apleleaza:
%
%   [x, fs, durata, bits]=exdatwav2(nume, parametru)
%
numewav=[nume,'.wav']
[y,fs,bits] = wavread(numewav);
disp(['Rata de achizitie: ', num2str(fs), ' Hz'])
disp(['Achizitie pe:      ', num2str(bits),' biti'])
%
%in vectorul y sunt citite datele
%
n=max(size(y));
disp(['Fisierul are:      ',num2str(n),' inregistrari'])
dt=1/fs;
durata=(n-1)*dt;
x=zeros(n,2);
x(:,2)=y;
%
%in coloana a doua sunt valorile extrase
%in prima va fi momentul in secunde de la inceputul inreg.
%
t=0:dt:durata;      %so far it is a line vector
x(:,1)=t';           %no longer, it turned into a column
%
%time to write data into the file nume.dat
%
numedat=[nume,'.dat'];
numeext=[nume,'.ext'];
if parametru == 1
    save(numedat,'x','-ascii');
else
    save(numeext,'y','-ascii');
end
%
