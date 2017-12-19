function [rez,a1]=calcps1(nume, frmax, pasfr, diam, theta, lambda, indref, tcelsius, optsav, fgr)
%
%   Functia genereaza valorile pentru power spectrum direct, folosind functia Lorentz. Le
%   normalizeaza astfel incat valoarea maximea sa fie 1.
%   Salveaza fisierul de tip .fps dupa ce ii pune in titlu si '-norm-gen.fps'
%   Reprezinta grafic valorile calculate
%   Fata de genps2 ia frecventele de la 1 la fmax cu pasul pasf nu le ia
%   din fisier. Returneaza o matrice cu doua coloane, frecventa si functia
%   Lorentz si parametrul a1
%
%   daca optsav>=1 salveaza fisierul cu frecventele si PS in format .fps
%   daca optsav>=2 salveaza si graficul in formatul 'fgr'
%  
% apelare: calcs1(nume, fmax, pasf, diam, theta, lambda, indref, tcelsius, optsav, fgr)
%
% Foloseste functia Lorentz corectata, florentz2
%
f=1:pasfr:frmax;
f=f';     % o trece in vector coloana
[nf,ncol]=size(f);
disp(['Calculez PS pentru ',int2str(nf),' frecvente'])
%
% calculeaza valorile necesare pentru parametrii functiei Lorentz
%
%numefis=[nume,'-',int2str(diam),'-',int2str(fs),'-',int2str(nf),'-',int2str(nt),'.fps']
%buf=load(numefis,'-ascii');
%[nrvalf,ntmp]=size(buf)
%
kb=1.3806505e-23;   % constanta lui Boltzman
eta=water_viscosity(tcelsius);  % vascozitate apei, in daP
lambdam=lambda*1.e-9;  % trece lambda in SI, in m
tabs=tcelsius+273.15;  % temperatura in Kelvin
diamm=diam*1.e-9; %diametrul in m
%
a0=10;      %oricum va fi normalizata
K=(4*pi/lambdam)*indref*sin(0.5*theta);
a1=(2*kb*tabs*K^2)/(6*pi*eta*0.5*diamm);
arata1('a1: ',a1)
%
arg=[a0, a1];
amp=florentz2(arg,f);
%
% normalizeaza PSD
%
mmax=max(amp);    %are doua elemente, maximele pe coloane
factor=1./mmax;
amp=amp.*factor;    %normalizata astfel incat maximul 
rez=[f,amp];    %pregateste rezultatele
%
%keyboard
% reprezinta grafic valorile generate cu cercuri si cu linie
%
figure(1)
loglog(f,amp,'-b')
xlabel('f, Hz')
ylabel('PS')
%
if optsav >= 1  % vrea salvat fisierul cu datele
    numefis1=[nume,'-',int2str(diam),'-norm-calcps1.fps'];
    save(numefis1,'rez','-ascii');  %salveaza fisierul ascii
end
%
if optsav >= 2  % vrea salvat graficul
   numefis2=[nume,'-',int2str(diam),'-norm-calcps1.',fgr];
   saveas(1,numefis2);
end