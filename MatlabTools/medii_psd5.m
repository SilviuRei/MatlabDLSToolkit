function [medii]=medii_psd5(nume,extensie,ngrup,extgraf,optprel, optgraf)
%
%   Functia citeste un fisier de tip ASCII cu numele in variabila
% nume de felul 'c:folder\file.extensie'. 
%   Afiseza info despre datele din fisier si face ca toate datele sa fie grupate in 
%   ngrup grupuri de inregistrari
%  va clacula media pe fiecare grup, specific pentru medii_psd3
%   extgraf este tipul fisierului grafic
%
%   Insereaza dupa nume secventa -ngrup-medgr.
%   Salveaza in fisierul nume-ngrup-medgr.ext valorile extrase
%   Fata de versiunea 0 la iesire da o matrice cu momentul 
%   de mijloc al intervalului si cu are valoarea medie
%   a intensitatii pe fiecare felie si salveaza un fiser de tip
%   nume-ngrup-medgr.ext 
%   Fata de versiunea 3 face si o scalare a.i. prima valoare sa fie 1, mai
%   usor pentru fitare, cu plaja mica pentru a0 si poate mai usor pt NN.
%   Fata de versiunea 4 scaleaza impartindla maximul valorii, astfel incat
%   nici o valoare sa nu fie >1.
%
%   daca optprel=1 salveaza fisierul nenormalizat 
%   daca optprel=2 salveaza fisierul normalizat (prima valoare pe 1)
%
%   daca optgraf < 0 nu salveaza nimic, doar returneaza mediile
%   daca optgraf =0 salveaza fisierul cu valorile medii
%   daca optgraf diferit de 1 sau 2 nu face grafic 
%   daca optgraf=1 salveaza graficul in scara liniara
%   daca optgraf=2 salveaza graficul in format logaritmic 
%
% apelare:
% [medii]=medii_part4(nume,extensie,ndata,fps,opt)
%
% 51 preia transf. Fourier ca variabila nu o citeste de pe disc si nu
% salveaza nimic
%
numefis=[nume,'.',extensie];
a=load(numefis);
[m,n]=size(a);
%disp(['Prelucrez fisierul: ', numefis, ', ', datestr(now)]) 
disp(['Setul are ', int2str(m), ' inregistrari pe ',int2str(n),' coloane'])
%
% in matricea a sunt citite datele
%
ndata=floor(m/ngrup); %numarul de date intr-un grup
disp(['Ultimele: ' num2str(rem(m,ngrup)),' date raman neprelucrate']) 
%kmax=floor(m/ndata)
% end
kmax=ngrup; %pastrez secventa de la versiunea 2
medii=zeros(kmax,n);
%
% incepe bucla de slicing si scriere
%
for k=1:kmax
    %disp(['Secventa nr. ',int2str(k)])
    lim1=(k-1)*ndata+1;
    lim2=min(k*ndata,m); %sa nu treca de ultima valoare
    buf=a(lim1:lim2,:);
    medii(k,:)=mean(buf,1); %mediile pe coloane
%    numefisout=[nume,'-',int2str(ndata),'-',int2str(k),'.',extensie];
%    save(numefisout,'buf','-ascii');
end
%
% daca optprel=2 vrea normalizat, cu valorile scalate astfel ca
% prima valoare sa fie pe 10
%
mmax=max(medii);    %are doua elemente, maximele pe coloane
if optprel==2
    factor=1./mmax(1,2);
    medii(:,2)=medii(:,2).*factor;
end
%
% arata si graficul daca este cazul
%
if optgraf >=1 % arata graficele
    figure(1)
    plot(medii(:,1),medii(:,2),'ok')
    xlabel('f, Hz')
    ylabel('I, a.u.')
    figure(2)
    loglog(medii(:,1),medii(:,2),'ob')
    xlabel('f, Hz')
    ylabel('I, a.u.')
end
%
if optgraf ==1
    saveas(1,[nume,'-',int2str(ngrup),'-medgr.',extgraf],extgraf)
elseif optgraf ==2
     saveas(2,[nume,'-',int2str(ngrup),'-medgr.',extgraf],extgraf)
end
% reminiscenta din versiunea 2; poate reluam rapoartele
%rap=medii(1,2)/medii(2,2);
%sirrap=num2str(rap);
%disp(['Raportul este ', sirrap])
% oricum salveaza fisierul pe disc
strnorm='';
if optprel==2
    strnorm='-norm';
end
if optgraf >=0 % salveaza pe disc mediile
    numefisout=[nume,'-',int2str(ngrup),'-mdegr',strnorm,'.',extensie]
    save(numefisout,'medii','-ascii');
end
%