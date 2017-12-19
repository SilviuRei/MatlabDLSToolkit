function [a,b, hi2]=hi2lin1(x,y);
%
%   Functia preia matrice care contine perechile xi - yi pe cate o coloana
%   fiecare, de date experimentale. 
%   Fiteaza pe aceste date o dreapta, a*x+b, fara functii Matlab, calculand direct 
% parametrii dreptei.
%   Functia nu este scrisa optim pe Matlab ci este scrisa pentru a putea fi
% usor tradusa in alt limbaj
%   La iesire da parametrii a si b ai dreptei si hi^2 pe punct.
%
%   Se apleleaza:
%
%  [a,b]=hi2lin1(x,y);
%
[n,m]=size(x);
%
%  calculeaza sumele care intervin in determinarea parametrilor
%
A=0;
B=0;
C=0;
D=0;
%
for i=1:n
    A=A+x(i)*x(i);
    B=B+x(i);
    C=C+x(i)*y(i);
    D=D+y(i);
end  % sumele sunt calculate
%
% calculeaza parametrii dreptei, a si b
%
a=(B*D-n*C)/(B*B-n*A);
b=(A*D-B*C)/(n*A-B*B);
%
% calculeaza hi^2 pe punct
%
hi2=0;
for i=1:n
    ycalc(i)=a*x(i)+b;
    tmp=ycalc(i)-y(i);
    hi2=hi2+tmp*tmp;
end
hi2=hi2/n;
% cam asta este