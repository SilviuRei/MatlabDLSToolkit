function []=slicer(nume,extensie,ndata)
%
%   Functia citeste un fisier de tip ASCII cu numele in variabila
% nume de felul 'c:folder\file.extensie'. 
%   Afiseza info despre datele din fisier si face ca ndata inregistrari 
%sa fie in fiecare felie pe care o va scrie ca un fisier separat.
%   Insereaza dupa nume secventa _ndate_n, n fiind numarul feliei.
%   Salveaza in fisierul nume.dat valorile extrase
%
numefis=[nume,'.',extensie];
a=load(numefis);
[m,n]=size(a);
disp(['Fisierul are ', int2str(m), ' inregistrari pe ',int2str(n),' coloane'])
%
%in vectorul y sunt citite datele
%
kmax=floor(m/ndata)+1; %scrie si ultma feliuta
%
% incepe buclea de slicing si scriere
%
for k=1:kmax
    disp(['Scriu fisierul nr. ',int2str(k)])
    lim1=(k-1)*ndata+1;
    lim2=min(k*ndata,m); %sa nu treca de ultima valoare
    buf=a(lim1:lim2,:);
    numefisout=[nume,'-',int2str(ndata),'-',int2str(k),'.',extensie]
    save(numefisout,'buf','-ascii')
end
disp(['Ultimul fisier are ', int2str(lim2-lim1+1), ' inregistrari'])