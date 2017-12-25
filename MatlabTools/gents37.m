function [t,x,a0,a1]=gents37(nume,diam,theta,lambda,indref,eta,tcelsius,fs,nt,opt)
%--------------------------------------------------------------------------
% Version 20171118, Silviu Rei based on gents36 by Dan Chicea
% [t,x,a0,a1]=gents36(nume,diam,theta,lambda,indref,eta,tcelsius,fs,nt,opt)
% 
%   The function generates time series for DLS
%	Input:
%       nume        = name of the TS
%       diam        = diameter of particles in nm
%       theta       = measuring ange in RAD
%       lambda      = laser wavelength in nm
%       indref      = refractive index of the solvent
%       eta         = viscosity of the solvent
%       tcelsius    = temperature in C
%       fs          = acquisition frequency
%       nt          = number of samples in the series
%       opt         = if 1, save the time series in a file
%	Output:
%       t           = time axis of the time series
%       x           = time series
%       a0, a1      = Lorentz parameters       
%	Example:
%		[t,x,a0,a1]=gents37('water',5,pi/2,lambda,indref,eta,tcelsius,fs,nt,1);
%-------------------------------------------------------------------------------
% Original Dan Chicea Comments:
%
%   Functia generaza o suprapunere de functii sinusoide de amplitudini care
%   simuleaza PSD inregistrat in DLS pentru centrii de imprastiere de
%   diametru diam. (A! este diametrul in nm, nu raza), la unghiul theta, exprimat
%   in radiani, de lumina cu lungimea de unda lambda, in nm, in apa la
%   temperatura tc, in grade Celsius.
%
%   Seria este in variabila x, generata cu frecventa (de achizitie) fs,
%   folosind nf frecvente si nt valori in seria de timp finala.
%  
%   Daca opt este 1 salveaza in fisierul nume,
%   de felul 'd:folder\nume-diam-fs-nf-nt.ext' 
%
%   Functia returneaza doi vectori, unul t cu valoarea timpului si celalalt x, cu seria
%   temporala
%
%   calculeaza valorile necesare pentru parametrii functiei Lorentz
%
%   fata de versiunea 1 ridica la patrat intrucat valorile inregistrare in experiment sunt
%   pozitive
%
%   fata de versiunea 2 tine cont si de indiele de refractie in calculul
%   lui K, ca si chi2dlsq2 !!!
%
%   32 fata de versiunea 31 initializeaza diferit seed-ul de nr. aleatoare
%   33 are seed-ul ca 100008cputime, sa fie variatie mare de l ao serie la
%   alta
%   34 nu initializeaza generatorul de nr. aleatoare. acesta este
%   initializat extern inaite de apelarea in serie a lui gents3
%
%   apelare:
%   [t,x]=gents32('FeO4-100', 100, 0.7854, 633, 1.5, 20, 2000, 100, 1000, 1)
%
%   v 35 revine dupa rezultatele eronate pe care le da procedure DLS, cu
%   diametre prea mici si renunta la schema cu radicalul si patratul
%   in plus calculeaza ci florentz2 ca si programul de fitare
%
%   v36 reia raducalul si patratul la ampltudine dar cu florentz2.
%   calculeaza singur numarul de frecvente sa fie comparabil cu cel din FS real la
%   numarul de valori din sir.
%
%-----------------------------------------------------------------------------------
a0=10;       %alegem arbitrar; l-am micsorat
kb=1.3806505e-23;   % constanta lui Boltzman
%eta=1.8369247E-5; %air viscosity at 20C
%eta=water_viscosity(tcelsius);  % vascozitate apei, in daP
lambdam=lambda*1.e-9;  % trece lambda in SI, in m
tabs=tcelsius+273.15;  % temperatura in Kelvin
diamm=diam*1.e-9; %diametrul in m
%
K=(4*pi/lambdam)*indref*sin(0.5*theta);
a1=(2*kb*tabs*K^2)/(6*pi*eta*0.5*diamm);
%
% genereaza vectorul linie cu frecventele, in intervalul [0, fs/2]
% si fazele initiale, uniform distribuite in [0, 2pi]
%
%rand('twister',sum(100*clock)); %initializeaza seria de numere aleatoare, diferite
%rand('twister',sum(200000)); %initializeaza seria de numere aleatoare, la fel pt fiecare serie
%
%c=clock;
%rand('twister',5000*sum(c(4:6))); %initializeaza seria de numere aleatoare, diferit la fiecare serie
%rand('twister',100*abs(cputime)); %initializeaza seria de numere aleatoare, diferit la fiecare serie
%rand('twister',10000*abs(cputime)); %initializeaza seria de numere aleatoare, diferit la fiecare serie
%
nf=nt/2+1;
df=0.5*fs/nf;   %pasul de frecvente, generate uniform 
f=df:df:nf*df;   % frecventele generate uniform in interval, nu-i bine ca
%apar armonicile si iese seria prea periodica
%
%f=0.5*fs*rand(1,nf);   %vectorul linie cu frecventele generate aleator in
%interval
%rand('twister',sum(100*clock)); %initializeaza seria de numere aleatoare, diferita la fiecare serie
%c=clock;
%rand('twister',5000*sum(c(4:6))); %initializeaza seria de numere aleatoare, diferit la fiecare serie
faz=2*pi*rand(1,nf);  %punem si faze inititale ca altfel are o variatie foarte mare la inceput  
% amp=a0*a1/((2*pi.*f)^2+a1^2)   %vectorul cu amplitudinile
%amp=zeros(1,nf);
%amp=4*pi^2*f.*f+a1^2;   %vectorul cu amplitudinile, calculat in pasi
%amp=a0*a1./amp;
% in versiunea 2 extrag radicalul pt ca ridicat la patrat sa dea f Lorentz
%amp=sqrt(amp);
arg=[a0,a1];
[amp]=florentz2(arg,f);
%
if opt >= 1         % pentru varianta rapida nu mai face graficul
                    % pt varianta lenta arata cate ceva
    disp(['Se genereaza seria pentru: ',int2str(nf),' frecvente']); 
    loglog(f,amp,'-m')
end
% genereaza seria de timp 
%
dt=1/fs;
t=(dt:dt:nt*dt)';   %vector coloana cu nt+1 valori
[n1,n2]=size(t); %dimensiunea seriei temporale
x=zeros(n1,n2);   %aceeasi dimensiune
%
%
%
amp=sqrt(amp);
for i=1:nf
    x=x+amp(i).*sin(2*pi*f(i).*t+faz(i));
end
%
% x=abs(x);    %determina valoarea absoluta ca sa fie pozitive toate
%   Nu este bine, f. Lorentz calculata coboara mai lent decat punctele
%
%x=x.^2;
%keyboard;
%
% in versiunea aceasta scad minimul din serie in loc sa ridic la patrat.
%
xmin=min(x);
x=x-xmin;
%
% salveaza daca este cazul fisierul pe disc
%
if opt >= 1
    numefis=[nume,'-',int2str(diam),'-',int2str(fs),'-',int2str(nf),'-',int2str(nt),'.ext'];
    save(numefis,'x','-ascii');
end
%
