function [a,addition,anew,t]=addfrecv1(nume,frecv,frqadd,tip,opt)
%
%   ps_dls5(nume,frecv,nr1,nr2,tip,opt)
%
%   Functia citeste un fisier de tip ASCII cu numele in variabila
% nume de felul 'c:folder\file.ext', extensia trebuie sa fie ext. 
%   datele de intrare:
%       frecv este frecventa de esantionare, de achizitie
%       frqadd este frecventa de adaugat si armonicele pana la cea de
%       achizitie
%       opt este un parametru de control pentru iesiri
%           Daca 
%                opt=0 nu salveaza nimic
%                opt >=1 salveaza noua serie temporala
%                opt >=2 reprezinta grafic addition si noua serie temporala
%                opt>=3  salveaza si graficele cu figurile
%   Scrie noul fisier ls care la denumire adauga '-frqadd' si tot extensia
%   ext
%   
numefis=[nume,'.','ext'];
a=load(numefis);
[m,m1]=size(a);
amax=max(a);    %valoarea maxima
amin=min(a);    %valoarea minima
ampexp=amax-amin;   %valoarea maxima a amplitudinii
%
disp(['Fisierul are        : ',int2str(m), ' inregistrari']);
disp(['Valoare minima este : ',num2str(amin)]);
disp(['Valoare maxima este : ',num2str(amax)]);
disp(['Amplit. maxima este : ',num2str(ampexp)]);
%
nrarmon=floor(frecv/frqadd);
disp(['Nr. de armonici este: ',int2str(nrarmon)]);
%
% calculeaza amplitudinile armonicilor
%
for i=1:nrarmon
    ampadd(i)=0.06*ampexp*exp(-0.25*i); %scad exponential
end
rand('state',sum(100*clock)); %resets the generator to a random state, different each time
phase=2*pi*rand(nrarmon);    %generate aleator 
%
% in vectorul coloana cu datele, adauga armonicile la fiecare moment
%
deltat=1/frecv;
addition=zeros(m,1);
t=0:deltat:(m-1)*deltat;    %a generat abscisele
for k=1:m
    for i=1:nrarmon
        addition(k)=addition(k)+ampadd(i)*sin(2*pi*i*frqadd*t(k)+phase(i));
    end
end
%
%face ca seria cu armonicile sa fie pozitiva 
%
addmin=min(addition);
%indiferent cum este, il scade si noul minim devine 0
addition=addition-addmin;
anew=a+addition;    %a adaugat seria cu armonicile
% scrie datele daca este cazul
numefisout=[nume,'-',int2str(frqadd)];
%
if opt >= 1
    save([numefisout,'.ext'],'anew','-ascii');
end
%arata grafiecele daca este cazul
if opt>=2
    figure(1)
    plot(t(11025:11370)',a(11025:11370),'-b');
    xlabel('t, s')
    ylabel('I, a.u.');
%
    figure(2)
    plot(t(11025:11370)',addition(11025:11370),'-g');
    xlabel('t, s')
    ylabel('I, a.u.');
%
    figure(3)
    plot(t(11025:11370)',anew(11025:11370),'-r');
    xlabel('t, s');
    ylabel('I, a.u.');
end
% salveaza figurile daca a cerut
if opt>=3
    saveas(1,[numefisout,'-old.',tip],tip)
    saveas(2,[numefisout,'-add.',tip],tip)
    saveas(3,[numefisout,'-new.',tip],tip)
end
%