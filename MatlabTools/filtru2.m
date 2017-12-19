function [y]=filtru2(nume, ext_fis, fr, deltafr, opt, fgr);
%
%   Functia citeste un fisier de tip fps si extrage toate valorile din
%   jurul unei frecvente aflate intr-o fereastra simetrica fata de valoarea
%   data si la fel pentru armonicele aflate intre o si valaorea maxima a
%   frecventatei din fisierul de tip ps.
%   
%   adauga un f-fr-deltaf inainte de punct
%   Daca opt>=1 scrie si imaginea pe disc, de tip fgr
%   Se apleleaza:
%
%  [y]=filtru1(nume, ext_fis, fr, deltafr, opt);
%
numeinn=[nume,'.',ext_fis];
x =load(numeinn,'-ascii');
hdeltafr=0.5*deltafr;   %jumatatea intervalului de frecventa
%
%in vectorul x sunt citite datele
%
n=max(size(x));
frmax=max(x(:,1));  %frecventa maxima
disp(['Fisierul are: ',num2str(n),' inreg., fr. maxima este: ',num2str(frmax)])
%
narm=1;  %numarul armonicii
while (narm*fr-hdeltafr) <= frmax
    j=0;
    n=max(size(x));
    y=zeros(n,2);   %matricea filtrata
    frcrt=narm*fr;  %frecventa curenta
    for i=1:n
        if ((x(i,1)<frcrt-hdeltafr)|(x(i,1)>frcrt+hdeltafr))
            j=j+1;
            y(j,:)=x(i,:);
        end
    end %for i
    narm=narm+1;
    x=y(1:j,:);    %matricea filtrata devine matricea de intrare la urmatorul pas
end %while
%
%time to write data into the file nume.dat
%
disp(['Fisierul final are: ',num2str(j),' inregistrari'])
numeout=[nume,'-f-',num2str(fr),'-',num2str(deltafr),'.',ext_fis];
y1=y(1:j,:);
save(numeout,'y1','-ascii');
%
% reprezinta grafic fisierul obtinut
%
figure(1)
loglog(y1(:,1),y1(:,2),'-');
xlabel('f, Hz');
ylabel('PS');
if opt >=1
    saveas(1, [nume,'-f-',num2str(fr),'-',num2str(deltafr),'.',fgr],fgr);
end
%