function [rap]=medii_psd2(nume,extensie,ndata,extgraf,opt)
%
%   Functia citeste un fisier de tip ASCII cu numele in variabila
% nume de felul 'c:folder\file.extensie'. 
%   Afiseza info despre datele din fisier si face ca ndata inregistrari 
%  sa fie in fiecare felie pe care  va calcula media.
%
%   fps este rata de achizitie, ndata nr de puncte pe care le mediaza
%   extgraf este tipul fisierului grafic
%
%   Insereaza dupa nume secventa _ndate.
%   Salveaza in fisierul nume-ndate-med.ext valorile extrase
%   Fata de versiunea 0 la iesire da o matrice cu momentul 
%   de mijloc al intervalului si cu are valoarea medie
%   a intensitatii pe fiecare felie si salveaza un fiser de tip
%   nume-ndate-med.ext
%
%   daca opt=1 salveaza si graficul
%   daca opt=2 salveaza si graficul in format logaritmic
%
% apelare:
% [medii]=medii_part2(nume,extensie,ndata,fps,opt)
%
numefis=[nume,'.',extensie];
a=load(numefis);
[m,n]=size(a);
disp(['Fisierul are ', int2str(m), ' inregistrari pe ',int2str(n),' coloane'])
%
%in vectorul y sunt citite datele
%
%if rem(m,ndata)~=0
%    kmax=floor(m/ndata)+1; %scrie si ultma feliuta
% else
    kmax=floor(m/ndata)
% end
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
%disp(['Ultimul fisier are ', int2str(lim2-lim1+1), ' inregistrari'])
%numere=(1:1:kmax)'; %este numarulsecventei
%t=zeros(kmax,1);        %aloc memorie pentru t
%t=(numere-0.5).*(ndata/fps);
%rez=[t, medii];
save([nume,'-',int2str(ndata),'-med.txt'],'medii','-ascii');
% arata si graficul
figure(1)
if opt ==1
  plot(medii(:,1),medii(:,2),'o')
elseif opt==2
    bar(medii(:,1),log10(medii(:,2)),'r')
end
%xlabel('t, s')
%ylabel('I, a.u.')
if opt >=1
    saveas(1,[nume,'-',int2str(ndata),'-med.',extgraf],extgraf)
end
%
rap=medii(1,2)/medii(2,2);
sirrap=num2str(rap);
disp(['Raportul este ', sirrap])