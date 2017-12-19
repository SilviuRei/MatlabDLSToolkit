function [diam,a0,a1,chi2min,exitflag]=chi2dlslsq1(nume,dmic,dist,indref,lambda,tcelsius,a0start,a0min,a0max,a1start,a1min,a1max,control,tip);
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
t0=clock;   %marcheaza inceputul executiei
disp(' ');
nume_inn=[nume,'.fps'];
tmp=load(nume_inn);
[n,l]=size(tmp);
f=tmp(:,1);         %extrage frecventa
psexp=tmp(:,2);     %extrage amplitudinile puterii exp
teta=atan(dmic/dist);   %unghiul la care face determinarile
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
options=optimset('MaxFunEvals',15000,'MaxIter',5000,'TolX',1.e-4);
%
%keyboard;
[arg,resnorm,residual,exitflag,output]=lsqcurvefit(@florentz,arg0,f,psexp,argmin,argmax,options);
exitflag
output
%
%keyboard;
%
a0=arg(1);
a1=arg(2);  %valorile optime
pscalc=florentz(arg,f);
chi2min=(1/n)*sum((psexp-pscalc).^2);
%
if control >=1  %vrea afisat pe ecran
    loglog(f, psexp,'-b',f,pscalc,'-r',...
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
arata1(' Deplasare detector:   ',dmic);
arata1(' Distanta cuva-detector ',dist);
arata1(' Unghi de masura  ',(180/pi)*teta);
arata1(' a0 start                ',a0start);
arata1(' a0 min                  ',a0min);
arata1(' a0 max                  ',a0max);
arata1(' a1start                ',a1start);
arata1(' a1min                  ',a1min);
arata1(' a1max                  ',a1max);
disp(' ');
arata1('   a0 optim        ', a0);
arata1('   a1optim        ', a1);
arata1('   Chi2/punct     ', chi2min);
arata1('   Resnorm        ', resnorm);
%arata1('  Eroare g       ', stepg);
%arata1('  Eroare C       ', stepc);
t1=clock;  %sfarsitul executiei
durata=etime(t1,t0)/60; %durata executiei in minute
arata1('   Durata, min.  ',durata);
disp(' ');
disp('diametru        a0 optim        a1optim            Hi2/pct')
disp([num2str(diam),'   ',num2str(a0),'   ',num2str(a1),'   ',num2str(chi2min)]);
%