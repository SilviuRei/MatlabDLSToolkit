function [chi1,chi2,chi3]=compar_array_1(nume1,nume2,a1,a2,d,optin)
%
% functia citeste doua fisiere date cu numele ca parametrii de intrare
% numea1 si numea2 sau ia doua doua matrici a1 si a2, de aceeasi dimensiune
% in functie de
% valoarea lui optin:
%   optin 0  ia matricile a1 si a2 si ignora numele de fisiere
%   optin >=1 le citeste din fisierele de pe disc
% ia lungimea minima a lor si calculeaza chi2/punct si chi2/punct modificat
% considerand ca setul din primul fisier este de referinta. Scrie chi2
% pe ecran si le returneaza ca parametrii de iesire
% face graficul (d,chi) pentru comparatia coloanelor consecutive la prima
% matrice, a doua si intre ele
%
% parametrii de intrare sunt:
%   nume1 - numele fisierului cu primul sir
%   nume2 - numele fisierului cu al doilea sir
%
% apelare: 
%
disp('___________________________________');
%disp(' ');
disp('  ap_chi2_1');
disp('  Ultima modificare: 23.12.2017');
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
[n1,m1]=size(a1);
[n2,m2]=size(a2);
%
% compara coloanele consecutive din prima matrice
%
chi1=zeros(1,m1-1);  %initializam vectorul cu chi2 per punct pt prima matrice
for i=1:m1-1
    chi1(i)=ap_chi2_1(nume1,nume1,a1(:,i),a1(:,i+1),optin);
    disp(['I, ',int2str(i)])
end
figure(1)
plot(d(1:m1-1),chi1,'-g')
xlabel('d, nm')
ylabel('chi^2')
title([nume1,'-',nume1])
saveas(1,[nume1,'-',nume1],'fig')
%
% compara coloanele consecutive din a doua matrice
%
chi2=zeros(1,m2-1);  %initializam vectorul cu chi2 per punct pt prima matrice
for i=1:m2-1
    chi2(i)=ap_chi2_1(nume2,nume2,a2(:,i),a2(:,i+1),optin);
    disp(['II, ',int2str(i)])
end
figure(2)
plot(d(1:m2-1),chi2,'-b')
xlabel('d, nm')
ylabel('chi^2')
title([nume2,'-',nume2])
saveas(2,[nume2,'-',nume2],'fig')
%
% trece la compararea coloanelor intre prima si a doua matrice
%
n=min(m1,m2);
disp(['Prelucrez ',int2str(n),' valori'])
%
chi3=zeros(1,n);  %initializam vectorul cu chi2 per punct pt prima matrice
for i=1:n
    chi3(i)=ap_chi2_1(nume1,nume2,a1(:,i),a2(:,i),optin);
    disp(['III, ',int2str(i)])
end
figure(3)
plot(d(1:n),chi3,'-r')
xlabel('d, nm')
ylabel('chi^2')
title([nume1,'-',nume2])
saveas(3,[nume1,'-',nume2],'fig')
disp(['chi2/punct : ',num2str(chi1),' ',num2str(chi2),' ',num2str(chi3)]);
%
% salveaza diametrele si comparatia intre coloanele matricilor in o marice cu 2 coloane
%
rez=[d',chi3'];
save(['d-',nume1,'-',nume2,'.cmp1'],'rez','-ascii')
%