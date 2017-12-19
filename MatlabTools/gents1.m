function [t,x,a0,a1]=gents1(nume, diam, theta, lambda, tcelsius, fs, nf, nt, opt)
%
%   Functia generaza o suprapunere de functii sinusoide de amplitudini care
%   simuleaza PSD inregistrat in DLS pentru centrii de imprastiere de
%   diametru diam. (A! este diametrul in nm, nu raza), la unghiul theta, exprimat
%   in radiani, de lumina cu lungimea de unda lambda, in nm, in apa la
%   temperatura tc, in grade Celsius.
%
%  Seria este in variabila x, generata cu frecventa (de achizitie) fs,
%  folosind nf frecvente si nt valori in seria de timp finala.
%  
%  Daca optsav este 1 salveaza in fisierul nume,
%  de felul 'd:folder\nume-diam-fs-nf-nt.ext' 
%
% Functia returneaza doi vectori, unul t cu valoarea timpului si celalalt x, cu seria
% temporala
%
% apelare:
% [t,x]=gents1('FeO4-100', 100, 0.7854, 633, 293.15, 2000, 100, 1000, 1)
%
% calculeaza valorile necesare pentru parametrii functiei Lorentz
%
a0=1000;       %alegem arbitrar
kb=1.3806505e-23;   % constanta lui Boltzman
eta=water_viscosity(tcelsius);  % vascozitate apei, in daP
lambdam=lambda*1.e-9;  % trece lambda in SI, in m
tabs=tcelsius+273.15;  % temperatura in Kelvin
diamm=diam*1.e-9; %diametrul in m
%
K=(4*pi/lambdam)*sin(0.5*theta);
a1=(2*kb*tabs*K^2)/(6*pi*eta*0.5*diamm);
%
% genereaza vectorul linie cu frecventele, in intervalul [0, fs/2]
% si fazele initiale, uniform distribuite in [0, 2pi]
%
rand('twister',sum(100*clock)); %initializeaza seria de numere aleatoare, diferite
%
%df=0.5*fs/nf;   %pasul de frecvente, generate uniform 
%f=df:df:nf*df;   % frecventele generate uniform in interval, nu-i bine ca
%apar armonicile si iese seria prea periodica
%
f=0.5*fs*rand(1,nf);   %vectorul linie cu frecventele generate aleator in
%interval
faz=2*pi*rand(1,nf);  %punem si faze inititale ca altfel are o variatie foarte mare la inceput  
% amp=a0*a1/((2*pi.*f)^2+a1^2)   %vectorul cu amplitudinile
amp=zeros(1,nf);
amp=4*pi^2*f.*f+a1^2;   %vectorul cu amplitudinile, calculat in pasi
amp=a0*a1./amp;
%
% genereaza seria de timp 
%
dt=1/fs;
t=(dt:dt:nt*dt)';   %vector coloana cu nt+1 valori
[n1,n2]=size(t); %dimensiunea seriei temporale
x=zeros(n1,n2);   %aceeasi dimensiune
%
%
%
for i=1:nf
    x=x+amp(i).*sin(2*pi*f(i).*t+faz(i));
end
%keyboard;
%
% salveaza daca este cazul fisierul pe disc
%
if opt >= 1
    numefis=[nume,'-',int2str(diam),'-',int2str(fs),'-',int2str(nf),'-',int2str(nt),'.ext'];
    save(numefis,'x','-ascii');
end
%
