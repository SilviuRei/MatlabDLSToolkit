function [medii]=medii_psd3(nume,extensie,ngrup,extgraf,opt)
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
%   nume--ngrup-medgr.ext 
%
%   daca opt >= 0 vrea fisierul salvat pe disc, altfel il da ca output
%   daca opt=1 salveaza si graficul
%   daca opt=2 salveaza si graficul in format logaritmic
%
% apelare:
% [medii]=medii_part2(nume,extensie,ndata,fps,opt)
%
numefis=[nume,'.',extensie];
a=load(numefis);
[m,n]=size(a);
disp(['Prelucrez fisierul: ', numefis, ', ', datestr(now)]) 
disp(['Fisierul are ', int2str(m), ' inregistrari pe ',int2str(n),' coloane'])
%
%in matricea a sunt citite datele
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
if opt >=0  %vrea fisierul salvat pe disc
    save([nume,'-',int2str(ngrup),'-medgr.',extensie],'medii','-ascii');
end
% arata si graficul
figure(1)
if opt ==1
  plot(medii(:,1),medii(:,2),'ok')
elseif opt==2
    loglog(medii(:,1),medii(:,2),'ob')
end
xlabel('f, Hz')
ylabel('I, a.u.')
if opt >=1
    saveas(1,[nume,'-',int2str(ngrup),'-medgr.',extgraf],extgraf)
end
% reminiscenta din versiunea 2; poate reluam rapoartele
%rap=medii(1,2)/medii(2,2);
%sirrap=num2str(rap);
%disp(['Raportul este ', sirrap])