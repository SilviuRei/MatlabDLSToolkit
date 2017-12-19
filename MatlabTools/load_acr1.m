function [acr,hd,dbindi]=load_acr1(nume,ats,diametre,nlags,nbindi,optsav);
%
% functia preia matricea cu serii temporale, ca variabila, care trebuie
% citita in prealabil de pe disc sau transmisa de load_ts36, care contine
% seria pe cate o coloana pentru fiecare diametru
%
% Calculeaza functia de autocorelatie pt fiecare din colane (serii) pe
% nlags si o pune pe o coloana in noammatrice acr, care are cate o coloana
% pt fiecare ts si are nlags linii. 
% Calculeaza si in care grup din cele ngrdiam se gaseste diametrul 
% corespunzator si adauga o coloana la fiecare serie temporala in matricea
% de iesire, care are atatea coloane ca si matricea de intrare si ngrdiam
% linii.
%
% Daca optsav este >=1 va scrie pe disc si fisierele cu matricea, ascii, pe disc, cu
% extensia acr si fisierul cu valorile pentru fiecare clasa de diametre, cu
% extensia hdm, pe care la transmite si ca parametrii de iesire sa fie ca
% variabile pt NN training.
%
t1=clock;
% verifica matricea de intrare si cea cu diametre sa corespunda
[m,n]=size(ats);
disp(['Calculez acr pentru aplicatia: ',nume])
disp(['Matricea contine: ',int2str(n),' serii temporale fiecare cu: ',int2str(m),' valori'])
[m1,n1]=size(diametre);
if (n1~=n) or (m1 ~= 1)
    disp('Matricile de intrare nu corespund ca dimensiuni')
    return
end
%
% OK, incepe sa calculeze functiile de autocorelatie pentru fiecare serie
% temporala si sa le adauge in matricile de iesire
%
acr=zeros(nlags,n1);
hd=zeros(nbindi,n1);   %matricile sunt alocate la inceput
%
texpas=0;
nrpasi=n;   %pentru fiecare serie face un pas
lengthbi=(diametre(n1)-diametre(1))/nbindi; %este latimea unui bin din histograma de diametre
% incarca in vectorul dbindi valorile de la mijlocul fiecarui interval
for i=1:nbindi
    dbindi(i)=diametre(1)+(i-0.5)*lengthbi;
end
%
for i=1:n
    tic  %porneste cronometrul 
    tmp=analizor_autocor2(nume,ats(:,i),nlags-1,16000,'png',0);  %nu conteaza fs, png caci nu scrie pe disc
    acr(:,i)=tmp'; %pt ca returneaza vector linie
    nrbin=min((1+floor( (diametre(i)-diametre(1))/lengthbi) ),nbindi);   % trece in vectorul d valoarea curenta
    hd(nrbin,i)=1.;
    texpas=toc;
    tramas=(nrpasi-i)*texpas/60; %timpul aprox ramas
    disp(['i: ',int2str(i),' t.r.m.: ',num2str(tramas)])
end
%
if optsav >= 1 % vrea scris fisierul psd pe disc
    save([nume,'-',int2str(nlags),'-',int2str(n),'-',int2str(nbindi),'-acr.txt'],'acr','-ascii')
    save([nume,'-',int2str(nlags),'-',int2str(n),'-',int2str(nbindi),'-hd.txt'],'hd','-ascii')
    save([nume,'-',int2str(nlags),'-',int2str(n),'-',int2str(nbindi),'-dbindi.txt'],'dbindi','-ascii')
end
t2=etime(clock,t1);
disp(['durata executiei pentru: ',int2str(n),' diametre este: ',num2str(t2/60),' minute'])
%


