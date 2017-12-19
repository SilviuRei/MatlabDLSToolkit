function [f,nf]=getfreq(fnamefr,fs);
%
% functia citeste primele numere prime care sunt mai mici dacat jumaate
% din frecventa
%
f1=load(fnamefr,'-ascii');
m1=length(f1);
fmax=fs/2;
j=1;
while (j <= m1) & (f1(j) <=fmax)
    f(j)=f1(j);
    j=j+1;
end
nf=j-1;
%