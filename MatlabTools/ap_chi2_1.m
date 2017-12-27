function [chi2]=ap_chi2_1(nume1,nume2,x1,x2,optin)
%
% functia citeste doua fisiere date cu numele ca parametrii de intrare nume
% 1 si nume 2 sau ia doua doi vectori a1 si a2, coloana, in functie de
% valoarea lui optin:
%   optin 0  ia variabilele x1 si x2 si ignora numele de fisiere
%   optin >=1 le citeste din fisierele de pe disc
% ia lungimea minima a lor si calculeaza chi2/punct si chi2/punct modificat
% considerand ca setul din primul fisier este de referinta. Scrie chi2
% pe ecran si le returneaza ca parametrii de iesire
%
% parametrii de intrare sunt:
%   nume1 - numele fisierului cu primul sir
%   nume2 - numele fisierului cu al doilea sir
%
% apelare: 
%
disp('___________________________________');
%disp(' ');
disp('       ap_chi2_1');
disp('       Ultima modificare: 23.12.2017');
disp(' ');
disp(['Rulare ',nume1,',  ',nume2,', ',datestr(clock,0)]);
%disp(' ');
disp('___________________________________');
disp(' ');
%
if optin >=1  % citeste din fisiere sirurile pe care le compara
    [x1]=load(nume1,'ascii');
    [x2]=load(nume2,'ascii');
end %if
[n1,m1]=size(x1);
[n2,m2]=size(x2);
%
n=min(n1,n2);
disp(['Prelucrez ',int2str(n),' valori'])
dif2=(x1-x2).^2;
chi2=sum(dif2)/n;
%chi2m=dif2./(x1.^2);
%chi2mod=sum(chi2m)/n
disp(['chi2/punct : ',num2str(chi2)]);
%disp(['chi2m/punct: ',num2str(chi2mod)]);
%
