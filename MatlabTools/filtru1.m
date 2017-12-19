function [y1,y2]=filtru1(nume, ext_fis, valmin, valmax);
%
%   Functia citeste un fisier de tip fps si lasa in fisierul de iesire doar
%   valorile care sunt intre valmin si valmax pe coloana a doua, dupa ce ii
%   adauga un f inainte de punct
%   Se apleleaza:
%
%  [y1,y2]=filtru1(nume, ext_fis, valmin, valmax);
%
numeinn=[nume,'.',ext_fis];
x =load(numeinn,'-ascii');
%
%in vectorul y sunt citite datele
%
n=max(size(x));
disp(['Fisierul are: ',num2str(n),' inregistrari'])
disp(' ');
y=zeros(n,2);       %vecorul cu valorile ramase
yrej=zeros(n,2);    %vecorul cu valorile rejectate
%
j=0;
jrej=0;
for i=1:n
    if (x(i,2)>=valmin) &  (x(i,2)<=valmax)
        j=j+1;
        y(j,:)=x(i,:);
    else
        jrej=jrej+1;
        yrej(jrej,:)=x(i,:);
    end
end
%
%time to write data into the file nume.dat
%
disp(['Fisierul final are: ',num2str(j),' inregistrari'])
disp(['Au fost eliminate : ',num2str(jrej),' inregistrari'])
numeout=[nume,'f-',num2str(valmin),'-',num2str(valmax),'.',ext_fis];
numerej=[nume,'f-rej-',num2str(valmin),'-',num2str(valmax),'.rej'];
y1=y(1:j,:);
save(numeout,'y1','-ascii');
%
y2=yrej(1:jrej,:);
save(numerej,'y2','-ascii');
%
% show the filtered file
%
loglog(y1(:,1),y1(:,2),'-r')
%
