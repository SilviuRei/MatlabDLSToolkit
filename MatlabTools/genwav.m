function genwav(nume,a1,a2,a3,f1,f2,fs,ts)
%
% functia scrie pe disc un fisier wav cu amplitudinile a1, a2 
% si frecventele f1 respectiv f2, cu o componenta continua a3
% cu sampling rate fs si timp specificat in variabila ts.
%
% Sintaxa:
%	genwav(nume,a1,a2,a3,f1,f2,fs,ts)
%

[x, t, dt, fs]=testvf1(f1, f2, a1, a2, a3, fs, ts);
wavwrite(x,fs,nume);
