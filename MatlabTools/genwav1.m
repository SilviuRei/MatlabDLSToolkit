function [x, t, dt, fs]=genwav1(nume,a1, f1, a2, f2, a3, fs, ts, play)
%
%   Functia generaza o suprapunere de 2 sinusoide de amplitudini a1 respectiv a2
% si frecvente f1 respectiv f2 peste care se poate adauga si o componenta continua a3
% Sampling rate e specificat in variabila fs, in Hertzi iar timpul total 
% in variabila ts, data in secunde.
%   Daca play este 1 si trimite fisierul la placa de sunet
%   Salveaza in fisierul nume, de felul 'c:folder\file.wav' 
%
% Functia returneaza un vector x cu suprapunerea dorita, un vector t care
% reprezinta axa timpului, pasul de timp dt si sampling rate fs
% 
dt=1/fs;
t=0:dt:ts;
x=a1*sin(2*pi*f1*t)+a2*sin(2*pi*f2*t)+a3;
%
wavwrite(x, fs, nume)
if play == 1
  wavplay(x, fs)
end
%
