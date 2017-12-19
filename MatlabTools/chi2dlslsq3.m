function [diam,a0,a1,chi2min,exitflag]=chi2dlslsq3(nume,teta,indref,lambda,tcelsius,a0start,a0min,a0max,a1start,a1min,a1max,control,tip);
% 
%   Functia  chi2dlslsq1 citeste fisierul nume.psd in care sunt perechile de tip
%   frecventa si power amplitude.
%       dmic - deplasarea transversala a detectorului
%       dist - distanta detector-cuva, in aceleasi unitati de masura.
%       indref - indicele de refractie al particulelor
%       lambda - lungimea de unda in vid a rad. laser, in metri
%       tcelsius - temperatura solutiei, in grade Celsius
%   Fiteaza prin metoda celor mai mici patrate functia florentz pe date
%   si gaseste valoarea parametrului hi2 pe punct.
%   Face graficul lui hi2 functie de g
%   Deseneaza graficul cu osd experimental si psd fitat daca control>=1   
%   Salveaza figura pe disc daca control >=2
%   Oricum salveaza fisierul cu datele din fit pe disc 
%   Returneaza valoarea lui diametru, a0, a1, chi2/punct 
%   precum si exit flag care arata cum a decurs fitarea.
%
%   Fata de versiunea 1 incerc sa controlez si tolfun
%  Nu are rost, mareste durata mult dar nu si precizia.
%   In schimb scrie explicit si valorile diametrului si hi2/punct
%
%   Versiunea 3 foloseste florentz2 care este corectata si are ca intrare
%   unghiul teta, in radiani, nu d mic si d mare.
%
% Apelare:
% [diam,a0,a1,chi2min,exitflag]=chi2dlslsq2(nume,teta,indref,lambda,tcelsius,a0start,a0min,a0max,a1start,a1min,a1max,control,tip);
%

disp('___________________________________');
%disp(' ');
disp('                 chi2dlslsq3');
disp('                 Ultima modificare: 1 Februarie 2016');
disp(' ');
disp(['Rulare ',nume,',  ',datestr(clock,0)]);
disp(['Control ',int2str(control)]);
%disp(' ');
disp('___________________________________');
disp(' ');
%
t0=clock;   %marcheaza inceputul executiei
disp(' ');
nume_inn=[nume,'.fps'];
tmp=load(nume_inn);
[n,l]=size(tmp);
f=tmp(:,1);         %extrage frecventa
psexp=tmp(:,2);     %extrage amplitudinile puterii exp
%teta=atan(dmic/dist);   %unghiul la care face determinarile
pscalc=zeros(n,1);
%
%   pregateste datele de intrare
%
arg0=[a0start, a1start];  %parametrii de start
argmin=[a0min, a1min];    %lower bounds
argmax=[a0max, a1max];    %upper bounds
%
% change some options
%
%options=optimset('MaxFunEvals',15000,'MaxIter',5000,'TolX',1.e-4);
options=optimset('MaxFunEvals',25000,'MaxIter',10000,'TolX',1.e-10,'TolFun',1.e-14);
%
%keyboard;
[arg,resnorm,residual,exitflag,output]=lsqcurvefit(@florentz2,arg0,f,psexp,argmin,argmax,options);
exitflag
output
%
%keyboard;
%
a0=arg(1);
a1=arg(2);  %valorile optime
pscalc=florentz2(arg,f);
chi2min=(1/n)*sum((psexp-pscalc).^2);
%
if control >=1  %vrea afisat pe ecran
    figure(1);
    loglog(f, psexp,'ob',f,pscalc,'-r',...
                        'LineWidth',2)
    title([nume,'  a0:',num2str(a0),'  a1:',num2str(a1)]);
    xlabel('f, Hz');
    ylabel('PS, a.u.')
end
%
if control >= 2 %vrea figura salvata pe disc
    format('long');
    numeg=[nume,'-a0-',num2str(a0),'-a1-',num2str(a1)];
    saveas(1,[numeg,'.',tip],tip);
end
%
% salveaza datele ca matrice, f, psexp, pscalc
%
rez(:,1)=f;
rez(:,2)=psexp;
rez(:,3)=pscalc;
numeout=[nume,'.rez'];
save(numeout,'rez','-ascii');
%keyboard;
%
%  calculeaza valoarea diametrului particulelor
%
kb=1.3806503e-23;       %constanta lui Boltzman
tkelvin=tcelsius+273.15;    %temperatura absoluta
eta=water_viscosity(tcelsius);
kmare=(4*pi*indref*sin(0.5*teta))/lambda;
raza=(2*kb*tkelvin*kmare.^2)/(6*pi*eta*a1);
diam=2*raza;
%
% That is all, write the result
%
disp('________________________________________')
disp(' ');
disp([ ' Numele fisierului      ',nume]);
disp(' Unghi de masura, radiani ',num2str(teta));
disp(' Unghi de masura, grade ',num2str((180/pi)*teta));
disp(' a0 start                ',num2str(a0start));
disp(' a0 min                  ',num2str(a0min));
disp(' a0 max                  ',num2str(a0max));
disp(' a1start                ',num2str(a1start));
disp(' a1min                  ',num2str(a1min));
disp(' a1max                  ',num2str(a1max));
disp(' ');
disp('   a0 optim        ', num2str(a0));
disp('   a1optim        ', num2str(a1));
disp('   Chi2/punct     ', num2str(chi2min));
disp('   Resnorm        ', num2str(resnorm));
disp(' ');
disp('   Diametru, m  ', num2str(diam));
disp('   Hi2/pct           ', num2str(chi2min));
t1=clock;  %sfarsitul executiei
durata=etime(t1,t0)/60; %durata executiei in minute
disp('   Durata, min.  ',num2str);
disp(' ');
disp('diametru        a0 optim        a1optim            Hi2/pct')
disp([num2str(diam),'   ',num2str(a0),'   ',num2str(a1),'   ',num2str(chi2min)]);
%