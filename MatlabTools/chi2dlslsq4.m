function [diam,a0,a1,chi2min]=chi2dlslsq4(nume,teta,indref,lambda,tcelsius,control,tip);
% 
%   Functia  chi2dlslsq4 citeste fisierul nume.psd in care sunt perechile de tip
%   frecventa si power amplitude.
%       dmic - deplasarea transversala a detectorului
%       dist - distanta detector-cuva, in aceleasi unitati de masura.
%       indref - indicele de refractie al particulelor
%       lambda - lungimea de unda in vid a rad. laser, in metri
%       tcelsius - temperatura solutiei, in grade Celsius
%   Fiteaza prin metoda celor mai mici patrate functia florentz inversata sifacuta functie de x=f^2
%   pe date si gaseste valoarea parametrului hi2 pe punct.
%   Deseneaza graficul cu psd experimental si psd fitat daca control>=1   
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
%   Versiunea 4 incearca o fitare liniara in loc de cea pe functia s(f),
%   drept care o inverseaza si o vede ca functie de x=f^2
%
% Apelare:
% [diam,a0,a1,chi2min,exitflag]=chi2dlslsq4(nume,teta,indref,lambda,tcelsius,control,tip);
%
% Atentie! Ia numai primele valori, astfel incat sa nu ajunga la zona de
% fluctuatii din spectru, ca duc la valori enorme care strica fitul. Pt
% 32000 valori in spectru ajung primele 2000 de perechi, chiar si pentru
% cativa zeci de nm.
%
disp(' ');
disp('___________________________________');
%disp(' ');
disp('                 chi2dlslsq4');
disp('                 Ultima modificare: 26 Septembrie 2016');
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
pscalc=zeros(n,1);
%
x=f.^2; % x este vectorul cu patratul frecventelor
is=1./psexp; %vectorul cu inversul lui s(f);
%
%   pregateste datele de intrare
%
[cfun,gof,output] = fit(x,is,'poly1') % fit liniar cu polinom de gr.1
%
aa=abs(cfun.p1);
bb=abs(cfun.p2);
a0=2.*pi./sqrt(aa.*bb);
a1=2.*pi.*sqrt(bb./aa);
%
arg=[a0,a1]; % intra pe vechiul fagas si calculeaza la fel valorile
%
pscalc=florentz2(arg,f);
chi2min=(1/n)*sum((psexp-pscalc).^2);
%
if control >=1  %vrea afisat pe ecran
    loglog(f, psexp,'ob',f,pscalc,'-r',...
                        'LineWidth',2)
    title([nume,'chi2dlslsq4  a0:',num2str(a0),'  a1:',num2str(a1)]);
    xlabel('f, Hz');
    ylabel('PS, a.u.')
    %
    figure(2)
    plot(x, is,'ob')
    title([nume,'chi2dlslsq4  a0:',num2str(a0),'  a1:',num2str(a1)]);
    xlabel('f^2, Hz');
    ylabel('1/S, a.u.')
    %
end
%
if control >= 2 %vrea figura salvata pe disc
    format('long');
    numeg1=[nume,'v4-a0-',num2str(a0),'-a1-',num2str(a1)];
    saveas(1,[numeg1,'.',tip],tip);
    numeg2=[nume,'v4-lin-a0-',num2str(a0),'-a1-',num2str(a1)];
    saveas(2,[numeg2,'.',tip],tip);
end
%
% salveaza datele ca matrice, f, psexp, pscalc
%
rez(:,1)=f;
rez(:,2)=psexp;
rez(:,3)=pscalc;
numeout=[nume,'.rezv4'];
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
arata1(' Unghi de masura, radiani ',teta);
arata1(' Unghi de masura, grade ',(180/pi)*teta);
disp(' ');
arata1('   a0 ', a0);
arata1('   a1 ', a1);
arata1('   Chi2/punct     ', chi2min);
disp(' ');
arata1('   Diametru, m  ', num2str(diam));
arata1('   Hi2/pct           ', num2str(chi2min));
t1=clock;  %sfarsitul executiei
durata=etime(t1,t0)/60; %durata executiei in minute
arata1('   Durata, min.  ',durata);
disp(' ');
disp('diametru        a0 optim        a1optim            Hi2/pct')
disp([num2str(diam),'   ',num2str(a0),'   ',num2str(a1),'   ',num2str(chi2min)]);
%