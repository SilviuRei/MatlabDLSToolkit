function [f,amp]=genps1(nume, numfisfr, diam, theta, lambda, indref, tcelsius, optsav, fgr)
%
%   Functia citeste un fisier numefisfr care contine frecventele la care sa genereze
%   valorile medii pentru power spectrum direct, folosind functia Lorentz. Le
%   normalizeaza astfel incat valoarea maximea sa fie 1.
%   Salveaza fisierul de tip .fps dupa ce ii pune in titlu si '-mdegr-norm-gen.fps'
%   Reprezinta grafic valorile calculate
%
%   daca optsav>=1 salveaza fisierul cu frecventele si PS in format .fps
%   daca optsav>=2 salveaza si graficul in formatul 'fgr'
%  
% apelare: genps1(nume, numfisfr, diam, theta, lambda, indref, tcelsius, optsav,fgr)
%
tmp=load(numfisfr,'-ascii');   % pot fi mai multe coloane, poate fi chiar un fisier de tip .fps
[nf,ncol]=size(tmp);
disp(['Generez PS pentru ',int2str(nf),' frecvente'])
f=tmp(:,1); %merge chiar daca sunt doua coloane; extrage doar prima
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
%
% genereaza vectorul linie cu frecventele, in intervalul [0, fs/2]
%
amp=zeros(nf,1);
amp=4*pi^2*f.*f+a1^2;   %vectorul coloana cu amplitudinile, calculat in pasi
amp=a0*a1./amp;
%
% normalizeaza PSD
%
mmax=max(amp);    %are doua elemente, maximele pe coloane
factor=1./mmax;
amp=amp.*factor;
%keyboard;
%
% reprezinta grafic valorile generate cu cercuri si cu linie
%
figure(1)
loglog(f,amp,'o-b')
xlabel('f, Hz')
ylabel('PS')
%
if optsav >= 1  % vrea salvat fisierul cu datele
    rez=[f,amp];
    numefis1=[nume,'-',int2str(diam),'-',int2str(nf),'-mdegr-norm-gen.fps'];
    save(numefis1,'rez','-ascii');  %salveaza fisierul ascii
end
%
if optsav >= 2  % vrea salvat graficul
   numefis2=[nume,'-',int2str(diam),'-',int2str(nf),'-mdegr-norm-gen.',fgr];
   saveas(1,numefis2);
end