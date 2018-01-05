function [diam,a0,a1,chi2min,exitflag]=dls_chi2_1a(nume,a,frecv,plui2,nr1,nr2,parfilt,thetagrade,fgr,optread,optcond,control)
%
% functia porneste de la o matrice ext si calculeaza psd, filtreaza si
% fiteaza functia Lorentz pe fiecare coloana
%
% parametrii de intrare sunt:
%   nume - numele fisierului, cu extensia ext
%   a numle matricii care contine seriile temporale pe cate o coloana
%   frecv - frecventa de achizitie
%   plui2 - se iau in considerate numai 2^plui2 date din seria temporala
%   fgr  - tipul fisierului grafic, daca se doreste
%   nr1 - primele n1 valori din psd nu sunt trecute in fisierul final
%   nr2 - ultimele n2 valori din psd nu sunt trecute in fisierul final
%   parfilt -intre 0 si 1, folosit de filtru31 la a pastra doar prima
%   parfilt parte din spectru la fitare
%   thetagrade - unghiul de inregistrare, in grade
%    optread - parametru de control al intrarii:
%           Daca:
%           optread=0 ia matricea cu coloane fiecare coloana fiind o serie temporala
%           din matricea a, variabila existenta in m omentul apelarii
%           optread >=1 citeste matricea de pe disc din fisier
%   optcond - Daca: 
%                optcond <=0 nu conditioneaza PS
%                optcond >=1 conditioneaza PS
%  control - este pt chi2dlslsq31
%
% apelare: 
% [diam,a0,a1,chi2min,exitflag]=dls_chi2_1a(nume,a,frecv,plui2,nr1,nr2,parfilt,thetagrade,fgr,optread,optcond,control)
%
disp('___________________________________');
%disp(' ');
disp('  dls_chi2_1a');
disp('  Ultima modificare: 4.01.2018');
disp(' ');
disp(['Rulare ',nume,',  ',datestr(clock,0)]);
disp(['control ',int2str(control)]);
%disp(' ');
disp('___________________________________');
disp(' ');
t1=clock;   % momentul de inceput
if optread >=1
    a=load([nume,'.ext'],'-ascii');     % in matricea a se gaseste s.t.
end % in acest punct are datele de intrare in matricea a
%
[n,m]=size(a);
%
% initializeaza matricile coloana cu rezultatele
%
diam=zeros(m,1);
a0=zeros(m,1);
a1=zeros(m,1);
chi2min=zeros(m,1);
exitflag=zeros(m,1);
[indref,lambda,tcelsius,theta]=initconst4(thetagrade);
lambda=lambda*1.e-9;    % trece in metri
mstr=int2str(m);
%
% Incepe bucla in care trateaza pe rand fiecare coloana a matricii (serie
% temporala)
%
parfor k=1:m;  %fiecare coloana este o t.s.
%for k=1:m;  %fiecare coloana este o t.s.
% calculeaza tr. Fourier
%disp(' ');
    tic;
    disp(' ');
    disp(['Pasul: ',int2str(k),' din: ',mstr,'; PS']);
    disp(' ');
    [x]=ps_dls52(nume,a(:,k),frecv,plui2,nr1,nr2,fgr,-1);
    if optcond >=1 %doreste conditionarea PS
        [x]=ps_cond_1(nume,x,0,'png',0,-1); %conditioneaza PS
    end
    % in x are perechile din PSD, f si amplitudine si filtreaza
    %disp('Filtrare');
    %[y]=filtru31(nume, x, 51, 3, parfilt*frecv/2, 0, fgr); %comentariul
    %trece comentariul pe linia de sub daca se ia de pe cea de deasupra
    y=x;
    %
    % ok, are datele filtrare simplist
    % timpul sa fiteze functia Lorentz
    %
    disp('Fitare');
    [diam(k),a0(k),a1(k),chi2min(k),exitflag(k)]=chi2dlslsq31([nume,'-',int2str(k)],y(:,1),y(:,2),theta,indref,lambda,tcelsius,4000,0.001,1.e13,900,10,29000,control,fgr);
    etime=toc;
    disp(['tr. m.: ', num2str((m-k)*etime/60)])
end %parfor k
%
% aduna rezultatele si le scrie intr-o matrice pe disc
%
rez=[diam,a0,a1,chi2min,exitflag];
save([nume,'.rzfit_dls_chi21a'],'rez','-ascii')
t2=clock;   %momentul de incheiere
et=t2-t1;   % timpul in secunde
disp(['Durata totala a executiei: ',num2str((et(4)*60+et(5)+et(6)/60)),' ','minute'])
%